GUI = {
  finished = false,
  screen_timer = 0,
  lerp_timer = 0,
  car_timer = 0,
  rank_timer = 0,
  lerp_fan_pool = 0,
  current_mode = 0,
  loading_done = false,
  unlocks = {},
  vehicles_unlocked = {},
  class_icon_names = {
    [UIEnums.VehicleClass.A] = "class_a",
    [UIEnums.VehicleClass.B] = "class_b",
    [UIEnums.VehicleClass.C] = "class_c",
    [UIEnums.VehicleClass.D] = "class_d"
  },
  style_names = {
    [UIEnums.VehicleUiStyle.Balanced] = UIText.RBC_STYLE_BALANCED,
    [UIEnums.VehicleUiStyle.Drifty] = UIText.RBC_STYLE_DRIFTY,
    [UIEnums.VehicleUiStyle.VeryDrifty] = UIText.RBC_STYLE_VERY_DRIFTY,
    [UIEnums.VehicleUiStyle.Grippy] = UIText.RBC_STYLE_GRIPPY,
    [UIEnums.VehicleUiStyle.VeryGrippy] = UIText.RBC_STYLE_VERY_GRIPPY,
    [UIEnums.VehicleUiStyle.OffRoad] = UIText.RBC_STYLE_OFF_ROAD
  },
  CanExit = function(_ARG_0_)
    return false
  end,
  RankupPlayTime = 0,
  RankupPlayStep = 0.09
}
function Init()
  AddSCUI_Elements()
  UIScreen.SetScreenTimers(0, 0.3)
  StoreInfoLine()
  UIGlobals.ShowingUnlocks = true
end
function PostInit()
  GUI.unlocks = Sp_UnlocksFilter(SinglePlayer.ProcessUnlocks())
  GUI.rank_info = SinglePlayer.RankInfo()
  GUI.dummy_id = SCUI.name_to_id.Root
  GUI.progress_bar_id = UIButtons.FindChildByName(GUI.dummy_id, "progress")
  GUI.bar_size_x = UIButtons.GetSize(GUI.progress_bar_id)
  GUI.total_fans = SinglePlayer.GameInfo().fans
  GUI.previous_total_fans = UIGlobals.Sp_PreviousFans
  GUI.next_rank_fan_bound = GUI.rank_info[FindNextRankFromFans(GUI.previous_total_fans)].fans
  GUI.current_rank_fan_bound = GUI.rank_info[FindRankFromFans(GUI.previous_total_fans)].fans
  GUI.ranked_up = GUI.total_fans >= GUI.next_rank_fan_bound
  GUI.max_rank = GUI.previous_total_fans >= GUI.rank_info[#GUI.rank_info].fans
  if GUI.max_rank ~= true and UIGlobals.Sp_PreviousFans ~= nil then
    StartProcessFanGain(GUI.previous_total_fans)
  elseif UIGlobals.Sp_PreviousFans ~= nil then
    SetupMaxRank(GUI.previous_total_fans)
  end
  GUI.txt_fans_last_race_id = UIButtons.FindChildByName(GUI.dummy_id, "fan_total")
  UIButtons.ChangeText(GUI.txt_fans_last_race_id, "GAME_NUM_" .. GUI.total_fans - GUI.previous_total_fans)
  GUI.hasUnlockedVehicles = #SinglePlayer.VehicleUnlocks().cars ~= 0
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ == UIEnums.Message.MenuNext and GUI.loading_done == true then
    if GUI.ranked_up == true then
      GUI.current_mode = 3
    else
      GUI.current_mode = 4
    end
  end
  if _ARG_0_ == UIEnums.GameMessage.UISceneReady then
    GUI.loading_done = true
  end
end
function FrameUpdate(_ARG_0_)
  GUI.screen_timer = GUI.screen_timer + _ARG_0_
  if GUI.current_mode == 0 then
    if GUI.screen_timer > 2 then
      GUI.current_mode = 1
    elseif GUI.screen_timer > 1.25 then
      UIButtons.TimeLineActive("show_progression", true)
    end
    return
  end
  if GUI.current_mode == 1 then
    UIButtons.TimeLineActive("lerping_up", true)
    GUI.RankupPlayTime = GUI.RankupPlayTime + _ARG_0_
    if GUI.RankupPlayTime > GUI.RankupPlayStep then
      GUI.RankupPlayTime = GUI.RankupPlayTime - GUI.RankupPlayStep
      UISystem.PlaySound(UIEnums.SoundEffect.FansCountUp)
    end
    if GUI.max_rank ~= true then
      UpdateProcessFanGain(_ARG_0_)
      if math.floor(GUI.next_rank_fan_bound - GUI.lerped_fans - GUI.previous_total_fans) == 0 then
        GUI.ranked_up = true
        UIButtons.TimeLineActive("finished_lerp", true, 0)
        UIButtons.TimeLineActive("lerping_up", false)
        UIButtons.TimeLineActive("rank_up", true, 0)
        UISystem.PlaySound(UIEnums.SoundEffect.RankUp)
        GUI.lerp_fan_pool = GUI.next_rank_fan_bound - GUI.previous_total_fans
        GUI.rank_timer = 0
        GUI.current_mode = 2
        if GUI.next_rank_fan_bound == GUI.rank_info[#GUI.rank_info].fans then
          GUI.max_rank = true
        end
      elseif GUI.total_fans == GUI.previous_total_fans + GUI.lerped_fans then
        UIButtons.TimeLineActive("finished_lerp", true, 0)
        if GUI.ranked_up == true or GUI.hasUnlockedVehicles == true then
          GUI.current_mode = 3
        else
          UIButtons.TimeLineActive("finished_lerp_all", true, 0)
          GUI.current_mode = 4
        end
      end
    else
      MaxRankLerp(_ARG_0_)
      if GUI.total_fans == GUI.previous_total_fans + GUI.lerped_fans then
        UIButtons.TimeLineActive("finished_lerp", true, 0)
        GUI.current_mode = 4
      end
    end
  elseif GUI.current_mode == 2 then
    if GUI.rank_timer > 0.185 then
      if GUI.max_rank == true then
        Amax.ChangeText(GUI.txt_fan_status_id, UIText["SP_RANK_" .. #GUI.rank_info])
      else
        Amax.ChangeText(GUI.txt_fan_status_id, UIText["SP_RANK_" .. FindRankFromFans(GUI.previous_total_fans + GUI.lerp_fan_pool)])
      end
    end
    GUI.rank_timer = GUI.rank_timer + _ARG_0_
    if GUI.rank_timer > 2.3 then
      GUI.current_mode = 1
      UIButtons.TimeLineActive("lerping_up", true, 0)
      if GUI.max_rank ~= true then
        NewRankUpdate()
      else
        SetupMaxRank(GUI.previous_total_fans)
      end
    end
  elseif GUI.current_mode == 3 then
    GUI.car_timer = GUI.car_timer + _ARG_0_
    if GUI.car_timer > 1.5 then
      GoScreen("Multiplayer\\Ingame\\MpUnlocks.lua")
    end
  elseif GUI.current_mode == 4 and GUI.loading_done == true then
    PopScreen()
  end
end
function EnterEnd()
  UIButtons.TimeLineActive("hide_unlocks", true)
  UIButtons.TimeLineActive("show_progression", false)
  UISystem.PlaySound(UIEnums.SoundEffect.MPRankAway)
end
function EndLoop(_ARG_0_)
end
function End()
  UIGlobals.ShowingUnlocks = false
end
function SetupMaxRank(_ARG_0_)
  GUI.lerped_fans = 0
  GUI.txt_total_fans_id = UIButtons.FindChildByName(GUI.dummy_id, "current_fans")
  GUI.txt_target_fans_id = UIButtons.FindChildByName(GUI.dummy_id, "required_fans")
  GUI.txt_fan_status_id = UIButtons.FindChildByName(GUI.dummy_id, "progression_rank")
  UIButtons.ChangeText(GUI.txt_total_fans_id, "GAME_UNLOCKS_FANS_" .. _ARG_0_ + GUI.lerped_fans)
  UIButtons.ChangeText(GUI.txt_target_fans_id, UIText.SP_MAX_RANK)
  Amax.ChangeText(GUI.txt_fan_status_id, UIText.SP_RANK_25)
  UpdateProgressBar(1, 1)
  GUI.lerp_target_fans = GUI.total_fans
  GUI.lerp_timer = 0
end
function MaxRankLerp(_ARG_0_)
  GUI.lerp_timer = GUI.lerp_timer + _ARG_0_
  if 1.5 < GUI.lerp_timer then
    GUI.lerp_timer = 1.5
  end
  GUI.lerped_fans = (GUI.lerp_target_fans - GUI.previous_total_fans) * (GUI.lerp_timer / 1.5)
  UIButtons.ChangeText(GUI.txt_total_fans_id, "GAME_UNLOCKS_FANS_" .. GUI.previous_total_fans + GUI.lerped_fans)
end
function StartProcessFanGain(_ARG_0_)
  if GUI.lerped_fans == nil then
    GUI.lerped_fans = 0
  else
    UIButtons.TimeLineActive("rank_reset", true, 0)
  end
  GUI.txt_total_fans_id = UIButtons.FindChildByName(GUI.dummy_id, "current_fans")
  GUI.txt_target_fans_id = UIButtons.FindChildByName(GUI.dummy_id, "required_fans")
  GUI.txt_fan_status_id = UIButtons.FindChildByName(GUI.dummy_id, "progression_rank")
  UIButtons.ChangeText(GUI.txt_total_fans_id, "GAME_UNLOCKS_FANS_" .. _ARG_0_ + GUI.lerped_fans)
  UIButtons.ChangeText(GUI.txt_target_fans_id, "GAME_UNLOCKS_NEXT_RANK_" .. GUI.next_rank_fan_bound - _ARG_0_ .. "_TO_" .. GUI.rank_info[FindNextRankFromFans(_ARG_0_)].name)
  Amax.ChangeText(GUI.txt_fan_status_id, UIText["SP_RANK_" .. FindRankFromFans(_ARG_0_ + GUI.lerp_fan_pool)])
  UpdateProgressBar(_ARG_0_ - GUI.current_rank_fan_bound, GUI.next_rank_fan_bound - GUI.current_rank_fan_bound)
  if GUI.total_fans >= GUI.next_rank_fan_bound then
    GUI.lerp_target_fans = GUI.next_rank_fan_bound
  else
    GUI.lerp_target_fans = GUI.total_fans
  end
  GUI.lerp_timer = 0
end
function UpdateProcessFanGain(_ARG_0_)
  GUI.lerp_timer = GUI.lerp_timer + _ARG_0_
  if 1.5 < GUI.lerp_timer then
    GUI.lerp_timer = 1.5
  end
  GUI.lerped_fans = (GUI.lerp_target_fans - GUI.lerp_fan_pool - GUI.previous_total_fans) * (GUI.lerp_timer / 1.5) + GUI.lerp_fan_pool
  UIButtons.ChangeText(GUI.txt_total_fans_id, "GAME_UNLOCKS_FANS_" .. GUI.previous_total_fans + GUI.lerped_fans)
  UIButtons.ChangeText(GUI.txt_target_fans_id, "GAME_UNLOCKS_NEXT_RANK_" .. math.floor(GUI.next_rank_fan_bound - GUI.lerped_fans - GUI.previous_total_fans) .. "_TO_" .. GUI.rank_info[FindNextRankFromFans(GUI.previous_total_fans + GUI.lerped_fans)].name)
  UpdateProgressBar(GUI.previous_total_fans - GUI.current_rank_fan_bound + GUI.lerped_fans, GUI.next_rank_fan_bound - GUI.current_rank_fan_bound)
end
function NewRankUpdate()
  GUI.current_rank_fan_bound = GUI.next_rank_fan_bound
  GUI.next_rank_fan_bound = GUI.rank_info[FindNextRankFromFans(GUI.next_rank_fan_bound + 1)].fans
  for _FORV_4_, _FORV_5_ in pairs(GUI.rank_info[FindNextRankFromFans(GUI.next_rank_fan_bound + 1)].vehicles) do
    VehicleUnlocked(_FORV_4_)
  end
  StartProcessFanGain(GUI.current_rank_fan_bound + 1)
end
function FindRankFromFans(_ARG_0_)
  return FindNextRankFromFans(_ARG_0_) - 1
end
function FindNextRankFromFans(_ARG_0_)
  if _ARG_0_ == 0 then
    return 2
  end
  for _FORV_5_, _FORV_6_ in ipairs(GUI.rank_info) do
    if _ARG_0_ < _FORV_6_.fans then
      return _FORV_6_.index
    end
  end
  return #GUI.rank_info
end
function UpdateProgressBar(_ARG_0_, _ARG_1_)
  UIButtons.ChangeSizeX(GUI.progress_bar_id, GUI.bar_size_x / _ARG_1_ * _ARG_0_)
end
function VehicleUnlocked(_ARG_0_)
  GUI.vehicles_unlocked[#GUI.vehicles_unlocked + 1] = _ARG_0_
end
