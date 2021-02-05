GUI = {
  finished = false,
  loading_ui = false,
  light_ids = {
    result = {
      primary = {}
    }
  },
  timer = 0,
  allow_next_and_share = false,
  count_failed = 0,
  count = 0
}
function Init()
  UIScreen.SetScreenTimers(1, UIGlobals.screen_time.default_end)
  AddSCUI_Elements()
  SetupInfoLine()
  if UIGlobals.FriendDemandSent == true then
    UIButtons.SetActive(SCUI.name_to_id.background, true)
  end
  if IsWideScreen() == false then
    UIButtons.ChangeScale(SCUI.name_to_id.centre, 1.35, 1.35, 1.35)
  end
end
function PostInit()
  GUI.is_boss_race = Amax.SP_IsBossBattleFD()
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), SCUI.name_to_id.primary_rb, UIEnums.Justify.MiddleCentre)
  SpFriendDemand_CreatePrimaryLights(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_light_dummy"), Amax.SP_GetLevelResult().state)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_title"), UIText.SP_EVENT_PRIMARY)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info"), "HUD_SP_RACE_RESULT")
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_icon"), Sp_KindToShape(SinglePlayer.EventInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).eventid_sp).kind))
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), SCUI.name_to_id.criteria_rb, UIEnums.Justify.MiddleCentre)
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_icon"), false)
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic"), true)
  UIButtons.ChangeTexture(Fd_GetCriteriaIconInfo(SinglePlayer.EventInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).eventid_sp).kind).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic")))
  UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic"), Fd_GetCriteriaIconInfo(SinglePlayer.EventInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).eventid_sp).kind).effect)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_title"), "HUD_SP_FD_CRITERIA_RESULT_TITLE")
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info_lights"), "HUD_SP_FD_CRITERIA_RESULT_THEM")
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info"), "HUD_SP_FD_CRITERIA_RESULT_YOU")
  if FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).extra_modifier == UIEnums.FriendDemandModifer.NotUsed then
    UIButtons.ChangePosition(SCUI.name_to_id.primary_rb, 100, nil, nil, true)
    UIButtons.ChangePosition(SCUI.name_to_id.criteria_rb, 100, nil, nil, true)
    GUI.has_extra_modifier = false
  else
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), SCUI.name_to_id.param_rb, UIEnums.Justify.MiddleCentre)
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_icon"), false)
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic"), true)
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic_lights"), true)
    UIButtons.ChangeTexture(Fd_GetModifierIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).extra_modifier).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic_lights")))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic_lights"), Fd_GetModifierIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).extra_modifier).effect)
    UIButtons.ChangeTexture(Fd_GetParamIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).extra_param).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic")))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic"), Fd_GetParamIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).extra_param).effect)
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_graphic"), Fd_GetParamIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).extra_param).colour)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_title"), "HUD_SP_FD_PARAM_RESULT_TITLE")
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info_lights"), "HUD_SP_FD_PARAM_RESULT_THEM")
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\Ingame\\SpRaceAwards.lua", "_obj_dummy"), "_obj_info"), "HUD_SP_FD_PARAM_RESULT_YOU")
  end
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), SCUI.name_to_id.blurb_node_rb, UIEnums.Justify.MiddleCentre)
  UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), UIEnums.Panel._3DAA_LIGHT, true)
  UIButtons.ChangeOrientation(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), 0, 0, 0)
  UIButtons.SetSelected(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), false, true)
  UIButtons.SetSelected(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), true, true)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_icon"), Sp_KindToShape(SinglePlayer.EventInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).eventid_sp).kind))
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_event_text"), Sp_KindToText(SinglePlayer.EventInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).eventid_sp).kind))
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_name"), "GAME_BLURB_NORMAL_MSG" .. UIGlobals.FriendDemandAttemptingIndex .. "_NAME")
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_info_time_sent"), "GAME_BLURB_NORMAL_MSG" .. UIGlobals.FriendDemandAttemptingIndex .. "_TIME_SENT")
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_info_days_left"), "GAME_BLURB_NORMAL_MSG" .. UIGlobals.FriendDemandAttemptingIndex .. "_ATTEMPTS")
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_type_icon"), false)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_sender"), "GAME_BLURB_NORMAL_MSG" .. UIGlobals.FriendDemandAttemptingIndex .. "_SENDER")
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_icon"), false)
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_event_text"), false)
  UIButtons.ChangeText(SCUI.name_to_id.selection_box_text_no_highlight, "GAME_BLURB_NORMAL_MSG" .. UIGlobals.FriendDemandAttemptingIndex .. "_DESC")
  FriendDemand.GetResult().passed = FriendDemand.GetResult().passed_state == true and FriendDemand.GetResult().passed_criteria == true
  if FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).extra_modifier ~= UIEnums.FriendDemandModifer.NotUsed then
    FriendDemand.GetResult().passed = FriendDemand.GetResult().passed == true and FriendDemand.GetResult().passed_param == true
  end
  UIButtons.ChangeText(SCUI.name_to_id.pass_fail_info, Select(FriendDemand.GetResult().passed, UIText.FDE_POST_RACE_PASS, UIText.FDE_POST_RACE_FAIL))
  UIButtons.ChangeColour(SCUI.name_to_id.pass_fail_info, Select(FriendDemand.GetResult().passed, "Support_0", "Support_3"))
  UIButtons.ChangeColour(SCUI.name_to_id.pass_fail_icon, Select(FriendDemand.GetResult().passed, "Support_0", "Support_3"))
  GUI.fd_passed = FriendDemand.GetResult().passed
  if FriendDemand.GetResult().passed_state == false then
    GUI.count_failed = GUI.count_failed + 1
    UIButtons.ReplaceTimeLineLabel(SCUI.name_to_id.primary_rb, "darken", "darken_" .. GUI.count_failed)
  end
  if FriendDemand.GetResult().passed_criteria == false then
    GUI.count_failed = GUI.count_failed + 1
    UIButtons.ReplaceTimeLineLabel(SCUI.name_to_id.criteria_rb, "darken", "darken_" .. GUI.count_failed)
  end
  if FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).extra_modifier ~= UIEnums.FriendDemandModifer.NotUsed and FriendDemand.GetResult().passed_param == false then
    GUI.count_failed = GUI.count_failed + 1
    UIButtons.ReplaceTimeLineLabel(SCUI.name_to_id.param_rb, "darken", "darken_" .. GUI.count_failed)
  end
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
  if _ARG_0_ == UIEnums.Message.MenuNext then
    if GUI.allow_next_and_share == false and GUI.has_taken_photo == true then
      SpFriendDemand_Skip()
    elseif GUI.allow_next_and_share == true then
      SetupCustomPopup(UIEnums.CustomPopups.SpPostRaceOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder then
    if GUI.allow_next_and_share == true and FriendDemand.IsComplete() > 0 and Amax.CanUseShare() == true then
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK)
      UIGlobals.ShareFromWhatPopup = -1
      SetupCustomPopup(UIEnums.CustomPopups.SharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    if FriendDemand.IsComplete() > 0 then
    end
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FriendDemandPassed, 1, -1)
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Ingame\\SpFriendDemand.lua")
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FriendDemandPassed, 0, -1)
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Ingame\\SpFriendDemand.lua")
      GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FriendDemandPassed, 2, -1)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SpPostRaceOptions then
    if _ARG_3_ == 0 then
      SpFriendDemand_Retry()
    elseif _ARG_3_ == 1 then
      SpFriendDemand_BackToUiStart()
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
      else
        StoreScreen(UIEnums.ScreenStorage.FE_FRIEND_DEMAND)
        FriendDemand.PopulateRechallengeText()
        GoScreen("Ingame\\ReChallengeFriendDemand.lua")
      end
    end
  end
end
function FrameUpdate(_ARG_0_)
end
function EnterEnd()
end
function EndLoop(_ARG_0_)
end
function End()
  if GUI.loading_ui == true then
    SpFriendDemand_BackToUiEnd()
  end
end
function SpFriendDemand_CreatePrimaryLights(_ARG_0_, _ARG_1_)
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
end
function SpFriendDemand_ParamOn()
  if GUI.has_extra_modifier ~= false then
    UISystem.PlaySound(UIEnums.SoundEffect.PostRaceGoalSpawn)
  end
end
function SpFriendDemand_PassFailOn()
  UISystem.PlaySound(Select(GUI.fd_passed == true, UIEnums.SoundEffect.PostRacePassed, UIEnums.SoundEffect.PostRaceFailed))
end
function SpFriendDemand_TakePhoto()
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
function SpFriendDemand_BackToUiStart()
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
function SpFriendDemand_BackToUiEnd()
end
function SpFriendDemand_Retry()
  FriendDemand.ReAttempt()
  UIButtons.SetActive(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.Txt_Loading, true, true)
  UIButtons.TimeLineActive("CSB_off_full", true)
  UIButtons.TimeLineActive("start_load", true)
  GameProfile.RetryingEvent()
  StopIngameMusic()
  Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
  Amax.SendMessage(UIEnums.GameFlowMessage.StopGameUpdate)
  UIGlobals.IsQuickRestart = true
  UIGlobals.Ingame = {}
  GoLoadingScreen("Loading\\LoadingSpGame.lua")
end
function SpFriendDemand_Skip()
  if GUI.has_skipped == true then
    return
  end
  if GUI.has_taken_photo ~= true then
    SpFriendDemand_TakePhoto()
  end
  UIButtons.TimeLineActive("CSB_off", true, 100, true)
  UIButtons.TimeLineActive("commands", true, 100, true)
  UIButtons.TimeLineActive("primary_on", true, 100, true)
  UIButtons.TimeLineActive("fan_par_on", true, 100, true)
  UIButtons.TimeLineActive("fan_run_on", true, 100, true)
  UIButtons.TimeLineActive("blurb_info_on", true, 100, true)
  UIButtons.TimeLineActive("darken_1", true, 100, true)
  UIButtons.TimeLineActive("darken_2", true, 100, true)
  UIButtons.TimeLineActive("darken_3", true, 100, true)
  UIButtons.TimeLineActive("pass_fail_info_on", true, 100, true)
  SpFriendDemand_EffectsFinished()
  GUI.has_skipped = true
end
function SpFriendDemand_DarkenFinished(_ARG_0_)
  if _ARG_0_ ~= true then
    GUI.count = GUI.count + 1
  end
  if GUI.count == GUI.count_failed then
    UIButtons.TimeLineActive("pass_fail_info_on", true, 0)
  end
end
function SpFriendDemand_EffectsFinished()
  GUI.allow_next_and_share = true
  if FriendDemand.IsComplete() > 0 then
    SetupInfoLine(UIText.INFO_A_NEXT, "GAME_SHARE_BUTTON")
  else
    SetupInfoLine(UIText.INFO_A_NEXT)
  end
end
