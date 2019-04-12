; #INDEX# =======================================================================================================================
; Title .........: FileTypeAssoc
; AutoIt Version : 3.3
; Description ...: Windows file association creator.
; Author(s) .....: Borja_Live (B0vE)
; ===============================================================================================================================


$comError = ObjEvent("AutoIt.Error","comError")

Func  _FileTypeAssoc($EXT , $FileType, $FileName)
Dim $oShell

$oShell = ObjCreate("wscript.shell")
$oShell.regwrite("HKCR\" & $EXT & "\", $FileType)
$oShell.regwrite("HKCR\" & $FileType & "\", $FileType)
$oShell.regwrite("HKCR\" & $FileType & "\DefaultIcon\", $FileName)
$oShell.regwrite("HKCR\" & $FileType & "\shell\open\command\", $FileName & " %L")

$oShell.regdelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\" & $EXT & "\Application")
$oShell.regwrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\" & $EXT & "\Application", $FileName)
$oShell.regdelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\" & $EXT & "\OpenWithList\")
$oShell.regwrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\" & $EXT & "\OpenWithList\a", $FileName)
Endfunc

Func comError()
  Msgbox(0,"Error Handler","Intercepted COM Error"    & @CRLF  & @CRLF & _
             "err.description is: " & @TAB & $oMyError.description  & @CRLF & _
             "err.windescription:"   & @TAB & $oMyError.windescription & @CRLF & _
             "err.number is: "       & @TAB & hex($oMyError.number,8)  & @CRLF & _
             "err.lastdllerror is: "   & @TAB & $oMyError.lastdllerror   & @CRLF & _
             "err.scriptline is: "   & @TAB & $oMyError.scriptline   & @CRLF & _
             "err.source is: "       & @TAB & $oMyError.source       & @CRLF & _
             "err.helpfile is: "       & @TAB & $oMyError.helpfile     & @CRLF & _
             "err.helpcontext is: " & @TAB & $oMyError.helpcontext _
            )
Endfunc