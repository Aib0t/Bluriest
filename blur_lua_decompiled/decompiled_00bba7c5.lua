GUINetwork = {
  multiplayer_context = 0,
  multiplayer_root = "multiplayer\\mpmain.lua",
  multiplayer_party_root = "multiplayer\\mponline.lua",
  load_started = false
}
function net_SetGroupPresence(_ARG_0_)
  if NetServices.ConnectionStatusIsOnline() == true then
    if _ARG_0_ ~= nil then
      Multiplayer.SetEventPresence(_ARG_0_)
    else
      Multiplayer.SetDefaultPresence()
    end
  end
end
function net_connection_CompleteConnect()
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    Profile.ReadPadProfile(UIGlobals.ProfilePressedStart)
  end
  NetServices.StartBandwidthEvaluation()
end
function net_FlushSessionEnumerator()
  NetRace.EnumerateLanGames(false)
  NetServices.FlushEnumertedSessions()
end
function net_StopSessionEnumerator()
  NetRace.EnumerateLanGames(false)
  NetServices.StopEnumertedSessions()
end
function net_CloseAllSessions()
  NetRace.Delete()
  NetParty.Delete()
  UIGlobals.Network.UnrecoverableSessionError = false
end
function net_DisconnectFromRace()
  if UIGlobals.Multiplayer.Disconnecting == true then
    return
  end
  UIGlobals.Multiplayer.Disconnecting = true
  NetRace.EnterDisconnecting()
  SetupCustomPopup(UIEnums.CustomPopups.MultiplayerDisconnectFromRace)
end
function net_Disconnecting()
  return UIGlobals.Multiplayer.Disconnecting
end
function net_StopScoreboardRequests()
  NetServices.StopScoreboardRequests()
end
function net_FlushEverything(_ARG_0_)
  if _ARG_0_ == nil then
    net_EnableGlobalUpdateRichPresence(false)
  end
  net_StopScoreboardRequests()
  net_FlushSessionEnumerator()
  net_CloseAllSessions()
  net_EnableGlobalUpdateRouterMonitoring(false)
  net_LockoutFriendsOverlay(false)
  net_EnableGlobalUpdatePartyCommands(false)
  UIGlobals.Network.UnrecoverableRouterError = false
  GUINetwork.load_started = false
end
function net_RouterAvailable(_ARG_0_)
  if NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionStateComplete then
    if NetServices.ConnectionStatus() == true then
      return true
    elseif _ARG_0_ == true then
      return false
    end
    return true
  end
  return false
end
function net_CloseServiceConnection()
  net_FlushEverything()
  print("NetworkBank.net_CloseServiceConnection")
  NetServices.Disconnect()
  Profile.SetDefaultUserName()
end
function net_CanStartOnlineServiceConnection()
  if NetServices.OnlineConnectionPossible() == false then
    return false
  end
  if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true and NetServices.UserHasAgeRestriction() == true then
    return false
  end
  return NetServices.ConnectionStatusIsOnline() == false
end
function net_StartServiceConnection(_ARG_0_, _ARG_1_, _ARG_2_)
  if UserKickBackActive() == true then
    return
  end
  UIGlobals.server_connection.online_mode = _ARG_0_
  UIGlobals.server_connection.callback = _ARG_1_
  UIGlobals.server_connection.active = true
  if NetServices.GameInvitePending() == true then
    UIGlobals.server_connection.online_mode = true
  end
  if UIEnums.CurrentPlatform == UIEnums.Platform.PC and UIGlobals.NetAccountActive == false and _ARG_0_ == true then
    UIGlobals.NetConnectionDarken = true
    GoScreen("Account\\NetLogin.lua", UIEnums.Context.Subscreen2)
  elseif _ARG_2_ == true then
    PopupSpawn(UIEnums.CustomPopups.NetConnectionTask)
  else
    SetupCustomPopup(UIEnums.CustomPopups.NetConnectionTask)
  end
end
function net_StartStorageDownload(_ARG_0_)
  UIGlobals.StorageDownloadCallback = _ARG_0_
  SetupCustomPopup(UIEnums.CustomPopups.StorageDownload)
end
function net_SetRichPresence(_ARG_0_)
  UIGlobals.Network.CurrentRichPresence = _ARG_0_
  NetServices.SetRichPresence(_ARG_0_)
end
function net_MpEnter(_ARG_0_)
  if _ARG_0_ == UIEnums.GameMode.Online then
    Amax.SetGameMode(UIEnums.GameMode.Online)
    net_EnableGlobalUpdateRichPresence(true)
    net_SetRichPresence(UIEnums.RichPresence.OnlineMain)
  elseif _ARG_0_ == UIEnums.GameMode.SplitScreen then
    Amax.SetGameMode(UIEnums.GameMode.SplitScreen)
    net_EnableGlobalUpdateRichPresence(false)
  elseif _ARG_0_ == UIEnums.GameMode.SystemLink then
    Amax.SetGameMode(UIEnums.GameMode.SystemLink)
    net_EnableGlobalUpdateRichPresence(false)
    net_SetRichPresence(UIEnums.RichPresence.LAN)
  else
    print("ERROR: Current GameMode is not supported", _ARG_0_)
    return
  end
end
function net_MpEnterPlayMode(_ARG_0_, _ARG_1_)
  if _ARG_0_ == UIEnums.PlayMode.Nothing or _ARG_0_ == UIEnums.PlayMode.CustomRace or _ARG_0_ == UIEnums.PlayMode.Playlist then
    Amax.SetPlayMode(_ARG_0_)
  else
    print("ERROR: Current PlayMode is not supported", _ARG_0_)
    return
  end
  if _ARG_1_ == nil then
    _ARG_1_ = false
  end
  Amax.SetOnlineRanked(_ARG_1_)
end
function net_MpLeave()
  UIGlobals.ConnectionType = UIEnums.ConnectionType.None
  Amax.SetGameMode(UIEnums.GameMode.Nothing)
  net_MpEnterPlayMode(UIEnums.PlayMode.Nothing, false)
  net_EnableGlobalUpdatePartyCommands(false)
  net_EnableGlobalUpdateRichPresence(false)
  UpdateMpStatusBar()
end
function net_EnableGlobalUpdate(_ARG_0_, _ARG_1_)
  UIGlobals.Network.GlobalUpdateEnabled = _ARG_0_
  if _ARG_1_ == nil or _ARG_1_ == false then
    UIGlobals.Network.GameInviteState = UIEnums.MpGameInviteState.Polling
  end
end
function net_GameInviteFailed()
  UIGlobals.Network.GameInviteState = UIEnums.MpGameInviteState.Polling
  net_FlushEverything()
end
function net_EnableGlobalUpdateRichPresence(_ARG_0_)
  UIGlobals.Network.RichPresenceUpdateEnabled = _ARG_0_
end
function net_EnableGlobalUpdateRouterMonitoring(_ARG_0_)
  UIGlobals.Network.RouterMonitoringEnabled = _ARG_0_
end
function net_LockoutFriendsOverlay(_ARG_0_)
  UIGlobals.Network.LockoutFriendsOverlay = _ARG_0_
  return UIGlobals.Network.LockoutFriendsOverlay
end
function net_SetPartyLobbyMatchingDelay()
  UIGlobals.Network.PartyLobbyMatchingDelay = 5
end
function net_EnableGlobalUpdatePartyCommands(_ARG_0_)
  UIGlobals.Network.GlobalUpdatePartyCommands = _ARG_0_
end
function net_EnterPartyLobby(_ARG_0_)
  NetRace.Delete()
  NetParty.EnterLobby()
  NetParty.EnableMatchingQoS(true)
  NetParty.ReceivedReturnToLobby(true)
  net_EnableGlobalUpdatePartyCommands(false)
  net_EnableGlobalUpdateRouterMonitoring(true)
  UIGlobals.Network.ReturnPartyLobbyState = UIEnums.MpReturnPartyLobbyState.Polling
  if _ARG_0_ == true then
    NetParty.ClearRaceInvite()
  end
end
function net_ExitPartyLobby()
  NetRace.Delete()
  NetParty.EnableMatchingQoS(false)
  net_EnableGlobalUpdatePartyCommands(false)
  net_FlushSessionEnumerator()
  net_CloseAllSessions()
end
function net_CanReconnectToDemonware()
  if NetServices.NetworkConnectionActive() == true and NetServices.OnlineConnectionPossible() == true then
    return true
  else
    return false
  end
end
function net_GlobalUpdate_RouterConnection()
  if UIGlobals.Network.RouterMonitoringEnabled == true and (UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC) and NetServices.ConnectionStatus() == UIEnums.Network.Router.eConnectionStateFailed then
    net_EnableGlobalUpdatePartyCommands(false)
    UIGlobals.Network.RouterMonitoringEnabled = false
    UIGlobals.Network.UnrecoverableRouterError = true
    Profile.CloseFriends()
  end
  return false
end
function net_GlobalUpdate_MatchingSessions()
  if UIGlobals.Network.UnrecoverableSessionError == false and (NetRace.UnrecoverableError() == true or NetParty.UnrecoverableError() == true) then
    if UIScreen.IsPopupActive() == true then
      UIScreen.CancelPopup()
    end
    if GUINetwork.load_started == false then
      Profile.CloseFriends()
      net_EnableGlobalUpdatePartyCommands(false)
      net_FlushSessionEnumerator()
      net_CloseAllSessions()
      if UIGlobals.IsIngame == true then
        Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
        StoreScreen(UIEnums.ScreenStorage.FE_RETURN, GUINetwork.multiplayer_root)
        if UserKickBackActive() == false then
          GoScreen("Loading\\LoadingUi.lua")
        end
      else
        GoScreen(GUINetwork.multiplayer_root, GUINetwork.multiplayer_context)
      end
      GUINetwork.load_started = true
      UIGlobals.Network.UnrecoverableSessionError = true
    end
  end
  return false
end
function net_GlobalUpdate_RichPresence()
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    NetServices.SetRichPresence(UIGlobals.Network.CurrentRichPresence)
  end
  return false
end
function net_CheckFriendsAvailability()
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    if false == false then
      Profile.CloseFriends()
    end
    Profile.SetFriendsActive(false)
  end
end
function net_GlobalUpdate_GameInvite()
  if UIGlobals.Network.GameInviteState == UIEnums.MpGameInviteState.Polling then
    if NetServices.GameInvitePending() == false then
      return false
    end
    if UIScreen.IsPopupActive() == true then
      UIScreen.CancelPopup()
    end
    if Profile.GetPrimaryPad() ~= NetServices.FindGameInvitePadIndex() then
      ReturnToStartScreen(UIEnums.UserKickBackMode.InactiveGameInvite)
      return
    end
    net_EnableGlobalUpdatePartyCommands(false)
    if UIScreen.GetCurrentScreen(GUINetwork.multiplayer_context) ~= GUINetwork.multiplayer_root then
      print("Booting Multiplayer mode")
      FlushSubscreens()
      if UIGlobals.IsIngame == true then
        Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
        Profile.CloseFriends()
        StoreScreen(UIEnums.ScreenStorage.FE_RETURN, GUINetwork.multiplayer_root)
        GoScreen("Loading\\LoadingUi.lua", UIEnums.Context.Main)
      else
        GoScreen(GUINetwork.multiplayer_root, GUINetwork.multiplayer_context)
        Amax.ChangeEnvironmentSettings(false)
      end
      UIGlobals.Network.GameInviteState = UIEnums.MpGameInviteState.Initialising
    else
      ForceCloseApp()
      UIGlobals.Network.GameInviteState = UIEnums.MpGameInviteState.Initialising
      net_StartStorageDownload()
    end
  elseif UIGlobals.Network.GameInviteState == UIEnums.MpGameInviteState.PreProcessing then
    Profile.CloseFriends()
    Amax.GameInviteStarted()
    RemoveBlaggedProfiles()
    net_FlushEverything()
    net_MpEnter(UIEnums.GameMode.Online)
    net_EnableGlobalUpdateRouterMonitoring(true)
    if NetServices.CheckEntryRequirements(true) == 0 then
    elseif NetServices.CheckEntryRequirements(true) == 1 then
      NetServices.ClearGameInvite()
    elseif NetServices.CheckEntryRequirements(true) == 2 then
      NetServices.ClearGameInvite()
    elseif NetServices.CheckEntryRequirements(true) == 3 then
      NetServices.ClearGameInvite()
    end
    if UIScreen.IsPopupActive() == true then
      PopupSpawn(UIEnums.CustomPopups.MultiplayerInvalidPrivileges)
    else
      SetupCustomPopup(UIEnums.CustomPopups.MultiplayerInvalidPrivileges)
    end
    UIGlobals.Network.GameInviteState = UIEnums.MpGameInviteState.Processing
  end
  return false
end
function net_GlobalUpdate_RaceInvite()
  if NetParty.IsRunning() == false then
    net_EnableGlobalUpdatePartyCommands(false)
    return false
  end
  if UIGlobals.Network.RaceInviteState == UIEnums.MpRaceInviteState.Polling then
    if NetParty.MatchmakingSessionIdle() == false or NetParty.ReceivedRaceInvite() == false then
      return false
    end
    if UIScreen.IsPopupActive() == true then
      UIScreen.CancelPopup()
    end
    NetParty.EnableMatchingQoS(false)
    Profile.CloseFriends()
    Mp_ReturnToPartyLobby()
    print("Booting party lobby")
    UIGlobals.Network.RaceInviteState = UIEnums.MpRaceInviteState.Initialising
  elseif UIGlobals.Network.RaceInviteState == UIEnums.MpRaceInviteState.PreProcessing then
    print("Accepting party race invite")
    UIGlobals.Network.RaceInviteState = UIEnums.MpRaceInviteState.Processing
    SetupCustomPopup(UIEnums.CustomPopups.AcceptPartyRaceInvite)
  end
  return false
end
function net_GlobalUpdate_PartyCommands()
  if NetParty.IsRunning() == false then
    net_EnableGlobalUpdatePartyCommands(false)
    return false
  end
  if UIGlobals.Network.GlobalUpdatePartyCommands == false then
    return false
  end
  if UIGlobals.IsLoading == false and UIGlobals.Network.GlobalUpdateEnabled == true and UIGlobals.Network.GameInviteState == UIEnums.MpGameInviteState.Polling then
    if UIGlobals.Network.ReturnPartyLobbyState == UIEnums.MpReturnPartyLobbyState.Polling then
      if NetParty.ReceivedReturnToLobby(false) == false then
        return false
      end
      print("Returning to lobby")
      if UIScreen.IsPopupActive() == true then
        UIScreen.CancelPopup()
      end
      NetRace.Delete()
      if UIScreen.GetCurrentScreen(GUINetwork.multiplayer_context) ~= GUINetwork.multiplayer_root then
        print("Booting Multiplayer mode")
        if UIGlobals.IsIngame == true then
          Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
          Profile.CloseFriends()
          GUINetwork.load_started = false
          GoScreen("Loading\\LoadingUi.lua")
        else
          GoScreen(GUINetwork.multiplayer_root, GUINetwork.multiplayer_context)
        end
        UIGlobals.Network.ReturnPartyLobbyState = UIEnums.MpReturnPartyLobbyState.Initialising
      else
        UIGlobals.Network.ReturnPartyLobbyState = UIEnums.MpReturnPartyLobbyState.PreProcessing
      end
    elseif UIGlobals.Network.ReturnPartyLobbyState == UIEnums.MpReturnPartyLobbyState.PreProcessing then
      UIGlobals.Network.ReturnPartyLobbyState = UIEnums.MpReturnPartyLobbyState.Polling
      net_EnableGlobalUpdatePartyCommands(false)
      NetParty.ReceivedReturnToLobby(true)
      LaunchScreen(UIEnums.MpLaunchScreen.PartyLobby)
    end
  end
  return false
end
function net_GlobalUpdate_InviteReconnectToServers()
  if NetServices.GameInvitePending() == false or UIGlobals.Network.GameInviteState ~= UIEnums.MpGameInviteState.Polling or NetServices.ConnectionStatusIsOnline() == true then
    return false
  end
  if Profile.GetPrimaryPad() ~= NetServices.FindGameInvitePadIndex() then
    return false
  end
  print("NET - Reconnecting to servers")
  if UIScreen.IsPopupActive() == true then
    UIScreen.CancelPopup()
  end
  net_StartServiceConnection(true, nil)
  return true
end
function net_GlobalUpdate()
  if UIGlobals.Network.RichPresenceUpdateEnabled == true then
    net_GlobalUpdate_RichPresence()
  end
  if UIGlobals.UserKickBackMode ~= UIEnums.UserKickBackMode.None then
    return
  end
  if UIGlobals.IsLoading == true or UIGlobals.Network.GlobalUpdateEnabled == false or UIGlobals.server_connection.active == true then
    return true
  end
  if net_GlobalUpdate_InviteReconnectToServers() == true then
    return false
  end
  if net_GlobalUpdate_RouterConnection() == true then
    return false
  end
  if net_GlobalUpdate_MatchingSessions() == true then
    return false
  end
  if net_GlobalUpdate_GameInvite() == true then
    return false
  end
  if net_GlobalUpdate_RaceInvite() == true then
    return false
  end
  if net_GlobalUpdate_PartyCommands() == true then
    return false
  end
  return true
end
