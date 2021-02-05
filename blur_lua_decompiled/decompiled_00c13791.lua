GUI = {
  finished = false,
  carousel_branch = "Options",
  diff = 0,
  initial_diff = 0,
  node_ids = {},
  difficulty_strings = {
    UIText.CMN_DIFFICULTY_1,
    UIText.CMN_DIFFICULTY_2,
    UIText.CMN_DIFFICULTY_3,
    UIText.CMN_DIFFICULTY_4,
    UIText.CMN_DIFFICULTY_5
  },
  difficulty_icons = {
    "ai_difficulty_low",
    "ai_difficutly_mid",
    "ai_difficulty"
  },
  difficulty_explanations = {
    UIText.CMN_HLP_OPT_DIFFICULTY1,
    UIText.CMN_HLP_OPT_DIFFICULTY2,
    UIText.CMN_HLP_OPT_DIFFICULTY3,
    UIText.CMN_HLP_OPT_DIFFICULTY4,
    UIText.CMN_HLP_OPT_DIFFICULTY5
  },
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  GUI.MessageListId = SCUI.name_to_id.OptionsList
  GUI.DifficultyId = SCUI.name_to_id.DifficultyList
  GUI.diff = UIGlobals.OptionsTable.difficulty
  GUI.initial_diff = GUI.diff
  SetupScreenTitle(UIText.CMN_DIFFICULTY, SCUI.name_to_id.Dummy, "ai_difficulty")
  GUI.bottom_help_text_id = SetupBottomHelpBar(GUI.difficulty_explanations[UIGlobals.OptionsTable.difficulty + 1])
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_CONFIRM, UIText.INFO_B_CANCEL)
end
function PostInit()
  for _FORV_3_ = 2, 4 do
    GUI.node_ids[_FORV_3_] = UIButtons.CloneXtGadgetByName("Shared\\Options_DrivingAssists.lua", "Nde_Difficulty")
    UIButtons.SetActive(GUI.node_ids[_FORV_3_], true, true)
    UIButtons.AddListItem(GUI.DifficultyId, GUI.node_ids[_FORV_3_], _FORV_3_ - 1)
    UIButtons.ChangeText(UIButtons.FindChildByName(GUI.node_ids[_FORV_3_], "txt_difficulty"), GUI.difficulty_strings[_FORV_3_])
    UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.node_ids[_FORV_3_], "Shp_Difficulty"), GUI.difficulty_icons[_FORV_3_ - 1])
  end
  _FOR_.SetSelection(GUI.DifficultyId, UIGlobals.OptionsTable.difficulty)
  if GUI.diff ~= 1 then
    UIButtons.TimeLineActive("left_fade", true)
  end
  if GUI.diff ~= 3 then
    UIButtons.TimeLineActive("right_fade", true)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.DiscardOptionsChanges and _ARG_3_ == UIEnums.PopupOptions.Yes then
    GUI.diff = GUI.initial_diff
    GoBack(true)
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    PlaySfxNext()
    if UIGlobals.OptionsTable.difficulty ~= UIButtons.GetSelection(GUI.DifficultyId) then
      Amax.GameDataLogDifficultySelected(UIGlobals.OptionsTable.difficulty, (UIButtons.GetSelection(GUI.DifficultyId)))
      UIGlobals.OptionsTable.difficulty = UIButtons.GetSelection(GUI.DifficultyId)
      UIGlobals.SaveOptions = true
    end
    GoScreen("Shared\\Options.lua")
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    if GUI.initial_diff == GUI.diff then
      GoBack()
    else
      SetupCustomPopup(UIEnums.CustomPopups.DiscardOptionsChanges)
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.diff ~= UIButtons.GetSelection(GUI.DifficultyId) then
    GUI.diff = UIButtons.GetSelection(GUI.DifficultyId)
    UIButtons.ChangeText(GUI.bottom_help_text_id, GUI.difficulty_explanations[UIButtons.GetSelection(GUI.DifficultyId) + 1])
    if UIButtons.GetSelection(GUI.DifficultyId) == 1 then
      UIButtons.TimeLineActive("left_fade", false)
      UIButtons.TimeLineActive("move_left", true, 0)
    elseif UIButtons.GetSelection(GUI.DifficultyId) == 3 then
      UIButtons.TimeLineActive("right_fade", false)
      UIButtons.TimeLineActive("move_right", true, 0)
    else
      UIButtons.TimeLineActive("right_fade", true)
      UIButtons.TimeLineActive("left_fade", true)
      if GUI.diff == 1 then
        UIButtons.TimeLineActive("move_right", true, 0)
      elseif GUI.diff == 3 then
        UIButtons.TimeLineActive("move_left", true, 0)
      end
    end
  end
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
