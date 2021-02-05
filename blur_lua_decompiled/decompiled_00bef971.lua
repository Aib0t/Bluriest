GUI = {
  finished = false,
  carousel_branch = "MpSplitscreenSignIn",
  CanExit = function(_ARG_0_, _ARG_1_)
    if UIGlobals.ProfilesFound == 0 then
      print("Blagging profile " .. _ARG_1_)
      UIGlobals.ProfileState[_ARG_1_] = UIEnums.Profile.Blagged
      Profile.ClearProfile(_ARG_1_)
      GameProfile.ClearGameProfile(_ARG_1_, true)
      Profile.Setup(_ARG_1_, true)
      Profile.SetPrimaryPad(_ARG_1_)
      UIGlobals.ProfilesFound = 1
    end
    SplitscreenSignIn_ValidateProfiles(false)
    Splitscreen_Clear()
    PlaySfxGraphicBack()
    _ARG_0_.reset_controls_to_sp = true
    return true
  end,
  ProfileState = {},
  primary_pad_inactive = false,
  can_continue = false,
  demo = false,
  gamerpic_ids = {},
  frame_ids = {},
  name_ids = {},
  info1_ids = {},
  info2_ids = {},
  pad_icon_ids = {},
  pad_connect_ids = {},
  pad_connected = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true
  },
  pad_connected_prev = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true
  },
  ProfileDevice = {},
  update_player_info = false
}
function Init()
  Amax.SetSplitscreenKeyboards()
  AddSCUI_Elements()
  DeferCam_Init(UIGlobals.CameraNames.MpAppBase)
  CarouselApp_SetScreenTimers()
  StoreInfoLine()
  SetupInfoLine()
  for _FORV_3_ = 0, 3 do
    GUI.ProfileDevice[_FORV_3_] = UIGlobals.ProfileDevice[_FORV_3_]
    UIGlobals.LoadProfile[_FORV_3_] = false
    GUI.ProfileState[_FORV_3_] = UIGlobals.ProfileState[_FORV_3_]
    GUI.gamerpic_ids[_FORV_3_] = SCUI.name_to_id["gamerpic_" .. _FORV_3_]
    GUI.frame_ids[_FORV_3_] = SCUI.name_to_id["frame_" .. _FORV_3_]
    GUI.name_ids[_FORV_3_] = SCUI.name_to_id["name_" .. _FORV_3_]
    GUI.info1_ids[_FORV_3_] = SCUI.name_to_id["info1_" .. _FORV_3_]
    GUI.info2_ids[_FORV_3_] = SCUI.name_to_id["info2_" .. _FORV_3_]
    GUI.pad_icon_ids[_FORV_3_] = SCUI.name_to_id["player_pad_icon_" .. _FORV_3_]
    GUI.pad_connect_ids[_FORV_3_] = SCUI.name_to_id["connect_pad_" .. _FORV_3_]
    UIButtons.ChangeColour(GUI.frame_ids[_FORV_3_], UIGlobals.Splitscreen.colours[_FORV_3_])
    UIButtons.ChangeColour(GUI.name_ids[_FORV_3_], UIGlobals.Splitscreen.colours[_FORV_3_])
    UIButtons.ChangeText(GUI.name_ids[_FORV_3_], "PROFILE_PAD" .. _FORV_3_ .. "_NAME")
    UIButtons.ChangeColour(GUI.pad_icon_ids[_FORV_3_], UIGlobals.Splitscreen.colours[_FORV_3_])
    if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
      UIShape.ChangeObjectName(GUI.pad_icon_ids[_FORV_3_], "ps3_controller")
    end
  end
  GUI.info1_size_x, GUI.info1_size_y = UIButtons.GetSize(GUI.info1_ids[1])
  Profile.AllowProfileChanges(true)
  Profile.ActOnProfileChanges(false)
  Profile.AllowAllPadInput(true)
  Profile.LockToPad(-1)
end
function PostInit()
  if UIGlobals.splitscreen_enter == true then
    UIGlobals.splitscreen_enter = false
    UIGlobals.ProfileDevice[UIGlobals.splitscreen_primary_pad_original] = UIGlobals.LastInputDevice
  end
  if UIGlobals.ProfileDevice[UIGlobals.splitscreen_primary_pad_original] ~= UIEnums.Device.Keyboard then
    UIButtons.SetParent(SCUI.name_to_id.primary_player_rb, SCUI.name_to_id["dummy_" .. UIGlobals.splitscreen_primary_pad_original + 1], UIEnums.Justify.MiddleCentre)
    UIButtons.SetActive(GUI.pad_icon_ids[UIGlobals.splitscreen_primary_pad_original], false)
    UIButtons.ChangeColour(SCUI.name_to_id.primary_player_km, UIGlobals.Splitscreen.colours[UIGlobals.splitscreen_primary_pad_original])
    UIButtons.ChangeColour(SCUI.name_to_id.primary_pad_icon, UIGlobals.Splitscreen.colours[UIGlobals.splitscreen_primary_pad_original])
  end
  SplitscreenSignIn_UpdatePlayerInfo()
  SplitscreenSignIn_UpdatePadChanges(true)
end
function CalcCanContinue()
  for _FORV_4_ = 0, 3 do
  end
  GUI.can_continue = 1 < 0 + 1
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    GUI.can_continue = 1 < 0 + 1 and GUI.primary_pad_inactive == false
  end
end
function StartLoop(_ARG_0_)
  DeferCam_Update(_ARG_0_)
end
function FrameUpdate(_ARG_0_)
  DeferCam_Update(_ARG_0_)
  if GUI.finished == true then
    return
  end
  CalcCanContinue()
  if GUI.can_continue == true then
    SetupNextAndBack()
  else
    SetupBack()
  end
  if GUI.update_player_info == true then
    GUI.update_player_info = false
    SplitscreenSignIn_UpdatePlayerInfo()
  end
  SplitscreenSignIn_UpdatePadChanges()
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    if GUI.primary_pad_inactive == true then
      UIButtons.ChangeText(GUI.info1_ids[Profile.GetPrimaryPad()], UIText.PRO_SS_CONNECT_CONTROLLER)
      UIButtons.ChangeSize(GUI.info1_ids[Profile.GetPrimaryPad()], GUI.info1_size_x, GUI.info1_size_y * 0.7)
    else
      UIButtons.ChangeText(GUI.info1_ids[Profile.GetPrimaryPad()], UIText.CMN_NOWT)
      UIButtons.ChangeSize(GUI.info1_ids[Profile.GetPrimaryPad()], GUI.info1_size_x, GUI.info1_size_y)
    end
    GUI.primary_pad_inactive = false
  end
  for _FORV_4_ = 0, 3 do
    GUI.pad_connected[_FORV_4_] = true
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) ~= -1 then
    _ARG_1_ = 0
  end
  if _ARG_0_ == UIEnums.Message.ControllerDisconnected and _ARG_1_ == Profile.GetPrimaryPad() then
    if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
      GUI.primary_pad_inactive = true
    elseif UIEnums.CurrentPlatform == UIEnums.Platform.PC and UIGlobals.ProfileDevice[_ARG_1_] ~= UIEnums.Device.Keyboard then
      GUI.primary_pad_inactive = true
    end
  elseif _ARG_0_ == UIEnums.Message.ControllerDisconnected and UIGlobals.ProfileState[_ARG_1_] == UIEnums.Profile.Blagged then
    if UIEnums.CurrentPlatform ~= UIEnums.Platform.PC then
      _ARG_0_ = UIEnums.Message.ButtonY
    elseif UIGlobals.ProfileDevice[_ARG_1_] ~= UIEnums.Device.Keyboard then
      _ARG_0_ = UIEnums.Message.ButtonY
    end
  end
  if _ARG_0_ == UIEnums.Message.ProfileChanged and GUI.demo == false then
    print("ProfileChanged")
    for _FORV_9_ = 0, 3 do
      if Profile.PadProfileSignedIn(_FORV_9_) == true then
        print("profile active", _FORV_9_)
        if UIGlobals.ProfileState[_FORV_9_] == UIEnums.Profile.None or UIGlobals.ProfileState[_FORV_9_] == UIEnums.Profile.Blagged then
          print("profile signed in", _FORV_9_)
          if _FORV_9_ == UIGlobals.splitscreen_primary_pad_original then
            ProfileSignedInOut(true, _FORV_9_)
          end
          UIGlobals.ProfileState[_FORV_9_] = UIEnums.Profile.GamerProfile
          UIGlobals.LoadProfile[_FORV_9_] = true
        end
      elseif Profile.PadProfileActive(_FORV_9_) == false then
        print("no profile", _FORV_9_)
        if UIGlobals.ProfileState[_FORV_9_] == UIEnums.Profile.GamerProfile or UIGlobals.ProfileState[_FORV_9_] == UIEnums.Profile.PreLoad then
          print("profile signed out", _FORV_9_)
          if _FORV_9_ == UIGlobals.splitscreen_primary_pad_original then
            ProfileSignedInOut(false, _FORV_9_)
          end
          UIGlobals.ProfileState[_FORV_9_] = UIEnums.Profile.None
          Profile.ClearProfile(_FORV_9_)
          GameProfile.ClearGameProfile(_FORV_9_, true)
          UIGlobals.LoadProfile[_FORV_9_] = false
        else
          Profile.ClearProfile(_FORV_9_)
          GameProfile.ClearGameProfile(_FORV_9_, true)
          UIGlobals.LoadProfile[_FORV_9_] = false
        end
      else
        print("profile blagged", _FORV_9_)
      end
    end
    _FOR_.ProfilesFound = 0
    for _FORV_9_ = 0, 3 do
      if UIGlobals.ProfileState[_FORV_9_] ~= UIEnums.Profile.None then
        UIGlobals.ProfilesFound = UIGlobals.ProfilesFound + 1
      end
    end
    print("profiles found", UIGlobals.ProfilesFound)
    GUI.update_player_info = true
    CalcCanContinue()
  end
  if _ARG_0_ == UIEnums.Message.ButtonY then
    if _ARG_1_ ~= UIGlobals.splitscreen_primary_pad_original and _ARG_4_ == UIEnums.Device.Keyboard then
      for _FORV_10_ = 0, 3 do
        if UIGlobals.ProfileState[_FORV_10_] == UIEnums.Profile.Blagged and UIGlobals.ProfileDevice[_FORV_10_] == UIEnums.Device.Keyboard then
          break
        end
      end
      if _FORV_10_ == -1 then
        for _FORV_11_ = 0, 3 do
          if UIGlobals.ProfileState[_FORV_11_] == UIEnums.Profile.None then
            break
          end
        end
        if _FORV_11_ == -1 then
          PlaySfxError()
        else
          PlaySfxToggle()
          UIGlobals.ProfileState[_FORV_11_] = UIEnums.Profile.Blagged
          UIGlobals.ProfileDevice[_FORV_11_] = _ARG_4_
          Profile.ClearProfile(_FORV_11_)
          GameProfile.ClearGameProfile(_FORV_11_, true)
          Profile.Setup(_FORV_11_, true)
          UIGlobals.ProfilesFound = UIGlobals.ProfilesFound + 1
        end
      else
        PlaySfxToggle()
        UIGlobals.ProfileState[_FORV_10_] = UIEnums.Profile.None
        UIGlobals.ProfileDevice[_FORV_10_] = -1
        Profile.ClearProfile(_FORV_10_)
        GameProfile.ClearGameProfile(_FORV_10_, true)
        UIGlobals.ProfilesFound = UIGlobals.ProfilesFound - 1
      end
    elseif UIGlobals.ProfileState[_ARG_1_] == UIEnums.Profile.PreLoad then
      PlaySfxToggle()
      UIGlobals.LoadProfile[_ARG_1_] = true
      UIGlobals.ProfileState[_ARG_1_] = UIEnums.Profile.GamerProfile
      UIGlobals.ProfileDevice[_ARG_1_] = _ARG_4_
    elseif UIGlobals.ProfileState[_ARG_1_] == UIEnums.Profile.None then
      PlaySfxToggle()
      UIGlobals.ProfileState[_ARG_1_] = UIEnums.Profile.Blagged
      UIGlobals.ProfileDevice[_ARG_1_] = _ARG_4_
      Profile.ClearProfile(_ARG_1_)
      GameProfile.ClearGameProfile(_ARG_1_, true)
      Profile.Setup(_ARG_1_, true)
      UIGlobals.ProfilesFound = UIGlobals.ProfilesFound + 1
    elseif UIGlobals.ProfileState[_ARG_1_] == UIEnums.Profile.Blagged then
      PlaySfxToggle()
      if UIGlobals.ProfileDevice[_ARG_1_] == UIEnums.Device.Keyboard then
        for _FORV_10_ = 0, 3 do
          if UIGlobals.ProfileState[_FORV_10_] == UIEnums.Profile.None then
            break
          end
        end
        if _FORV_10_ ~= -1 then
          UIGlobals.ProfileState[_FORV_10_] = UIEnums.Profile.Blagged
          UIGlobals.ProfileDevice[_FORV_10_] = UIGlobals.ProfileDevice[_ARG_1_]
          Profile.ClearProfile(_FORV_10_)
          GameProfile.ClearGameProfile(_FORV_10_, true)
          Profile.Setup(_FORV_10_, true)
          UIGlobals.ProfilesFound = UIGlobals.ProfilesFound + 1
        end
        UIGlobals.ProfileDevice[_ARG_1_] = _ARG_4_
      else
        UIGlobals.ProfileState[_ARG_1_] = UIEnums.Profile.None
        UIGlobals.ProfileDevice[_ARG_1_] = -1
        Profile.ClearProfile(_ARG_1_)
        GameProfile.ClearGameProfile(_ARG_1_, true)
        UIGlobals.ProfilesFound = UIGlobals.ProfilesFound - 1
      end
    elseif UIGlobals.ProfileState[_ARG_1_] == UIEnums.Profile.GamerProfile then
      if _ARG_1_ ~= UIGlobals.splitscreen_primary_pad_original == true then
        PlaySfxToggle()
        UIGlobals.LoadProfile[_ARG_1_] = false
        UIGlobals.ProfileState[_ARG_1_] = UIEnums.Profile.PreLoad
      end
    end
    GUI.update_player_info = true
    CalcCanContinue()
  end
  if _ARG_1_ == 5 then
    for _FORV_9_ = 0, 3 do
      if UIGlobals.ProfileState[_FORV_9_] == UIEnums.Profile.Blagged and UIGlobals.ProfileDevice[_FORV_9_] == UIEnums.Device.Keyboard then
        _ARG_1_ = _FORV_9_
        break
      end
    end
  end
  if (_ARG_0_ == _FOR_.Message.MenuNext or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA) and GUI.can_continue == true and (UIGlobals.ProfileState[_ARG_1_] == UIEnums.Profile.GamerProfile or UIGlobals.ProfileState[_ARG_1_] == UIEnums.Profile.Blagged) then
    SplitscreenSignIn_ValidateProfiles(true)
  end
end
function EnterEnd()
  RestoreInfoLine()
  Profile.AllowProfileChanges(true)
  Profile.ActOnProfileChanges(true)
  Profile.AllowAllPadInput(false)
  Profile.LockToPad(Profile.GetPrimaryPad())
  if GUI.reset_controls_to_sp == true then
    Amax.Options(nil)
    GUI.reset_controls_to_sp = false
  end
end
function End()
end
function SplitscreenSignIn_UpdatePlayerInfo()
  for _FORV_5_ = 0, 3 do
    if UIGlobals.ProfileState[_FORV_5_] == UIEnums.Profile.GamerProfile then
      UIButtons.TimeLineActive("player_active_" .. _FORV_5_, true)
      if (UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC) == true or GUI.demo == true then
        UIButtons.ChangeText(GUI.info1_ids[_FORV_5_], UIText.CMN_NOWT)
        UIButtons.ChangeText(GUI.info2_ids[_FORV_5_], UIText.CMN_NOWT)
      else
        UIButtons.ChangeText(GUI.info1_ids[_FORV_5_], UIText.PRO_SS_SIGN_OUT_J)
        UIButtons.ChangeText(GUI.info2_ids[_FORV_5_], Select(_FORV_5_ ~= UIGlobals.splitscreen_primary_pad_original, UIText.PRO_SS_LEAVE_Y, UIText.CMN_NOWT))
      end
    elseif UIGlobals.ProfileState[_FORV_5_] == UIEnums.Profile.None then
      UIButtons.TimeLineActive("player_active_" .. _FORV_5_, false)
      if (UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC) == true or GUI.demo == true then
        UIButtons.ChangeText(GUI.info1_ids[_FORV_5_], UIText.PRO_SS_JOIN_PCP_PCY)
        UIButtons.ChangeText(GUI.info2_ids[_FORV_5_], UIText.CMN_NOWT)
      else
        UIButtons.ChangeText(GUI.info1_ids[_FORV_5_], UIText.PRO_SS_SIGN_IN_J)
        UIButtons.ChangeText(GUI.info2_ids[_FORV_5_], UIText.PRO_SS_JOIN_Y)
      end
    elseif UIGlobals.ProfileState[_FORV_5_] == UIEnums.Profile.PreLoad then
      UIButtons.TimeLineActive("player_active_" .. _FORV_5_, false)
      if (UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC) == true or GUI.demo == true then
        UIButtons.ChangeText(GUI.info1_ids[_FORV_5_], UIText.CMN_NOWT)
        UIButtons.ChangeText(GUI.info2_ids[_FORV_5_], UIText.CMN_NOWT)
      else
        UIButtons.ChangeText(GUI.info1_ids[_FORV_5_], UIText.PRO_SS_SIGN_OUT_J)
        UIButtons.ChangeText(GUI.info2_ids[_FORV_5_], UIText.PRO_SS_JOIN_Y)
      end
    elseif UIGlobals.ProfileState[_FORV_5_] == UIEnums.Profile.Blagged then
      UIButtons.TimeLineActive("player_active_" .. _FORV_5_, true)
      if (UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC) == true or GUI.demo == true then
        UIButtons.ChangeText(GUI.info1_ids[_FORV_5_], UIText.PRO_SS_LEAVE_PCP_PCY)
        UIButtons.ChangeText(GUI.info2_ids[_FORV_5_], UIText.CMN_NOWT)
      else
        UIButtons.ChangeText(GUI.info1_ids[_FORV_5_], UIText.PRO_SS_SIGN_IN_J)
        UIButtons.ChangeText(GUI.info2_ids[_FORV_5_], UIText.PRO_SS_LEAVE_Y)
      end
    else
      print("*** ERROR: invalid profile state ***")
    end
    SplitscreenSignIn_UpdatePad(_FORV_5_)
  end
end
function SplitscreenSignIn_ValidateProfiles(_ARG_0_)
  for _FORV_6_ = 0, 3 do
    if (UIGlobals.ProfileState[_FORV_6_] == UIEnums.Profile.GamerProfile or UIGlobals.ProfileState[_FORV_6_] == UIEnums.Profile.Blagged) and _FORV_6_ == Profile.GetPrimaryPad() then
      break
    end
  end
  if _FORV_6_ == -1 then
    for _FORV_6_ = 0, 3 do
      if UIGlobals.ProfileState[_FORV_6_] == UIEnums.Profile.GamerProfile or UIGlobals.ProfileState[_FORV_6_] == UIEnums.Profile.Blagged then
        break
      end
    end
  end
  if _FORV_6_ == -1 then
    print("new_primary_pad == -1. This is bad - setting to pad0 to be safe")
  end
  Profile.SetPrimaryPad(0)
  if _ARG_0_ == true and UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
    for _FORV_7_ = 0, 3 do
      if UIGlobals.LoadProfile[_FORV_7_] == true then
        break
      end
    end
  end
  if _ARG_0_ == true then
    UIGlobals.Splitscreen.players = {}
    UIGlobals.Splitscreen.pad_to_player = {}
    for _FORV_9_ = 0, 3 do
      if UIGlobals.ProfileState[_FORV_9_] == UIEnums.Profile.GamerProfile or UIGlobals.ProfileState[_FORV_9_] == UIEnums.Profile.Blagged then
        UIGlobals.Splitscreen.players[#UIGlobals.Splitscreen.players + 1] = {
          pad = _FORV_9_,
          car_id = 0,
          colour_id = 0
        }
        UIGlobals.Splitscreen.pad_to_player[_FORV_9_] = #UIGlobals.Splitscreen.players
        if _FORV_9_ == UIGlobals.splitscreen_primary_pad_original then
        else
        end
      end
    end
    _FOR_.SetSplitscreenKeyboards(_FORV_9_, _FORV_9_)
  end
  if true == true then
    StoreScreen(UIEnums.ScreenStorage.FE_BACK, UIScreen.GetCurrentScreen(UIScreen.Context()))
    net_SetRichPresence(UIEnums.RichPresence.SplitScreen)
    GoScreen("Multiplayer\\Shared\\MpModeSelect.lua")
    PlaySfxNext()
    PlaySfxGraphicNext()
  elseif _ARG_0_ == true then
    StoreScreen(UIEnums.ScreenStorage.FE_BACK, UIScreen.GetCurrentScreen(UIScreen.Context()))
    net_SetRichPresence(UIEnums.RichPresence.SplitScreen)
    GoScreen("Multiplayer\\Shared\\MpModeSelect.lua")
    PlaySfxNext()
    PlaySfxGraphicNext()
  end
end
function SplitscreenSignIn_UpdatePadChanges(_ARG_0_)
  for _FORV_4_ = 0, 3 do
    if _ARG_0_ == true then
      SplitscreenSignIn_UpdatePad(_FORV_4_)
    else
      GUI.pad_connected_prev[_FORV_4_] = GUI.pad_connected[_FORV_4_]
      SplitscreenSignIn_UpdatePad(_FORV_4_)
    end
  end
end
function SplitscreenSignIn_UpdatePad(_ARG_0_)
  if UIGlobals.ProfileDevice[_ARG_0_] == UIEnums.Device.Keyboard then
    UIShape.ChangeSceneName(GUI.pad_icon_ids[_ARG_0_], "common_icons")
    UIShape.ChangeObjectName(GUI.pad_icon_ids[_ARG_0_], "keyboard_mouse")
  else
    UIShape.ChangeSceneName(GUI.pad_icon_ids[_ARG_0_], "fe_icons")
    UIShape.ChangeObjectName(GUI.pad_icon_ids[_ARG_0_], "controller")
  end
  if GUI.pad_connected[_ARG_0_] == true or _ARG_0_ == Profile.GetPrimaryPad() and GUI.primary_pad_inactive == true then
    UIButtons.SetActive(GUI.name_ids[_ARG_0_], true)
    UIButtons.SetActive(GUI.info1_ids[_ARG_0_], true)
    UIButtons.SetActive(GUI.info2_ids[_ARG_0_], true)
    UIButtons.SetActive(GUI.pad_connect_ids[_ARG_0_], false)
    if UIGlobals.ProfileState[_ARG_0_] == UIEnums.Profile.None or UIGlobals.ProfileState[_ARG_0_] == UIEnums.Profile.PreLoad then
    end
    UIButtons.ChangeColour(GUI.gamerpic_ids[_ARG_0_], "Main_Black")
    UIButtons.ChangeColour(GUI.frame_ids[_ARG_0_], "Main_Black")
    UIButtons.ChangeColour(GUI.name_ids[_ARG_0_], "Main_Black")
    UIButtons.ChangeColour(GUI.pad_icon_ids[_ARG_0_], "Main_Black")
  else
    UIButtons.SetActive(GUI.name_ids[_ARG_0_], false)
    UIButtons.SetActive(GUI.info1_ids[_ARG_0_], false)
    UIButtons.SetActive(GUI.info2_ids[_ARG_0_], false)
    UIButtons.SetActive(GUI.pad_connect_ids[_ARG_0_], true)
    UIButtons.ChangeColour(GUI.gamerpic_ids[_ARG_0_], "Main_Black")
    UIButtons.ChangeColour(GUI.frame_ids[_ARG_0_], "Main_Black")
    UIButtons.ChangeColour(GUI.name_ids[_ARG_0_], "Main_Black")
    UIButtons.ChangeColour(GUI.pad_icon_ids[_ARG_0_], "Main_Black")
  end
end
