GUI = {
  finished = false,
  DisableLoading = false,
  timer = 0,
  show_time = 0.28,
  tip_timer = 0,
  tip_change_time = 10,
  disconnect_time_out = 20,
  RaceLoaded = false,
  SentReady = false,
  DisconnectedIdlePlayers = true,
  Disconnecting = false,
  LoadTimer = 0,
  LoadStarted = false
}
function Init()
  if UIGlobals.LoadFromDebug == false then
    Profile.AllowProfileChanges(true)
    Profile.ActOnProfileChanges(false)
    UIGlobals.ActUponFriendChallenges = false
  end
  if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    GUI.disconnect_time_out = 120
  end
  AddSCUI_Elements()
  SetupInfoLine(UIText.INFO_NEXT_TIP_RT)
  net_LockoutFriendsOverlay(true)
  if IsSplitScreen() == true then
    Splitscreen_ClearMessages()
  end
  UIScreen.SetScreenTimers(0, 1)
  Amax.SetLoadStateIntoRace()
  if IsTable((Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista, Multiplayer.GetCurrentRace().route))) == true then
    UIButtons.ChangePosition(SCUI.name_to_id.VistaDestination, XtToScreenSpaceX(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista, Multiplayer.GetCurrentRace().route).px, true), XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista, Multiplayer.GetCurrentRace().route).py, true))
  end
  UIButtons.DummyLerpMatrixCopy(SCUI.name_to_id.VistaDestination, SCUI.name_to_id.VistaDummy)
end
function PostInit()
  AddLoadingSegs()
  Mp_RefreshRaceOverview(SCUI.name_to_id.border, Multiplayer.GetCurrentRace(), Multiplayer.GetCurrentRaceIndex(), false)
  if UIGlobals.IsQuickRestart == false then
    Amax.DeleteTextureBundle()
  end
  UIButtons.ChangeTexture({
    filename = "LOADING_TEXTURE"
  }, 1, UIButtons.FindChildByName(SCUI.name_to_id.border, "thumbnail"))
  UpdateRouteShapes("Shp_Route", 4, Multiplayer.GetCurrentRace().city, Multiplayer.GetCurrentRace().route, "Shp_StartLine")
  UIButtons.SetActive(SCUI.name_to_id.toggle_branch, false)
  LoadingMp_HelpTextInit()
  LoadingMp_HelpTextNext()
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
  if _ARG_0_ == UIEnums.Message.ButtonRightTrigger then
    LoadingMp_HelpTextNext()
  end
  if _ARG_0_ == UIEnums.GameFlowMessage.LevelDumped then
    Amax.SendMessage(UIEnums.GameFlowMessage.StartRaceLoad)
    print("LEVEL DUMPED - START LOAD")
  elseif _ARG_0_ == UIEnums.GameFlowMessage.RaceLoaded then
    Amax.SetGlobalFade(1)
    Amax.FillStreamer()
    Amax.ExitNetworkLoad()
    GUI.RaceLoaded = true
    print("RACE LOADED - FILLING STREAMER")
  end
end
function FrameUpdate(_ARG_0_)
  LoadingMp_HelpTextUpdate(_ARG_0_)
  if GUI.DisableLoading == true then
    return
  end
  GUI.LoadTimer = GUI.LoadTimer + _ARG_0_
  if GUI.LoadStarted == false and GUI.LoadTimer > 1 then
    Amax.EnterNetworkLoad()
    Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
    if Amax.AmaxWorldLayerExists() == true then
      print("FrontendLobby load - DUMP LEVEL")
      Amax.SendMessage(UIEnums.GameFlowMessage.DumpLevel)
    else
      print("PostRaceLobby load - START RACE")
      Amax.SendMessage(UIEnums.GameFlowMessage.StartRaceLoad)
    end
    GUI.LoadStarted = true
    ClearMultiplayerGlobals()
  end
  if NetRace.LocalPlayerDisconnecting() == true then
    GUI.Disconnecting = NetRace.LocalPlayerDisconnecting()
  end
  if GUI.RaceLoaded == true and Amax.WaitForStreamer() == false then
    UIGlobals.IsLoading = false
    if NetServices.GameInvitePending() == true then
      UIGlobals.IsIngame = true
      return
    end
    if IsSplitScreen() == true then
      LeaveScreen()
    elseif GUI.Disconnecting == false then
      if GUI.SentReady == false then
        LoadingMpGame_SendReady()
      elseif NetRace.RaceStartSynchronised() == true then
        LoadingMpGame_StartRace()
      elseif GUI.DisconnectedIdlePlayers == false then
        GUI.disconnect_time_out = GUI.disconnect_time_out - _ARG_0_
        if GUI.disconnect_time_out <= 0 then
          LoadingMpGame_DisconnectIdlePlayers()
        end
      end
      if UserKickBackActive() == false then
        if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
          ServiceConnectionLost()
        elseif NetServices.ConnectionStatusIsOnline() == false then
          XLSPConnectionLost()
        end
      end
    end
  end
end
function LoadingMpGame_SendReady()
  print("LoadingMpGame.lua : PLAYER READY SENT")
  if UIGlobals.LoadFromDebug == false then
    Profile.ForceProfileUpdate()
    Profile.ActOnProfileChanges(true)
    UIGlobals.ActUponFriendChallenges = true
  end
  NetRace.EnterSyncAfterRaceLoad()
  GUI.SentReady = true
  UIGlobals.IsIngame = true
end
function LoadingMpGame_StartRace()
  print("LoadingMpGame.lua : EVERYONES READY! LETS GO!")
  NetRace.StartPlay()
  LeaveScreen()
end
function LoadingMpGame_DisconnectIdlePlayers()
  print("LoadingMpGame.lua : TIME OUT - Requesting disconnection of idle players!")
  NetRace.DisconnectIdleLoadingPlayers()
  GUI.DisconnectedIdlePlayers = true
end
function Render()
end
function EndLoop(_ARG_0_)
end
function LeaveScreen()
  GoScreen("Ingame\\IntroVista.lua")
end
function EnterEnd()
  UIButtons.SetActive(SCUI.name_to_id.hint_text, false)
  UIButtons.TimeLineActive("Hide_BottomHelp", true)
end
function End()
  if GUI.DisableLoading == true then
    return
  end
  UIGlobals.IsIngame = true
  UIGlobals.IsLoading = false
  UIGlobals.IsQuickRestart = false
  Amax.SendMessage(UIEnums.GameFlowMessage.StartGameRendering)
  if UserKickBackActive() == false then
    StartIngameMusic()
  end
  if IsSplitScreen() == true and UIGlobals.LoadFromDebug == false then
    Profile.ForceProfileUpdate()
    Profile.ActOnProfileChanges(true)
    UIGlobals.ActUponFriendChallenges = true
  end
end
function SetupToggle(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Loading\\LoadingMpGame.lua", "toggle_branch"), "toggle_icon"), _ARG_1_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Loading\\LoadingMpGame.lua", "toggle_branch"), "toggle_icon"), _ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Loading\\LoadingMpGame.lua", "toggle_branch"), "toggle_text"), _ARG_2_)
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Loading\\LoadingMpGame.lua", "toggle_branch"), "toggle_icon"), _ARG_3_)
  return (UIButtons.CloneXtGadgetByName("Loading\\LoadingMpGame.lua", "toggle_branch"))
end
function LoadingMp_HelpTextInit()
  if Select(IsSplitScreen(), UIGlobals.ls_help_text_ss_ids, UIGlobals.ls_help_text_ids) ~= nil and #Select(IsSplitScreen(), UIGlobals.ls_help_text_ss_ids, UIGlobals.ls_help_text_ids) > 1 then
    return
  end
  if IsSplitScreen() == true then
    UIGlobals.ls_help_text_ss_ids = {}
  else
    UIGlobals.ls_help_text_ids = {}
  end
  UIGlobals.ls_num_help = 100
  for _FORV_4_ = 1, UIGlobals.ls_num_help do
    Select(IsSplitScreen(), UIGlobals.ls_help_text_ss_ids, UIGlobals.ls_help_text_ids)[#Select(IsSplitScreen(), UIGlobals.ls_help_text_ss_ids, UIGlobals.ls_help_text_ids) + 1] = Select(IsSplitScreen(), UIText["MLHP_SS_" .. _FORV_4_], UIText["MHLP_" .. _FORV_4_])
  end
end
function LoadingMp_HelpTextNext()
  UIButtons.ChangeText(SCUI.name_to_id.hint_text, (table.remove(Select(IsSplitScreen(), UIGlobals.ls_help_text_ss_ids, UIGlobals.ls_help_text_ids), 1)))
  UIButtons.TimeLineActive("hint_text_next", true, 0)
  UIButtons.ChangeScale(SCUI.name_to_id.motd_dummy, 1, UIButtons.GetStaticTextHeight(SCUI.name_to_id.hint_text) / UIButtons.GetSize(SCUI.name_to_id.hint_text) + 0.3)
  if #Select(IsSplitScreen(), UIGlobals.ls_help_text_ss_ids, UIGlobals.ls_help_text_ids) == 0 then
    LoadingMp_HelpTextInit()
  end
  PlaySfxToggle()
  GUI.tip_timer = 0
end
function LoadingMp_HelpTextUpdate(_ARG_0_)
  GUI.tip_timer = GUI.tip_timer + _ARG_0_
  if GUI.tip_timer >= GUI.tip_change_time then
    LoadingMp_HelpTextNext()
  end
end
