function InfoLineSwitchContext(_ARG_0_)
  if _ARG_0_ == nil then
    _ARG_0_ = UIEnums.Context.Main
  end
  if InfoLineContext_Original == nil then
    InfoLineContext_Original = _ARG_0_
  end
  if InfoLineContext == InfoLineContext_Original and InfoLines ~= nil then
    InfoLines_Store_Original = InfoLines
  end
  if _ARG_0_ == InfoLineContext_Original and InfoLines_Store_Original ~= nil then
    InfoLines = InfoLines_Store_Original
  else
    InfoLines = {
      locked = false,
      force = false,
      commands = "",
      do_timelines = {},
      spacing = 10
    }
  end
  InfoLineContext = _ARG_0_
end
function InfoLineFlush()
  InfoLineContext = nil
  InfoLineContext_Original = nil
  InfoLines_Store_Original = nil
  InfoLines = nil
  InfoLineSwitchContext()
end
InfoLineFlush()
function InfoLineClearCommands()
  InfoLines.commands = ""
end
function InfoLineFrameUpdate()
  if #InfoLines.do_timelines > 0 then
    for _FORV_3_, _FORV_4_ in ipairs(InfoLines.do_timelines) do
      UIButtons.TimeLineActive(_FORV_4_, true, 0)
    end
    InfoLines.do_timelines = {}
  end
end
function InfoLineLock()
  InfoLines.locked = true
end
function InfoLineUnlock(_ARG_0_)
  InfoLines.locked = false
  if _ARG_0_ == true then
    ProtectedLoadRunString(InfoLines.commands)
  end
  InfoLineClearCommands()
end
function InfoLineAllow()
  return InfoLines.locked ~= true or InfoLines.force == true
end
function InfoLineCommand(_ARG_0_)
  if string.find(InfoLines.commands, _ARG_0_, -(string.len(_ARG_0_) + 1), true) ~= nil then
    return
  end
  InfoLines.commands = InfoLines.commands .. " " .. _ARG_0_ .. ";"
end
function InfoLineSafeParam(_ARG_0_)
  if _ARG_0_ == nil then
    return "nil"
  end
  if IsBoolean(_ARG_0_) == true then
    return Select(_ARG_0_, "true", "false")
  end
  if IsString(_ARG_0_) == true then
    return "\"" .. _ARG_0_ .. "\""
  end
  return _ARG_0_
end
function InfoLineContains_F(_ARG_0_)
  InfoLines.force = true
  InfoLineContains(_ARG_0_)
  InfoLines.force = false
end
function InfoLineContains(_ARG_0_)
  InfoLineContainsL(_ARG_0_)
end
function InfoLineContainsL_F(_ARG_0_)
  InfoLines.force = true
  InfoLineContainsL(_ARG_0_)
  InfoLines.force = false
end
function InfoLineContainsL(_ARG_0_)
  return __InfoLineContains(_ARG_0_, true)
end
function InfoLineContainsR_F(_ARG_0_)
  InfoLines.force = true
  InfoLineContainsR(_ARG_0_)
  InfoLines.force = false
end
function InfoLineContainsR(_ARG_0_)
  return __InfoLineContains(_ARG_0_, false)
end
function StoreInfoLine_F()
  InfoLines.force = true
  StoreInfoLine()
  InfoLines.force = false
end
function StoreInfoLine()
  if InfoLineAllow() == false then
    InfoLineCommand("StoreInfoLine()")
    return
  end
  if ContextTable[InfoLineContext].GUI.info_line == nil then
    return
  end
  if ContextTable[InfoLineContext].GUI.info_line.state == nil then
    ContextTable[InfoLineContext].GUI.info_line.state = {}
  end
  ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state + 1] = {
    L = {},
    R = {}
  }
  if ContextTable[InfoLineContext].GUI.info_line.L ~= nil then
    for _FORV_7_ = 1, #ContextTable[InfoLineContext].GUI.info_line.L do
      if ContextTable[InfoLineContext].GUI.info_line.L[_FORV_7_].active == true then
        ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state].L[#ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state].L + 1] = ContextTable[InfoLineContext].GUI.info_line.L[_FORV_7_].text
      end
    end
  end
  if _FOR_.R ~= nil then
    for _FORV_7_ = 1, #ContextTable[InfoLineContext].GUI.info_line.R do
      if ContextTable[InfoLineContext].GUI.info_line.R[_FORV_7_].active == true then
        ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state].R[#ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state].R + 1] = ContextTable[InfoLineContext].GUI.info_line.R[_FORV_7_].text
      end
    end
  end
  return ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state]
end
function RestoreInfoLine_F()
  InfoLines.force = true
  RestoreInfoLine()
  InfoLines.force = false
end
function RestoreInfoLine()
  if InfoLineAllow() == false then
    InfoLineCommand("RestoreInfoLine()")
    return
  end
  if ContextTable[InfoLineContext].GUI.info_line ~= nil and IsTable(ContextTable[InfoLineContext].GUI.info_line.state) and #ContextTable[InfoLineContext].GUI.info_line.state > 0 then
    __SetupInfoLineL2(unpack(ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state].L))
    __SetupInfoLineR2(unpack(ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state].R))
    SetNil(ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state])
    ContextTable[InfoLineContext].GUI.info_line.state[#ContextTable[InfoLineContext].GUI.info_line.state] = nil
  end
end
function PushInfoLine_F(_ARG_0_)
  InfoLines.force = true
  PushInfoLine(_ARG_0_)
  InfoLines.force = false
end
function PushInfoLine(_ARG_0_)
  PushInfoLineL(_ARG_0_)
end
function PushInfoLineL_F(_ARG_0_)
  InfoLines.force = true
  PushInfoLineL(_ARG_0_)
  InfoLines.force = false
end
function PushInfoLineL(_ARG_0_)
  __PushInfoLine(_ARG_0_, true)
end
function PushInfoLineR_F(_ARG_0_)
  InfoLines.force = true
  PushInfoLineR(_ARG_0_)
  InfoLines.force = false
end
function PushInfoLineR(_ARG_0_)
  __PushInfoLine(_ARG_0_, false)
end
function SetupInfoLine_F(...)
  InfoLines.force = true
  SetupInfoLine(unpack(nil))
  InfoLines.force = false
end
function SetupInfoLine(...)
  SetupInfoLineL(unpack(nil))
end
function SetupInfoLineL_F(...)
  InfoLines.force = true
  SetupInfoLineL(unpack(nil))
  InfoLines.force = false
end
function SetupInfoLineL(...)
  __SetupInfoLine(nil, true)
end
function SetupInfoLineR_F(...)
  InfoLines.force = true
  SetupInfoLineR(unpack(nil))
  InfoLines.force = false
end
function SetupInfoLineR(...)
  __SetupInfoLine(nil, false)
end
function __SetupInfoLine(_ARG_0_, _ARG_1_)
  if InfoLineAllow() == false then
    for _FORV_6_ = 1, _ARG_0_.n do
      if _FORV_6_ ~= _ARG_0_.n then
      end
    end
    InfoLineCommand((((Select(_ARG_1_, "SetupInfoLineL", "SetupInfoLineR") .. "( ") .. InfoLineSafeParam(_ARG_0_[_FORV_6_])) .. ", ") .. " )")
    return
  end
  __SetupInfoLine2(_ARG_0_, _ARG_1_)
end
function __DoSetupInfoLine2(_ARG_0_, _ARG_1_)
  if ContextTable[InfoLineContext].GUI.info_line == nil then
    return true
  end
  if Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R) == nil then
    return true
  end
  for _FORV_8_, _FORV_9_ in ipairs((Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R))) do
  end
  if _ARG_0_.n == 0 or _ARG_0_.n ~= 0 + 1 then
    return true
  end
  for _FORV_8_ = 1, _ARG_0_.n do
    if Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_8_].active == false or Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_8_].text ~= _ARG_0_[_FORV_8_] then
      return true
    end
  end
  return _FOR_
end
function __SetupInfoLineL2(...)
  __SetupInfoLine2(nil, true)
end
function __SetupInfoLineR2(...)
  __SetupInfoLine2(nil, false)
end
function __SetupInfoLine2(_ARG_0_, _ARG_1_)
  if __DoSetupInfoLine2(_ARG_0_, _ARG_1_) == false then
    return
  end
  if ContextTable[InfoLineContext].GUI.info_line == nil then
    ContextTable[InfoLineContext].GUI.info_line = {}
    ContextTable[InfoLineContext].GUI.info_line.L = {}
    ContextTable[InfoLineContext].GUI.info_line.R = {}
  end
  if #Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R) == 0 then
    for _FORV_13_ = 1, 8 do
      Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_] = {}
      Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].id = UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_1_, "_info_lineL", "_info_lineR"), InfoLineContext)
      Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].width = 0
    end
  end
  _FOR_.do_timelines[#InfoLines.do_timelines + 1] = Select(_ARG_1_, "SetupInfoLineL", "SetupInfoLineR")
  for _FORV_13_ = 1, 8 do
    UIButtons.SetActive(Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].id, false)
    Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].active = false
  end
  if 8 < _FOR_ then
    _ARG_0_.n = 8
  end
  for _FORV_13_ = 1, _ARG_0_.n do
    UIButtons.SetActive(Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].id, true)
    if _ARG_0_[_FORV_13_] == nil then
      _ARG_0_[_FORV_13_] = UIText.CMN_NOWT
    end
    Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].text = _ARG_0_[_FORV_13_]
    UIButtons.ChangeText(Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].id, _ARG_0_[_FORV_13_])
    Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].width = UIButtons.GetStaticTextLength(Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].id)
    Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].active = true
  end
  for _FORV_13_ = 1, _ARG_0_.n do
    UIButtons.ChangeMouseClickable(Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_13_].id, true)
  end
  for _FORV_14_ = 1, _ARG_0_.n do
    UIButtons.ChangePosition(Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_14_].id, Select(_ARG_1_, Screen.safe.left, Screen.safe.right) + 0 * Select(_ARG_1_, 1, -1), Screen.safe.bottom)
  end
end
function __InfoLineContains(_ARG_0_, _ARG_1_)
  if InfoLineAllow() == false then
    InfoLineCommand(((Select(_ARG_1_, "InfoLineContainsL", "InfoLineContainsR") .. "( ") .. InfoLineSafeParam(_ARG_0_)) .. " )")
    return
  end
  if ContextTable[InfoLineContext].GUI.info_line == nil then
    return
  end
  if Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R) == nil then
    return
  end
  for _FORV_7_ = 1, #Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R) do
    if Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_7_].active == true and Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R)[_FORV_7_].text == _ARG_0_ then
      return true
    end
  end
  return _FOR_
end
function __PushInfoLine(_ARG_0_, _ARG_1_)
  if InfoLineAllow() == false then
    InfoLineCommand(((Select(_ARG_1_, "PushInfoLineL", "PushInfoLineR") .. "( ") .. InfoLineSafeParam(_ARG_0_)) .. " )")
    return
  end
  if ContextTable[InfoLineContext].GUI.info_line == nil then
    Select(_ARG_1_, SetupInfoLineL, SetupInfoLineR)()
  end
  if Select(_ARG_1_, ContextTable[InfoLineContext].GUI.info_line.L, ContextTable[InfoLineContext].GUI.info_line.R) == nil then
    Select(_ARG_1_, SetupInfoLineL, SetupInfoLineR)()
  end
  if Select(_ARG_1_, InfoLineContainsL, InfoLineContainsR)(_ARG_0_) == false then
    Select(_ARG_1_, StoreInfoLine().L, StoreInfoLine().R)[#Select(_ARG_1_, StoreInfoLine().L, StoreInfoLine().R) + 1] = _ARG_0_
    RestoreInfoLine()
  end
end
function SetupNextAndBack_F()
  InfoLines.force = true
  SetupNextAndBack()
  InfoLines.force = false
end
function SetupNextAndBack()
  SetupInfoLineL(UIText.INFO_A_NEXT, UIText.INFO_B_BACK)
end
function SetupMenuOptions_F()
  InfoLines.force = true
  SetupMenuOptions()
  InfoLines.force = false
end
function SetupMenuOptions()
  SetupInfoLineL(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
end
function SetupNext_F()
  InfoLines.force = true
  SetupNext()
  InfoLines.force = false
end
function SetupNext()
  SetupInfoLineL(UIText.INFO_A_NEXT)
end
function SetupBack_F()
  InfoLines.force = true
  SetupBack()
  InfoLines.force = false
end
function SetupBack()
  SetupInfoLineL(UIText.INFO_B_BACK)
end
