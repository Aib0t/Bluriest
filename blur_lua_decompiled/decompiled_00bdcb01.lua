GUI = {
  finished = false,
  state = {
    summary = 1,
    summary_end = 2,
    progression = 3,
    rank_up = 4,
    end_wait = 6
  },
  current_state = 1,
  timelines = {
    "show_ontrack",
    "show_challenge_bonus",
    "show_finish",
    "show_total",
    "summary_end",
    "show_progression"
  },
  times = {},
  start_time = 0.25,
  end_time = 1,
  base_time = 0.5,
  current_timeline = 1,
  current_time = 0,
  LevelUp = 0,
  NumLevelUps = 0,
  TotalFans = 0,
  MaxTime = 1.5,
  Timer = 0,
  SummaryEndTime = 1,
  RankUpTime = 1,
  EndTime = 0.5,
  RankupPlayTime = 0,
  RankupPlayStep = 0.09
}
function Init()
  AddSCUI_Elements()
  UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceResults.lua", "MpBgStuff")
  if Multiplayer.GetRaceSummary().showy_flourish_fans > 0 then
    UIButtons.SetActive(SCUI.name_to_id.showy_flourish_rb, true)
  end
  if 0 < Multiplayer.GetRaceSummary().fan_favourite_fans then
    UIButtons.SetActive(SCUI.name_to_id.fan_favourite_rb, true)
  end
  if 0 < Multiplayer.GetRaceChallengesComplete() then
    for _FORV_6_ = 1, Multiplayer.GetRaceChallengesComplete() do
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), SCUI.name_to_id.challenge_bonus_title, UIEnums.Justify.BottomCentre)
      UIButtons.ChangeText(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "MPL_RACE_SUMMARY_CHALLENGE" .. _FORV_6_)
      UIButtons.SetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.end", UIButtons.GetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.end") + (UIButtons.GetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.end") - UIButtons.GetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.start")) * (_FORV_6_ - 1))
      UIButtons.SetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.start", UIButtons.GetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.start") + (UIButtons.GetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.end") - UIButtons.GetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.start")) * (_FORV_6_ - 1))
    end
  else
    UIButtons.ChangePosition(SCUI.name_to_id.on_track_fans_title, -25, 0, -100)
    UIButtons.ChangePosition(SCUI.name_to_id.finish_bonus_title, 25, 0, -100)
  end
  GUI.times[1] = GUI.start_time
  GUI.times[2] = GUI.times[1] + GUI.base_time
  GUI.times[3] = GUI.times[2] + (0 + (UIButtons.GetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.end") - UIButtons.GetXtVar(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpProgression.lua", "challenge_bonus"), "time_lines.0.time.start") - 0.1) + 0.5)
  GUI.times[4] = GUI.times[3] + 1
  GUI.times[5] = GUI.times[4] + 0.25
  GUI.times[6] = GUI.times[5]
  GUI.FansTargetID = SCUI.name_to_id.required_fans
  GUI.FansID = SCUI.name_to_id.current_fans
  GUI.RankID = SCUI.name_to_id.progression_rank
  GUI.RankIcon = SCUI.name_to_id.progression_rank_icon
  GUI.ProgressID = SCUI.name_to_id.progress
  GUI.MaxSizeX, GUI.MaxSizeY, GUI.MaxSizeZ = UIButtons.GetSize(SCUI.name_to_id.backing)
  Progression_Init()
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.challenge_bonus, false)
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
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  GUI.current_time = GUI.current_time + _ARG_0_
  if GUI.current_state == GUI.state.summary then
    if GUI.current_time > GUI.times[GUI.current_timeline] then
      UIButtons.TimeLineActive(GUI.timelines[GUI.current_timeline], true)
      GUI.current_timeline = GUI.current_timeline + 1
      if Multiplayer.GetRaceChallengesComplete() == 0 and GUI.timelines[GUI.current_timeline] == "show_challenge_bonus" then
        GUI.current_timeline = GUI.current_timeline + 1
      end
      if GUI.current_timeline > #GUI.timelines then
        GUI.current_state = GUI.state.summary_end
        GUI.current_time = 0
      end
    end
  elseif GUI.current_state == GUI.state.summary_end then
    if GUI.current_time >= GUI.SummaryEndTime then
      GUI.current_state = GUI.state.progression
      GUI.current_time = 0
      Progression_SetupEffect(GUI.CurrentFans - GUI.PreviousFans, GUI.TargetFans - GUI.PreviousFans)
    end
  elseif GUI.current_state == GUI.state.progression then
    if GUI.current_time >= GUI.MaxTime then
      GUI.current_time = GUI.MaxTime
      GUI.current_state = GUI.state.rank_up
    end
    if GUI.Progression.maxed == false then
      GUI.RankupPlayTime = GUI.RankupPlayTime + _ARG_0_
      if (GUI.TargetFans - GUI.PreviousFans) * (GUI.current_time / GUI.MaxTime) >= GUI.TotalFans - GUI.PreviousFans then
        GUI.RankupPlayTime = 0
      end
      if GUI.RankupPlayTime > GUI.RankupPlayStep then
        GUI.RankupPlayTime = GUI.RankupPlayTime - GUI.RankupPlayStep
        UISystem.PlaySound(UIEnums.SoundEffect.FansCountUp)
      end
      Progression_UpdateEffect(GUI.TotalFans - GUI.PreviousFans, GUI.TargetFans - GUI.PreviousFans, GUI.PreviousFans, GUI.Progression.previous_level + GUI.LevelUp)
    end
    if GUI.current_state == GUI.state.rank_up then
      GUI.LevelUp = GUI.LevelUp + 1
      if GUI.LevelUp > GUI.NumLevelUps then
        GUI.LevelUp = GUI.NumLevelUps
        GUI.current_state = GUI.state.unlocks
        GUI.current_time = 0
      else
        Progression_RankUp(GUI.Progression.previous_level + GUI.LevelUp)
      end
      GUI.current_time = 0
    end
  elseif GUI.current_state == GUI.state.rank_up then
    if GUI.current_time > GUI.RankUpTime then
      if GUI.TotalFans == Multiplayer.LevelProgressionData(GUI.Progression.previous_level + GUI.LevelUp).fans_previous then
        GUI.current_state = GUI.state.unlocks
        GUI.current_time = 0
      else
        GUI.current_state = GUI.state.progression
        Progression_RefreshLevel()
      end
    end
  elseif GUI.current_state == GUI.state.unlocks then
    GUI.current_state = GUI.state.end_wait
    GUI.current_time = 0
    UIButtons.TimeLineActive("show_progression", false)
    UIButtons.TimeLineActive("show_unlocks", false)
    UISystem.PlaySound(UIEnums.SoundEffect.MPRankAway)
  elseif GUI.current_state == GUI.state.end_wait and GUI.current_time >= GUI.EndTime then
    if Progression_ShowUnlocks(GUI.Progression.unlocks) == true then
      GoScreen("Multiplayer\\Ingame\\MpUnlocks.lua")
    else
      GoScreen("Multiplayer\\Ingame\\MpRaceAwards.lua")
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
function Progression_Init()
  GUI.Progression = Multiplayer.GetProgressionForRace()
  GUI.LevelData = Multiplayer.LevelProgressionData(GUI.Progression.previous_level)
  GUI.NumLevelUps = GUI.Progression.level_ups
  GUI.LevelUp = 0
  GUI.TotalFans = GUI.Progression.fans
  GUI.CurrentFans = GUI.Progression.previous_fans
  GUI.PreviousFans = GUI.LevelData.fans_previous
  GUI.TargetFans = GUI.LevelData.fans_needed
  if GUI.Progression.maxed == false then
    Progression_UpdateEffect(GUI.CurrentFans - GUI.PreviousFans, GUI.TargetFans - GUI.PreviousFans, GUI.PreviousFans, GUI.Progression.previous_level)
  else
    Progression_UpdateEffect(GUI.CurrentFans, GUI.TargetFans, 0, GUI.Progression.level)
  end
  Mp_RankIcon(GUI.RankIcon, GUI.Progression.previous_level - 1, GUI.Progression.legend)
  Mp_RankIcon(GUI.PlayerRankIconID, GUI.Progression.previous_level - 1, GUI.Progression.legend)
end
function Progression_RankUp(_ARG_0_)
  Amax.ChangeText(GUI.RankID, "MPL_LEVEL_RANK" .. _ARG_0_)
  Mp_RankIcon(GUI.RankIcon, _ARG_0_ - 1, GUI.Progression.legend)
  Multiplayer.PostRankedUp()
  UIButtons.TimeLineActive("ranked_up", true, 0)
  UIButtons.TimeLineActive("show_unlocks", true)
  UISystem.PlaySound(UIEnums.SoundEffect.RankUp)
end
function Progression_RefreshLevel()
  GUI.LevelData = Multiplayer.LevelProgressionData(GUI.Progression.previous_level + GUI.LevelUp)
  GUI.PreviousFans = GUI.LevelData.fans_previous
  GUI.TargetFans = GUI.LevelData.fans_needed
  Progression_SetupEffect(GUI.PreviousFans - GUI.PreviousFans, GUI.TargetFans - GUI.PreviousFans)
  Progression_UpdateEffect(0, GUI.TargetFans - GUI.PreviousFans, GUI.PreviousFans, GUI.Progression.previous_level + GUI.LevelUp)
end
function Progression_SetupEffect(_ARG_0_, _ARG_1_)
  if _ARG_1_ == 0 then
    GUI.current_time = GUI.MaxTime
  else
    GUI.current_time = GUI.MaxTime * (_ARG_0_ / _ARG_1_)
  end
end
function Progression_UpdateEffect(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_ = math.ceil(_ARG_0_)
  _ARG_1_ = math.ceil(_ARG_1_)
  _ARG_2_ = math.ceil(_ARG_2_)
  UIButtons.ChangeSize(GUI.ProgressID, GUI.MaxSizeX * (_ARG_0_ / _ARG_1_), GUI.MaxSizeY, GUI.MaxSizeZ)
  UIButtons.ChangeText(GUI.FansID, "MPL_LEVEL_NUM_FANS" .. _ARG_2_ + _ARG_0_)
  UIButtons.ChangeText(GUI.FansTargetID, "MPL_LEVEL_FANS_NEEDED" .. _ARG_2_ + _ARG_1_ - (_ARG_2_ + _ARG_0_) .. "_" .. _ARG_3_ + 1)
  Amax.ChangeText(GUI.RankID, "MPL_LEVEL_RANK" .. _ARG_3_)
end
function Progression_ShowUnlocks(_ARG_0_)
  if #_ARG_0_.features > 0 then
    return true
  elseif 0 < #_ARG_0_.playlists then
    return true
  elseif #_ARG_0_.features > 0 then
    return true
  elseif 0 < #_ARG_0_.packs then
    return true
  elseif 0 < #_ARG_0_.upgrades then
    return true
  elseif 0 < #_ARG_0_.abilities then
    return true
  elseif 0 < #_ARG_0_.cars then
    return true
  end
  return false
end
