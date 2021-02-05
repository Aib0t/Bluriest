GUI = {
  finished = false,
  started = false,
  delay = 0,
  timeout = 0,
  failed = false,
  complete = false,
  carousel_branch = "Group",
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  StoreInfoLine()
  SetupInfoLine()
  UIScreen.SetScreenTimers(0.3, 0.3, UIScreen.Context())
  net_EnableGlobalUpdate(false)
  AddSCUI_Elements()
  GUI.connecting_online_txt = SCUI.name_to_id.Connecting_Online
  GUI.connecting_offline_txt = SCUI.name_to_id.Connecting_Offline
  GUI.failed_online_txt = SCUI.name_to_id.Failed_Online
  GUI.failed_offline_txt = SCUI.name_to_id.Failed_Offline
  SetCorrectText()
end
function PostInit()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true and GUI.complete == true then
    PlaySfxNext()
    MoveOn()
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == false then
    SetCorrectText()
    if GUI.complete == true then
      GUI.timeout = GUI.timeout + _ARG_0_
      if GUI.timeout > 5 then
        MoveOn()
      end
    elseif GUI.started == false then
      GUI.delay = GUI.delay + _ARG_0_
      if GUI.delay >= 1 then
        Begin()
      end
    else
      Monitor()
    end
  end
end
function Render()
end
function EnterEnd()
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
  UIGlobals.server_connection.active = false
end
function Begin()
  if NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionStateComplete and NetServices.ConnectionStatus() == true and UIGlobals.server_connection.online_mode == false then
    CompleteConnect()
  else
    GUI.started = true
    net_FlushEverything(true)
    if NetServices.Connect(UIGlobals.server_connection.online_mode) == false then
      FailConnect()
    end
  end
end
function Monitor()
  if NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionStateComplete then
    CompleteConnect()
  elseif NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionStateFailed or NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionStateNotActive then
    if NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionResultNoServiceProvider then
      GUI.failed = true
      GUI.complete = true
      net_CloseServiceConnection()
      MoveOn()
    elseif NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionResultInvalidUserName then
      FailConnect()
    elseif NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionResultInvalidPassword then
      FailConnect()
    else
      FailConnect()
    end
  end
end
function MoveOn()
  net_EnableGlobalUpdate(true)
  if GUI.failed == false then
    GoScreen(GetStoredScreen(UIEnums.ScreenStorage.FE_NEXT))
  else
    GoScreen(GetStoredScreen(UIEnums.ScreenStorage.FE_BACK))
  end
end
function SetCorrectText()
  RemoveAllText()
  if GUI.failed == true then
    if UIGlobals.server_connection.online_mode == true then
      UIButtons.SetActive(GUI.failed_online_txt, true)
    else
      UIButtons.SetActive(GUI.failed_offline_txt, true)
    end
  elseif UIGlobals.server_connection.online_mode == true then
    UIButtons.SetActive(GUI.connecting_online_txt, true)
  else
    UIButtons.SetActive(GUI.connecting_offline_txt, true)
  end
end
function RemoveAllText()
  UIButtons.SetActive(GUI.connecting_online_txt, false)
  UIButtons.SetActive(GUI.connecting_offline_txt, false)
  UIButtons.SetActive(GUI.failed_online_txt, false)
  UIButtons.SetActive(GUI.failed_offline_txt, false)
end
function FailConnect()
  GUI.failed = true
  GUI.complete = true
  net_CloseServiceConnection()
  SetCorrectText()
end
function CompleteConnect()
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    Profile.ReadPadProfile(UIGlobals.ProfilePressedStart)
  end
  NetServices.StartBandwidthEvaluation()
  GUI.failed = false
  GUI.complete = true
  MoveOn()
end
