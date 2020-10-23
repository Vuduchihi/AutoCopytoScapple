#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



#SingleInstance, Force

;***splitting a text into multiple setences SCAPPLE***
^!Tab:: ;press Ctrl+Alt+Tab
Clipback := ClipboardAll
Clipboard =
send, ^c
ClipWait,1


if ErrorLevel{
		Clipboard:=Clipback
		MsgBox, No text was sent to clipboard
		return
	}
StringReplace, Clipboard , Clipboard , `r`n, %A_Space%, All
separate := RegExReplace(Clipboard,"((?<!\w\.\w.)(?<![A-Z][a-z]\.)(?<=\.|\?)\s)","@@@`n")

If WinExist("ahk_exe Scapple.exe")
{
	WinActivate, ahk_exe Scapple.exe
	WinWaitActive, ahk_exe Scapple.exe
}
else
{
	Run, D:\program file\scapple.exe
	WinActivate
	WinWaitActive, ahk_exe Scapple.exe		
}

for i, row in StrSplit(separate,"@@@`n"){
	data.= row 
	Clipboard:=data
	Send ^{Enter}
	send, ^v
	Sleep, 150
	Clipboard := Clipback
	data:=""
}

return


