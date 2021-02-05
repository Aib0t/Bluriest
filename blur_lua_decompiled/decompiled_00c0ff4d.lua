GUI = {
  finished = false,
  carousel_branch = "Options",
  GetSelections = function()
    UIGlobals.OptionsTable.room = UIButtons.GetSelection(GUI.RoomSizeId)
    UIGlobals.OptionsTable.music_mode = UIButtons.GetSelection(GUI.MusicModeId)
    UIGlobals.OptionsTable.lfe = UIButtons.GetSelection(GUI.BoostId)
  end,
  SetSelections = function()
    UIButtons.SetSelection(GUI.RoomSizeId, UIGlobals.OptionsTable.room)
    UIButtons.SetSelection(GUI.MusicModeId, UIGlobals.OptionsTable.music_mode)
    UIButtons.SetSelection(GUI.BoostId, UIGlobals.OptionsTable.lfe)
  end,
  HaveChangedSelections = function()
    return GUI.StartingOptionsTable.room ~= UIButtons.GetSelection(GUI.RoomSizeId) or GUI.StartingOptionsTable.music_mode ~= UIButtons.GetSelection(GUI.MusicModeId) or GUI.StartingOptionsTable.lfe ~= UIButtons.GetSelection(GUI.BoostId)
  end,
  UpdateInfoLine = function()
    if GUI.selection ~= UIButtons.GetSelectionIndex(GUI.MessageListId) then
      GUI.selection = UIButtons.GetSelectionIndex(GUI.MessageListId)
      if UIButtons.GetSelectionIndex(GUI.MessageListId) == 3 then
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_CANCEL, UIText.INFO_RESET_TO_DEFAULT)
      else
        SetupInfoLine(UIText.INFO_A_CONFIRM, UIText.INFO_B_CANCEL, UIText.INFO_RESET_TO_DEFAULT)
      end
    end
  end,
  bottom_help_text = {
    UIText.CMN_HLP_ADVANCED_AUDIO_ROOM,
    UIText.CMN_HLP_ADVANCED_AUDIO_MODE,
    UIText.CMN_HLP_ADVANCED_AUDIO_LFE,
    UIText.CMN_HLP_ADVANCED_AUDIO_SPEAKERS
  },
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  GUI.RoomSizeId = SCUI.name_to_id.Sdr_RoomSize
  GUI.MusicModeId = SCUI.name_to_id.Sdr_MusicMode
  GUI.BoostId = SCUI.name_to_id.Sdr_Boost
  GUI.MessageListId = SCUI.name_to_id.OptionsList
  UIButtons.AddItem(GUI.RoomSizeId, 0, UIText.CMN_OPT_AUDIO_SMALL, false)
  UIButtons.AddItem(GUI.RoomSizeId, 1, UIText.CMN_OPT_AUDIO_MEDIUM, false)
  UIButtons.AddItem(GUI.RoomSizeId, 2, UIText.CMN_OPT_AUDIO_LARGE, false)
  UIButtons.AddItem(GUI.RoomSizeId, 3, UIText.CMN_OPT_AUDIO_AUDITORIUM, false)
  UIButtons.AddItem(GUI.MusicModeId, 0, UIText.CMN_OPT_AUDIO_STEREO, false)
  UIButtons.AddItem(GUI.MusicModeId, 1, UIText.CMN_OPT_AUDIO_QUAD, false)
  UIButtons.AddItem(GUI.MusicModeId, 2, UIText.CMN_OPT_AUDIO_SURROUND, false)
  for _FORV_3_ = 0, 9 do
    UIButtons.AddItem(GUI.BoostId, _FORV_3_, _FORV_3_, false)
  end
  _FOR_.SetSelections()
  StoreInfoLine()
  GUI.StartingOptionsTable = CloneTable(UIGlobals.OptionsTable)
  SetupScreenTitle(UIText.CMN_OPT_ADVANCED_AUDIO_OPTIONS, SCUI.name_to_id.Dummy, "sub")
end
function PostInit()
  UIButtons.NodeListScan(GUI.MessageListId)
  if IsNumber(GetScreenOtions().selection) == true then
    UIButtons.SetSelectionByIndex(GUI.MessageListId, GetScreenOtions().selection)
    GUI.bottom_text_id = SetupBottomHelpBar(GUI.bottom_help_text[GetScreenOtions().selection + 1])
  else
    UIButtons.SetSelectionByIndex(GUI.MessageListId, 0)
    GUI.bottom_text_id = SetupBottomHelpBar(GUI.bottom_help_text[1])
  end
  GUI.UpdateInfoLine()
  GUI.do_update_options = true
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.PopupNext then
    if _ARG_2_ == UIEnums.CustomPopups.DiscardOptionsChanges and _ARG_3_ == UIEnums.PopupOptions.Yes then
      ResetToStarting()
      GoScreen("Shared\\Options_Audio.lua")
    elseif _ARG_2_ == UIEnums.CustomPopups.ResetToDefaults and _ARG_3_ == UIEnums.PopupOptions.Yes then
      ResetToDefaults()
    end
  end
  mouse_overide = false
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and _ARG_3_ == UIScreen.Context() then
    UIButtons.SetCurrentItemByID(GUI.MessageListId, (UIButtons.GetParent(_ARG_2_)))
    mouse_overide = true
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or mouse_overide == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    if UIButtons.GetSelectionIndex(GUI.MessageListId) == 3 then
      PlaySfxNext()
      GoScreen("Shared\\Options_SpeakerPos.lua")
    else
      PlaySfxNext()
      GUI.GetSelections()
      GoScreen("Shared\\Options_Audio.lua")
    end
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    if GUI.HaveChangedSelections() == true then
      SetupCustomPopup(UIEnums.CustomPopups.DiscardOptionsChanges)
    else
      PlaySfxBack()
      GoScreen("Shared\\Options_Audio.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeft or _ARG_0_ == UIEnums.Message.ButtonRight then
    GUI.do_update_options = true
  elseif _ARG_0_ == UIEnums.Message.ButtonDown or _ARG_0_ == UIEnums.Message.ButtonUp then
    GUI.do_update_options = true
  elseif _ARG_0_ == UIEnums.Message.ButtonX then
    SetupCustomPopup(UIEnums.CustomPopups.ResetToDefaults)
  end
end
function FrameUpdate(_ARG_0_)
  GUI.UpdateInfoLine()
  if GUI.do_update_options == true then
    GUI.GetSelections()
    UIButtons.ChangeText(GUI.bottom_text_id, GUI.bottom_help_text[UIButtons.GetSelectionIndex(GUI.MessageListId) + 1])
    UIButtons.TimeLineActive("HelpFade", true, 0.5)
    Amax.UpdateAudioOptions(UIGlobals.OptionsTable)
    GUI.do_update_options = false
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
  GetScreenOtions().selection = UIButtons.GetSelectionIndex(GUI.MessageListId)
end
function ResetToStarting()
  UIGlobals.OptionsTable.room = GUI.StartingOptionsTable.room
  UIGlobals.OptionsTable.music_mode = GUI.StartingOptionsTable.music_mode
  UIGlobals.OptionsTable.lfe = GUI.StartingOptionsTable.lfe
  Amax.UpdateAudioOptions(UIGlobals.OptionsTable)
end
function ResetToDefaults()
  UIGlobals.OptionsTable.room = UIGlobals.DefaultOptionsTable.room
  UIGlobals.OptionsTable.music_mode = UIGlobals.DefaultOptionsTable.music_mode
  UIGlobals.OptionsTable.lfe = UIGlobals.DefaultOptionsTable.lfe
  GUI.SetSelections()
  GUI.StartingOptionsTable = CloneTable(UIGlobals.OptionsTable)
  Amax.UpdateAudioOptions(UIGlobals.OptionsTable)
end
