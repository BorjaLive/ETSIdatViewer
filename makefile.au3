#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=makefile.Exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#include "UDF\_BZIP.au3"

Const $UPX_STANDALONE = '"C:\Program Files (x86)\AutoIt3\Aut2Exe\upx.exe"'
Const $AUTOIT_COMPILER = '"C:\Program Files (x86)\AutoIt3\Aut2Exe\Aut2exe.exe"'
Const $GCC_COMPILER = '"C:\Program Files (x86)\Dev-Cpp\MinGW64\bin\g++.exe"'

Const $COMPRESS = FALSE, $COMPILAR = True

;Compilar los binarios
If $COMPILAR Then
	If FileExists("BIN") Then DirRemove("BIN",1)
	DirCreate("BIN")
	DirCreate("BIN\components")
	If FileExists("OUT") Then DirRemove("OUT",1)
	DirCreate("OUT")
	RunWait($AUTOIT_COMPILER&" /in ETSIdatViewer.au3 /out BIN\ETSIdatViewer.exe /icon icon.ico")
	RunWait($AUTOIT_COMPILER&" /in installer.au3 /out OUT/Installer.exe /icon icon.ico")
	$comps = _FileListToArrayRec("components", "*.cpp", 1, 1)
	;_ArrayDisplay($comps)
	For $i = 1 To $comps[0]
		$path = "BIN\components\"&StringMid($comps[$i],1,StringInStr($comps[$i],"\",-1)-1)
		If Not FileExists($path) Then DirCreate($path)
		RunWait($GCC_COMPILER&" components\"&$comps[$i]&" -o "&" BIN\components\"&StringReplace($comps[$i], ".cpp", ".exe"), @ScriptDir, @SW_HIDE)
	Next

	;Optimizar los binarios con upx
	If $COMPRESS Then
		$comps = _FileListToArrayRec("BIN\components","*.exe",1, 1)
		For $i = 1 To $comps[0]
			RunWait($UPX_STANDALONE&" "&@ScriptDir&"\BIN\components\"&$comps[$i], @ScriptDir, @SW_HIDE)
		Next
	EndIf
EndIf


__packBZIP("BIN", "OUT\data.BZIP")

DirRemove("BIN",1)