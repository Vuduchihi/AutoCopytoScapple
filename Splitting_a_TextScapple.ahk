#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;***splitting a text into multiple setences SCAPPLE***
^Tab::
Clipboard := ""
Send ^c
ClipWait

StringReplace, Clipboard , Clipboard , `r`n, %A_Space%, All
separate := RegExReplace(Clipboard,"((?<!\w\.\w.)(?<![A-Z][a-z]\.)(?<=\.|\?)\s)","@@@`n")

/*WrapText(Clipboard,StrLen(Clipboard))

WrapText(Text, LineLength) {
	StringReplace, Text, Text, `r`n, %A_Space%, All
	while (p := RegExMatch(Text, "(.{1," LineLength "})(\s|\R+|$)", Match, p ? p + StrLen(Match) : 1))
		Result .= Match1 ((Match2 = A_Space || Match2 = A_Tab) ? "`n" : Match2)
	return, Result
}
NewStr := StrReplace(WrapText(Clipboard, StrLen(Clipboard)), ".", ".. ")
clipboardArray := StrSplit(NewStr,". ")
*/
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


