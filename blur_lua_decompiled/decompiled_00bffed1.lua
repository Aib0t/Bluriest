GUI = {
  finished = false,
  timer = 0,
  checking_for_signin_wait_time = 0.25,
  checking_for_signin = false,
  waiting_for_signin = false,
  signin_wait_time = 1,
  signin_wait_timer = 0,
  waiting_for_load = false,
  check_for_dlc = false,
  check_for_dlc_time = 0.25,
  check_for_dlc_timer = 0,
  check_for_connection = false,
  check_for_connection_time = 0.25,
  check_for_connection_timer = 0,
  waiting_to_finish = false,
  waiting_to_finish_time = 5.6
}
function Init()
  AddSCUI_Elements()
  UIScreen.SetScreenTimers(0.3, 0.3)
  StoreInfoLine()
  SetupInfoLine()
  UIGlobals.ProfileBootContext = UIScreen.Context()
  UIGlobals.CallbackDLC = nil
  GUI.checking_for_signin = true
end
function PostInit()
  UIGlobals.boot_help_text_id, UIGlobals.boot_bottom_help_id = SetupBottomHelpBar(nil, nil, nil, nil, nil, 1.8)
  UIButtons.PrivateTimeLineActive(UIGlobals.boot_bottom_help_id, "Hide_BottomHelp", true, 0)
  UIButtons.ChangeText(SCUI.name_to_id.auto_saving_text, UIText.POP_AUTO_SAVE_WARNING)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function FrameUpdate(_ARG_0_)
  if GUI.checking_for_signin == true then
    print("..1..")
    if Profile.PadProfileActive(UIGlobals.ProfilePressedStart) == false then
      UIHardware.StartSigninUI(1)
    else
      GUI.checking_for_signin_wait_time = 0
      GUI.signin_wait_time = 0
    end
    GUI.checking_for_signin = false
    GUI.waiting_for_signin = true
  end
  if GUI.waiting_for_signin == true and GUI.timer > GUI.checking_for_signin_wait_time then
    print("..2..")
    if Profile.GuideActive() == false then
      if GUI.signin_wait_timer > GUI.signin_wait_time then
        GUI.waiting_for_signin = false
        Profile.ActOnProfileChanges(true)
        StartAsyncLoad()
        GUI.waiting_for_load = true
      end
      GUI.signin_wait_timer = GUI.signin_wait_timer + _ARG_0_
    end
  end
  if GUI.waiting_for_load == true and UIGlobals.FileParams.FinishedSuccess ~= nil then
    print("..3..")
    if Boot_TryDLC() == false and Boot_TryConnection() == false then
      Boot_Finished()
    end
    GUI.waiting_for_load = false
  end
  if GUI.check_for_dlc == true then
    print("..4..")
    if GUI.check_for_dlc_timer > GUI.check_for_dlc_time then
      Boot_GoDLC()
      GUI.check_for_dlc = false
    else
      GUI.check_for_dlc_timer = GUI.check_for_dlc_timer + _ARG_0_
    end
  end
  if GUI.check_for_connection == true then
    print("..5..")
    if GUI.check_for_connection_timer > GUI.check_for_connection_time then
      Boot_GoConnection()
      GUI.check_for_connection = false
    else
      GUI.check_for_connection_timer = GUI.check_for_connection_timer + _ARG_0_
    end
  end
  if GUI.waiting_to_finish == true then
    print("..6..")
    UIGlobals.ProfileBootFinished = true
    PopScreen()
  end
  GUI.timer = GUI.timer + _ARG_0_
end
function EnterEnd()
  RestoreInfoLine()
  UIButtons.TimeLineActive("auto_save_warning_on", false)
  UIButtons.PrivateTimeLineActive(UIGlobals.boot_bottom_help_id, "Hide_BottomHelp", true)
end
function EndLoop(_ARG_0_)
end
function End()
end
function Boot_TryDLC()
  if IsTable(ContextTable[UIGlobals.ProfileBootContext]) == false then
    return false
  end
  ContextTable[UIGlobals.ProfileBootContext].GUI.check_for_dlc = UIGlobals.ProfileState[Profile.GetPrimaryPad()] == UIEnums.Profile.GamerProfile
  return ContextTable[UIGlobals.ProfileBootContext].GUI.check_for_dlc
end
function Boot_GoDLC()
  UIGlobals.CallbackDLC = Boot_CallbackDLC
  SetupCustomPopup(UIEnums.CustomPopups.CheckForDLC)
end
function Boot_CallbackDLC(_ARG_0_)
  print("Boot_CallbackDLC - success", _ARG_0_)
  if Boot_TryConnection() == false then
    Boot_Finished()
  end
end
function Boot_TryConnection()
  if IsTable(ContextTable[UIGlobals.ProfileBootContext]) == false then
    return false
  end
  if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    ContextTable[UIGlobals.ProfileBootContext].GUI.check_for_connection = NetServices.NetworkConnectionActive() == true
  else
    ContextTable[UIGlobals.ProfileBootContext].GUI.check_for_connection = net_CanReconnectToDemonware() == true
  end
  return ContextTable[UIGlobals.ProfileBootContext].GUI.check_for_connection
end
function Boot_GoConnection()
  UIGlobals.NetConnectionDarken = false
  net_StartServiceConnection(true, Boot_CallbackConnection)
end
function Boot_CallbackConnection(_ARG_0_)
  print("Boot_CallbackConnection - success", _ARG_0_)
  UIGlobals.NetConnectionDarken = true
  Boot_Finished()
end
function Boot_Finished()
  if IsTable(ContextTable[UIGlobals.ProfileBootContext]) == false then
    return false
  end
  ContextTable[UIGlobals.ProfileBootContext].GUI.waiting_to_finish = true
end
