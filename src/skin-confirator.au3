#cs
  Name = Rainmeter skin confirator
  Author = Findoss
  Version = 1.0.1
  License = MIT
#ce

#include <GUIConstants.au3>
#include <..\libs\Json.au3>

Local $configJsonFile = FileOpen(@ScriptDir & "\config.json", 0)
if $configJsonFile = -1 Then
  MsgBox(16, "Error", "Create config.json")
  Exit
EndIf
Local $jsonString = FileRead($configJsonFile)
FileClose($configJsonFile)

Global $OBJ = Json_Decode($jsonString)
if @Error Then
  MsgBox(16, "Error", "JSON string is invalid.")
  Exit
EndIf

Global $countFileConfin = UBound(Json_Get($OBJ,'["config"]'))
Local $countSection = 0
Local $countInput = 0
Local $max = 0

For $i = 0 To $countFileConfin - 1
  Local $sum = 30
  $countSection = UBound(Json_Get($OBJ,'["config"]['&$i&']["section"]'))
  For $j = 0 To $countSection - 1
    $countInput = UBound(Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]'))
    $sum = $sum + $countInput * 30 + 30
  Next
  $sum = $sum + 30
  If $sum > $max Then $max = $sum
Next

Local $limitSection = 15
Local $limitInput = 25
Dim $items[$countFileConfin][$limitSection][$limitInput]

Global $W = 440
Global $H = $max+5
Global $FORM  = GUICreate("Rainmeter skin confirator", $W, $H, $WS_EX_TOOLWINDOW)
Global $YES = GUICtrlCreateButton("OK", $W-155, $H-30, 150, 25)
Global $NO = GUICtrlCreateButton("Cancel", $W-310, $H-30, 150, 25)
Global $INFO = GUICtrlCreateButton("About", 5, $H-30, 40, 25)
GUICtrlCreateTab (5,5, $W-10,$H-35)
For $i = 0 To $countFileConfin - 1
  ; TAB
  Local $endGroupY = 0
  Local $startGroupY = 30
  Local $pathFileINI = Json_Get($OBJ,'["config"]['&$i&']["pathConfigFile"]')
  Local $nameFileINI = Json_Get($OBJ,'["config"]['&$i&']["name"]')
  If $nameFileINI <> "" Then 
    GUICtrlCreateTabitem($nameFileINI)
  Else 
    GUICtrlCreateTabitem($pathFileINI)
  EndIf
  $countSection = UBound(Json_Get($OBJ,'["config"]['&$i&']["section"]'))
  For $j = 0 To $countSection - 1
    $countInput = UBound(Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]'))
    $startGroupY = $startGroupY + $endGroupY + 5
    $endGroupY = 30 * $countInput + 25
    ; GROUP
    $sectionName = Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["name"]')
    GUICtrlCreateGroup ($sectionName, 10, $startGroupY, $W-20, $endGroupY)
    Local $startLableY = $startGroupY
    For $l = 0 To $countInput - 1
      $startLableY = $startGroupY + 30 * $l+20
      GUICtrlCreateLabel ("=", 272, $startLableY+4, 10, 25)
      GUICtrlCreateLabel (Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]['&$l&']["discriotion"]'), 20, $startLableY, 250, 25, $SS_LEFT)
      GUICtrlSetBkColor (-1, 0xefefef)
      Local $key = Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]['&$l&']["key"]')
      Local $default = Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]['&$l&']["default"]')
      Local $val = IniRead($pathFileINI, $sectionName, $key, $default)
      Switch Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]['&$l&']["type"]')
        Case "number"
          Local $max = Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]['&$l&']["limit"]["max"]')
          Local $min = Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]['&$l&']["limit"]["min"]')
          $items[$i][$j][$l] = GUICtrlCreateInput ($val, 280, $startLableY, 145, 25)
          $updown = GUICtrlCreateUpdown($items[$i][$j][$l])
          If $min <> "" and $max <> "" Then GUICtrlSetLimit($updown, $max, $min)
        Case "combo"
          Local $options = Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]['&$l&']["options"]')
          $items[$i][$j][$l] = GUICtrlCreateCombo ("", 280, $startLableY, 145, 25)
          GUICtrlSetData($items[$i][$j][$l], $options, $val)
        Case "checkbox"
          $items[$i][$j][$l] = GUICtrlCreateCheckbox ("", 285, $startLableY, 140, 25)
          GUICtrlSetState ($items[$i][$j][$l], $val)
        Case Else
          $items[$i][$j][$l] = GUICtrlCreateInput ($val, 280, $startLableY, 145, 25)
      EndSwitch
    Next
  Next
Next

Func WriteFileINI()
  For $i = 0 To $countFileConfin - 1
    For $j = 0 To UBound(Json_Get($OBJ,'["config"]['&$i&']["section"]')) - 1
      For $l = 0 To UBound(Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]')) - 1
        Local $pathFileINI = Json_Get($OBJ,'["config"]['&$i&']["pathConfigFile"]')
        Local $sectionName = Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["name"]')
        Local $key = Json_Get($OBJ,'["config"]['&$i&']["section"]['&$j&']["inputs"]['&$l&']["key"]')
        IniWrite($pathFileINI, $sectionName, $key, '"'&GUICtrlRead($items[$i][$j][$l])&'"')
      Next
    Next
  Next
EndFunc

Func RefreshSkin()
  ; todo
EndFunc

Func ReadFileINI()
  ; todo
EndFunc

GUISetState(@SW_SHOW)
While 1
   $msg = GUIGetMsg()
   Select
    Case $msg = $YES
     WriteFileINI()
     MsgBox(0, "Info", "Success"&@LF&"Refresh all skins")
    Case $msg = $INFO
     MsgBox(64, "About", "Rainmeter skin confirator"&@LF&"Author Findoss "&@LF&"Version = 1.0.0 "&@LF&"License = MIT"&@LF&@LF&"GitHub.com/Findoss/Rainmeter-skin-configurator")
    Case $msg = $NO
     ExitLoop
    Case $msg = $GUI_EVENT_CLOSE
     ExitLoop
  EndSelect
WEnd