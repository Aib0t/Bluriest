GUI = {
  finished = false,
  options = {
    powerups = 1,
    respawn = 2,
    random = 3,
    bolt = 4,
    shock = 5,
    mine = 6,
    nitro = 7,
    barge = 8,
    shield = 9,
    shunt = 10,
    repair = 11
  },
  powerups = {},
  powerup_toggle = nil,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_3", UIGlobals.CameraLerpTime, 0)
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK_CONFIRM, UIText.INFO_LT_ADVANCED)
  GUI.helptext = {
    [GUI.options.powerups] = UIText.MP_CRHELP_POWERUPS,
    [GUI.options.respawn] = UIText.MP_CRHELP_POWERUPRESPAWN,
    [GUI.options.random] = UIText.MP_CRHELP_RANDOMPOWERUPS,
    [GUI.options.bolt] = UIText.MP_CRHELP_BOLT,
    [GUI.options.shock] = UIText.MP_CRHELP_SHOCK,
    [GUI.options.mine] = UIText.MP_CRHELP_MINE,
    [GUI.options.nitro] = UIText.MP_CRHELP_NITRO,
    [GUI.options.barge] = UIText.MP_CRHELP_BARGE,
    [GUI.options.shield] = UIText.MP_CRHELP_SHIELD,
    [GUI.options.shunt] = UIText.MP_CRHELP_SHUNT,
    [GUI.options.repair] = UIText.MP_CRHELP_REPAIR
  }
  GUI.table_id = SCUI.name_to_id.table
  Mp_ReadCustomRaceSettings()
  CustomRace_CreateLeftColumn()
  CustomRace_CreateCentreColumn()
  CustomRace_CreateRightColumn()
end
function PostInit()
  UIButtons.ChangePanel(SetupScreenTitle(UIText.MP_CUSTOM_RACE_POWERUPS, SCUI.name_to_id.centre, "race_settings"), UIEnums.Panel._3DAA_WORLD, true)
  GUI.helpline_id = SetupBottomHelpBar(UIText.MP_CRHELP_GAMEMODE)
  CustomRace_UpdateHelptext()
  CustomRace_SetPowerupDefault()
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if UIButtons.GetTableSelection(GUI.table_id) == GUI.options.powerups or UIButtons.GetTableSelection(GUI.table_id) == GUI.options.respawn then
      GUI.table_toggle = not GUI.table_toggle
      UIButtons.ActivateTableElement(GUI.table_id, GUI.table_toggle)
      PlaySfxNext()
    elseif UIButtons.GetTableSelection(GUI.table_id) == GUI.options.random then
      PlaySfxToggle()
      Amax.Toggle(GUI.random_id)
    else
      PlaySfxToggle()
      Amax.Toggle(GUI.powerups[UIButtons.GetTableSelection(GUI.table_id)])
      CustomRace_SetPowerupDefault()
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftTrigger and _ARG_2_ == true then
    if UIButtons.TableElementActivated(GUI.table_id) == false then
      CustomRace_PowerupsTable()
      UISystem.PlaySound(UIEnums.SoundEffect.StickersPage)
      GoScreen("Multiplayer\\Shared\\MpCustomRaceAdvanced.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    PlaySfxBack()
    if UIButtons.TableElementActivated(GUI.table_id) == true then
      GUI.table_toggle = false
      UIButtons.ActivateTableElement(GUI.table_id, false)
    else
      CustomRace_PowerupsTable()
      Amax.ChangeUiCamera(UIGlobals.CameraNames.MpLobby, UIGlobals.CameraLerpTime, 0)
      if Amax.GetGameMode() == UIEnums.GameMode.Online or Amax.GetGameMode() == UIEnums.GameMode.SystemLink then
        NetRace.SendNewRaceSettings()
        PopScreen()
      elseif Amax.GetGameMode() == UIEnums.GameMode.SplitScreen then
        GoScreen("Multiplayer\\MpSplitscreenLobby.lua")
      end
      PlaySfxGraphicNext()
    end
  end
end
function FrameUpdate(_ARG_0_)
  if UIButtons.TableElementActivated(GUI.table_id) == true and UIButtons.GetSelection(GUI.powerups_id) ~= GUI.powerup_toggle then
    GUI.powerup_toggle = UIButtons.GetSelection(GUI.powerups_id)
    if UIButtons.GetSelection(GUI.powerups_id) ~= 2 then
      CustomRace_TogglePowerups((UIButtons.GetSelection(GUI.powerups_id)))
    end
  end
  CustomRace_UpdateHelptext()
end
function EnterEnd()
  RestoreInfoLine()
end
function End()
end
function CustomRace_UpdateHelptext()
  if UIButtons.GetTableSelection(GUI.table_id) ~= GUI.selection then
    GUI.selection = UIButtons.GetTableSelection(GUI.table_id)
    UIButtons.ChangeText(GUI.helpline_id, GUI.helptext[UIButtons.GetTableSelection(GUI.table_id)])
    UIButtons.TimeLineActive("HelpFade", true, 0.5)
  end
end
function CustomRace_TogglePowerups(_ARG_0_)
  for _FORV_4_, _FORV_5_ in pairs(GUI.powerups) do
    UIButtons.SetSelection(_FORV_5_, _ARG_0_)
  end
end
function CustomRace_SetPowerupDefault()
  for _FORV_5_, _FORV_6_ in pairs(GUI.powerups) do
    if UIButtons.GetSelection(_FORV_6_) == 1 then
    else
    end
  end
  if 0 + 1 == 0 then
    UIButtons.SetSelection(GUI.powerups_id, 0)
  elseif 0 + 1 == 0 then
    UIButtons.SetSelection(GUI.powerups_id, 1)
  else
    UIButtons.SetSelection(GUI.powerups_id, 2)
  end
end
function CustomRace_CreateLeftColumn()
  UIButtons.AddTableCol(GUI.table_id)
  GUI.powerups_id = CustomRace_SetupSpinner(GUI.table_id, GUI.options.powerups, UIText.MP_CUSTOM_RACE_POWERUPS, "perk_option", "perk_icons")
  UIButtons.AddItem(GUI.powerups_id, 0, UIText.MP_CUSTOM_RACE_OFF, false)
  UIButtons.AddItem(GUI.powerups_id, 1, UIText.MP_CUSTOM_RACE_ON, false)
  UIButtons.AddItem(GUI.powerups_id, 2, UIText.MP_CUSTOM_RACE_CUSTOM, false)
  UIButtons.SetSelection(GUI.powerups_id, 1)
  GUI.powerups[GUI.options.nitro] = CustomRace_SetupToggle(GUI.table_id, GUI.options.nitro, UIText.MP_POWERUP_NITRO, "perk_nitro", "perk_icons")
  UIButtons.SetSelection(GUI.powerups[GUI.options.nitro], BoolToNumber(UIGlobals.CustomRaceSettings.powerups.nitro))
  CustomRace_SetupPowerupIcon(GUI.powerups[GUI.options.nitro], "Nitro_Glow")
  GUI.powerups[GUI.options.bolt] = CustomRace_SetupToggle(GUI.table_id, GUI.options.bolt, UIText.MP_POWERUP_BOLT, "perk_bolt", "perk_icons")
  UIButtons.SetSelection(GUI.powerups[GUI.options.bolt], BoolToNumber(UIGlobals.CustomRaceSettings.powerups.bolt))
  CustomRace_SetupPowerupIcon(GUI.powerups[GUI.options.bolt], "Blindfire_Glow")
  GUI.powerups[GUI.options.mine] = CustomRace_SetupToggle(GUI.table_id, GUI.options.mine, UIText.MP_POWERUP_MINE, "perk_mine", "perk_icons")
  UIButtons.SetSelection(GUI.powerups[GUI.options.mine], BoolToNumber(UIGlobals.CustomRaceSettings.powerups.mine))
  CustomRace_SetupPowerupIcon(GUI.powerups[GUI.options.mine], "Flash_Glow")
end
function CustomRace_CreateCentreColumn()
  UIButtons.AddTableCol(GUI.table_id)
  GUI.respawn_id = CustomRace_SetupSpinner(GUI.table_id, GUI.options.respawn, UIText.MP_CUSTOM_RACE_POWERUP_RESPAWN, "drop_mode", "common_icons")
  UIButtons.AddItem(GUI.respawn_id, UIEnums.MpPowerupRespawnMode.None, UIText.MP_POWERUP_RESPAWN_MODE_NEVER, false)
  UIButtons.AddItem(GUI.respawn_id, UIEnums.MpPowerupRespawnMode.Normal, UIText.MP_POWERUP_RESPAWN_MODE_NORMAL, false)
  UIButtons.AddItem(GUI.respawn_id, UIEnums.MpPowerupRespawnMode.Long, UIText.MP_POWERUP_RESPAWN_MODE_LONG, false)
  UIButtons.AddItem(GUI.respawn_id, UIEnums.MpPowerupRespawnMode.VeryLong, UIText.MP_POWERUP_RESPAWN_MODE_VERY_LONG, false)
  UIButtons.AddItem(GUI.respawn_id, UIEnums.MpPowerupRespawnMode.AlwaysOn, UIText.MP_POWERUP_RESPAWN_MODE_ALWAYS_ON, false)
  UIButtons.SetSelection(GUI.respawn_id, UIGlobals.CustomRaceSettings.powerup_respawn)
  GUI.powerups[GUI.options.barge] = CustomRace_SetupToggle(GUI.table_id, GUI.options.barge, UIText.MP_POWERUP_BARGE, "perk_barge", "perk_icons")
  UIButtons.SetSelection(GUI.powerups[GUI.options.barge], BoolToNumber(UIGlobals.CustomRaceSettings.powerups.barge))
  CustomRace_SetupPowerupIcon(GUI.powerups[GUI.options.barge], "Barge_Glow")
  GUI.powerups[GUI.options.repair] = CustomRace_SetupToggle(GUI.table_id, GUI.options.repair, UIText.MP_POWERUP_REPAIR, "perk_repair", "perk_icons")
  UIButtons.SetSelection(GUI.powerups[GUI.options.repair], BoolToNumber(UIGlobals.CustomRaceSettings.powerups.repair))
  CustomRace_SetupPowerupIcon(GUI.powerups[GUI.options.repair], "Repair_Glow")
  GUI.powerups[GUI.options.shock] = CustomRace_SetupToggle(GUI.table_id, GUI.options.shock, UIText.MP_POWERUP_SHOCK, "perk_shock", "perk_icons")
  UIButtons.SetSelection(GUI.powerups[GUI.options.shock], BoolToNumber(UIGlobals.CustomRaceSettings.powerups.shock))
  CustomRace_SetupPowerupIcon(GUI.powerups[GUI.options.shock], "Shock_Glow")
  if UIGlobals.CustomRaceSettings.game_mode == UIEnums.MpRaceType.Destruction then
    UIButtons.SetActive(UIButtons.GetNodeID(GUI.table_id, GUI.options.shock), false)
  end
end
function CustomRace_CreateRightColumn()
  UIButtons.AddTableCol(GUI.table_id)
  GUI.random_id = CustomRace_SetupToggle(GUI.table_id, GUI.options.random, UIText.MP_CUSTOM_RACE_RANDOM_POWERUPS, "perk_question", "perk_icons")
  UIButtons.SetSelection(GUI.random_id, UIGlobals.CustomRaceSettings.random_powerups)
  print("UIGlobals.CustomRaceSettings.random_powerups", UIGlobals.CustomRaceSettings.random_powerups)
  GUI.powerups[GUI.options.shunt] = CustomRace_SetupToggle(GUI.table_id, GUI.options.shunt, UIText.MP_POWERUP_SHUNT, "perk_shunt", "perk_icons")
  UIButtons.SetSelection(GUI.powerups[GUI.options.shunt], BoolToNumber(UIGlobals.CustomRaceSettings.powerups.shunt))
  CustomRace_SetupPowerupIcon(GUI.powerups[GUI.options.shunt], "Shunt_Glow")
  GUI.powerups[GUI.options.shield] = CustomRace_SetupToggle(GUI.table_id, GUI.options.shield, UIText.MP_POWERUP_SHIELD, "perk_shield", "perk_icons")
  UIButtons.SetSelection(GUI.powerups[GUI.options.shield], BoolToNumber(UIGlobals.CustomRaceSettings.powerups.shield))
  CustomRace_SetupPowerupIcon(GUI.powerups[GUI.options.shield], "Shield_Glow")
end
function CustomRace_PowerupsTable()
  UIGlobals.CustomRaceSettings.random_powerups = UIButtons.GetSelection(GUI.random_id)
  UIGlobals.CustomRaceSettings.powerup_respawn = UIButtons.GetSelection(GUI.respawn_id)
  UIGlobals.CustomRaceSettings.powerups.bolt = NumberToBool(UIButtons.GetSelection(GUI.powerups[GUI.options.bolt]))
  UIGlobals.CustomRaceSettings.powerups.barge = NumberToBool(UIButtons.GetSelection(GUI.powerups[GUI.options.barge]))
  UIGlobals.CustomRaceSettings.powerups.nitro = NumberToBool(UIButtons.GetSelection(GUI.powerups[GUI.options.nitro]))
  UIGlobals.CustomRaceSettings.powerups.shunt = NumberToBool(UIButtons.GetSelection(GUI.powerups[GUI.options.shunt]))
  UIGlobals.CustomRaceSettings.powerups.shock = NumberToBool(UIButtons.GetSelection(GUI.powerups[GUI.options.shock]))
  UIGlobals.CustomRaceSettings.powerups.repair = NumberToBool(UIButtons.GetSelection(GUI.powerups[GUI.options.repair]))
  UIGlobals.CustomRaceSettings.powerups.mine = NumberToBool(UIButtons.GetSelection(GUI.powerups[GUI.options.mine]))
  UIGlobals.CustomRaceSettings.powerups.shield = NumberToBool(UIButtons.GetSelection(GUI.powerups[GUI.options.shield]))
  Amax.SetupRace(UIGlobals.CustomRaceSettings)
end
