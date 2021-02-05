GUI = {
  finished = false,
  carousel_branch = "Options",
  GetSelections = function()
    UIGlobals.OptionsTable.speaker_fl, UIGlobals.OptionsTable.speaker_fr, UIGlobals.OptionsTable.speaker_rr, UIGlobals.OptionsTable.speaker_rl = Amax.Speakers(GUI.SpeakersId)
  end,
  HaveChangedSelections = function()
    return GUI.StartingOptionsTable.speaker_fl ~= Amax.Speakers(GUI.SpeakersId) or GUI.StartingOptionsTable.speaker_fr ~= Amax.Speakers(GUI.SpeakersId) or GUI.StartingOptionsTable.speaker_rr ~= Amax.Speakers(GUI.SpeakersId) or GUI.StartingOptionsTable.speaker_rl ~= Amax.Speakers(GUI.SpeakersId)
  end,
  CanExit = function(_ARG_0_)
    return false
  end,
  counter = 0
}
function Init()
  AddSCUI_Elements()
  GUI.SpeakersId = SCUI.name_to_id.Speakers
  Amax.Speakers(GUI.SpeakersId, UIGlobals.OptionsTable.speaker_fl, UIGlobals.OptionsTable.speaker_fr, UIGlobals.OptionsTable.speaker_rr, UIGlobals.OptionsTable.speaker_rl)
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_CONFIRM, UIText.INFO_B_CANCEL, UIText.INFO_RESET_TO_DEFAULT, UIText.INFO_LS_SPEAKER, UIText.INFO_RS_ANGLE)
  GUI.StartingOptionsTable = CloneTable(UIGlobals.OptionsTable)
  SetupScreenTitle(UIText.CMN_OPT_AUDIO_SPEAKERS, SCUI.name_to_id.Dummy, "small_speaker")
  SetupBottomHelpBar(UIText.CMN_HLP_AUDIO_SPEAKERS_SCREEN)
end
function PostInit()
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
      GoScreen("Shared\\Options_AdvancedAudio.lua")
    elseif _ARG_2_ == UIEnums.CustomPopups.ResetToDefaults and _ARG_3_ == UIEnums.PopupOptions.Yes then
      ResetToDefaults()
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    PlaySfxNext()
    GUI.GetSelections()
    GoScreen("Shared\\Options_AdvancedAudio.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    if Amax.isSpeakerSelected(GUI.SpeakersId) == false then
      if GUI.HaveChangedSelections() == true then
        SetupCustomPopup(UIEnums.CustomPopups.DiscardOptionsChanges)
      else
        PlaySfxBack()
        GoScreen("Shared\\Options_AdvancedAudio.lua")
      end
    end
  elseif _ARG_0_ == UIEnums.Message.StickLeftX or _ARG_0_ == UIEnums.Message.StickRightY then
    GUI.do_update_options = true
  elseif _ARG_0_ == UIEnums.Message.ButtonX then
    SetupCustomPopup(UIEnums.CustomPopups.ResetToDefaults)
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.do_update_options == true then
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
end
function ResetToStarting()
  Amax.Speakers(GUI.SpeakersId, GUI.StartingOptionsTable.speaker_fl, GUI.StartingOptionsTable.speaker_fr, GUI.StartingOptionsTable.speaker_rr, GUI.StartingOptionsTable.speaker_rl)
  Amax.UpdateAudioOptions(GUI.StartingOptionsTable)
end
function ResetToDefaults()
  Amax.Speakers(GUI.SpeakersId, UIGlobals.DefaultOptionsTable.speaker_fl, UIGlobals.DefaultOptionsTable.speaker_fr, UIGlobals.DefaultOptionsTable.speaker_rr, UIGlobals.DefaultOptionsTable.speaker_rl)
  GUI.StartingOptionsTable = CloneTable(UIGlobals.OptionsTable)
  Amax.UpdateAudioOptions(UIGlobals.OptionsTable)
end
