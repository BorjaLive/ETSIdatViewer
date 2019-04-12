; #INDEX# =======================================================================================================================
; Title .........: BZIP
; AutoIt Version : 3.3
; Description ...: Join files and folders structures in one.
; Author(s) .....: Borja_Live (B0vE)
; ===============================================================================================================================

#include-once
#include <File.au3>

Func __packBZIP($folder, $dest)
	$file = FileOpen($dest, 16 + 2)
	$files = _FileListToArrayRec($folder, "*", 1, 1)

	For $i = 1 To $files[0]
		$files[$i] = $folder&"\"&$files[$i]
		FileWrite($file,StringToBinary(StringReplace($files[$i],$folder&"\","")&"|"&FileGetSize($files[$i])&"|"))
		FileWrite($file, FileRead($files[$i]))
	Next

	FileClose($file)
EndFunc

Func __unpackBZIP($dest, $file)
	$file = FileOpen($file)

	$sentence = ""
	dim $filename, $size
	$mode = 1	; 1 leer nombre, 2 leer size, 3 leer data
	Do
		If $mode = 1 Or $mode = 2 Then
			$read = FileRead($file,1)
			$sentence &= BinaryToString($read)
			;ConsoleWrite($sentence&"->"&$read&@CRLF)
		EndIf
		If $mode = 1 Then
			If BinaryToString($read) = "|" Then
				$filename = StringTrimRight($sentence,1)
				$sentence = ""
				$mode = 2
			EndIf
		ElseIf $mode = 2 Then
			If BinaryToString($read) = "|" Then
				$size = StringTrimRight($sentence,1)
				$sentence = ""
				$mode = 3
			EndIf
		ElseIf $mode = 3 Then
			$outFile = FileOpen($dest&"\"&$filename,16 + 8 + 2)
			;MsgBox(0,$filename,$size)
			FileWrite($outFile, FileRead($file,$size))
			FileClose($outFile)
			$mode = 1
		EndIf

	Until BinaryLen($read) = 0

	FileClose($file)
EndFunc