GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  Stage = {
    Loadout = 1,
    Slot = 2,
    Ability = 3
  },
  CurrentAbility = -1,
  CurrentStage = 1,
  Countdown = 0,
  LoadoutGadgets = {},
  PreviewGadgets = {},
  AbilityGadgets = {},
  ChoosenAbilities = {},
  BackupAbilities = {},
  SlotGadgets = {},
  CurrentSlot = 1,
  CurrentSelection = -1,
  NewLoadout = false,
  ShouldSave = false,
  LookingAtEmptyLoadout = false,
  Previews = {}
}
function Init()
  if UIGlobals.Multiplayer.InLobby == true then
    PlaySfxGraphicBack()
  else
    PlaySfxGraphicNext()
  end
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_3", UIGlobals.CameraLerpTime, 0)
  StoreInfoLine()
  SetupInfoLine()
  if UIGlobals.Multiplayer.InLobby == false then
    net_SetRichPresence(UIEnums.RichPresence.ModShop)
  end
  GUI.LoadoutsID = SCUI.name_to_id.loadouts
  GUI.LoadoutPreviewID = SCUI.name_to_id.loadout_preview
  GUI.CategorysID = SCUI.name_to_id.categorys
  GUI.AbilitiesID = SCUI.name_to_id.abilities
  GUI.AbilityNameID = SCUI.name_to_id.ability_name
  GUI.AbilityDescID = SCUI.name_to_id.ability_desc
  GUI.LoadoutPreviewTextID = SCUI.name_to_id.loadout_preview_text
  GUI.Loadouts = Multiplayer.GetAbilityLoadouts(UIGlobals.Multiplayer.InLobby)
  GUI.UnlockMap = Multiplayer.GetAbilityUnlockMap()
  UIGlobals.Multiplayer.ModShopActive = true
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.node_loadout, false)
  UIButtons.SetActive(SCUI.name_to_id.node_ability, false)
  UIButtons.SetActive(SCUI.name_to_id.node_preview_ability, false)
  Multiplayer.FeatureViewed(UIEnums.MPFeatures.ModShop)
  UIButtons.ChangePanel(SetupScreenTitle(UIText.MP_MOD_SHOP, SCUI.name_to_id.centre, "custom_shop"), UIEnums.Panel._3DAA_WORLD, true)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.Loadouts) do
    GUI.LoadoutGadgets[_FORV_4_] = SetupLoadout(_FORV_4_ - 1, _FORV_5_.slots)
    UIButtons.AddListItem(GUI.LoadoutsID, GUI.LoadoutGadgets[_FORV_4_], _FORV_4_)
    if _FORV_4_ == Multiplayer.GetCurrentLoadOutType(UIGlobals.Multiplayer.InLobby) + 1 then
      UIButtons.PrivateTimeLineActive(GUI.LoadoutGadgets[_FORV_4_], "loadout_selected", true, 1)
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(GUI.LoadoutGadgets[_FORV_4_], "background_box"), "loadout_selected", true, 0)
    end
  end
  UIButtons.SetSelectionByIndex(GUI.LoadoutsID, (Multiplayer.GetCurrentLoadOutType(UIGlobals.Multiplayer.InLobby)))
  GUI.AbilityPacks = Multiplayer.GetAbilityPacks()
  for _FORV_4_ = 1, 3 do
    GUI.PreviewGadgets[_FORV_4_] = SetupPreviewItem("GAME_STR_Ability" .. _FORV_4_, "GAME_STR_Deal more Power-up damage", "deep_impact")
    UIButtons.AddListItem(GUI.LoadoutPreviewID, GUI.PreviewGadgets[_FORV_4_], _FORV_4_)
  end
  GUI.Abilities = Multiplayer.GetAbilities(GUI.AbilityPacks[1].type)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.Abilities) do
    GUI.AbilityGadgets[_FORV_4_] = SetupAbility(_FORV_5_.icon_name)
    UIButtons.AddListItem(GUI.AbilitiesID, GUI.AbilityGadgets[_FORV_4_], _FORV_4_)
  end
  UIButtons.SetActive(SCUI.name_to_id.darken, UIGlobals.Multiplayer.InLobby)
  UIButtons.SetActive(SCUI.name_to_id.countdown, UIGlobals.Multiplayer.InLobby)
  RefreshPreview(UIButtons.GetSelection(GUI.LoadoutsID))
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.CurrentStage == GUI.Stage.Loadout and _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.ModShopOptions then
    if _ARG_3_ == UIEnums.ModShopOptions.Use then
      if GUI.Loadouts[UIButtons.GetSelection(GUI.LoadoutsID)].can_use == true then
        for _FORV_8_, _FORV_9_ in ipairs(GUI.LoadoutGadgets) do
          UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_9_, "background_box"), "loadout_selected", false)
        end
        GUI.ShouldSave = true
        UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(GUI.LoadoutGadgets[UIButtons.GetSelection(GUI.LoadoutsID)], "background_box"), "loadout_selected", true, 0)
        Multiplayer.SetCurrentLoadOutType(UIButtons.GetSelection(GUI.LoadoutsID) - 1, UIGlobals.Multiplayer.InLobby)
        if UIGlobals.Multiplayer.InLobby == true then
          NetRace.ChangeLocalPlayerLoadout(Profile.GetPrimaryPad())
          UIGlobals.Multiplayer.LobbyUpdateLoadout = true
        end
      end
    elseif _ARG_3_ == UIEnums.ModShopOptions.Edit then
      GUI.CurrentStage = GUI.CurrentStage + 1
      SelectLoadout(UIButtons.GetSelection(GUI.LoadoutsID), true)
      GUI.ShouldSave = true
      GUI.NewLoadout = not GUI.Loadouts[UIButtons.GetSelection(GUI.LoadoutsID)].can_use
    elseif _ARG_3_ == UIEnums.ModShopOptions.Rename then
      RenameLoadout(UIButtons.GetSelection(GUI.LoadoutsID), _ARG_1_)
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if GUI.CurrentStage == GUI.Stage.Loadout then
      UIGlobals.Multiplayer.CanEquipMods = GUI.Loadouts[UIButtons.GetSelection(GUI.LoadoutsID)].can_use
      SetupCustomPopup(UIEnums.CustomPopups.ModShopOptions)
    elseif GUI.CurrentStage == GUI.Stage.Slot then
      if GUI.CurrentSlot <= #GUI.SlotGadgets then
        GUI.CurrentStage = GUI.CurrentStage + 1
        SelectSlot(GUI.CurrentSlot, true)
        PlaySfxNext()
      end
    elseif GUI.CurrentStage == GUI.Stage.Ability then
      GUI.CurrentStage = GUI.CurrentStage - 1
      SelectAbility(UIButtons.GetSelection(GUI.AbilitiesID))
      SelectSlot(GUI.CurrentSlot, false)
      UISystem.PlaySound(UIEnums.SoundEffect.ModShopAttach)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeft and _ARG_2_ == true then
    MoveLeft()
  elseif _ARG_0_ == UIEnums.Message.ButtonRight and _ARG_2_ == true then
    MoveRight()
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    PlaySfxBack()
    GUI.CurrentSelection = -1
    if GUI.CurrentStage == GUI.Stage.Loadout then
      if GUI.ShouldSave == true then
        Amax.CheckStickerProgress(UIEnums.StickerType.CustomiseALoadout, 1)
      end
      if UIGlobals.Multiplayer.InLobby == true then
        PopScreen()
      else
        if GUI.ShouldSave == true then
          StartAsyncSave()
        end
        GoScreen("Multiplayer\\MpOnline.lua")
      end
      if UIGlobals.Multiplayer.InLobby == true then
        PlaySfxGraphicNext()
      else
        PlaySfxGraphicBack()
      end
    elseif GUI.CurrentStage == GUI.Stage.Slot then
      Multiplayer.SetAbilityLoadout(UIButtons.GetSelection(GUI.LoadoutsID) - 1, GUI.ChoosenAbilities, UIGlobals.Multiplayer.InLobby)
      GUI.Loadouts = Multiplayer.GetAbilityLoadouts(UIGlobals.Multiplayer.InLobby)
      SelectLoadout(UIButtons.GetSelection(GUI.LoadoutsID), false)
      GUI.CurrentStage = GUI.CurrentStage - 1
      if UIGlobals.Multiplayer.InLobby == true then
        NetRace.ChangeLocalPlayerLoadout(Profile.GetPrimaryPad())
        UIGlobals.Multiplayer.LobbyUpdateLoadout = true
      end
      if GUI.LookingAtEmptyLoadout == true or UIGlobals.Multiplayer.InLobby == true then
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
      else
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
      end
    elseif GUI.CurrentStage == GUI.Stage.Ability then
      SelectSlot(GUI.CurrentSlot, false)
      GUI.CurrentStage = GUI.CurrentStage - 1
    end
  elseif GUI.CurrentStage == GUI.Stage.Loadout and _ARG_0_ == UIEnums.Message.KeyboardFinished then
    GUI.ShouldSave = true
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
    if Amax.CanUseShare() == true and GUI.LookingAtEmptyLoadout == false and UIGlobals.Multiplayer.InLobby == false and GUI.CurrentStage == GUI.Stage.Loadout then
      UIGlobals.ShareFromWhatPopup = -1
      SetupCustomPopup(UIEnums.CustomPopups.SharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Multiplayer\\ModShop\\MpModShop.lua")
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.OwnMod, 1, UIButtons.GetSelection(GUI.LoadoutsID) - 1)
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.OwnMod, 0, UIButtons.GetSelection(GUI.LoadoutsID) - 1)
      GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.OwnMod, 2, UIButtons.GetSelection(GUI.LoadoutsID) - 1)
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if GUI.CurrentStage == GUI.Stage.Loadout then
    if UIButtons.GetSelection(GUI.LoadoutsID) ~= GUI.CurrentSelection then
      GUI.CurrentSelection = UIButtons.GetSelection(GUI.LoadoutsID)
      RefreshPreview((UIButtons.GetSelection(GUI.LoadoutsID)))
    end
  elseif GUI.CurrentStage == GUI.Stage.Slot then
    if GUI.CurrentSlot ~= GUI.CurrentSelection then
      GUI.CurrentSelection = GUI.CurrentSlot
      if GUI.CurrentSlot <= #GUI.SlotGadgets then
        RefreshAbilities(GUI.CurrentSlot)
      end
    end
  elseif GUI.CurrentStage == GUI.Stage.Ability and UIButtons.GetSelection(GUI.AbilitiesID) ~= GUI.CurrentSelection then
    GUI.CurrentSelection = UIButtons.GetSelection(GUI.AbilitiesID)
    RefreshAbility((UIButtons.GetSelection(GUI.AbilitiesID)))
  end
end
function EnterEnd()
  if UIGlobals.Multiplayer.InLobby == true then
    Amax.ChangeUiCamera(UIGlobals.CameraNames.MpLobby, UIGlobals.CameraLerpTime, 0)
  end
  RestoreInfoLine()
end
function End()
  UIGlobals.Multiplayer.ModShopActive = false
end
function Modified()
  for _FORV_4_, _FORV_5_ in pairs(GUI.BackupAbilities) do
    if _FORV_5_.type ~= GUI.ChoosenAbilities[_FORV_4_].type then
      break
    end
  end
  return true
end
function MoveLeft()
  if GUI.CurrentStage == GUI.Stage.Slot and GUI.CurrentSlot > 1 then
    PlaySfxLeft()
    UIButtons.PrivateTimeLineActive(GUI.SlotGadgets[GUI.CurrentSlot], "selected", false)
    GUI.CurrentSlot = GUI.CurrentSlot - 1
    UIButtons.PrivateTimeLineActive(GUI.SlotGadgets[GUI.CurrentSlot], "selected", true)
  end
end
function MoveRight()
  if GUI.CurrentStage == GUI.Stage.Slot and GUI.CurrentSlot < #GUI.SlotGadgets then
    PlaySfxRight()
    UIButtons.PrivateTimeLineActive(GUI.SlotGadgets[GUI.CurrentSlot], "selected", false)
    GUI.CurrentSlot = GUI.CurrentSlot + 1
    UIButtons.PrivateTimeLineActive(GUI.SlotGadgets[GUI.CurrentSlot], "selected", true)
  end
end
function RestoreLoadout()
  GUI.ChoosenAbilities = CloneTable(GUI.BackupAbilities)
  for _FORV_3_ = 1, 3 do
    if GUI.ChoosenAbilities[_FORV_3_].empty == true then
      UIShape.ChangeSceneName(GUI.SlotGadgets[_FORV_3_], "common_icons")
      UIShape.ChangeObjectName(GUI.SlotGadgets[_FORV_3_], "style_mixed")
      UIButtons.ChangeColour(GUI.SlotGadgets[_FORV_3_], "main_black")
    else
      UIShape.ChangeSceneName(GUI.SlotGadgets[_FORV_3_], "ability_icons")
      UIShape.ChangeObjectName(GUI.SlotGadgets[_FORV_3_], GUI.ChoosenAbilities[_FORV_3_].icon_name)
      UIButtons.ChangeColour(GUI.SlotGadgets[_FORV_3_], UIGlobals.CategoryColour[GUI.ChoosenAbilities[_FORV_3_].pack])
    end
  end
end
function RefreshPreview(_ARG_0_)
  GUI.LookingAtEmptyLoadout = false
  for _FORV_4_, _FORV_5_ in ipairs(GUI.Loadouts[_ARG_0_].slots) do
    if _FORV_5_.empty == false then
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "name"), _FORV_5_.name)
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "desc"), _FORV_5_.desc)
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "name"), "Main_White")
      UIShape.ChangeSceneName(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "icon"), "ability_icons")
      UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "icon"), _FORV_5_.icon_name)
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "icon"), UIGlobals.CategoryColour[_FORV_5_.pack])
    else
      GUI.LookingAtEmptyLoadout = true
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "name"), UIText.MP_EMPTY_SLOT)
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "desc"), UIText.CMN_NOWT)
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "name"), "Main_Black")
      UIShape.ChangeSceneName(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "icon"), "common_icons")
      UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "icon"), "style_mixed")
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PreviewGadgets[_FORV_4_], "icon"), "Main_Black")
    end
  end
  if GUI.LookingAtEmptyLoadout == true or UIGlobals.Multiplayer.InLobby == true or Amax.CanUseShare() == false then
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
  else
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
  end
end
function RefreshAbilities(_ARG_0_)
  GUI.Abilities = Multiplayer.GetAbilities(GUI.AbilityPacks[_ARG_0_].type)
  for _FORV_5_, _FORV_6_ in ipairs(GUI.Abilities) do
    if Amax.IsGameModeRanked() == false and UIGlobals.Multiplayer.InLobby == true or GUI.UnlockMap[_FORV_6_.type].unlocked == true then
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "unlock_rank"), UIText.CMN_NOWT)
      UIShape.ChangeSceneName(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "ability_icon"), "ability_icons")
      UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "ability_icon"), _FORV_6_.icon_name)
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "ability_icon"), UIGlobals.CategoryColour[GUI.AbilityPacks[_ARG_0_].type])
      UIButtons.SetNodeItemLocked(GUI.AbilitiesID, _FORV_5_ - 1, false)
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "new"), Multiplayer.GetNewAbilitiesMap()[_FORV_6_.type])
    else
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "unlock_rank"), "MPL_ABILITY_LOCKED" .. GUI.UnlockMap[_FORV_6_.type].level + 1)
      UIShape.ChangeSceneName(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "ability_icon"), "common_icons")
      UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "ability_icon"), "style_mixed")
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "ability_icon"), "locked")
      UIButtons.SetNodeItemLocked(GUI.AbilitiesID, _FORV_5_ - 1, true)
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.AbilityGadgets[_FORV_5_], "new"), false)
    end
    if GUI.ChoosenAbilities[GUI.CurrentSlot].type == _FORV_6_.type then
      RefreshAbility(_FORV_5_)
    end
  end
end
function RefreshAbility(_ARG_0_)
  UIButtons.ChangeText(GUI.AbilityNameID, GUI.Abilities[_ARG_0_].name)
  UIButtons.ChangeText(GUI.AbilityDescID, GUI.Abilities[_ARG_0_].desc)
  UIButtons.SetActive(UIButtons.FindChildByName(GUI.AbilityGadgets[_ARG_0_], "new"), false)
  Multiplayer.AbilityViewed(GUI.Abilities[_ARG_0_].type)
end
function SelectLoadout(_ARG_0_, _ARG_1_)
  GUI.CurrentSelection = -1
  UIButtons.SetSelected(GUI.LoadoutsID, not _ARG_1_)
  UIButtons.TimeLineActive("show_abilities", _ARG_1_)
  for _FORV_5_, _FORV_6_ in pairs(GUI.LoadoutGadgets) do
    if GUI.LoadoutGadgets[_ARG_0_] == _FORV_6_ then
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_6_, "dummy_loadout"), "move_up" .. _ARG_0_, _ARG_1_)
      UIButtons.PrivateTimeLineActive(_FORV_6_, "edit_loadout", _ARG_1_)
      UIButtons.SetActive(UIButtons.FindChildByName(_FORV_6_, "left_arrow"), _ARG_1_)
      UIButtons.SetActive(UIButtons.FindChildByName(_FORV_6_, "right_arrow"), _ARG_1_)
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_6_, "left_arrow"), "gadget_activated", _ARG_1_, 1)
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_6_, "right_arrow"), "gadget_activated", _ARG_1_, 1)
      if _ARG_1_ == true then
        GUI.SlotGadgets = {}
        for _FORV_10_ = 1, 3 do
          GUI.SlotGadgets[_FORV_10_] = UIButtons.FindChildByName(_FORV_6_, "slot_" .. _FORV_10_)
          GUI.ChoosenAbilities[_FORV_10_] = GUI.Loadouts[_ARG_0_].slots[_FORV_10_]
        end
        _FOR_.CurrentSlot = 1
        GUI.SlotGadgets[4] = UIButtons.FindChildByName(_FORV_6_, "confirm")
        GUI.BackupAbilities = CloneTable(GUI.ChoosenAbilities)
      end
      UIButtons.PrivateTimeLineActive(GUI.SlotGadgets[GUI.CurrentSlot], "selected", _ARG_1_)
    else
      UIButtons.PrivateTimeLineActive(_FORV_6_, "move_off", _ARG_1_)
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_6_, "dummy_loadout"), "move_off", _ARG_1_)
    end
  end
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
end
function SelectSlot(_ARG_0_, _ARG_1_)
  for _FORV_5_, _FORV_6_ in ipairs(GUI.Abilities) do
    if GUI.ChoosenAbilities[GUI.CurrentSlot].type == _FORV_6_.type then
      UIButtons.SetSelection(GUI.AbilitiesID, _FORV_5_)
    end
  end
  GUI.CurrentSelection = -1
  UIButtons.SetSelected(GUI.AbilitiesID, _ARG_1_)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(GUI.LoadoutGadgets[UIButtons.GetSelection(GUI.LoadoutsID)], "slot_1"), "select_slot", _ARG_1_)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(GUI.LoadoutGadgets[UIButtons.GetSelection(GUI.LoadoutsID)], "slot_2"), "select_slot", _ARG_1_)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(GUI.LoadoutGadgets[UIButtons.GetSelection(GUI.LoadoutsID)], "slot_3"), "select_slot", _ARG_1_)
  UIButtons.PrivateTimeLineActive(GUI.SlotGadgets[GUI.CurrentSlot], "selected", not _ARG_1_)
  UIButtons.SetActive(UIButtons.FindChildByName(GUI.LoadoutGadgets[UIButtons.GetSelection(GUI.LoadoutsID)], "left_arrow"), not _ARG_1_)
  UIButtons.SetActive(UIButtons.FindChildByName(GUI.LoadoutGadgets[UIButtons.GetSelection(GUI.LoadoutsID)], "right_arrow"), not _ARG_1_)
end
function SelectAbility(_ARG_0_)
  GUI.CurrentSelection = -1
  UIShape.ChangeSceneName(GUI.SlotGadgets[GUI.CurrentSlot], "ability_icons")
  UIShape.ChangeObjectName(GUI.SlotGadgets[GUI.CurrentSlot], GUI.Abilities[_ARG_0_].icon_name)
  UIButtons.ChangeColour(GUI.SlotGadgets[GUI.CurrentSlot], UIGlobals.CategoryColour[GUI.Abilities[_ARG_0_].pack])
  GUI.ChoosenAbilities[GUI.CurrentSlot] = GUI.Abilities[_ARG_0_]
  UIButtons.PrivateTimeLineActive(GUI.SlotGadgets[GUI.CurrentSlot], "select_ability", true, 0)
  if GUI.NewLoadout then
    MoveRight()
  end
  UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PreviewGadgets[GUI.CurrentSlot], "name"), GUI.Abilities[_ARG_0_].name)
  UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PreviewGadgets[GUI.CurrentSlot], "desc"), GUI.Abilities[_ARG_0_].desc)
  UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PreviewGadgets[GUI.CurrentSlot], "name"), "Support_1")
  UIShape.ChangeSceneName(UIButtons.FindChildByName(GUI.PreviewGadgets[GUI.CurrentSlot], "icon"), "ability_icons")
  UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.PreviewGadgets[GUI.CurrentSlot], "icon"), GUI.Abilities[_ARG_0_].icon_name)
  UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PreviewGadgets[GUI.CurrentSlot], "icon"), UIGlobals.CategoryColour[GUI.Abilities[_ARG_0_].pack])
end
function SetupLoadout(_ARG_0_, _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_loadout"), "loadout_index"), "MPL_LOADOUT_INDEX" .. _ARG_0_)
  if UIGlobals.Multiplayer.InLobby == true then
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_loadout"), "loadout_name"), "MPL_LOADOUT_NAME_LOBBY" .. _ARG_0_)
  else
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_loadout"), "loadout_name"), "MPL_LOADOUT_NAME" .. _ARG_0_)
  end
  for _FORV_8_, _FORV_9_ in ipairs(_ARG_1_) do
    if _FORV_9_.empty == false then
      UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_loadout"), "slot_" .. _FORV_8_), "ability_icons")
      UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_loadout"), "slot_" .. _FORV_8_), _FORV_9_.icon_name)
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_loadout"), "slot_" .. _FORV_8_), UIGlobals.CategoryColour[_FORV_9_.pack])
    end
  end
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_loadout"))
end
function SetupCategory(_ARG_0_, _ARG_1_, _ARG_2_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_category"), "category_name"), _ARG_0_)
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_category"), "category_icon"), _ARG_2_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_category"), "category_icon"), _ARG_1_)
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_category"))
end
function SetupPreviewItem(_ARG_0_, _ARG_1_, _ARG_2_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_preview_ability"), "name"), _ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_preview_ability"), "desc"), _ARG_1_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_preview_ability"), "icon"), _ARG_2_)
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_preview_ability"))
end
function SetupAbility(_ARG_0_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_ability"), "ability_icon"), _ARG_0_)
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\ModShop\\MpModShop.lua", "node_ability"))
end
function RenameLoadout(_ARG_0_, _ARG_1_)
  if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    LaunchPopupKeyboard(UIText.MP_LOADOUT_NAME, 16)
    UIGlobals.MpModShopKeyboardCheck = UIButtons.GetSelection(GUI.LoadoutsID) - 1
  else
    UIHardware.StartKeyboard(_ARG_1_, "MPL_LOADOUT_NAME" .. _ARG_0_ - 1, UIText.CMN_NOWT, UIText.MP_LOADOUT_NAME_HELP, 16, UIEnums.XboxKeyboardType.GamertagHighlight)
    UIGlobals.MpModShopKeyboardCheck = UIButtons.GetSelection(GUI.LoadoutsID) - 1
  end
end
