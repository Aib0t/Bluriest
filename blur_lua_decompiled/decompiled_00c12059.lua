GUI = {
  finished = false,
  carousel_branch = "Options",
  selection = -1,
  initial_selection = -1,
  bottom_bar_text_id = nil,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  GUI.OptionsId = SCUI.name_to_id.OptionsList
  GUI.configs_table = Amax.GetControllerConfigs()
  if IsTable(GUI.configs_table) == true then
    for _FORV_3_, _FORV_4_ in ipairs(GUI.configs_table) do
      UIButtons.AddItem(GUI.OptionsId, _FORV_3_, _FORV_4_.name, false)
    end
  end
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_CONFIRM, UIText.INFO_B_CANCEL)
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
    SetupScreenTitle(UIText.CMN_CONTROLS_TITLE, SCUI.name_to_id.Dummy, "ps3_controller_options")
  else
    SetupScreenTitle(UIText.CMN_CONTROLS_TITLE, SCUI.name_to_id.Dummy, "controller_options")
  end
  GUI.initial_selection = UIGlobals.OptionsTable.ctrl_index
  GUI.bottom_bar_text_id, GUI.bottom_bar_root_id = SetupBottomHelpBar(GUI.configs_table[UIGlobals.OptionsTable.ctrl_index + 1].name)
  UIButtons.SetParent(SCUI.name_to_id.arrow_left, GUI.bottom_bar_root_id, UIEnums.Justify.MiddleCentre)
  UIButtons.SetParent(SCUI.name_to_id.arrow_right, GUI.bottom_bar_root_id, UIEnums.Justify.MiddleCentre)
end
function PostInit()
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
    print("Ps3")
  elseif UIEnums.CurrentPlatform == UIEnums.Platform.Xenon or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    print("360")
  end
  UIButtons.SetActive(SCUI.name_to_id.Bra_360, true)
  GUI.text_table = {
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_AButton"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_BButton"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_XButton"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_YButton"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_LTrigger"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_RTrigger"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_LBumper"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_RBumper"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Txt_RStickButton")
  }
  GUI.parent_line_table = {
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_AButton"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_BButton"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_XButton"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_YButton"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_LTrigger"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_RTrigger"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_LBumper"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_RBumper"),
    UIButtons.FindChildByName(SCUI.name_to_id.Bra_360, "Gfx_LineA_RStick")
  }
  UIButtons.SetSelection(GUI.OptionsId, UIGlobals.OptionsTable.ctrl_index + 1)
  UpdateControllerButtons()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.DiscardOptionsChanges and _ARG_3_ == UIEnums.PopupOptions.Yes then
    GoBack(true)
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    PlaySfxNext()
    if UIGlobals.OptionsTable.ctrl_index ~= UIButtons.GetSelection(GUI.OptionsId) - 1 then
      Amax.GameDataLogControllerLayoutChanged(UIGlobals.OptionsTable.ctrl_index, UIButtons.GetSelection(GUI.OptionsId) - 1)
      UIGlobals.OptionsTable.ctrl_index = UIButtons.GetSelection(GUI.OptionsId) - 1
      UIGlobals.SaveOptions = true
    end
    GoScreen("Shared\\Options.lua")
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    if GUI.initial_selection == UIButtons.GetSelection(GUI.OptionsId) - 1 then
      GoBack()
    else
      SetupCustomPopup(UIEnums.CustomPopups.DiscardOptionsChanges)
    end
  end
end
function UpdateControllerButtons()
  if GUI.selection == UIButtons.GetSelection(GUI.OptionsId) then
    return
  end
  if IsTable(GUI.configs_table) == false then
    return
  end
  if IsTable(GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)]) == false then
    return
  end
  UIButtons.ChangeText(GUI.bottom_bar_text_id, GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].name)
  if UIButtons.GetSelection(GUI.OptionsId) == 1 then
    UIButtons.TimeLineActive("left_fade", false)
  elseif UIButtons.GetSelection(GUI.OptionsId) == 3 then
    UIButtons.TimeLineActive("right_fade", false)
  else
    UIButtons.TimeLineActive("left_fade", true)
    UIButtons.TimeLineActive("right_fade", true)
  end
  if UIButtons.GetSelection(GUI.OptionsId) > GUI.selection and GUI.selection ~= -1 then
    UIButtons.TimeLineActive("move_right", true, 0)
  else
    UIButtons.TimeLineActive("move_left", true, 0)
  end
  for _FORV_6_, _FORV_7_ in ipairs(GUI.text_table) do
    if _FORV_7_ == 0 or {
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsA,
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsB,
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsX,
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsY,
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsLT,
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsRT,
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsLB,
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsRB,
      GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsRThumb
    }[_FORV_6_] == 32767 then
      UIButtons.SetActive(_FORV_7_, false)
      UIButtons.SetActive(GUI.parent_line_table[_FORV_6_], false, true)
    else
      UIButtons.SetActive(_FORV_7_, true)
      UIButtons.SetActive(GUI.parent_line_table[_FORV_6_], true, true)
      UIButtons.ChangeText(_FORV_7_, {
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsA,
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsB,
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsX,
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsY,
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsLT,
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsRT,
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsLB,
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsRB,
        GUI.configs_table[UIButtons.GetSelection(GUI.OptionsId)].ButtonsRThumb
      }[_FORV_6_])
    end
  end
  GUI.selection = UIButtons.GetSelection(GUI.OptionsId)
end
function FrameUpdate(_ARG_0_)
  UpdateControllerButtons()
end
function Render()
end
function EnterEnd()
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
end
function GoBack(_ARG_0_)
  if _ARG_0_ ~= true then
    PlaySfxBack()
  end
  GoScreen("Shared\\Options.lua")
end
