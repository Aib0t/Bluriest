GUI = {
  finished = false,
  carousel_branch = "Options",
  OutputSelection = -1,
  output_index = 6,
  advanced_index = 7,
  GetSelections = function()
    UIGlobals.OptionsTable.quality = UIButtons.GetSelection(GUI.AudioQualityId)
    UIGlobals.OptionsTable.fx_vol = UIButtons.GetSelection(GUI.SoundEffectsId)
    UIGlobals.OptionsTable.music_vol = UIButtons.GetSelection(GUI.MusicId)
    UIGlobals.OptionsTable.voice_vol = UIButtons.GetSelection(GUI.VoiceId)
    UIGlobals.OptionsTable.menu_vol = UIButtons.GetSelection(GUI.MenuMusicId)
    UIGlobals.OptionsTable.music_type = UIButtons.GetSelection(GUI.MusicModeId)
    UIGlobals.OptionsTable.dynamic = UIButtons.GetSelection(GUI.DynamicRangeId)
    UIGlobals.OptionsTable.output = UIButtons.GetSelection(GUI.OutputId)
  end,
  SetSelections = function()
    UIButtons.SetSelection(GUI.AudioQualityId, UIGlobals.OptionsTable.quality)
    UIButtons.SetSelection(GUI.SoundEffectsId, UIGlobals.OptionsTable.fx_vol)
    UIButtons.SetSelection(GUI.MusicId, UIGlobals.OptionsTable.music_vol)
    UIButtons.SetSelection(GUI.MenuMusicId, UIGlobals.OptionsTable.menu_vol)
    UIButtons.SetSelection(GUI.MusicModeId, UIGlobals.OptionsTable.music_type)
    UIButtons.SetSelection(GUI.OutputId, UIGlobals.OptionsTable.output)
    UIButtons.SetSelection(GUI.DynamicRangeId, UIGlobals.OptionsTable.dynamic)
  end,
  HaveChangedSelections = function()
    return GUI.StartingOptionsTable.fx_vol ~= UIButtons.GetSelection(GUI.SoundEffectsId) or GUI.StartingOptionsTable.quality ~= UIButtons.GetSelection(GUI.AudioQualityId) or GUI.StartingOptionsTable.music_vol ~= UIButtons.GetSelection(GUI.MusicId) or GUI.StartingOptionsTable.menu_vol ~= UIButtons.GetSelection(GUI.MenuMusicId) or GUI.StartingOptionsTable.music_type ~= UIButtons.GetSelection(GUI.MusicModeId) or GUI.StartingOptionsTable.dynamic ~= UIButtons.GetSelection(GUI.DynamicRangeId) or GUI.StartingOptionsTable.output ~= UIButtons.GetSelection(GUI.OutputId)
  end,
  UpdateInfoLine = function()
    if GUI.selection ~= UIButtons.GetSelectionIndex(GUI.MessageListId) then
      GUI.selection = UIButtons.GetSelectionIndex(GUI.MessageListId)
      if UIButtons.GetSelectionIndex(GUI.MessageListId) == GUI.advanced_index then
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_CANCEL, UIText.INFO_RESET_TO_DEFAULT)
      else
        SetupInfoLine(UIText.INFO_A_CONFIRM, UIText.INFO_B_CANCEL, UIText.INFO_RESET_TO_DEFAULT)
      end
    end
  end,
  bottom_help_text = {
    UIText.CMN_HLP_AUDIO_QUALITY,
    UIText.CMN_HLP_AUDIO_SFX,
    UIText.CMN_HLP_AUDIO_MUSIC,
    UIText.CMN_HLP_AUDIO_MENU_MUSIC,
    UIText.CMN_HLP_AUDIO_MUSIC_MODE,
    UIText.CMN_HLP_AUDIO_DYNAMIC_RANGE,
    UIText.CMN_HLP_AUDIO_OUTPUT,
    UIText.CMN_HLP_AUDIO_ADVANCED
  },
  CanExit = function(_ARG_0_)
    return false
  end,
  CheckAdvancedOption = function()
    if UIGlobals.OptionsTable.output == 1 then
      UIButtons.SetNodeItemLocked(GUI.MessageListId, GUI.advanced_index, false)
      UIButtons.SetActive(GUI.AdvancedNodeId, true)
    else
      UIButtons.SetNodeItemLocked(GUI.MessageListId, GUI.advanced_index, true)
      UIButtons.SetActive(GUI.AdvancedNodeId, false)
    end
  end,
  UpdateAdvancedOption = function()
    if UIButtons.GetSelectionIndex(GUI.MessageListId) ~= GUI.output_index then
      return
    end
    if GUI.OutputSelection == UIButtons.GetSelectionIndex(GUI.OutputId) then
      return
    end
    GUI.CheckAdvancedOption()
    GUI.OutputSelection = UIButtons.GetSelectionIndex(GUI.OutputId)
  end
}
function Init()
  AddSCUI_Elements()
  GUI.MessageListId = SCUI.name_to_id.OptionsList
  GUI.AudioQualityId = SCUI.name_to_id.SDR_AudioQuality
  GUI.SoundEffectsId = SCUI.name_to_id.SDR_SoundEffects
  GUI.MusicId = SCUI.name_to_id.SDR_Music
  GUI.VoiceId = SCUI.name_to_id.SDR_Voice
  GUI.MenuMusicId = SCUI.name_to_id.SDR_MenuMusic
  GUI.MusicModeId = SCUI.name_to_id.SDR_MusicMode
  GUI.DynamicRangeId = SCUI.name_to_id.SDR_DynamicRange
  GUI.OutputId = SCUI.name_to_id.SDR_Ouput
  GUI.AdvancedNodeId = SCUI.name_to_id.Nde_Advanced
  for _FORV_4_, _FORV_5_ in ipairs({
    GUI.SoundEffectsId,
    GUI.MusicId,
    GUI.MenuMusicId
  }) do
    for _FORV_9_ = 0, 9 do
      UIButtons.AddItem(_FORV_5_, _FORV_9_, _FORV_9_, false)
    end
  end
  if UIGlobals.IsIngame ~= true then
    UIButtons.AddItem(GUI.AudioQualityId, 0, UIText.CMN_OPT_GRAPHICS_LOW, false)
    UIButtons.AddItem(GUI.AudioQualityId, 1, UIText.CMN_OPT_GRAPHICS_MEDIUM, false)
    UIButtons.AddItem(GUI.AudioQualityId, 2, UIText.CMN_OPT_GRAPHICS_HIGH, false)
  else
    GUI.output_index = 5
    GUI.advanced_index = 6
    UIButtons.SetActive(SCUI.name_to_id.Nde_AudioQuality, false)
  end
  UIButtons.AddItem(GUI.MusicModeId, 0, UIText.CMN_OFF, false)
  UIButtons.AddItem(GUI.MusicModeId, 1, UIText.CMN_ON, false)
  UIButtons.AddItem(GUI.OutputId, 0, UIText.CMN_OPT_AUDIO_STEREO, false)
  UIButtons.AddItem(GUI.OutputId, 1, UIText.CMN_OPT_AUDIO_SURROUND, false)
  UIButtons.AddItem(GUI.DynamicRangeId, 0, UIText.CMN_OPT_AUDIO_TV, false)
  UIButtons.AddItem(GUI.DynamicRangeId, 1, UIText.CMN_OPT_AUDIO_HOME_THEATRE, false)
  GUI.SetSelections()
  GUI.CheckAdvancedOption()
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_CANCEL)
  GUI.UpdateAdvancedOption()
  GUI.StartingOptionsTable = CloneTable(UIGlobals.OptionsTable)
  SetupScreenTitle(UIText.CMN_AUDIO_BASIC, SCUI.name_to_id.Dummy, "large_speaker")
end
function PostInit()
  UIButtons.ChangeScale(SetupSelectionBox(GUI.AdvancedNodeId, UIText.CMN_OPT_ADVANCED_AUDIO_OPTIONS, nil, nil, nil, nil, UIEnums.Justify.MiddleCentre))
  UIButtons.ChangePosition(SetupSelectionBox(GUI.AdvancedNodeId, UIText.CMN_OPT_ADVANCED_AUDIO_OPTIONS, nil, nil, nil, nil, UIEnums.Justify.MiddleCentre))
  if UIGlobals.IsIngame == true then
    UIButtons.SetParent(SCUI.name_to_id.Nde_AudioQuality, nil)
    UIButtons.SetSelection(GUI.MessageListId, 1)
  end
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
      GoScreen("Shared\\Options.lua")
    elseif _ARG_2_ == UIEnums.CustomPopups.ResetToDefaults and _ARG_3_ == UIEnums.PopupOptions.Yes then
      ResetToDefaults()
    end
  end
  mouse_overide = false
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and _ARG_3_ == UIScreen.Context() then
    UIButtons.SetCurrentItemByID(GUI.MessageListId, (UIButtons.GetParent(_ARG_2_)))
    mouse_overide = true
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    if GUI.HaveChangedSelections() == true then
      SetupCustomPopup(UIEnums.CustomPopups.DiscardOptionsChanges)
    else
      PlaySfxBack()
      GoScreen("Shared\\Options.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or mouse_overide == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    if UIButtons.GetSelectionIndex(GUI.MessageListId) == GUI.advanced_index then
      PlaySfxNext()
      GoScreen("Shared\\Options_AdvancedAudio.lua")
    else
      PlaySfxNext()
      GUI.GetSelections()
      GoScreen("Shared\\Options.lua")
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
    Amax.UpdateAudioOptions(UIGlobals.OptionsTable)
    UIButtons.ChangeText(GUI.bottom_text_id, GUI.bottom_help_text[UIButtons.GetSelectionIndex(GUI.MessageListId) + 1])
    UIButtons.TimeLineActive("HelpFade", true, 0.5)
    GUI.do_update_options = false
  end
  GUI.UpdateAdvancedOption()
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
  UIGlobals.OptionsTable.fx_vol = GUI.StartingOptionsTable.fx_vol
  UIGlobals.OptionsTable.music_vol = GUI.StartingOptionsTable.music_vol
  UIGlobals.OptionsTable.voice_vol = GUI.StartingOptionsTable.voice_vol
  UIGlobals.OptionsTable.menu_vol = GUI.StartingOptionsTable.menu_vol
  UIGlobals.OptionsTable.music_type = GUI.StartingOptionsTable.music_type
  UIGlobals.OptionsTable.dynamic = GUI.StartingOptionsTable.dynamic
  UIGlobals.OptionsTable.output = GUI.StartingOptionsTable.output
  Amax.UpdateAudioOptions(UIGlobals.OptionsTable)
end
function ResetToDefaults()
  UIGlobals.OptionsTable.fx_vol = UIGlobals.DefaultOptionsTable.fx_vol
  UIGlobals.OptionsTable.music_vol = UIGlobals.DefaultOptionsTable.music_vol
  UIGlobals.OptionsTable.voice_vol = UIGlobals.DefaultOptionsTable.voice_vol
  UIGlobals.OptionsTable.menu_vol = UIGlobals.DefaultOptionsTable.menu_vol
  UIGlobals.OptionsTable.music_type = UIGlobals.DefaultOptionsTable.music_type
  UIGlobals.OptionsTable.dynamic = UIGlobals.DefaultOptionsTable.dynamic
  UIGlobals.OptionsTable.output = UIGlobals.DefaultOptionsTable.output
  GUI.SetSelections()
  GUI.CheckAdvancedOption()
  GUI.StartingOptionsTable = CloneTable(UIGlobals.OptionsTable)
  Amax.UpdateAudioOptions(UIGlobals.OptionsTable)
end
