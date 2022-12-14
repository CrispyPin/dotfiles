#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#F3::
MouseMove, 0, -16, 0, R
return

#F7::
MouseMove, -16, 0, 0, R
return

#F8::
MouseMove, 0, 16, 0, R
return

#F9::
MouseMove, 16, 0, 0, R
return

#^F3::
MouseMove, 0, -256, 0, R
return

#^F7::
MouseMove, -256, 0, 0, R
return

#^F8::
MouseMove, 0, 256, 0, R
return

#^F9::
MouseMove, 256, 0, 0, R
return


F13::
MouseClick, Left
return

F14::
MouseClick, Right
return

F15::
MouseClick, Middle
return


F16::
MouseClick, WheelUp
return

F17::
MouseClick, WheelDown
return
