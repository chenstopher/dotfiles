;; Configuration
;#NoTrayIcon

;; Higher numbers mean more sensitive
esmb_VertSen = 2
esmb_HorzSen = 1

;; This key/Button activates scrolling
esmb_TriggerKey = MButton

;; End of configuration

#Persistent
CoordMode, Mouse, Screen
Hotkey, %esmb_TriggerKey%, esmb_TriggerKeyDown
HotKey, %esmb_TriggerKey% Up, esmb_TriggerKeyUp
esmb_KeyDown = n
esmb_scrollMode = 0
SetTimer, esmb_CheckForScrollEventAndExecute, 16
return

esmb_TriggerKeyDown:
	esmb_Moved = n
	esmb_FirstIteration = y
	esmb_KeyDown = y
	MouseGetPos, esmb_OrigX, esmb_OrigY
	esmb_scrollMode := DetermineScrollMode()
return

esmb_TriggerKeyUp:
	esmb_KeyDown = n
	;; Send a middle-click if we did not scroll
	if esmb_Moved = n
		MouseClick, Middle

	SystemCursor("On")
return

esmb_CheckForScrollEventAndExecute:
	if esmb_KeyDown = n
		return
	
	MouseGetPos, esmb_NewX, esmb_NewY
	esmb_DeltaY := esmb_NewY - esmb_OrigY
	esmb_DeltaX := esmb_NewX - esmb_OrigX
	esmb_TotalDX += esmb_TotalDX + esmb_DeltaX
	esmb_TotalDY += esmb_TotalDY + esmb_DeltaY

	if (esmb_DeltaX != 0 OR esmb_DeltaY != 0) AND esmb_Moved != y 
	{
		esmb_Moved := y
		SystemCursor("Off")
	}

	;; Do not send clicks on the first iteration
	if esmb_FirstIteration = y
		esmb_FirstIteration = n
	else 
	{
		if esmb_DeltaX != 0 OR esmb_DeltaY != 0 
		{
			if esmb_scrollMode = 0 
			{
				if abs(esmb_TotalDY) >= 120
				{
					MouseClickScroll(esmb_TotalDY / 120)
					if esmb_TotalDY > 0
						esmb_TotalDY := Mod(esmb_TotalDY, 120)
					else
						esmb_TotalDY := -Mod(abs(esmb_TotalDY), 120)

					esmb_TotalDY = 0;
				}
			}
			else if esmb_scrollMode = 1 
			{
				if abs(esmb_TotalDY) >= 120
				{
					MouseClickScroll(esmb_TotalDY / 120)
					if esmb_TotalDY > 0
						esmb_TotalDY := Mod(esmb_TotalDY, 120)
					else
						esmb_TotalDY := -Mod(abs(esmb_TotalDY), 120)

					esmb_TotalDY = 0;
				}
			}
			else if esmb_scrollMode = 2
			{
				SmoothScroll(esmb_DeltaX * esmb_HorzSen, -esmb_DeltaY * esmb_VertSen)
			}
		}
	}

	MouseMove,esmb_OrigX,esmb_OrigY,0
return

DetermineScrollMode()
{    
	; Get process name of active window
	WinGet, Active_ID, ID, A
    WinGet, pname, ProcessName, ahk_id %Active_ID%
	StringLower, pname, pname

	mode = 0

	if pname in chrome.exe,firefox.exe
	{
		mode = 2
	}
	else if pname in spotify.exe
	{
		mode = 1
	}

	Return, %mode%
}

MouseClickScroll(delta)
{
	if delta > 0
		MouseClick, WheelUp
	else if delta < 0
		MouseClick, WheelDown
}

MessageScroll(delta)
{
	CoordMode, Mouse, Screen
	MouseGetPos, m_x, m_y, winID, control

	;ControlGetFocus, c, A
	;ControlGet, hWnd, hWnd, , %c%, A

	; 0x115 = WM_VSCROLL
	; 0 = SB_LINEUP
	; 1 = SB_LINEDOWN
	; 0xB6 = EM_LINESCROLL

	if delta > 0
		PostMessage, 0x115, 0, 0, %control%, ahk_id %winID%
	else if delta < 0
		PostMessage, 0x115, 1, 0, %control%, ahk_id %winID%
}


;http://msdn.microsoft.com/en-us/library/windows/desktop/ms645617(v=vs.85).aspx
SmoothScroll(deltaX, deltaY)
{ 
	WM_MOUSEWHEEL := 0x20A
	WM_MOUSEHWHEEL := 0x20E
	CoordMode, Mouse, Screen
	MouseGetPos, x, y
	Modifiers := 0x8*GetKeyState("ctrl") | 0x1*GetKeyState("lbutton") | 0x10*GetKeyState("mbutton")
				|0x2*GetKeyState("rbutton") | 0x4*GetKeyState("shift") | 0x20*GetKeyState("xbutton1")
				|0x40*GetKeyState("xbutton2")

	PostMessage, WM_MOUSEWHEEL, deltaY << 16 | Modifiers, y << 16 | x , , A
	PostMessage, WM_MOUSEHWHEEL, deltaX << 16 | Modifiers, y << 16 | x , , A
}

; Function to hide or show the mouse cursor
SystemCursor(OnOff=1)	 ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
{
	static AndMask, XorMask, $, h_cursor
			,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
			, b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13	 ; blank cursors
			, h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13	 ; handles of default cursors

	if (OnOff = "Init" or OnOff = "I" or $ = "")			 ; init when requested or at first call
	{
		$ = h																					; active default cursors
		VarSetCapacity( h_cursor,4444, 1 )
		VarSetCapacity( AndMask, 32*4, 0xFF )
		VarSetCapacity( XorMask, 32*4, 0 )
		system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
		StringSplit c, system_cursors, `,
		Loop %c0%
		{
			h_cursor := DllCall( "LoadCursor", "uint",0, "uint",c%A_Index% )
			h%A_Index% := DllCall( "CopyImage",	"uint",h_cursor, "uint",2, "int",0, "int",0, "uint",0 )
			b%A_Index% := DllCall("CreateCursor","uint",0, "int",0, "int",0
					, "int",32, "int",32, "uint",&AndMask, "uint",&XorMask )
		}
	}

	if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
		$ = b	; use blank cursors
	else
		$ = h	; use the saved cursors

	Loop %c0%
	{
		h_cursor := DllCall( "CopyImage", "uint",%$%%A_Index%, "uint",2, "int",0, "int",0, "uint",0 )
		DllCall( "SetSystemCursor", "uint",h_cursor, "uint",c%A_Index% )
	}
}
