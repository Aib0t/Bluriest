GUI = {
  finished = false,
  carousel_branch = "Options",
  OutputSelection = -1,
  UnblockDontChange = false,
  GetSelections = function()
    UIGlobals.OptionsTable.IsCustom = GUI.current_config
    UIGlobals.OptionsTable.Throttle = GUI.KEYCONFIG[GUI.current_config + 1][1]
    UIGlobals.OptionsTable.Brake = GUI.KEYCONFIG[GUI.current_config + 1][2]
    UIGlobals.OptionsTable.SteerLeft = GUI.KEYCONFIG[GUI.current_config + 1][3]
    UIGlobals.OptionsTable.SteerRight = GUI.KEYCONFIG[GUI.current_config + 1][4]
    UIGlobals.OptionsTable.EBrake = GUI.KEYCONFIG[GUI.current_config + 1][5]
    UIGlobals.OptionsTable.Fire = GUI.KEYCONFIG[GUI.current_config + 1][6]
    UIGlobals.OptionsTable.SwitchPerk = GUI.KEYCONFIG[GUI.current_config + 1][7]
    UIGlobals.OptionsTable.ChangeView = GUI.KEYCONFIG[GUI.current_config + 1][8]
    UIGlobals.OptionsTable.Pause = GUI.KEYCONFIG[GUI.current_config + 1][9]
    UIGlobals.OptionsTable.RearView = GUI.KEYCONFIG[GUI.current_config + 1][10]
    UIGlobals.OptionsTable.PowerUpFwd = GUI.KEYCONFIG[GUI.current_config + 1][11]
    UIGlobals.OptionsTable.PowerUpBwd = GUI.KEYCONFIG[GUI.current_config + 1][12]
    UIGlobals.OptionsTable.Drop = GUI.KEYCONFIG[GUI.current_config + 1][13]
  end,
  SetSelections = function()
    if UIGlobals.OptionsTable.IsCustom == 2 then
      GUI.KEYCONFIG[3][1] = UIGlobals.OptionsTable.Throttle
      GUI.KEYCONFIG[3][2] = UIGlobals.OptionsTable.Brake
      GUI.KEYCONFIG[3][3] = UIGlobals.OptionsTable.SteerLeft
      GUI.KEYCONFIG[3][4] = UIGlobals.OptionsTable.SteerRight
      GUI.KEYCONFIG[3][5] = UIGlobals.OptionsTable.EBrake
      GUI.KEYCONFIG[3][6] = UIGlobals.OptionsTable.Fire
      GUI.KEYCONFIG[3][7] = UIGlobals.OptionsTable.SwitchPerk
      GUI.KEYCONFIG[3][8] = UIGlobals.OptionsTable.ChangeView
      GUI.KEYCONFIG[3][9] = UIGlobals.OptionsTable.Pause
      GUI.KEYCONFIG[3][10] = UIGlobals.OptionsTable.RearView
      GUI.KEYCONFIG[3][11] = UIGlobals.OptionsTable.PowerUpFwd
      GUI.KEYCONFIG[3][12] = UIGlobals.OptionsTable.PowerUpBwd
      GUI.KEYCONFIG[3][13] = UIGlobals.OptionsTable.Drop
    end
  end,
  valid = function()
    if GUI.current_config ~= 2 then
      return true
    end
    for _FORV_3_ = 1, #GUI.KEYCONFIG[3] do
      if GUI.KEYCONFIG[3][_FORV_3_] == "CMN_KEYS_QUESTION_MARK" then
        return false
      end
    end
    return _FOR_
  end,
  WaitForInput = false,
  CurrentWaitIndex = -1,
  CanExit = function(_ARG_0_)
    return false
  end,
  key_menu = {},
  map_id = {},
  KEYCONFIG = {
    {},
    {},
    {}
  },
  UpdateKeySet = function(_ARG_0_)
    for _FORV_4_, _FORV_5_ in ipairs(GUI.key_menu) do
      UIButtons.ClearItems(_FORV_5_)
      if Amax.GetPCKeyboard() == "0000040C" then
        if GUI.KEYCONFIG[_ARG_0_][_FORV_4_] == "CMN_Q" then
        elseif GUI.KEYCONFIG[_ARG_0_][_FORV_4_] == "CMN_A" then
        elseif GUI.KEYCONFIG[_ARG_0_][_FORV_4_] == "CMN_Z" then
        elseif GUI.KEYCONFIG[_ARG_0_][_FORV_4_] == "CMN_W" then
        end
      end
      UIButtons.AddItem(_FORV_5_, 0, UIText.CMN_Z, false)
    end
  end,
  FindClickedKeyID = function(_ARG_0_)
    for _FORV_4_, _FORV_5_ in ipairs(GUI.key_menu) do
      if _ARG_0_ == _FORV_5_ then
        return _FORV_5_
      end
    end
    return -1
  end,
  FadeArrows = function()
    if GUI.current_config == 0 then
      UIButtons.TimeLineActive("left_fade", false)
      UIButtons.TimeLineActive("right_fade", true)
    elseif GUI.current_config == 1 then
      UIButtons.TimeLineActive("left_fade", true)
      UIButtons.TimeLineActive("right_fade", false)
    end
  end,
  Animatearrows = function(_ARG_0_)
    if _ARG_0_ > GUI.current_config then
      UIButtons.TimeLineActive("move_right", true, 0)
    else
      UIButtons.TimeLineActive("move_left", true, 0)
    end
  end
}
function Init()
  AddSCUI_Elements()
  GUI.map_id.CMN_1 = 1
  GUI.map_id.CMN_2 = 2
  GUI.map_id.CMN_3 = 3
  GUI.map_id.CMN_4 = 4
  GUI.map_id.CMN_5 = 5
  GUI.map_id.CMN_6 = 6
  GUI.map_id.CMN_7 = 7
  GUI.map_id.CMN_8 = 8
  GUI.map_id.CMN_9 = 9
  GUI.map_id.CMN_0 = 10
  GUI.map_id.CMN_KEYS_MINUS = 11
  GUI.map_id.CMN_KEYS_PLUS = 12
  GUI.map_id.CMN_KEYS_BACKSPACE = 13
  GUI.map_id.CMN_KEYS_TAB = 14
  GUI.map_id.CMN_Q = 15
  GUI.map_id.CMN_W = 16
  GUI.map_id.CMN_E = 17
  GUI.map_id.CMN_R = 18
  GUI.map_id.CMN_T = 19
  GUI.map_id.CMN_Y = 20
  GUI.map_id.CMN_U = 21
  GUI.map_id.CMN_I = 22
  GUI.map_id.CMN_O = 23
  GUI.map_id.CMN_P = 24
  GUI.map_id.CMN_KEYS_LSQR_BRACKET = 25
  GUI.map_id.CMN_KEYS_RSQR_BRACKET = 26
  GUI.map_id.CMN_KEYS_RETURN = 27
  GUI.map_id.CMN_KEYS_LCTRL = 28
  GUI.map_id.CMN_A = 29
  GUI.map_id.CMN_S = 30
  GUI.map_id.CMN_D = 31
  GUI.map_id.CMN_F = 32
  GUI.map_id.CMN_G = 33
  GUI.map_id.CMN_H = 34
  GUI.map_id.CMN_J = 35
  GUI.map_id.CMN_K = 36
  GUI.map_id.CMN_L = 37
  GUI.map_id.CMN_KEYS_SEMI_COLON = 38
  GUI.map_id.CMN_KEYS_APOSTROPHE = 39
  GUI.map_id.CMN_KEYS_GRAVE = 40
  GUI.map_id.CMN_KEYS_LSHIFT = 41
  GUI.map_id.CMN_KEYS_BSLASH = 42
  GUI.map_id.CMN_Z = 43
  GUI.map_id.CMN_X = 44
  GUI.map_id.CMN_C = 45
  GUI.map_id.CMN_V = 46
  GUI.map_id.CMN_B = 47
  GUI.map_id.CMN_N = 48
  GUI.map_id.CMN_M = 49
  GUI.map_id.CMN_KEYS_COMMA = 50
  GUI.map_id.CMN_KEYS_FULLSTOP = 51
  GUI.map_id.CMN_KEYS_FSLASH = 52
  GUI.map_id.CMN_KEYS_RSHIFT = 53
  GUI.map_id.CMN_KEYS_NUMPAD_ASTERISK = 54
  GUI.map_id.CMN_KEYS_LALT = 55
  GUI.map_id.CMN_KEYS_SPACE = 56
  GUI.map_id.CMN_KEYS_F1 = 58
  GUI.map_id.CMN_KEYS_F2 = 59
  GUI.map_id.CMN_KEYS_F3 = 60
  GUI.map_id.CMN_KEYS_F4 = 61
  GUI.map_id.CMN_KEYS_F5 = 62
  GUI.map_id.CMN_KEYS_F6 = 63
  GUI.map_id.CMN_KEYS_F7 = 64
  GUI.map_id.CMN_KEYS_F8 = 65
  GUI.map_id.CMN_KEYS_F9 = 66
  GUI.map_id.CMN_KEYS_F10 = 67
  GUI.map_id.CMN_KEYS_NUMPAD_7 = 70
  GUI.map_id.CMN_KEYS_NUMPAD_8 = 71
  GUI.map_id.CMN_KEYS_NUMPAD_9 = 72
  GUI.map_id.CMN_KEYS_NUMPAD_MINUS = 73
  GUI.map_id.CMN_KEYS_NUMPAD_4 = 74
  GUI.map_id.CMN_KEYS_NUMPAD_5 = 75
  GUI.map_id.CMN_KEYS_NUMPAD_6 = 76
  GUI.map_id.CMN_KEYS_NUMPAD_PLUS = 77
  GUI.map_id.CMN_KEYS_NUMPAD_1 = 78
  GUI.map_id.CMN_KEYS_NUMPAD_2 = 79
  GUI.map_id.CMN_KEYS_NUMPAD_3 = 80
  GUI.map_id.CMN_KEYS_NUMPAD_0 = 81
  GUI.map_id.CMN_KEYS_NUMPAD_POINT = 82
  GUI.map_id.CMN_KEYS_F11 = 84
  GUI.map_id.CMN_KEYS_F12 = 85
  GUI.map_id.CMN_KEYS_NUMPAD_RETURN = 105
  GUI.map_id.CMN_KEYS_RCTRL = 106
  GUI.map_id.CMN_KEYS_NUMPAD_SLASH = 115
  GUI.map_id.CMN_KEYS_RALT = 117
  GUI.map_id.CMN_KEYS_HOME = 119
  GUI.map_id.CMN_KEYS_UP_ARROW = 120
  GUI.map_id.CMN_KEYS_PAGE_UP = 121
  GUI.map_id.CMN_KEYS_LEFT_ARROW = 122
  GUI.map_id.CMN_KEYS_RIGHT_ARROW = 123
  GUI.map_id.CMN_KEYS_END = 124
  GUI.map_id.CMN_KEYS_DOWN_ARROW = 125
  GUI.map_id.CMN_KEYS_PAGE_DOWN = 126
  GUI.map_id.CMN_KEYS_INSERT = 127
  GUI.map_id.CMN_KEYS_DELETE = 128
  GUI.ConfigNodeID = SCUI.name_to_id.SDR_MpCurrentConfig
  GUI.current_config = Amax.UpdateCustomKeyboardControls().IsCustom
  UIButtons.SetActive(GUI.ConfigNodeID, true)
  GUI.MessageListId = SCUI.name_to_id.KeyNodeList
  GUI.AdvancedNodeId = SCUI.name_to_id.Nde_Controller
  GUI.LeftArrow = SCUI.name_to_id.arrow_left
  GUI.RightArrow = SCUI.name_to_id.arrow_right
  GUI.ThrottleNodeID = SCUI.name_to_id.SDR_Throttle
  GUI.BrakeNodeID = SCUI.name_to_id.SDR_Brake
  GUI.SteerLeftNodeID = SCUI.name_to_id.SDR_SteerLeft
  GUI.SteerRightNodeID = SCUI.name_to_id.SDR_SteerRight
  GUI.EBrakeNodeID = SCUI.name_to_id.SDR_EBrake
  GUI.FireNodeID = SCUI.name_to_id.SDR_Fire
  GUI.SwitchPerkNodeID = SCUI.name_to_id.SDR_SwitchPerk
  GUI.ChangeViewNodeID = SCUI.name_to_id.SDR_ChangeView
  GUI.PauseNodeID = SCUI.name_to_id.SDR_Pause
  GUI.RearViewNodeID = SCUI.name_to_id.SDR_LookBack
  GUI.FwdFireNodeID = SCUI.name_to_id.SDR_FireFwd
  GUI.BwdFireNodeID = SCUI.name_to_id.SDR_FireBwd
  GUI.DropNodeID = SCUI.name_to_id.SDR_Drop
  GUI.key_menu[1] = GUI.ThrottleNodeID
  GUI.key_menu[2] = GUI.BrakeNodeID
  GUI.key_menu[3] = GUI.SteerLeftNodeID
  GUI.key_menu[4] = GUI.SteerRightNodeID
  GUI.key_menu[5] = GUI.EBrakeNodeID
  GUI.key_menu[6] = GUI.FireNodeID
  GUI.key_menu[7] = GUI.SwitchPerkNodeID
  GUI.key_menu[8] = GUI.ChangeViewNodeID
  GUI.key_menu[9] = GUI.PauseNodeID
  GUI.key_menu[10] = GUI.RearViewNodeID
  GUI.key_menu[11] = GUI.FwdFireNodeID
  GUI.key_menu[12] = GUI.BwdFireNodeID
  GUI.key_menu[13] = GUI.DropNodeID
  UIButtons.AddItem(GUI.ConfigNodeID, 0, UIText.CMN_OPT_CNT_LAYOUT1, false)
  UIButtons.AddItem(GUI.ConfigNodeID, 1, UIText.CMN_OPT_CNT_LAYOUT2, false)
  GUI.KEYCONFIG[1][1] = "CMN_Q"
  GUI.KEYCONFIG[1][2] = "CMN_A"
  GUI.KEYCONFIG[1][3] = "CMN_KEYS_LEFT_ARROW"
  GUI.KEYCONFIG[1][4] = "CMN_KEYS_RIGHT_ARROW"
  GUI.KEYCONFIG[1][5] = "CMN_KEYS_DOWN_ARROW"
  GUI.KEYCONFIG[1][6] = "CMN_KEYS_RCTRL"
  GUI.KEYCONFIG[1][7] = "CMN_KEYS_UP_ARROW"
  GUI.KEYCONFIG[1][8] = "CMN_V"
  GUI.KEYCONFIG[1][9] = "CMN_P"
  GUI.KEYCONFIG[1][10] = "CMN_KEYS_TAB"
  GUI.KEYCONFIG[1][11] = "CMN_W"
  GUI.KEYCONFIG[1][12] = "CMN_S"
  GUI.KEYCONFIG[1][13] = "CMN_D"
  GUI.KEYCONFIG[2][1] = "CMN_W"
  GUI.KEYCONFIG[2][2] = "CMN_S"
  GUI.KEYCONFIG[2][3] = "CMN_A"
  GUI.KEYCONFIG[2][4] = "CMN_D"
  GUI.KEYCONFIG[2][5] = "CMN_KEYS_SPACE"
  GUI.KEYCONFIG[2][6] = "CMN_KEYS_RCTRL"
  GUI.KEYCONFIG[2][7] = "CMN_KEYS_LEFT_ARROW"
  GUI.KEYCONFIG[2][8] = "CMN_Z"
  GUI.KEYCONFIG[2][9] = "CMN_P"
  GUI.KEYCONFIG[2][10] = "CMN_KEYS_PAGE_DOWN"
  GUI.KEYCONFIG[2][11] = "CMN_KEYS_UP_ARROW"
  GUI.KEYCONFIG[2][12] = "CMN_KEYS_DOWN_ARROW"
  GUI.KEYCONFIG[2][13] = "CMN_KEYS_RIGHT_ARROW"
  GUI.KEYCONFIG[3][1] = "CMN_Q"
  GUI.KEYCONFIG[3][2] = "CMN_A"
  GUI.KEYCONFIG[3][3] = "CMN_KEYS_LEFT_ARROW"
  GUI.KEYCONFIG[3][4] = "CMN_KEYS_RIGHT_ARROW"
  GUI.KEYCONFIG[3][5] = "CMN_KEYS_DOWN_ARROW"
  GUI.KEYCONFIG[3][6] = "CMN_KEYS_RCTRL"
  GUI.KEYCONFIG[3][7] = "CMN_KEYS_UP_ARROW"
  GUI.KEYCONFIG[3][8] = "CMN_V"
  GUI.KEYCONFIG[3][9] = "CMN_P"
  GUI.KEYCONFIG[3][10] = "CMN_KEYS_TAB"
  GUI.KEYCONFIG[3][11] = "CMN_W"
  GUI.KEYCONFIG[3][12] = "CMN_S"
  GUI.KEYCONFIG[3][13] = "CMN_D"
  GUI.SetSelections()
  for _FORV_4_, _FORV_5_ in ipairs(GUI.key_menu) do
    UIButtons.AddItem(_FORV_5_, 0, UIText[GUI.KEYCONFIG[GUI.current_config + 1][_FORV_4_]], false)
  end
  UIButtons.SetSelected(GUI.ConfigNodeID, true)
  UIButtons.SetSelected(GUI.MessageListId, false)
  GUI.do_update_keys = true
  UIButtons.SetSelectionByIndex(GUI.ConfigNodeID, GUI.current_config)
  GUI.UpdateKeySet(GUI.current_config + 1)
  StoreInfoLine()
  SetupMenuOptions()
end
function PostInit()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.WaitForInput == true and _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    GUI.UnblockDontChange = true
  end
  if GUI.WaitForInput == false then
    mouse_overide = false
    if _ARG_0_ == UIEnums.Message.MouseClickInBox and _ARG_3_ == UIScreen.Context() then
      if _ARG_2_ == GUI.LeftArrow then
        UIButtons.SetPreviousItem(GUI.ConfigNodeID)
      elseif _ARG_2_ == GUI.RightArrow then
        UIButtons.SetNextItem(GUI.ConfigNodeID)
      end
      if GUI.FindClickedKeyID(_ARG_2_) ~= -1 then
        if GUI.current_config == 2 then
          UIButtons.SetSelected(GUI.MessageListId, true)
          UIButtons.SetSelected(GUI.ConfigNodeID, false)
          UIButtons.SetCurrentItemByID(GUI.MessageListId, (UIButtons.GetParent(_ARG_2_)))
          mouse_overide = true
        end
      else
        UIButtons.SetSelected(GUI.MessageListId, false)
        UIButtons.SetSelected(GUI.ConfigNodeID, true)
      end
    end
    if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
      if UIButtons.IsSelected(GUI.MessageListId) == true then
        UIButtons.SetSelected(GUI.MessageListId, false)
        UIButtons.SetSelected(GUI.ConfigNodeID, true)
      else
        UIGlobals.SaveOptions = false
        GoScreen("Shared\\Options.lua")
      end
    elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or mouse_overide == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
      PlaySfxNext()
      UIGlobals.SaveOptions = true
      GoScreen("Shared\\Options.lua")
    elseif _ARG_0_ == UIEnums.Message.ButtonLeft or _ARG_0_ == UIEnums.Message.ButtonRight then
      GUI.do_update_keys = true
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.WaitForInput == true then
    if GUI.current_config ~= 2 then
      GUI.WaitForInput = false
      GUI.CurrentWaitIndex = -1
    end
    if GUI.UnblockDontChange == true then
      GUI.CurrentWaitIndex = -1
      GUI.UnblockDontChange = false
      UIButtons.SetBlockInput(GUI.MessageListId, false)
    end
    if UIButtons.GetKeyInput() ~= "" and true == false then
      UIButtons.ClearItems(GUI.key_menu[GUI.CurrentWaitIndex])
      for _FORV_6_ = 1, #GUI.KEYCONFIG[3] do
        if _FORV_6_ ~= GUI.CurrentWaitIndex and GUI.KEYCONFIG[3][_FORV_6_] == UIButtons.GetKeyInput() then
          SetupCustomPopup(UIEnums.CustomPopups.OptionsInvalidKeys)
          UIButtons.AddItem(GUI.key_menu[GUI.CurrentWaitIndex], 0, UIText[GUI.KEYCONFIG[3][GUI.CurrentWaitIndex]], false)
        end
      end
      if true == false then
        UIButtons.AddItem(GUI.key_menu[GUI.CurrentWaitIndex], 0, UIText[UIButtons.GetKeyInput()], false)
        GUI.KEYCONFIG[3][GUI.CurrentWaitIndex] = UIButtons.GetKeyInput()
      end
      GUI.WaitForInput = false
      GUI.CurrentWaitIndex = -1
      UIButtons.SetBlockInput(GUI.MessageListId, false)
    end
  end
  if GUI.current_config ~= 2 then
    UIButtons.SetSelected(GUI.MessageListId, false)
  end
  if GUI.do_update_keys == true and UIButtons.GetSelection(GUI.ConfigNodeID) ~= GUI.current_config then
    GUI.Animatearrows((UIButtons.GetSelection(GUI.ConfigNodeID)))
    GUI.current_config = UIButtons.GetSelection(GUI.ConfigNodeID)
    GUI.UpdateKeySet(UIButtons.GetSelection(GUI.ConfigNodeID) + 1)
    do_update_keys = false
    GUI.FadeArrows()
  end
end
function Render()
end
function EnterEnd()
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function EnterEnd()
  RestoreInfoLine()
end
function End()
  if UIGlobals.SaveOptions == true then
    GetScreenOtions().selection = UIButtons.GetSelectionIndex(GUI.MessageListId)
    UIGlobals.OptionsTable.IsCustom = GUI.current_config
    UIGlobals.OptionsTable.Throttle = GUI.map_id[UIGlobals.OptionsTable.Throttle]
    UIGlobals.OptionsTable.Brake = GUI.map_id[UIGlobals.OptionsTable.Brake]
    UIGlobals.OptionsTable.SteerLeft = GUI.map_id[UIGlobals.OptionsTable.SteerLeft]
    UIGlobals.OptionsTable.SteerRight = GUI.map_id[UIGlobals.OptionsTable.SteerRight]
    UIGlobals.OptionsTable.EBrake = GUI.map_id[UIGlobals.OptionsTable.EBrake]
    UIGlobals.OptionsTable.Fire = GUI.map_id[UIGlobals.OptionsTable.Fire]
    UIGlobals.OptionsTable.SwitchPerk = GUI.map_id[UIGlobals.OptionsTable.SwitchPerk]
    UIGlobals.OptionsTable.ChangeView = GUI.map_id[UIGlobals.OptionsTable.ChangeView]
    UIGlobals.OptionsTable.Pause = GUI.map_id[UIGlobals.OptionsTable.Pause]
    UIGlobals.OptionsTable.RearView = GUI.map_id[UIGlobals.OptionsTable.RearView]
    UIGlobals.OptionsTable.PowerUpFwd = GUI.map_id[UIGlobals.OptionsTable.PowerUpFwd]
    UIGlobals.OptionsTable.PowerUpBwd = GUI.map_id[UIGlobals.OptionsTable.PowerUpBwd]
    UIGlobals.OptionsTable.Drop = GUI.map_id[UIGlobals.OptionsTable.Drop]
    Amax.UpdateCustomKeyboardControls(UIGlobals.OptionsTable, GUI.current_config)
  end
end
