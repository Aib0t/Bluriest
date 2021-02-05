GUI = {
  finished = false,
  DisableLoading = false,
  WaitForFinishLoad = false,
  move_cool_down = 0,
  Tabs = {
    Min = 0,
    Map = 1,
    Goal = 2,
    FanPar = 3,
    FanRun = 4,
    Max = 5
  },
  TabsActive = {
    true,
    true,
    true,
    true
  },
  CurrentTab = 0,
  RaceType = 0,
  tip_timer = 0,
  tip_change_time = 10,
  transmitter_id = 0,
  reading_leaderboard = false,
  server_timeout = 0,
  local_tips_table = {},
  CurrentlySelectingFromLocalTips = true
}
function HandleLoad()
  Amax.EnterNetworkLoad()
  if UIGlobals.IsQuickRestart == false then
    Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
    Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
    if Amax.AmaxWorldLayerExists() == true then
      Amax.SendMessage(UIEnums.GameFlowMessage.DumpLevel)
    end
  else
    StartGameLoad()
  end
  UIGlobals.Ingame = {}
  UIGlobals.IsLoading = true
end
function Init()
  net_LockoutFriendsOverlay(true)
  if UIGlobals.SuccessfullyCreatedNetworkSession == true and UIGlobals.NetworkSessionStarted == false then
    Amax.StartPlayStatsOnlyMatchingSession()
    UIGlobals.NetworkSessionStarted = true
    print("Network Session Started: ", UIGlobals.NetworkSessionStarted)
  end
  if IsTable(UIGlobals.Sp) == true and IsTable(UIGlobals.Sp.BossInfo) == true and IsTable(UIGlobals.SpBossDemandStore) == true then
    CloneTable(UIGlobals.Sp.BossInfo[UIGlobals.Sp.CurrentTier], UIGlobals.SpBossDemandStore[UIGlobals.Sp.CurrentTier])
  end
  AddSCUI_Elements()
  UIScreen.SetScreenTimers(0, 1)
  GUI.event_id = nil
  GUI.is_fd = SP_IsFriendDemand()
  if GUI.is_fd == true then
    GUI.fd_index = UIGlobals.FriendDemandAttemptingIndex
    GUI.fd_info = FriendDemand.GetInfo(GUI.fd_index)
    GUI.event_id = GUI.fd_info.eventid_sp
  else
    GUI.event_id = UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]
  end
  GUI.event_info = SinglePlayer.EventInfo(GUI.event_id)
  GUI.amax_event_info = GameData.GetEvent(GUI.event_info.eventId)
  if IsTable((Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista, GUI.amax_event_info.route_id))) == true then
    UIButtons.ChangePosition(SCUI.name_to_id.VistaDestination, XtToScreenSpaceX(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista, GUI.amax_event_info.route_id).px, true), XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista, GUI.amax_event_info.route_id).py, true))
  end
  UIButtons.DummyLerpMatrixCopy(SCUI.name_to_id.VistaDestination, SCUI.name_to_id.VistaDummy)
  if GUI.DisableLoading == true then
    return
  end
  Profile.AllowProfileChanges(true)
  Profile.ActOnProfileChanges(false)
  UIGlobals.ActUponFriendChallenges = false
  UIGlobals.Ingame = {}
  Amax.SetLoadStateIntoRace()
  UIGlobals.Sp_PreviousFans = nil
  if Amax.IsFrontEndLoading() == true then
    GUI.WaitForFinishLoad = true
  else
    HandleLoad()
  end
end
function PostInit()
  SetupInfoLine(UIText.INFO_NEXT_TIP_RT)
  AddLoadingSegs()
  if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true or UIEnums.CurrentPlatform == UIEnums.Platform.PS3 and LSP.IsConnected() == true then
    GUI.reading_leaderboard = true
    print("Reading the scoreboard")
    Amax.StartFriendScoreboardRead(0)
  end
  UIButtons.TimeLineActive("Goal_Up", true, 1)
  UIButtons.TimeLineActive("FanPar_Up", true, 1)
  UIButtons.TimeLineActive("FanRun_Up", true, 1)
  UIButtons.TimeLineActive("Map_Up", true, 1)
  Sp_UpdateEventPreview(SCUI.name_to_id.VistaDestination, GUI.event_info, GUI.amax_event_info, GUI.event_id)
  if SP_ChangeRestrictionText(SCUI.name_to_id.Restriction_Title, SCUI.name_to_id.Restriction_Text, GUI.event_info) ~= true then
    UIButtons.ChangeSize(SCUI.name_to_id.RacesFrame, UIButtons.GetSize(SCUI.name_to_id.RacesFrame))
    UIButtons.ChangeSize(SCUI.name_to_id.BoxInner, UIButtons.GetSize(SCUI.name_to_id.RacesFrame))
  end
  UpdateRouteShapes("Shp_Route", 4, GUI.amax_event_info.city_id, GUI.amax_event_info.route_id, "Shp_StartLine")
  GUI.CurrentTab = GUI.Tabs.Goal
  UIShape.ChangeObjectName(SCUI.name_to_id.big_KindIcon, Sp_KindToShape(GUI.event_info.kind))
  if GUI.is_fd == true then
    UIButtons.ChangeText(SCUI.name_to_id.goal_title, UIText.FDE_MEDAL_ACHIEVED)
    UIButtons.ChangeText(SCUI.name_to_id.primary_info_gold, "SPL_EVENT_" .. GUI.event_id .. "_PRIMARY_GOAL_" .. Sp_EventStateToNumber(GUI.fd_info.state) .. "_" .. GUI.fd_info.difficulty)
    UIButtons.ChangeText(SCUI.name_to_id.primary_info_num_lights_gold, "SPL_EVENT_STAR_COUNT_" .. Sp_EventStateToStars(GUI.fd_info.state, GUI.event_info.kind == "boss"))
    SpSetStarTexture(SCUI.name_to_id.BlurLight_On_gold, true, GUI.fd_info.state)
    UIButtons.SetActive(SCUI.name_to_id.goal_silver, false)
    UIButtons.SetActive(SCUI.name_to_id.goal_bronze, false)
    UIButtons.SetActive(SCUI.name_to_id.fan_par_light_dummy, false, true)
    UIButtons.SetActive(SCUI.name_to_id.fan_run_light_info, false, true)
    UIShape.ChangeObjectName(SCUI.name_to_id.fan_par_icon, Fd_GetCriteriaShape(GUI.event_info.kind))
    UIButtons.ChangeText(SCUI.name_to_id.fan_par_title, "GAME_FRIEND_DEMAND_STORE_CRITERIA_TITLE_" .. GUI.fd_index .. "_0")
    UIButtons.ChangeText(SCUI.name_to_id.fan_par_fd_info, "GAME_FRIEND_DEMAND_STORE_CRITERIA_VAR_" .. GUI.fd_index .. "_0")
    if GUI.fd_info.extra_modifier == UIEnums.FriendDemandModifer.NotUsed then
      GUI.Tabs.Max = GUI.Tabs.FanPar + 1
    else
      UIButtons.SetActive(SCUI.name_to_id.fan_run_icon, false)
      UIButtons.ChangeText(SCUI.name_to_id.fan_run_title, "GAME_FRIEND_DEMAND_STORE_PARAM_TITLE_" .. GUI.fd_index .. "_0")
      UIButtons.ChangeText(SCUI.name_to_id.fan_run_fd_info, "GAME_FRIEND_DEMAND_STORE_PARAM_VAR_" .. GUI.fd_index .. "_0")
      UIButtons.SetActive(SCUI.name_to_id.fan_run_graphic, true)
      UIButtons.ChangeTexture(Fd_GetParamIconInfo(GUI.fd_info.extra_param).tex, 0, SCUI.name_to_id.fan_run_graphic)
      UIButtons.ChangeEffectIndex(SCUI.name_to_id.fan_run_graphic, Fd_GetParamIconInfo(GUI.fd_info.extra_param).effect)
      UIButtons.ChangeColour(SCUI.name_to_id.fan_run_graphic, Fd_GetParamIconInfo(GUI.fd_info.extra_param).colour)
      UIButtons.SetActive(SCUI.name_to_id.fan_run_modifier_graphic, true)
      UIButtons.ChangeTexture(Fd_GetModifierIconInfo(GUI.fd_info.extra_modifier).tex, 0, SCUI.name_to_id.fan_run_modifier_graphic)
      UIButtons.ChangeEffectIndex(SCUI.name_to_id.fan_run_modifier_graphic, Fd_GetModifierIconInfo(GUI.fd_info.extra_modifier).effect)
    end
  else
    if GUI.event_info.kind == "boss" then
      GUI.Tabs.Max = GUI.Tabs.Goal + 1
    end
    UIButtons.ChangeText(SCUI.name_to_id.primary_info_gold, "SPL_EVENT_" .. GUI.event_id .. "_PRIMARY_GOAL_" .. Sp_EventStateToNumber("gold"))
    if GUI.event_info.kind ~= "boss" then
      UIButtons.ChangeText(SCUI.name_to_id.primary_info_num_lights_gold, "SPL_EVENT_STAR_COUNT_" .. Sp_EventStateToStars("gold"))
      UIButtons.ChangeText(SCUI.name_to_id.primary_info_silver, "SPL_EVENT_" .. GUI.event_id .. "_PRIMARY_GOAL_" .. Sp_EventStateToNumber("silver"))
      UIButtons.ChangeText(SCUI.name_to_id.primary_info_num_lights_silver, "SPL_EVENT_STAR_COUNT_" .. Sp_EventStateToStars("silver"))
      UIButtons.ChangeText(SCUI.name_to_id.primary_info_bronze, "SPL_EVENT_" .. GUI.event_id .. "_PRIMARY_GOAL_" .. Sp_EventStateToNumber("bronze"))
      UIButtons.ChangeText(SCUI.name_to_id.primary_info_num_lights_bronze, "SPL_EVENT_STAR_COUNT_" .. Sp_EventStateToStars("bronze"))
    else
      UIButtons.ChangeText(SCUI.name_to_id.primary_info_num_lights_gold, "SPL_EVENT_STAR_COUNT_" .. Sp_EventStateToStars("gold", true))
      LoadingSPGameSetTabEnabled(GUI.Tabs.FanPar)
      LoadingSPGameSetTabEnabled(GUI.Tabs.FanRun)
      UIButtons.SetActive(SCUI.name_to_id.goal_silver, false)
      UIButtons.SetActive(SCUI.name_to_id.goal_bronze, false)
    end
    UIButtons.ChangeText(SCUI.name_to_id.secondary_info, "SPL_EVENT_" .. GUI.event_id .. "_SECONDARY_GOAL")
    UIButtons.ChangeText(SCUI.name_to_id.fan_demand_info, UIText.SP_EVENT_GFD_INFO)
  end
  LoadingSPGameSetActiveTab(GUI.CurrentTab)
  GUI.RaceType = GUI.event_info.kind
  LoadingSp_HelpTextInit()
  LoadingSp_HelpTextInitLocalTips()
  LoadingSp_HelpTextNext()
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
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.GameFlowMessage.LevelDumped and UIGlobals.IsQuickRestart == false then
    StartGameLoad()
  end
  if _ARG_0_ == UIEnums.Message.ButtonRightTrigger then
    LoadingSp_HelpTextNext()
  elseif _ARG_0_ == UIEnums.Message.ButtonRight then
    if LoadingSPGameSetActiveTab(GUI.CurrentTab + 1) == true then
      UISystem.PlaySound(UIEnums.SoundEffect.LoadingScreenNav)
      UIButtons.TimeLineActive("Bounce_RightArrow", true, 0, true)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeft and LoadingSPGameSetActiveTab(GUI.CurrentTab - 1) == true then
    UISystem.PlaySound(UIEnums.SoundEffect.LoadingScreenNav)
    UIButtons.TimeLineActive("Bounce_LeftArrow", true, 0, true)
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.move_cool_down > 0 then
    GUI.move_cool_down = GUI.move_cool_down - _ARG_0_
  end
  LoadingSp_HelpTextUpdate(_ARG_0_)
  if GUI.reading_leaderboard == true then
    GUI.server_timeout = GUI.server_timeout + _ARG_0_
    if GUI.server_timeout > 15 then
      print("LEADERBOARD READ FAILED!!!!!!--------------------------------------------")
    end
    if true == true then
      GUI.reading_leaderboard = false
      print("Finished Reading Leaderboard", 0, -1, -1)
      UIGlobals.SPPostRaceLeaderboardDone = false
    end
  end
  if GUI.WaitForFinishLoad == true and Amax.IsFrontEndLoading() == false and GUI.reading_leaderboard == false then
    GUI.WaitForFinishLoad = false
    HandleLoad()
  end
end
function EnterEnd()
  SetupInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
  Amax.ExitNetworkLoad()
  Profile.ForceProfileUpdate()
  Profile.ActOnProfileChanges(true)
  UIGlobals.ActUponFriendChallenges = true
end
function LoadingSPGameSetTabEnabled(_ARG_0_, _ARG_1_)
  GUI.TabsActive[_ARG_0_] = _ARG_1_
end
function LoadingSPGameSetActiveTab(_ARG_0_)
  if GUI.move_cool_down > 0 then
    return false
  end
  GUI.move_cool_down = 0.15
  if IsString({
    [GUI.Tabs.Goal] = "Goal",
    [GUI.Tabs.FanPar] = "FanPar",
    [GUI.Tabs.FanRun] = "FanRun",
    [GUI.Tabs.Map] = "Map"
  }[GUI.CurrentTab]) == true then
    UIButtons.TimeLineActive({
      [GUI.Tabs.Goal] = "Goal",
      [GUI.Tabs.FanPar] = "FanPar",
      [GUI.Tabs.FanRun] = "FanRun",
      [GUI.Tabs.Map] = "Map"
    }[GUI.CurrentTab] .. Select(_ARG_0_ > GUI.CurrentTab, "_Up", "_Down"), false, 0)
    UIButtons.TimeLineActive({
      [GUI.Tabs.Goal] = "Goal",
      [GUI.Tabs.FanPar] = "FanPar",
      [GUI.Tabs.FanRun] = "FanRun",
      [GUI.Tabs.Map] = "Map"
    }[GUI.CurrentTab] .. Select(not (_ARG_0_ > GUI.CurrentTab), "_Up", "_Down"), true)
  end
  if _ARG_0_ == GUI.Tabs.Max then
    GUI.CurrentTab = GUI.Tabs.Min + 1
  elseif _ARG_0_ == GUI.Tabs.Min then
    GUI.CurrentTab = GUI.Tabs.Max - 1
  else
    GUI.CurrentTab = _ARG_0_
  end
  if IsString({
    [GUI.Tabs.Goal] = "Goal",
    [GUI.Tabs.FanPar] = "FanPar",
    [GUI.Tabs.FanRun] = "FanRun",
    [GUI.Tabs.Map] = "Map"
  }[GUI.CurrentTab]) == true then
    UIButtons.TimeLineActive({
      [GUI.Tabs.Goal] = "Goal",
      [GUI.Tabs.FanPar] = "FanPar",
      [GUI.Tabs.FanRun] = "FanRun",
      [GUI.Tabs.Map] = "Map"
    }[GUI.CurrentTab] .. Select(_ARG_0_ > GUI.CurrentTab, "_Up", "_Down"), true, 1, true)
    UIButtons.TimeLineActive({
      [GUI.Tabs.Goal] = "Goal",
      [GUI.Tabs.FanPar] = "FanPar",
      [GUI.Tabs.FanRun] = "FanRun",
      [GUI.Tabs.Map] = "Map"
    }[GUI.CurrentTab] .. Select(_ARG_0_ > GUI.CurrentTab, "_Up", "_Down"), false)
    UIButtons.TimeLineActive({
      [GUI.Tabs.Goal] = "Goal",
      [GUI.Tabs.FanPar] = "FanPar",
      [GUI.Tabs.FanRun] = "FanRun",
      [GUI.Tabs.Map] = "Map"
    }[GUI.CurrentTab] .. Select(not (_ARG_0_ > GUI.CurrentTab), "_Up", "_Down"), false, 0)
  end
  return true
end
function LoadingSp_HelpTextInit()
  if GUI.RaceType == "race" then
  elseif GUI.RaceType == "checkpoint" then
  elseif GUI.RaceType == "destruction" then
  elseif GUI.RaceType == "boss" then
  elseif GUI.RaceType == "fan" then
  end
  if UIGlobals.sp_fan_help_text_ids ~= nil and #UIGlobals.sp_fan_help_text_ids > 1 then
    return
  end
  if GUI.RaceType == "race" then
    UIGlobals.sp_race_help_text_ids = {}
  elseif GUI.RaceType == "checkpoint" then
    UIGlobals.sp_checkpoint_help_text_ids = {}
  elseif GUI.RaceType == "destruction" then
    UIGlobals.sp_destruction_help_text_ids = {}
  elseif GUI.RaceType == "boss" then
    UIGlobals.sp_boss_help_text_ids = {}
  elseif GUI.RaceType == "fan" then
    UIGlobals.sp_fan_help_text_ids = {}
  end
  UIGlobals.sp_num_event_help = 50
  UIGlobals.sp_num_generic_help = 100
  if GUI.RaceType == "race" then
  elseif GUI.RaceType == "checkpoint" then
  elseif GUI.RaceType == "destruction" then
  elseif GUI.RaceType == "boss" then
  elseif GUI.RaceType == "fan" then
  end
  for _FORV_4_ = 1, UIGlobals.sp_num_generic_help do
    if _FORV_4_ <= UIGlobals.sp_num_event_help then
      if GUI.RaceType == "race" then
        if UIText["HLP_RACE_" .. _FORV_4_] ~= nil then
          UIGlobals.sp_fan_help_text_ids[#UIGlobals.sp_fan_help_text_ids + 1] = UIText["HLP_RACE_" .. _FORV_4_]
        end
      elseif GUI.RaceType == "checkpoint" then
        if UIText["HLP_CHECKPOINT_" .. _FORV_4_] ~= nil then
          UIGlobals.sp_fan_help_text_ids[#UIGlobals.sp_fan_help_text_ids + 1] = UIText["HLP_CHECKPOINT_" .. _FORV_4_]
        end
      elseif GUI.RaceType == "destruction" then
        if UIText["HLP_DESTRUCTION_" .. _FORV_4_] ~= nil then
          UIGlobals.sp_fan_help_text_ids[#UIGlobals.sp_fan_help_text_ids + 1] = UIText["HLP_DESTRUCTION_" .. _FORV_4_]
        end
      elseif GUI.RaceType == "boss" then
        if UIText["HLP_BOSS_" .. _FORV_4_] ~= nil then
          UIGlobals.sp_fan_help_text_ids[#UIGlobals.sp_fan_help_text_ids + 1] = UIText["HLP_BOSS_" .. _FORV_4_]
        end
      elseif GUI.RaceType == "fan" and UIText["HLP_FAN_" .. _FORV_4_] ~= nil then
        UIGlobals.sp_fan_help_text_ids[#UIGlobals.sp_fan_help_text_ids + 1] = UIText["HLP_FAN_" .. _FORV_4_]
      end
    end
    if UIText["HLP_" .. _FORV_4_] ~= nil then
      UIGlobals.sp_fan_help_text_ids[#UIGlobals.sp_fan_help_text_ids + 1] = UIText["HLP_" .. _FORV_4_]
    end
  end
  for _FORV_4_ = 1, #UIGlobals.sp_fan_help_text_ids do
    UIGlobals.sp_fan_help_text_ids[math.random(#UIGlobals.sp_fan_help_text_ids)], UIGlobals.sp_fan_help_text_ids[_FORV_4_] = UIGlobals.sp_fan_help_text_ids[_FORV_4_], UIGlobals.sp_fan_help_text_ids[math.random(#UIGlobals.sp_fan_help_text_ids)]
  end
end
function LoadingSp_HelpTextInitLocalTips()
  if SinglePlayer.FanStatusForTooltip() == 1 then
    if UIText["HLP_EARLYFANSTATUS_" .. SinglePlayer.FanStatusForTooltip()] ~= nil then
      GUI.local_tips_table[#GUI.local_tips_table + 1] = UIText["HLP_EARLYFANSTATUS_" .. SinglePlayer.FanStatusForTooltip()]
    end
  elseif SinglePlayer.FanStatusForTooltip() == 2 then
    if UIText["HLP_MIDFANSTATUS_" .. SinglePlayer.FanStatusForTooltip()] ~= nil then
      GUI.local_tips_table[#GUI.local_tips_table + 1] = UIText["HLP_MIDFANSTATUS_" .. SinglePlayer.FanStatusForTooltip()]
    end
  elseif SinglePlayer.FanStatusForTooltip() == 3 and UIText["HLP_LATEFANSTATUS_" .. SinglePlayer.FanStatusForTooltip()] ~= nil then
    GUI.local_tips_table[#GUI.local_tips_table + 1] = UIText["HLP_LATEFANSTATUS_" .. SinglePlayer.FanStatusForTooltip()]
  end
  if Profile.PadProfileOnline(Profile.GetPrimaryPad()) then
    for _FORV_5_ = 1, 20 do
      if UIText["HLP_ONLINE_" .. _FORV_5_] ~= nil then
        GUI.local_tips_table[#GUI.local_tips_table + 1] = UIText["HLP_ONLINE_" .. _FORV_5_]
      end
    end
  end
  if _FOR_.is_fd ~= nil and GUI.is_fd == true then
    for _FORV_5_ = 1, 20 do
      if UIText["HLP_FRIEND_" .. _FORV_5_] ~= nil then
        GUI.local_tips_table[#GUI.local_tips_table + 1] = UIText["HLP_FRIEND_" .. _FORV_5_]
      end
    end
  end
  for _FORV_5_ = 1, #GUI.local_tips_table do
    GUI.local_tips_table[_FORV_5_] = GUI.local_tips_table[math.random(#GUI.local_tips_table)]
    GUI.local_tips_table[math.random(#GUI.local_tips_table)] = GUI.local_tips_table[_FORV_5_]
  end
end
function LoadingSp_HelpTextNext()
  if GUI.RaceType == "race" then
  elseif GUI.RaceType == "checkpoint" then
  elseif GUI.RaceType == "destruction" then
  elseif GUI.RaceType == "boss" then
  elseif GUI.RaceType == "fan" then
  end
  if GUI.CurrentlySelectingFromLocalTips == true and #GUI.local_tips_table > 0 then
    GUI.CurrentlySelectingFromLocalTips = false
  else
    GUI.CurrentlySelectingFromLocalTips = true
  end
  UIButtons.ChangeText(SCUI.name_to_id.hint_text, (table.remove(UIGlobals.sp_fan_help_text_ids, 1)))
  UIButtons.TimeLineActive("hint_text_next", true, 0)
  UIButtons.ChangeScale(SCUI.name_to_id.motd_dummy, 1, UIButtons.GetStaticTextHeight(SCUI.name_to_id.hint_text) / UIButtons.GetSize(SCUI.name_to_id.hint_text) + 0.3)
  if #UIGlobals.sp_fan_help_text_ids == 0 then
    LoadingSp_HelpTextInit()
  end
  PlaySfxToggle()
  GUI.tip_timer = 0
end
function LoadingSp_HelpTextUpdate(_ARG_0_)
  GUI.tip_timer = GUI.tip_timer + _ARG_0_
  if GUI.tip_timer >= GUI.tip_change_time then
    LoadingSp_HelpTextNext()
  end
end
