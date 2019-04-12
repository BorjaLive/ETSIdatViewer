#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=ETSIdatViewer.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <File.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include "UDF\_ArrayUtils.au3"

;Local $cmdLine = [1, "test"]
If $cmdLine[0] <> 1 Then
	MsgBox(16,"ETSIdatViewer ERROR", "ETSIdatViewer debe ser invocado al abrir un archivo.")
	Exit
Else
	;MsgBox(0,"FILE",$cmdLine[1])
EndIf

$installPath = @AppDataDir&"\ETSIdatViewer"
$componentsPath = $installPath&"\components"

;Obtener lista de componentes
$asignaturas = _FileListToArray($componentsPath,"*",2,false)
$componentes = __getArray()
For $i = 1 To $asignaturas[0]
	__add($componentes, _FileListToArray($componentsPath&"\"&$asignaturas[$i],"*",1,false))
Next


;Mostrar la interfaz
$GUI = GUICreate("ETSIdatViewer",500,500, -1, -1, $WS_BORDER, BitOr($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST))
GUICtrlSetFont(GUICtrlCreateLabel("Seleccione la asignatura y tipo de fichero que desea abrir", _
	10,10, 480, 25), 15)

$open = GUICtrlCreateButton("Abrir", 30,420,150,40)
GUICtrlSetFont($open,16,700)
$cancel = GUICtrlCreateButton("Cancelar", 210,420,150,40)
GUICtrlSetFont($cancel,16,700)


$selAsig = GUICtrlCreateList("", 15, 50, 200, 350)
GUICtrlSetTip($selAsig, 'Asignatura')
GUICtrlSetData($selAsig, _getListFromArray($asignaturas))

$selFile = GUICtrlCreateList("", 230, 50, 250, 350)
GUICtrlSetTip($selFile, 'Archivo')
GUICtrlSetData($selFile, "")

GUICtrlSetFont($selAsig,14,500)
GUICtrlSetFont($selFile,14,500)


GUISetState(@SW_SHOW, $GUI)

$selected = ""
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $cancel
			Exit
		Case $open
			ExitLoop
		Case $selAsig
			GUICtrlSetData($selFile, "")
			$n = _getIndex($asignaturas,GUICtrlRead($selAsig))
			If $n <> 0 Then GUICtrlSetData($selFile, _getListFromArray($componentes[$n]))
		Case $selFile
			$selected = GUICtrlRead($selAsig)&"\"&GUICtrlRead($selFile)&".exe"
	EndSwitch
WEnd


GUIDelete($GUI)

;Abrir los archivos
If $selected <> "" Then Run($componentsPath&"\"&$selected &" "& $cmdLine[1])




Func _getListFromArray($array)
	$text = ""

	For $i = 1 To $array[0]
		$text &= StringReplace($array[$i],".exe","")&"|"
	Next

	Return $text
EndFunc
Func _getIndex($array, $text)
	For $i = 1 To $array[0]
		If $array[$i] = $text Then Return $i
	Next
	Return 0
EndFunc