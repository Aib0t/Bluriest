GUI = {
  finished = false,
  unlocks = {},
  screen_id = -1,
  render_branch_ids = {},
  current_branch = 0,
  carousel_branch = "Races",
  CanExit = function(_ARG_0_)
    return false
  end,
  playing_video = false,
  unlock_kind = {},
  unlock_type = {}
}
function Init()
  AddSCUI_Elements()
  CarouselApp_SetScreenTimers()
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_NEXT, "GAME_SHARE_BUTTON")
  GUI.screen_id = SCUI.name_to_id.screen
end
function PostInit()
  GUI.unlocks = Sp_UnlocksFilter(SinglePlayer.ProcessUnlocks())
  for _FORV_3_, _FORV_4_ in pairs(GUI.unlocks) do
    if _FORV_4_.kind == "tier" then
      SpUnlocks_ProcessTier(_FORV_4_)
    elseif _FORV_4_.kind == "event" then
      SpUnlocks_ProcessEvent(_FORV_4_)
    elseif _FORV_4_.kind == "rank" then
      SpUnlocks_ProcessRank(_FORV_4_)
    elseif _FORV_4_.kind == "vehicle" then
      SpUnlocks_ProcessVehicle(_FORV_4_)
    elseif _FORV_4_.kind == "mod" then
      SpUnlocks_ProcessMod(_FORV_4_)
    end
  end
  SpUnlocks_Next()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
    if Amax.CanUseShare() == true then
      UIGlobals.ShareFromWhatPopup = -1
      SetupCustomPopup(UIEnums.CustomPopups.SharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    if GUI.unlock_type[GUI.current_branch][1] == "Tier" then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.UnlockedTier, 1, GUI.unlocks[GUI.current_branch].tierId)
    elseif GUI.unlock_type[GUI.current_branch][1] == "Event" then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.UnlockedEvent, 1, GUI.unlocks[GUI.current_branch].eventId)
    elseif GUI.unlock_type[GUI.current_branch][1] == "Rank" then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.UnlockedRank, 1, GUI.unlocks[GUI.current_branch].rank)
    elseif GUI.unlock_type[GUI.current_branch][1] == "Vehicle" then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.UnlockedVehicle, 1, GUI.unlocks[GUI.current_branch].vehicleId)
    elseif GUI.unlock_type[GUI.current_branch][1] == "BossVehicle" then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.UnlockedBossVehicle, 1, GUI.unlocks[GUI.current_branch].vehicleId)
    elseif GUI.unlock_type[GUI.current_branch][1] == "Mod" then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.UnlockedMod, 1, GUI.unlocks[GUI.current_branch].modId)
    end
    StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "SinglePlayer\\SpUnlocks.lua")
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    else
      GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    SpUnlocks_Next()
  end
  if _ARG_0_ == UIEnums.Message.MovieFinished and _ARG_1_ == 0 then
    UIButtons.TimeLineActive("movie_start", false)
    GUI.playing_video = false
  end
end
function FrameUpdate(_ARG_0_)
end
function EnterEnd()
  RestoreInfoLine()
  SinglePlayer.ClearUnlocks()
end
function EndLoop(_ARG_0_)
end
function End()
  UISystem.DestroyMovie(0)
end
function SpUnlocks_Next()
  if GUI.playing_video == true then
    UIButtons.TimeLineActive("movie_start", false)
    GUI.playing_video = false
    return
  else
    UISystem.DestroyMovie(0)
  end
  if GUI.current_branch == #GUI.render_branch_ids then
    CloseCurrentApp()
  else
    GUI.current_branch = GUI.current_branch + 1
    UIButtons.SetActive(GUI.render_branch_ids[GUI.current_branch], true)
    UIButtons.PrivateTimeLineActive(GUI.render_branch_ids[GUI.current_branch], "unlocked", true, 0)
    UIButtons.ChangeOrientation(GUI.render_branch_ids[GUI.current_branch], UIButtons.GetOrientation(GUI.render_branch_ids[GUI.current_branch]))
    if GUI.unlock_kind[GUI.current_branch][1] ~= nil then
      print("playing Movie", GUI.unlock_kind[GUI.current_branch][1])
      UISystem.InitMovie(0, GUI.unlock_kind[GUI.current_branch][1], false, nil, false, true)
      UISystem.EnableMovieLooping(0, false)
      GUI.playing_video = true
      UIButtons.TimeLineActive("movie_start", true, 0)
    end
  end
end
function SpUnlocks_ProcessTier(_ARG_0_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_tier_branch"), GUI.screen_id, UIEnums.Justify.MiddleCentre)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_tier_branch"), "_tier_num"), "GAME_NUM_" .. SinglePlayer.TierInfo()[_ARG_0_.tier].starRequirement)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_tier_branch"), "_tier_name"), SinglePlayer.TierInfo()[_ARG_0_.tier].name)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_tier_branch"), "_tier_boss_name"), SinglePlayer.BossInfo()[_ARG_0_.tier].name)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_tier_branch"), "_tier_boss_bio"), SinglePlayer.BossInfo()[_ARG_0_.tier].bio)
  GUI.render_branch_ids[#GUI.render_branch_ids + 1] = UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_tier_branch")
  GUI.unlock_kind[#GUI.unlock_kind + 1] = {
    "Ui\\Movies\\atvi.bik"
  }
  GUI.unlock_type[#GUI.unlock_type + 1] = {"Tier"}
end
function SpUnlocks_ProcessEvent(_ARG_0_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_boss_branch"), GUI.screen_id, UIEnums.Justify.MiddleCentre)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_boss_branch"), "_boss_name"), SinglePlayer.BossInfo()[_ARG_0_.tier].name)
  GUI.render_branch_ids[#GUI.render_branch_ids + 1] = UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_boss_branch")
  GUI.unlock_kind[#GUI.unlock_kind + 1] = {
    "Ui\\Movies\\BlurAttract.bik"
  }
  GUI.unlock_type[#GUI.unlock_type + 1] = {"Event"}
end
function SpUnlocks_ProcessRank(_ARG_0_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_rank_branch"), GUI.screen_id, UIEnums.Justify.MiddleCentre)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_rank_branch"), "_rank_num"), "GAME_NUM_" .. _ARG_0_.rank)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_rank_branch"), "_rank_fan_amount"), "GAME_NUM_" .. SinglePlayer.RankInfo()[_ARG_0_.rank].fans)
  GUI.render_branch_ids[#GUI.render_branch_ids + 1] = UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_rank_branch")
  GUI.unlock_kind[#GUI.unlock_kind + 1] = {}
  GUI.unlock_type[#GUI.unlock_type + 1] = {"Rank"}
end
function SpUnlocks_ProcessVehicle(_ARG_0_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), GUI.screen_id, UIEnums.Justify.MiddleCentre)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_car_num"), "GAME_NUM_" .. _ARG_0_.rank)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_car_icon"), GameData.GetVehicle(_ARG_0_.vehicleId).icon)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_stat_car_name"), GameData.GetVehicle(_ARG_0_.vehicleId).name)
  if GameData.GetVehicle(_ARG_0_.vehicleId).man_texture_square == true then
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_stat_man_square"), true)
    UIButtons.ChangeTexture({
      filename = GameData.GetVehicle(_ARG_0_.vehicleId).man_texture
    }, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_stat_man_square")))
  else
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_stat_man_rect"), true)
    UIButtons.ChangeTexture({
      filename = GameData.GetVehicle(_ARG_0_.vehicleId).man_texture
    }, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_stat_man_rect")))
  end
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_stat_class_icon"), {
    [UIEnums.VehicleClass.A] = "class_a",
    [UIEnums.VehicleClass.B] = "class_b",
    [UIEnums.VehicleClass.C] = "class_c",
    [UIEnums.VehicleClass.D] = "class_d"
  }[GameData.GetVehicle(_ARG_0_.vehicleId).class])
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_stat_style_text"), {
    [UIEnums.VehicleUiStyle.Balanced] = UIText.RBC_STYLE_BALANCED,
    [UIEnums.VehicleUiStyle.Drifty] = UIText.RBC_STYLE_DRIFTY,
    [UIEnums.VehicleUiStyle.VeryDrifty] = UIText.RBC_STYLE_VERY_DRIFTY,
    [UIEnums.VehicleUiStyle.Grippy] = UIText.RBC_STYLE_GRIPPY,
    [UIEnums.VehicleUiStyle.VeryGrippy] = UIText.RBC_STYLE_VERY_GRIPPY,
    [UIEnums.VehicleUiStyle.OffRoad] = UIText.RBC_STYLE_OFF_ROAD
  }[GameData.GetVehicle(_ARG_0_.vehicleId).style])
  Amax.SetChickletsValue(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_chick_acceleration"), GameData.GetVehicle(_ARG_0_.vehicleId).acceleration)
  Amax.SetChickletsValue(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_chick_speed"), GameData.GetVehicle(_ARG_0_.vehicleId).speed)
  Amax.SetChickletsValue(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_chick_off_road"), GameData.GetVehicle(_ARG_0_.vehicleId).stability)
  Amax.SetChickletsValue(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_chick_health"), GameData.GetVehicle(_ARG_0_.vehicleId).strength)
  if _ARG_0_.boss == true then
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_car_boss_pic"), true)
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch"), "_car_mod_icon"), true)
    GUI.render_branch_ids[#GUI.render_branch_ids + 1] = UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch")
    GUI.unlock_kind[#GUI.unlock_kind + 1] = {
      "Ui\\Movies\\BizarreSplash.bik"
    }
    GUI.unlock_type[#GUI.unlock_type + 1] = {
      "BossVehicle"
    }
  else
    GUI.render_branch_ids[#GUI.render_branch_ids + 1] = UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_car_branch")
    GUI.unlock_kind[#GUI.unlock_kind + 1] = {}
    GUI.unlock_type[#GUI.unlock_type + 1] = {"Vehicle"}
  end
end
function SpUnlocks_ProcessMod(_ARG_0_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_mod_branch"), GUI.screen_id, UIEnums.Justify.MiddleCentre)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_mod_branch"), "_mod_num"), "GAME_NUM_" .. _ARG_0_.rank)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_mod_branch"), "_mod_icon"), Multiplayer.GetAbility(_ARG_0_.modId).icon_name)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_mod_branch"), "_mod_name"), Multiplayer.GetAbility(_ARG_0_.modId).name)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_mod_branch"), "_mod_desc"), Multiplayer.GetAbility(_ARG_0_.modId).desc)
  if _ARG_0_.boss == true then
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_mod_branch"), "_mod_boss_pic"), true)
  end
  GUI.render_branch_ids[#GUI.render_branch_ids + 1] = UIButtons.CloneXtGadgetByName("SinglePlayer\\SpUnlocks.lua", "_mod_branch")
  GUI.unlock_kind[#GUI.unlock_kind + 1] = {}
  GUI.unlock_type[#GUI.unlock_type + 1] = {"Mod"}
end
