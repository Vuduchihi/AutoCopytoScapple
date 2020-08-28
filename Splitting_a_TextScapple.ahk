#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;***splitting a text into multiple setences SCAPPLE***
^+Tab:: ;press Ctrl+Shift+Tab
Clipboard := ""
Send ^c
ClipWait

StringReplace, Clipboard , Clipboard , `r`n, %A_Space%, All
separate := RegExReplace(Clipboard,"((?<!\w\.\w.)(?<![A-Z][a-z]\.)(?<=\.|\?)\s)","@@@`n")
clipboardArray := StrSplit(separate, "@@@`n")

Loop % clipboardArray.MaxIndex()
{
	sentences := clipboardArray[A_Index]
	If WinExist("ahk_exe Scapple.exe")
	{
		WinActivate, ahk_exe Scapple.exe
		Sleep, 400
		Send ^{Enter}
		KeyWait, Control, L
		KeyWait, Enter, L
		SendInput %sentences%{^v}
		KeyWait, v, L	
	}
	else
	{
		Run, D:\program file\scapple.exe
		WinActivate
		Sleep, 500
		Send ^{Enter}
		KeyWait, Control, L
		KeyWait, Enter, L
		SendInput %sentences%{^v}
		KeyWait, v, L		
	}
}


return


