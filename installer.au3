#RequireAdmin
#include "UDF\_FileTypeAssoc.au3"
#include "UDF\_ArrayUtils.au3"
#include "UDF\_BZIP.au3"
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

$installPath = @AppDataDir&"\ETSIdatViewer"
If FileExists($installPath) Then
	DirRemove($installPath,1)
EndIf
DirCreate($installPath)

__unpackBZIP($installPath, "data.BZIP")


_FileTypeAssoc(".dat", "ETSIdatViewer", $installPath&"\ETSIdatViewer.exe")


$GUI = GUICreate("ETSIdatViewer",400,70, -1, -1, $WS_BORDER, BitOr($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST))
GUICtrlSetFont(GUICtrlCreateLabel("ETSIdatViewer instalado correctamente", _
	20,10, 480, 20), 15)


GUISetState(@SW_SHOW, $GUI)

Sleep(3000)

GUIDelete($GUI)



