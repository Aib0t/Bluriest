GUI = {
  finished = false,
  total_unlocks = {},
  unlock_order = {
    "playlists",
    "features",
    "packs",
    "upgrades",
    "abilities",
    "cars"
  },
  unlock_times = {
    2.2,
    2,
    2.2,
    2.2,
    2.7,
    2.2
  },
  unlock_titles = {
    UIText.MP_UNLOCK_TYPE_PLAYLIST,
    UIText.MP_UNLOCK_TYPE_FEATURE,
    UIText.MP_UNLOCK_TYPE_PACK,
    UIText.MP_UNLOCK_TYPE_CAR_UPGRADE,
    UIText.MP_UNLOCK_TYPE_MOD,
    UIText.MP_UNLOCK_TYPE_CAR
  },
  unlock_templates = {
    "playlist_template",
    "feature_template",
    "feature_template",
    "upgrade_template",
    "mod_template",
    "car_template"
  },
  current_type = 1,
  current_unlock = 1,
  max = 0,
  timer = 0,
  end_time = 0.75,
  finished_unlocks = false
}
function Init()
  AddSCUI_Elements()
  UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceResults.lua", "MpBgStuff")
  GUI.unlock_functions = {
    MpUnlocks_SetupPlaylist,
    MpUnlocks_SetupFeature,
    MpUnlocks_SetupFeature,
    MpUnlocks_SetupUpgrade,
    MpUnlocks_SetupAbility,
    MpUnlocks_SetupCar
  }
  if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
    GUI.total_unlocks = SinglePlayer.VehicleUnlocks()
  elseif IsTable((Multiplayer.GetProgressionForRace())) == true then
    GUI.total_unlocks = Multiplayer.GetProgressionForRace().unlocks
  end
end
function PostInit()
  if IsTable(GUI.total_unlocks) == true then
    for _FORV_3_ = 1, #GUI.unlock_order do
      if MpUnlocks_SetupType(GUI.current_type) == true then
        break
      end
      GUI.current_type = GUI.current_type + 1
    end
    MpUnlocks_SetupUnlock(GUI.current_type, GUI.current_unlock)
  end
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
  GUI.timer = GUI.timer - _ARG_0_
  if GUI.finished_unlocks == true then
    if GUI.timer <= 0 then
      if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
        PopScreen()
      else
        GoScreen("Multiplayer\\Ingame\\MpRaceAwards.lua")
      end
    end
    return
  end
  if GUI.timer <= 0 then
    GUI.current_unlock = GUI.current_unlock + 1
    if GUI.current_unlock > GUI.max then
      GUI.current_type = GUI.current_type + 1
      if GUI.current_type > #GUI.unlock_order then
        MpUnlocks_Finish()
      else
        for _FORV_4_ = 1, #GUI.unlock_order do
          if MpUnlocks_SetupType(GUI.current_type) == true then
            break
          end
          GUI.current_type = GUI.current_type + 1
        end
        if _FOR_.current_type > #GUI.unlock_order then
          MpUnlocks_Finish()
        end
      end
    end
    if GUI.finished_unlocks == false and 0 < #GUI.unlocks then
      MpUnlocks_SetupUnlock(GUI.current_type, GUI.current_unlock)
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
function MpUnlocks_Finish()
  UIButtons.TimeLineActive("hide", true)
  GUI.finished_unlocks = true
  GUI.timer = GUI.end_time
end
function MpUnlocks_SetupType(_ARG_0_)
  GUI.unlocks = GUI.total_unlocks[GUI.unlock_order[_ARG_0_]]
  GUI.current_unlock = 1
  if IsTable(GUI.unlocks) == false then
    return false
  end
  UIButtons.TimeLineActive("show_type", true, 0)
  GUI.max = #GUI.unlocks
  GUI.timer = GUI.unlock_times[_ARG_0_]
  for _FORV_4_, _FORV_5_ in ipairs(GUI.unlock_templates) do
    UIButtons.SetActive(SCUI.name_to_id[_FORV_5_], false)
  end
  if 0 < GUI.max then
    UIButtons.SetActive(SCUI.name_to_id[GUI.unlock_templates[_ARG_0_]], true)
    UIButtons.ChangeText(SCUI.name_to_id.unlocked_text, GUI.unlock_titles[_ARG_0_])
    return true
  end
  return false
end
function MpUnlocks_RandomTrail()
  UIButtons.TimeLineActive("trail_" .. math.random(4), true, 0, true)
  UIButtons.SetActive(SCUI.name_to_id["trail_" .. math.random(4) .. "_a"], true)
  UIButtons.SetActive(SCUI.name_to_id["trail_" .. math.random(4) .. "_b"], true)
end
function MpUnlocks_SetupUnlock(_ARG_0_, _ARG_1_)
  UIButtons.TimeLineActive("show_unlock", true, 0)
  if IsTable(GUI.unlocks[_ARG_1_]) == true then
    GUI.unlock_functions[_ARG_0_](GUI.unlocks[_ARG_1_])
    GUI.timer = GUI.unlock_times[_ARG_0_]
    MpUnlocks_RandomTrail()
  end
end
function MpUnlocks_SetupPlaylist(_ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.playlist_template, "name"), _ARG_0_.name)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.playlist_template, "desc"), _ARG_0_.desc)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(SCUI.name_to_id.playlist_template, "icon"), _ARG_0_.icon)
  UIButtons.ChangeTexture({
    filename = _ARG_0_.texture
  }, 0, (UIButtons.FindChildByName(SCUI.name_to_id.playlist_template, "thumbnail")))
end
function MpUnlocks_SetupFeature(_ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.feature_template, "name"), _ARG_0_.name)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.feature_template, "desc"), _ARG_0_.desc)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(SCUI.name_to_id.feature_template, "icon"), _ARG_0_.sheet)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(SCUI.name_to_id.feature_template, "icon"), _ARG_0_.icon)
end
function MpUnlocks_SetupUpgrade(_ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.upgrade_template, "title"), "MPL_CAR_UPGRADE_NAME" .. _ARG_0_.challenge .. "_" .. _ARG_0_.tier)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.upgrade_template, "desc"), "MPL_CAR_UPGRADE_DESC" .. _ARG_0_.challenge .. "_" .. _ARG_0_.tier)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.upgrade_template, "name"), "MPL_CAR_UPGRADE_TYPE" .. _ARG_0_.challenge .. "_" .. _ARG_0_.tier)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(SCUI.name_to_id.upgrade_template, "icon"), UIGlobals.CarUpgradeIcons[_ARG_0_.type])
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.upgrade_template, "car_name"), GameData.GetVehicle(Amax.GetCurrentCarID()).name)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(SCUI.name_to_id.upgrade_template, "car_icon"), GameData.GetVehicle(Amax.GetCurrentCarID()).sheet)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(SCUI.name_to_id.upgrade_template, "car_icon"), GameData.GetVehicle(Amax.GetCurrentCarID()).icon)
  UIButtons.ChangeText(SCUI.name_to_id.unlocked_text, Select(_ARG_0_.challenge == UIEnums.MpUpgradeChallenges.Races, UIText.MP_UNLOCK_TYPE_CAR_UPGRADE, UIText.MP_UNLOCK_TYPE_CAR_PAINT))
  UIButtons.TimeLineActive("show_type", true, 0)
end
function MpUnlocks_SetupAbility(_ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.mod_template, "name"), _ARG_0_.name)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.mod_template, "desc"), _ARG_0_.desc)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(SCUI.name_to_id.mod_template, "icon"), _ARG_0_.icon)
end
function MpUnlocks_SetupCar(_ARG_0_)
  if GameData.GetVehicle(_ARG_0_.id).man_texture_square == true then
    UIButtons.SetActive(UIButtons.FindChildByName(SCUI.name_to_id.car_template, "manufacturer_square"), true)
    UIButtons.SetActive(UIButtons.FindChildByName(SCUI.name_to_id.car_template, "manufacturer_rect"), false)
    UIButtons.ChangeTexture({
      filename = GameData.GetVehicle(_ARG_0_.id).man_texture
    }, 0, (UIButtons.FindChildByName(SCUI.name_to_id.car_template, "manufacturer_square")))
  else
    UIButtons.SetActive(UIButtons.FindChildByName(SCUI.name_to_id.car_template, "manufacturer_square"), false)
    UIButtons.SetActive(UIButtons.FindChildByName(SCUI.name_to_id.car_template, "manufacturer_rect"), true)
    UIButtons.ChangeTexture({
      filename = GameData.GetVehicle(_ARG_0_.id).man_texture
    }, 0, (UIButtons.FindChildByName(SCUI.name_to_id.car_template, "manufacturer_rect")))
  end
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.car_template, "name"), GameData.GetVehicle(_ARG_0_.id).name)
  UIButtons.ChangeTexture({
    filename = GameData.GetVehicle(_ARG_0_.id).tag
  }, 0, (UIButtons.FindChildByName(SCUI.name_to_id.car_template, "thumbnail")))
  UIShape.ChangeObjectName(UIButtons.FindChildByName(SCUI.name_to_id.car_template, "class"), UIGlobals.ClassIcons[GameData.GetVehicle(_ARG_0_.id).class])
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.car_template, "style"), UIGlobals.CarStyles[GameData.GetVehicle(_ARG_0_.id).style])
end
