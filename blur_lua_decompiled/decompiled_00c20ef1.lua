GUI = {
  finished = false,
  loading_ui = false,
  stage = {goals = 0, leaderboard = 1},
  current_stage = 0,
  light_ids = {
    event = {
      primary = {},
      primary_blob = {},
      fan_par = {},
      fan_par_blob = nil,
      fan_run = {},
      fan_run_blob = nil
    },
    result = {
      primary = {},
      fan_par = {},
      fan_run = {}
    }
  },
  light_effect_ids = {},
  light_change_active = nil,
  light_change_timer = 0,
  light_change_timer_next = 0,
  light_change_current = 1,
  timer = 0,
  allow_next_and_share = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  WriteFailed = false,
  FinishedWriting = false,
  LeaderboardWriteTimer = 1,
  LeaderboardsValid = false,
  FinishPostRaceLeaderboardScreen = false,
  leaderboard_initialised = false
}
function SPRaceAwardLeaderboard(_ARG_0_)
  if _ARG_0_ == true then
    UIGlobals.StartPostRaceLeaderboardWrite = true
    UIGlobals.SPRA_UpdateRival = true
  end
end
function Init()
  UIScreen.SetScreenTimers(1, UIGlobals.screen_time.default_end)
  AddSCUI_Elements()
  SetupFadeToBlack(false, true)
  GUI.event_id = UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]
  GUI.result = Amax.SP_GetLevelResult()
  GUI.LeaderboardsValid = false
  if GUI.result.state ~= "none" then
    if UIEnums.CurrentPlatform == UIEnums.Platform.PC and UIGlobals.SuccessfullyCreatedNetworkSession == true then
      GUI.LeaderboardsValid = true
      if UIGlobals.SPPostRaceLeaderboardDone == false then
        print("PC leaderboard write")
        Amax.StartSPScoreboardWrite()
      end
      SpMiniLeaderboard_Init()
    end
    if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon and UIGlobals.SuccessfullyCreatedNetworkSession == true then
      GUI.LeaderboardsValid = true
      if UIGlobals.SPPostRaceLeaderboardDone == false then
        print("Xenon")
        Amax.StartSPScoreboardWrite()
      end
      SpMiniLeaderboard_Init()
    end
    if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 and LSP.IsConnected() == true then
      print("Starting write ...")
      GUI.LeaderboardsValid = true
      if UIGlobals.SPPostRaceLeaderboardDone == false then
        print("PS3")
        Amax.StartSPScoreboardWrite()
      end
      SpMiniLeaderboard_Init()
    end
  elseif UIGlobals.NetworkSessionStarted == true then
    Amax.EndPlayStatsOnlyMatchingSession()
    UIGlobals.NetworkSessionStarted = false
    print("Network Session Ended")
  end
  SetupInfoLine()
  if UIGlobals.FriendDemandSent == true then
    UIButtons.SetActive(SCUI.name_to_id.background, true)
  end
end
function PostInit()
  if IsTable(GUI.result) ~= true then
    return
  end
  GUI.is_boss_race = Amax.SP_IsBossRace()
  if GUI.result.state == "gold" and GUI.is_boss_race == false then
    UIButtons.SetActive(SCUI.name_to_id.best_branch, true)
    if Amax.SP_IsStreetRace() == true then
      Amax.ChangeText(SCUI.name_to_id.SpNextMedalInfo, "HUD_SP_RACE_STREET_DIFF_TO_MEDAL")
      _, _ = Amax.SP_StreetRaceState()
    elseif Amax.SP_IsCheckpointRace() == true then
      Amax.ChangeText(SCUI.name_to_id.SpNextMedalInfo, "HUD_SP_RACE_CHECKPOINT_TIME_DIFF_TO_MEDAL")
      _, _, _ = Amax.SP_CheckpointRaceState()
    elseif Amax.SP_IsDestructionRace() == true then
      Amax.ChangeText(SCUI.name_to_id.SpNextMedalInfo, "HUD_SP_RACE_DESTRUCTION_DIFF_TO_MEDAL")
      _, _, _ = Amax.SP_DestructionRaceState()
    elseif Amax.SP_IsFanDemandRace() == true then
      Amax.ChangeText(SCUI.name_to_id.SpNextMedalInfo, "HUD_SP_RACE_FAN_DEMAND_DIFF_TO_MEDAL")
      _, _, _ = Amax.SP_FanDemandRaceState()
    end
    if Amax.SP_FanDemandRaceState() == false then
      UIButtons.ChangeColour(SCUI.name_to_id.SpNextArrow, "Support_3")
      UIButtons.ChangeOrientation(SCUI.name_to_id.SpNextArrow, 0, 0, 180)
    end
    GUI.beating_best = Amax.SP_FanDemandRaceState()
  end
  GUI.event_info = SinglePlayer.EventInfo(GUI.event_id)
  if UIGlobals.DoResults == true then
    UIGlobals.DoResults = false
    UIGlobals.Sp_PreviousFans = SinglePlayer.GameInfo().fans
    SinglePlayer.CompleteEvent(GUI.event_id)
    if UIGlobals.FriendDemandSent == false then
      Amax.PostRaceSinglePlayer()
    end
  end
  UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("SpSCUI", "Event_Node"), UIEnums.Panel._3DAA_0, true)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SpSCUI", "Event_Node"), SCUI.name_to_id.event_node_rb, UIEnums.Justify.TopCentre)
  UIButtons.ChangeOrientation(UIButtons.CloneXtGadgetByName("SpSCUI", "Event_Node"), 0, 0, 0)
  SpRaceAwards_SetEventInfo((UIButtons.CloneXtGadgetByName("SpSCUI", "Event_Node")))
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), SCUI.name_to_id.primary_rb, UIEnums.Justify.MiddleCentre)
  SpRaceAwards_CreatePrimaryLights(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_light_dummy"), GUI.result.state)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_title"), UIText.SP_EVENT_PRIMARY)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info"), "HUD_SP_RACE_RESULT")
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_icon"), Sp_KindToShape(GUI.event_info.kind))
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), SCUI.name_to_id.fan_par_rb, UIEnums.Justify.MiddleCentre)
  SpRaceAwards_CreateSecondaryLights(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_light_dummy"), GUI.result.secondary)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_title"), UIText.SP_EVENT_SECONDARY)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info"), "SPL_EVENT_" .. GUI.event_id .. "_SECONDARY_GOAL")
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info_extra"), "HUD_0_FANS_STRING")
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_icon"), "fan")
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), SCUI.name_to_id.gfd_rb, UIEnums.Justify.MiddleCentre)
  SpRaceAwards_CreateGfdLights(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_light_dummy"), GUI.result.gfd)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_title"), UIText.SP_EVENT_GFD)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info"), UIText.SP_EVENT_GFD_INFO)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_icon"), "fan_attack")
  if GUI.result.state == "none" then
    UIButtons.SetActive(SCUI.name_to_id.failed_branch, true)
    UIButtons.SetActive(SCUI.name_to_id.event_node_rb, false)
    UIButtons.ChangePosition(SCUI.name_to_id.city_icon, UIButtons.GetPosition(SCUI.name_to_id.city_icon))
    SetupInfoLine(UIText.INFO_A_NEXT)
  else
    if 0 < #Sp_UnlocksFilter(SinglePlayer.ProcessUnlocks()) then
      UIButtons.SetActive(SCUI.name_to_id.new_branch, true)
      GUI.has_new_unlocks = true
    end
    UIButtons.TimeLineActive("event_info_on", true, 0)
  end
  for _FORV_8_ = 1, Sp_EventStateToStars(GUI.result.state, GUI.is_boss_race) do
    GUI.light_effect_ids[#GUI.light_effect_ids + 1] = {
      GUI.light_ids.result.primary[Sp_EventStateToStars(GUI.result.state, GUI.is_boss_race) - _FORV_8_ + 1][1],
      GUI.light_ids.event.primary[_FORV_8_][1],
      true,
      false,
      false,
      GUI.light_ids.event.primary_blob[_FORV_8_]
    }
  end
  if _FOR_.result.secondary == true then
    GUI.light_effect_ids[#GUI.light_effect_ids + 1] = {
      GUI.light_ids.result.fan_par[1],
      GUI.light_ids.event.fan_par[1],
      false,
      true,
      false,
      GUI.light_ids.event.fan_par_blob
    }
  end
  if GUI.result.gfd == true then
    GUI.light_effect_ids[#GUI.light_effect_ids + 1] = {
      GUI.light_ids.result.fan_run[1],
      GUI.light_ids.event.fan_run[1],
      false,
      false,
      true,
      GUI.light_ids.event.fan_run_blob
    }
  end
  GUI.transmitter_id = AddTransmitter(24, 0, 32, 32, UIEnums.Panel._2DAA)
  UIButtons.SetParent(GUI.transmitter_id, SCUI.name_to_id.Txt_Loading, UIEnums.Justify.MiddleRight)
  UIButtons.SetActive(SCUI.name_to_id.Txt_Loading, false, true)
  if GUI.LeaderboardsValid == true then
    GUI.leaderboard_initialised = SpMiniLeaderboard_PostInit(SCUI.name_to_id.centre)
  end
  SpRaceAwards_UpdateRival(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent])
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.GameFlowMessage.UILoaded and UIGlobals.LoadFromDebug == true then
    GoScreen(GetStoredScreen(UIEnums.ScreenStorage.FE_RETURN))
  elseif _ARG_0_ == UIEnums.GameFlowMessage.StartGameRendering then
    GoScreen(GetStoredScreen(UIEnums.ScreenStorage.FE_RETURN))
  end
  if SubScreenActive() == true or GUIBank.loading == true or GUI.loading_ui == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.FailedWriteToLeaderboards then
    UIGlobals.SPPostRaceLeaderboardDone = true
    GUI.FinishedWriting = true
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SpPostRaceOptions then
    if _ARG_3_ == 0 then
      PushScreen("Shared\\GarageMini.lua")
    elseif _ARG_3_ == 1 then
      SpRaceAwards_BackToUiStart()
    elseif _ARG_3_ == 2 then
      if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
        if net_CanReconnectToDemonware() == false then
          SetupCustomPopup(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
        else
          net_StartServiceConnection(true, nil, false)
        end
      elseif LSP.IsConnected() == false then
        SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
      elseif FriendDemand.HasPrivilege() == false then
        SetupCustomPopup(UIEnums.CustomPopups.FriendChallengeNoPrivilege)
      elseif Amax.GetNumFriends() == 0 then
        SetupCustomPopup(UIEnums.CustomPopups.FriendChallengeNoFriends)
      else
        Fd_ClearExtraChallenge()
        FriendDemand.PopulateChallengeText()
        UIGlobals.FriendDemandFriends[1] = nil
        UIGlobals.FriendDemandFriends[2] = nil
        UIGlobals.FriendDemandFriends[3] = nil
        StoreScreen(UIEnums.ScreenStorage.FE_FRIEND_DEMAND)
        GoScreen("Ingame\\AddFriendsToFriendDemand.lua")
      end
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SPLeaderboardPostRaceError then
    GUI.FinishPostRaceLeaderboardScreen = true
  elseif _ARG_0_ == UIEnums.Message.MenuNext or mouseButton == UIEnums.Message.ButtonA then
    if GUI.current_stage == GUI.stage.goals and GUI.result.state ~= "none" and GUI.allow_next_and_share == false and GUI.has_taken_photo == true then
      SpRaceAwards_Skip()
    else
      SetupCustomPopup(UIEnums.CustomPopups.SpPostRaceOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and GUI.allow_next_and_share == true then
    if GUI.result.state ~= "none" and Amax.CanUseShare() == true then
      SetupCustomPopup(UIEnums.CustomPopups.SpPostRaceSharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      Amax.CreateBlurb(UIGlobals.SharingOptionsChosen, 1, GUI.event_id)
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "SinglePlayer\\Ingame\\SpRaceAwards.lua")
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
      Amax.CreateBlurb(UIGlobals.SharingOptionsChosen, 0, GUI.event_id)
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "SinglePlayer\\Ingame\\SpRaceAwards.lua")
      GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      Amax.CreateBlurb(UIGlobals.SharingOptionsChosen, 2, GUI.event_id)
    end
  end
end
function SpRaceAwards_DoLights()
  if GUI.light_change_active == nil and #GUI.light_effect_ids > 0 then
    GUI.light_change_active = true
  end
end
function FrameUpdate(_ARG_0_)
  if UIGlobals.SPRA_UpdateRival == true then
    SpRaceAwards_UpdateRival(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent])
    UIGlobals.SPRA_UpdateRival = false
  end
  if UIGlobals.StartPostRaceLeaderboardWrite == true then
    UIGlobals.StartPostRaceLeaderboardWrite = nil
    if UIGlobals.SPPostRaceLeaderboardDone == false then
      print("FrameUPdate")
      Amax.StartSPScoreboardWrite()
    end
    SpMiniLeaderboard_Init()
    GUI.leaderboard_initialised = SpMiniLeaderboard_PostInit(SCUI.name_to_id.centre)
    SpRaceAwards_UpdateRival(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent])
    GUI.LeaderboardsValid = true
  end
  if GUI.FinishPostRaceLeaderboardScreen == false then
    if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
      if UIGlobals.SuccessfullyCreatedNetworkSession == false and Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
        return
      end
    elseif LSP.IsConnected() == false and net_CanReconnectToDemonware() == true and GUI.LeaderboardsValid == false then
      return
    end
  end
  if GUI.LeaderboardsValid == true then
    if Amax.SPScooreboardWriteSuccess() == false then
      if GUI.WriteFailed ~= true then
        SetupCustomPopup(UIEnums.CustomPopups.FailedWriteToLeaderboards)
        GUI.WriteFailed = true
      end
    elseif GUI.WriteFailed == false and Amax.SPScoreboardWriteComplete() == true then
      if GUI.FinishedWriting == false then
        print("write Complete ...")
      end
      UIGlobals.SPPostRaceLeaderboardDone = true
      GUI.FinishedWriting = true
    end
    if UIGlobals.LeaderboardReTryPassed ~= nil and UIGlobals.LeaderboardReTryPassed == true then
      UIGlobals.LeaderboardReTryPassed = nil
      GUI.FinishedWriting = true
    end
    if GUI.FinishedWriting == true then
      GUI.LeaderboardWriteTimer = GUI.LeaderboardWriteTimer - _ARG_0_
      if (GUI.LeaderboardWriteTimer <= 0 or GUI.WriteFailed == true) and UIGlobals.NetworkSessionStarted == true then
        Amax.EndPlayStatsOnlyMatchingSession()
        UIGlobals.NetworkSessionStarted = false
        print("Network Session Ended")
      end
    end
  end
  if GUI.LeaderboardsValid == true and GUI.leaderboard_initialised == true and GUI.FinishedWriting == true then
    SpMiniLeaderboard_FrameUpdate(_ARG_0_, true, false)
  end
  GUI.timer = GUI.timer + _ARG_0_
  if GUI.light_change_active == true then
    if GUI.light_change_timer > GUI.light_change_timer_next then
      GUI.light_change_timer_next = GUI.light_change_timer_next + 0.325
      SpRaceAwards_UpdateLight()
    end
    GUI.light_change_timer = GUI.light_change_timer + _ARG_0_
  end
end
function EnterEnd()
end
function EndLoop(_ARG_0_)
end
function End()
  if GUI.loading_ui == true then
    SpRaceAwards_BackToUiEnd()
  end
end
function SpRaceAwards_CreatePrimaryLights(_ARG_0_, _ARG_1_)
  for _FORV_8_ = 1, SP_MaxStars(GUI.is_boss_race) do
    for _FORV_13_, _FORV_14_ in ipairs((Sp_CreateStar(_FORV_8_ <= Sp_EventStateToStars(_ARG_1_, GUI.is_boss_race), _FORV_8_, _ARG_1_, nil, nil, 12, true, false))) do
      UIButtons.SetParent(_FORV_14_, _ARG_0_, UIEnums.Justify.TopRight)
      UIButtons.ChangePanel(_FORV_14_, UIEnums.Panel._3DAA_0, true)
      UIButtons.ChangeJustification(_FORV_14_, UIEnums.Justify.MiddleCentre)
      UIButtons.ChangeScale(_FORV_14_, 12, 12)
      if _FORV_8_ == 1 and _FORV_13_ == 1 then
        _, _ = UIButtons.GetSize(_FORV_14_)
      end
    end
    GUI.light_ids.result.primary[#GUI.light_ids.result.primary + 1] = Sp_CreateStar(_FORV_8_ <= Sp_EventStateToStars(_ARG_1_, GUI.is_boss_race), _FORV_8_, _ARG_1_, nil, nil, 12, true, false)
  end
  UIButtons.ChangePosition(_ARG_0_, UIButtons.GetPosition(_ARG_0_) - _FOR_ * UIButtons.GetSize(_FORV_14_) * 13 * 0.5, UIButtons.GetPosition(_ARG_0_))
  if GUI.is_boss_race == true then
    UIButtons.SetActive(SCUI.name_to_id.fan_par_rb, false)
    UIButtons.SetActive(SCUI.name_to_id.gfd_rb, false)
    UIButtons.ChangePosition(SCUI.name_to_id.primary_rb, 0, UIButtons.GetPosition(SCUI.name_to_id.primary_rb))
  end
end
function SpRaceAwards_CreateSecondaryLights(_ARG_0_, _ARG_1_)
  for _FORV_6_, _FORV_7_ in ipairs((Sp_CreateStar(_ARG_1_, 1, nil, true, nil, nil, true, false))) do
    UIButtons.SetParent(_FORV_7_, _ARG_0_, UIEnums.Justify.TopRight)
    UIButtons.ChangePanel(_FORV_7_, UIEnums.Panel._3DAA_0, true)
    UIButtons.ChangeJustification(_FORV_7_, UIEnums.Justify.MiddleCentre)
    UIButtons.ChangeScale(_FORV_7_, 12, 12)
  end
  GUI.light_ids.result.fan_par = Sp_CreateStar(_ARG_1_, 1, nil, true, nil, nil, true, false)
end
function SpRaceAwards_CreateGfdLights(_ARG_0_, _ARG_1_)
  for _FORV_6_, _FORV_7_ in ipairs((Sp_CreateStar(_ARG_1_, 1, nil, nil, true, nil, true, false))) do
    UIButtons.SetParent(_FORV_7_, _ARG_0_, UIEnums.Justify.TopRight)
    UIButtons.ChangePanel(_FORV_7_, UIEnums.Panel._3DAA_0, true)
    UIButtons.ChangeJustification(_FORV_7_, UIEnums.Justify.MiddleCentre)
    UIButtons.ChangeScale(_FORV_7_, 12, 12)
  end
  GUI.light_ids.result.fan_run = Sp_CreateStar(_ARG_1_, 1, nil, nil, true, nil, true, false)
end
function SpRaceAwards_SetEventInfo(_ARG_0_)
  UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "New"), false)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "EventNumber"), "GAME_NUM_" .. UIGlobals.Sp.CurrentEvent)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "KindName"), Sp_KindToText(GUI.event_info.kind))
  UIShape.ChangeObjectName(UIButtons.FindChildByName(_ARG_0_, "KindIcon"), Sp_KindToShape(GUI.event_info.kind))
  for _FORV_6_ = 1, SP_MaxStars(GUI.is_boss_race) do
    for _FORV_12_, _FORV_13_ in ipairs(Sp_CreateStar(_FORV_6_ <= Sp_EventStateToStars(GUI.event_info.state, GUI.is_boss_race), _FORV_6_, GUI.event_info.state, nil, nil, nil, true, true)) do
      UIButtons.ChangePanel(_FORV_13_, UIEnums.Panel._3DAA_0, true)
      UIButtons.SetParent(_FORV_13_, UIButtons.FindChildByName(_ARG_0_, "Light_Root"), UIEnums.Justify.TopRight)
    end
    GUI.light_ids.event.primary[#GUI.light_ids.event.primary + 1] = Sp_CreateStar(_FORV_6_ <= Sp_EventStateToStars(GUI.event_info.state, GUI.is_boss_race), _FORV_6_, GUI.event_info.state, nil, nil, nil, true, true)
    GUI.light_ids.event.primary_blob[#GUI.light_ids.event.primary_blob + 1] = Sp_CreateStar(_FORV_6_ <= Sp_EventStateToStars(GUI.event_info.state, GUI.is_boss_race), _FORV_6_, GUI.event_info.state, nil, nil, nil, true, true)
  end
  if _FOR_.is_boss_race == false then
    for _FORV_8_, _FORV_9_ in ipairs(Sp_CreateStar(GUI.event_info.fanParComplete, 6.5, nil, true, nil, nil, true, true)) do
      UIButtons.ChangePanel(_FORV_9_, UIEnums.Panel._3DAA_0, true)
      UIButtons.SetParent(_FORV_9_, UIButtons.FindChildByName(_ARG_0_, "Light_Root"), UIEnums.Justify.TopRight)
    end
    GUI.light_ids.event.fan_par = Sp_CreateStar(GUI.event_info.fanParComplete, 6.5, nil, true, nil, nil, true, true)
    GUI.light_ids.event.fan_par_blob = Sp_CreateStar(GUI.event_info.fanParComplete, 6.5, nil, true, nil, nil, true, true)
    for _FORV_10_, _FORV_11_ in ipairs(Sp_CreateStar(GUI.event_info.fanRunComplete, 7.5, nil, nil, true, nil, true, true)) do
      UIButtons.ChangePanel(_FORV_11_, UIEnums.Panel._3DAA_0, true)
      UIButtons.SetParent(_FORV_11_, UIButtons.FindChildByName(_ARG_0_, "Light_Root"), UIEnums.Justify.TopRight)
    end
    GUI.light_ids.event.fan_run = Sp_CreateStar(GUI.event_info.fanRunComplete, 7.5, nil, nil, true, nil, true, true)
    GUI.light_ids.event.fan_run_blob = Sp_CreateStar(GUI.event_info.fanRunComplete, 7.5, nil, nil, true, nil, true, true)
  end
  UIShape.ChangeObjectName(SCUI.name_to_id.city_icon, GameData.GetEvent(GUI.event_info.eventId).city_icon_name)
  UIButtons.ChangeText(SCUI.name_to_id.city_name, GameData.GetEvent(GUI.event_info.eventId).city_name)
  UIButtons.ChangeText(SCUI.name_to_id.route_name, GameData.GetEvent(GUI.event_info.eventId).route_name)
  UIButtons.ChangePosition(SCUI.name_to_id.city_icon, UIButtons.GetPosition(SCUI.name_to_id.city_icon) - math.max(UIButtons.GetStaticTextLength(SCUI.name_to_id.city_name), (UIButtons.GetStaticTextLength(SCUI.name_to_id.route_name))) / 2, UIButtons.GetPosition(SCUI.name_to_id.city_icon))
  UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "BoxFrame"), "Main_2")
  if Amax.EventOwnerState(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]) == UIEnums.EventOwnerResult.Losing or Amax.EventOwnerState(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]) == UIEnums.EventOwnerResult.Winning then
    UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("SpSCUI", "Owner_Node"), UIEnums.Panel._3DAA_0, true)
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SpSCUI", "Owner_Node"), UIButtons.FindChildByName(_ARG_0_, "BoxFrame"), UIEnums.Justify.BottomLeft)
    Sp_UpdateOwnerState(UIButtons.CloneXtGadgetByName("SpSCUI", "Owner_Node"), Amax.EventOwnerState(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]), UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent])
  end
end
function SpRaceAwards_BestOn()
  if GUI.beating_best == nil then
    return
  end
  UISystem.PlaySound(Select(GUI.beating_best == true, UIEnums.SoundEffect.PostRaceBest, UIEnums.SoundEffect.PostRaceNotBest))
end
function SpRaceAwards_FailedOn()
  if GUI.result.state == "none" then
    UISystem.PlaySound(UIEnums.SoundEffect.PostRaceFailed)
  end
end
function SpRaceAwards_NewOn()
  if GUI.has_new_unlocks == true then
    UISystem.PlaySound(UIEnums.SoundEffect.PostRaceNewUnlocks)
  end
end
function SpRaceAwards_TakePhoto()
  SpRaceAwards_CheckCanReconnectLeaderboard()
  if UIGlobals.FriendDemandSent == true then
    SetupCustomPopup(UIEnums.CustomPopups.SpPostRaceOptions)
  else
    Amax.TakePhoto(1, false, false)
  end
  UIButtons.SetActive(SCUI.name_to_id.background, true)
  Amax.SendMessage(UIEnums.GameFlowMessage.Pause)
  UISystem.PlaySound(UIEnums.SoundEffect.EndOfRacePause)
  GUI.has_taken_photo = true
end
function SpRaceAwards_BackToUiStart()
  GUI.loading_ui = true
  Amax.SendMessage(UIEnums.GameFlowMessage.UnPause)
  UISystem.PlaySound(UIEnums.SoundEffect.EndOfRaceUnPause)
  Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
  UIScreen.SetScreenTimers(0, 0.3)
  UIButtons.TimeLineActive("end_alpha", true)
  UIButtons.TimeLineActive("start_load", true)
  SetupInfoLine()
  StartAsyncSave()
  GoScreen("Loading\\LoadingUi.lua")
end
function SpRaceAwards_BackToUiEnd()
end
function SpRaceAwards_CanGoLeaderboard()
  return GUI.current_stage == GUI.stage.goals and Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true and GUI.result.state ~= "none" and GUI.LeaderboardsValid == true
end
function SpRaceAwards_CheckCanReconnectLeaderboard()
  if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
    if UIGlobals.SuccessfullyCreatedNetworkSession ~= true and Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
      GUI.FinishPostRaceLeaderboardScreen = false
      SetupCustomPopup(UIEnums.CustomPopups.SPLeaderboardPostRaceError)
    end
  elseif LSP.IsConnected() == false and net_CanStartOnlineServiceConnection() == true then
    GUI.FinishPostRaceLeaderboardScreen = false
    SetupCustomPopup(UIEnums.CustomPopups.SPLeaderboardPostRaceError)
  end
end
function SpRaceAwards_TryGoLeaderboard(_ARG_0_)
  if _ARG_0_ == true then
    if SpRaceAwards_CanGoLeaderboard() == false and GUI.current_stage == GUI.stage.goals then
      SetupInfoLine(UIText.INFO_A_NEXT, "GAME_SHARE_BUTTON")
      GUI.allow_next_and_share = true
    end
  elseif SpRaceAwards_CanGoLeaderboard() == true then
    SpRaceAwards_GoLeaderboard()
  elseif GUI.current_stage == GUI.stage.goals then
    SetupInfoLine(UIText.INFO_A_NEXT, "GAME_SHARE_BUTTON")
    GUI.allow_next_and_share = true
  end
end
function SpRaceAwards_GoLeaderboard()
  GUI.current_stage = GUI.stage.leaderboard
  UIButtons.TimeLineActive("goals_off", true)
  UIButtons.TimeLineActive("leaderboard_on", true)
  if GUI.result.state ~= "none" then
    SetupInfoLine(UIText.INFO_A_NEXT, "GAME_SHARE_BUTTON")
    GUI.allow_next_and_share = true
  else
    SetupInfoLine(UIText.INFO_A_NEXT)
  end
end
function SpRaceAwards_UpdateLight(_ARG_0_, _ARG_1_)
  if _ARG_1_ == nil then
    _ARG_1_ = 0
  end
  UISystem.PlaySound(UIEnums.SoundEffect.MedalIncrease)
  for _FORV_7_ = GUI.light_change_current, Select(_ARG_0_, #GUI.light_effect_ids, GUI.light_change_current) do
    UIButtons.PrivateTimeLineActive(GUI.light_effect_ids[GUI.light_change_current][1], "light_off", true, _ARG_1_, _ARG_0_)
    UIButtons.PrivateTimeLineActive(GUI.light_effect_ids[GUI.light_change_current][2], "light_on", true, 0)
    UIButtons.PrivateTimeLineActive(GUI.light_effect_ids[GUI.light_change_current][6], "light_on", true, 0)
    SpSetStarTexture(GUI.light_effect_ids[GUI.light_change_current][2], true, Select(Sp_EventStateToStars(GUI.result.state) > Sp_EventStateToStars(GUI.event_info.state), GUI.result.state, GUI.event_info.state), GUI.light_effect_ids[GUI.light_change_current][4], GUI.light_effect_ids[GUI.light_change_current][5])
    if GUI.light_effect_ids[GUI.light_change_current][4] == true or GUI.light_effect_ids[GUI.light_change_current][5] == true then
    end
    UIButtons.ChangeColour(GUI.light_effect_ids[GUI.light_change_current][6], (Sp_EventStateToColour("gold")))
    GUI.light_change_current = GUI.light_change_current + 1
  end
  if _FOR_.light_change_current > #GUI.light_effect_ids then
    GUI.light_change_active = false
    UIButtons.TimeLineActive("goals_darken", true, 0)
  end
end
function SpRaceAwards_Skip()
  if GUI.has_skipped == true then
    return
  end
  if GUI.has_taken_photo ~= true then
    SpRaceAwards_TakePhoto()
  end
  UIButtons.TimeLineActive("CSB_off", true, 100, true)
  UIButtons.TimeLineActive("commands", true, 100, true)
  UIButtons.TimeLineActive("primary_on", true, 100, true)
  UIButtons.TimeLineActive("fan_par_on", true, 100, true)
  UIButtons.TimeLineActive("fan_run_on", true, 100, true)
  UIButtons.TimeLineActive("best_info_on", true, 100, true)
  UIButtons.TimeLineActive("fail_info_on", true, 100, true)
  UIButtons.TimeLineActive("city_info_on", true, 100, true)
  if GUI.result.state ~= "none" then
    UIButtons.TimeLineActive("event_info_on", true, 100, true)
  end
  SpRaceAwards_UpdateLight(true, 100)
  SpRaceAwards_TryGoLeaderboard(true)
  SpRaceAwards_TryGoLeaderboard()
  GUI.has_skipped = true
end
function SpRaceAwards_UpdateRival(_ARG_0_)
  if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false or LSP.IsConnected() == false then
    UIButtons.SetActive(SCUI.name_to_id._background_box, false)
    UIButtons.SetActive(SCUI.name_to_id._text_title_rival, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Help, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_AvatarFrame, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Gamertag, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Score, false)
    return
  end
  if Amax.HasSinglePlayerRival() == true then
    if SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).new == true then
      UIButtons.SetActive(SCUI.name_to_id.Owner_Help, true)
      UIButtons.ChangeText(SCUI.name_to_id.Owner_Help, UIText.CMN_RIVAL_EVENT_NEW)
      UIButtons.SetActive(SCUI.name_to_id.Owner_AvatarFrame, false)
      UIButtons.SetActive(SCUI.name_to_id.Owner_Gamertag, false)
      UIButtons.SetActive(SCUI.name_to_id.Owner_Score, false)
    else
      UIButtons.SetActive(SCUI.name_to_id.Owner_Help, false)
      UIButtons.SetActive(SCUI.name_to_id.Owner_AvatarFrame, true)
      UIButtons.SetActive(SCUI.name_to_id.Owner_Gamertag, true)
      UIButtons.SetActive(SCUI.name_to_id.Owner_Score, true)
      if Profile.GetRemoteGamerPictureMap()[0] ~= nil then
        UIButtons.ChangeTexture({
          filename = "REMOTE_GAMERPIC_" .. Profile.GetRemoteGamerPictureMap()[0]
        }, 1, SCUI.name_to_id.Owner_AvatarFrame)
      end
      UIButtons.ChangeText(SCUI.name_to_id.Owner_Gamertag, "SPL_EVENT_" .. _ARG_0_ .. "_RIVAL_NAME")
      UIButtons.ChangeText(SCUI.name_to_id.Owner_Score, "SPL_EVENT_" .. _ARG_0_ .. "_RIVAL_SCORE")
    end
  else
    UIButtons.SetActive(SCUI.name_to_id.Owner_Help, true)
    UIButtons.ChangeText(SCUI.name_to_id.Owner_Help, UIText.CMN_NO_RIVAL_SET_GAME)
    UIButtons.SetActive(SCUI.name_to_id.Owner_AvatarFrame, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Gamertag, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Score, false)
  end
end
