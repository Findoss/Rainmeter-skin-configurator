Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
  Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
  If @error Then Return SetError(@error, @extended, "")
  If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
  Return $aResult
EndFunc

Func GUICtrlComboGetCurSel($hWnd)
  If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
  Return _SendMessage($hWnd, 0x147)
EndFunc