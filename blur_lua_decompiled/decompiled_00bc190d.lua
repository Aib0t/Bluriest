GUI = {
  finished = false,
  num_options = -1,
  node_list_id = -1,
  current_option_selection = -1,
  switch_icon_ids = {},
  switch_rb_ids = {},
  switch_node_list_ids = {},
  switch_text_ids = {},
  current_switch_selection = {},
  choosing_switch = false
}
function Init()
  PlaySfxGraphicNext()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupInfoLine()
  GUI.camera_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Cam_Carousel")
  UIButtons.SetParent(GUI.camera_id, SCUI.name_to_id.CameraDolly, UIEnums.Justify.MiddleCentre)
  UIScreen.BlockInputToContext(true)
  UIScreen.SetScreenTimers(0.3, 0.3)
end
function PostInit()
  UIButtons.TimeLineActive("stage1", true, 0)
  SetupScreenTitle(UIText.FDE_FRIEND_DEMAND, SCUI.name_to_id.screen, "message", "common_icons", nil, UIEnums.Justify.TopCentre, true, nil, UIEnums.Panel._3DAA_LIGHT, nil, UIEnums.Justify.TopCentre)
  GUI.help_text_id = SetupBottomHelpBar(UIText.FDE_CREATE_HELP1, nil, 4, true)
  GUI.node_list_id = SCUI.name_to_id.node_list_options
  GUI.num_options = FriendDemand.GetParamCount()
  for _FORV_5_ = 1, GUI.num_options do
    UIButtons.ChangeTexture(Fd_GetParamIconInfo((FriendDemand.GetParamType(_FORV_5_ - 1))).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_icon")))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_icon"), Fd_GetParamIconInfo((FriendDemand.GetParamType(_FORV_5_ - 1))).effect)
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_icon"), Fd_GetParamIconInfo((FriendDemand.GetParamType(_FORV_5_ - 1))).colour)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_text_title"), "GAME_FRIEND_DEMAND_PARAM_TITLE_" .. _FORV_5_ - 1)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_text_info"), "GAME_FRIEND_DEMAND_PARAM_VAR_" .. _FORV_5_ - 1)
    if _FORV_5_ % 2 == 0 then
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_backing"), false)
    end
    if _FORV_5_ == GUI.num_options then
      UIButtons.ChangeSize(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), UIButtons.GetSize((UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"))))
    else
    end
    GUI.switch_icon_ids[_FORV_5_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_modifier_icon")
    GUI.switch_rb_ids[_FORV_5_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_switch_rb")
    GUI.switch_node_list_ids[_FORV_5_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_switch_node_list")
    GUI.switch_text_ids[_FORV_5_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), "_option_switch_info")
    GUI.current_switch_selection[_FORV_5_] = -1
    UIButtons.ChangeTexture(Fd_GetModifierIconInfo(UIEnums.FriendDemandModifer.LessThan).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_less"), "_option_switch_icon_less")))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_less"), "_option_switch_icon_less"), Fd_GetModifierIconInfo(UIEnums.FriendDemandModifer.LessThan).effect)
    UIButtons.AddListItem(GUI.switch_node_list_ids[_FORV_5_], UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_less"), UIEnums.FriendDemandModifer.LessThan)
    UIButtons.ChangeTexture(Fd_GetModifierIconInfo(UIEnums.FriendDemandModifer.Equals).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_equal"), "_option_switch_icon_equal")))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_equal"), "_option_switch_icon_equal"), Fd_GetModifierIconInfo(UIEnums.FriendDemandModifer.Equals).effect)
    UIButtons.AddListItem(GUI.switch_node_list_ids[_FORV_5_], UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_equal"), UIEnums.FriendDemandModifer.Equals)
    UIButtons.ChangeTexture(Fd_GetModifierIconInfo(UIEnums.FriendDemandModifer.GreaterThan).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_more"), "_option_switch_icon_more")))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_more"), "_option_switch_icon_more"), Fd_GetModifierIconInfo(UIEnums.FriendDemandModifer.GreaterThan).effect)
    UIButtons.AddListItem(GUI.switch_node_list_ids[_FORV_5_], UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_more"), UIEnums.FriendDemandModifer.GreaterThan)
    if FriendDemand.GetParamUsage(_FORV_5_ - 1) == UIEnums.FriendDemandParamUse.LessThanMoreThan then
      UIButtons.SetNodeItemLocked(GUI.switch_node_list_ids[_FORV_5_], UIEnums.FriendDemandModifer.Equals, true, true)
    elseif FriendDemand.GetParamUsage(_FORV_5_ - 1) == UIEnums.FriendDemandParamUse.LessThanMoreThanEquals then
    elseif FriendDemand.GetParamUsage(_FORV_5_ - 1) == UIEnums.FriendDemandParamUse.EqualsMoreThan then
      UIButtons.SetNodeItemLocked(GUI.switch_node_list_ids[_FORV_5_], UIEnums.FriendDemandModifer.LessThan, true, true)
    elseif FriendDemand.GetParamUsage(_FORV_5_ - 1) == UIEnums.FriendDemandParamUse.LessThanEquals then
      UIButtons.SetNodeItemLocked(GUI.switch_node_list_ids[_FORV_5_], UIEnums.FriendDemandModifer.GreaterThan, true, true)
    end
    UIButtons.ChangePosition(GUI.switch_node_list_ids[_FORV_5_], UIButtons.GetPosition(GUI.switch_node_list_ids[_FORV_5_]) - (2 - 1) / 2 * UIButtons.GetSize((UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_switch_node_less"))), UIButtons.GetPosition(GUI.switch_node_list_ids[_FORV_5_]))
    UIButtons.AddListItem(GUI.node_list_id, UIButtons.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_option_node"), _FORV_5_)
  end
  UIButtons.AddListItem(GUI.node_list_id, _FOR_.CloneXtGadgetByName("Ingame\\CreateFriendDemand.lua", "_setup_node"), GUI.num_options + 1)
  UIButtons.ChangePosition(GUI.node_list_id, UIButtons.GetPosition(GUI.node_list_id))
  FdCreate_UpdateSwitches()
  FdCreate_SetupInfoLines()
  FdCreate_SetInitialSelections()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.choosing_switch == false then
    if _ARG_0_ == UIEnums.Message.MenuNext then
      if GUI.current_option_selection == GUI.num_options + 1 then
        PopScreen()
      else
        GUI.choosing_switch = true
        UIButtons.SetSelected(GUI.node_list_id, false)
        UIButtons.SetSelected(GUI.switch_node_list_ids[GUI.current_option_selection], true)
        UIButtons.PrivateTimeLineActive(GUI.switch_rb_ids[GUI.current_option_selection], "option_switch_on", true, 0)
      end
      PlaySfxNext()
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      PlaySfxBack()
      PopScreen()
    elseif _ARG_0_ == UIEnums.Message.ButtonX and UIGlobals.FriendDemandSwitchChosen > -1 then
      Fd_ClearExtraChallenge()
      FdCreate_UpdateSwitches()
      FdCreate_SetupInfoLines()
      PlaySfxError()
    end
  elseif GUI.choosing_switch == true and (_ARG_0_ == UIEnums.Message.MenuNext or _ARG_0_ == UIEnums.Message.MenuBack) then
    GUI.choosing_switch = false
    UIButtons.SetSelected(GUI.node_list_id, true)
    UIButtons.SetSelected(GUI.switch_node_list_ids[GUI.current_option_selection], false)
    UIButtons.PrivateTimeLineActive(GUI.switch_rb_ids[GUI.current_option_selection], "option_switch_on", false)
    if _ARG_0_ == UIEnums.Message.MenuNext then
      for _FORV_9_ = 1, GUI.num_options do
        FriendDemand.ChangeSwitch(_FORV_9_ - 1, 0)
      end
      _FOR_.ChangeSwitch(GUI.current_option_selection - 1, (UIButtons.GetSelection(GUI.switch_node_list_ids[GUI.current_option_selection])))
      UIGlobals.FriendDemandSwitchChosen = GUI.current_option_selection - 1
      FdCreate_UpdateSwitches()
      FdCreate_SetupInfoLines()
      PlaySfxNext()
    else
      PlaySfxBack()
    end
  end
end
function FrameUpdate(_ARG_0_)
  if UIButtons.GetSelection(GUI.node_list_id) ~= GUI.current_option_selection then
    GUI.current_option_selection = UIButtons.GetSelection(GUI.node_list_id)
    FdCreate_SetupInfoLines()
  end
  for _FORV_5_, _FORV_6_ in ipairs(GUI.switch_node_list_ids) do
    if UIButtons.GetSelection(_FORV_6_) ~= GUI.current_switch_selection[_FORV_5_] then
      GUI.current_switch_selection[_FORV_5_] = UIButtons.GetSelection(_FORV_6_)
      if UIButtons.GetSelection(_FORV_6_) == UIEnums.FriendDemandModifer.LessThan then
        UIButtons.ChangeText(GUI.switch_text_ids[_FORV_5_], UIText.FDE_LESS_THAN)
      elseif UIButtons.GetSelection(_FORV_6_) == UIEnums.FriendDemandModifer.GreaterThan then
        UIButtons.ChangeText(GUI.switch_text_ids[_FORV_5_], UIText.FDE_GREATER_THAN)
      elseif UIButtons.GetSelection(_FORV_6_) == UIEnums.FriendDemandModifer.Equals then
        UIButtons.ChangeText(GUI.switch_text_ids[_FORV_5_], UIText.FDE_EQUALS)
      end
    end
  end
end
function EnterEnd()
  RestoreInfoLine()
  UIButtons.TimeLineActive("stage1", false)
  UIGlobals.FdAddText_DoUpdate = true
  FriendDemand.Create()
  PlaySfxGraphicBack()
end
function EndLoop(_ARG_0_)
end
function End()
end
function FdCreate_UpdateSwitches()
  for _FORV_3_ = 1, GUI.num_options do
    UIButtons.SetActive(GUI.switch_icon_ids[_FORV_3_], FriendDemand.GetSwitch(_FORV_3_ - 1) ~= UIEnums.FriendDemandModifer.NotUsed)
    if FriendDemand.GetSwitch(_FORV_3_ - 1) ~= UIEnums.FriendDemandModifer.NotUsed then
      UIButtons.ChangeTexture(Fd_GetModifierIconInfo((FriendDemand.GetSwitch(_FORV_3_ - 1))).tex, 0, GUI.switch_icon_ids[_FORV_3_])
      UIButtons.ChangeEffectIndex(GUI.switch_icon_ids[_FORV_3_], Fd_GetModifierIconInfo((FriendDemand.GetSwitch(_FORV_3_ - 1))).effect)
    end
  end
end
function FdCreate_SetupInfoLines()
  if GUI.current_option_selection == GUI.num_options + 1 then
    if UIGlobals.FriendDemandSwitchChosen > -1 then
      SetupInfoLine(UIText.INFO_A_CONFIRM, UIText.INFO_B_BACK, UIText.INFO_X_CLEAR_EXTRA_CHALLENGE)
    else
      SetupInfoLine(UIText.INFO_A_CONFIRM, UIText.INFO_B_BACK)
    end
  elseif GUI.choosing_switch == true or GUI.choosing_switch == false and UIGlobals.FriendDemandSwitchChosen == -1 then
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
  else
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, UIText.INFO_X_CLEAR_EXTRA_CHALLENGE)
  end
end
function FdCreate_SetInitialSelections()
  if UIGlobals.FriendDemandSwitchChosen > -1 then
    UIButtons.SetSelection(GUI.node_list_id, UIGlobals.FriendDemandSwitchChosen + 1)
  end
  for _FORV_3_ = 1, GUI.num_options do
    if FriendDemand.GetSwitch(_FORV_3_ - 1) ~= UIEnums.FriendDemandModifer.NotUsed then
      UIButtons.SetSelection(GUI.switch_node_list_ids[_FORV_3_], (FriendDemand.GetSwitch(_FORV_3_ - 1)))
    end
  end
end
