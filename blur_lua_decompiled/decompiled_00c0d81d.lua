GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  VideoEnums = {
    UIEnums.SPVideoConfig.VIDEO_TUTORIAL_1,
    UIEnums.SPVideoConfig.VIDEO_POWER_UPS,
    UIEnums.SPVideoConfig.VIDEO_TUTORIAL_2,
    UIEnums.SPVideoConfig.VIDEO_GAME_MODE_RACE,
    UIEnums.SPVideoConfig.VIDEO_GAME_MODE_DESTRUCTION,
    UIEnums.SPVideoConfig.VIDEO_GAME_MODE_CHECKPOINT,
    UIEnums.SPVideoConfig.VIDEO_GAME_MODE_ONEONONE,
    UIEnums.SPVideoConfig.VIDEO_FAN_PAR,
    UIEnums.SPVideoConfig.VIDEO_FAN_RUN,
    UIEnums.SPVideoConfig.VIDEO_FAN_DEMAND
  },
  VideoIcons = {
    "bio",
    "perk_question",
    "garage",
    "style_racing",
    "survivor",
    "quick_race",
    "deathmatch",
    "fan",
    "fan_attack",
    "fan"
  },
  VideoTextures = {
    "tut_thumb_1",
    "tut_thumb_7",
    "tut_thumb_2",
    "tut_thumb_6",
    "tut_thumb_8",
    "tut_thumb_9",
    "tut_thumb_10",
    "tut_thumb_4",
    "tut_thumb_5",
    "tut_thumb_3"
  },
  VideoTitles = {
    UIText.CMN_HELP_VIDEO_VID1,
    UIText.CMN_HELP_VIDEO_VID2,
    UIText.CMN_HELP_VIDEO_VID3,
    UIText.CMN_HELP_VIDEO_VID4,
    UIText.CMN_HELP_VIDEO_VID5,
    UIText.CMN_HELP_VIDEO_VID6,
    UIText.CMN_HELP_VIDEO_VID7,
    UIText.CMN_HELP_VIDEO_VID8,
    UIText.CMN_HELP_VIDEO_VID9,
    UIText.CMN_HELP_VIDEO_VID10
  },
  VideoBottomHelp = {
    UIText.CMN_HELP_VIDEO_VID1_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID2_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID3_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID4_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID5_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID6_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID7_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID8_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID9_BOTTOM,
    UIText.CMN_HELP_VIDEO_VID10_BOTTOM
  },
  num_videos = 10,
  do_update = true
}
function Init()
  AddSCUI_Elements()
  GUI.NodeListId = SCUI.name_to_id.video_list
  for _FORV_3_ = 1, GUI.num_videos do
    SetupVideoNode(_FORV_3_)
  end
  _FOR_()
  SetupInfoLine(UIText.INFO_PLAY_A, UIText.INFO_B_BACK)
  SetupScreenTitle(UIText.CMN_HELP_VIDEO_TITLE, SCUI.name_to_id._CarouselDummy, "video")
  GUI.bottom_bar_text_id = SetupBottomHelpBar(GUI.VideoBottomHelp[1])
end
function PostInit()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and _ARG_3_ == UIScreen.Context() then
    if _ARG_2_ == SCUI.name_to_id.left_arrow then
      UIButtons.SetPreviousItem(SCUI.name_to_id.left_arrow)
    elseif _ARG_2_ == SCUI.name_to_id.right_arrow then
      UIButtons.SetNextItem(SCUI.name_to_id.right_arrow)
    else
      UIButtons.SetCurrentItemByID(GUI.NodeListId, (UIButtons.GetParent(_ARG_2_)))
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA or true == true then
    PlaySPMovieFullScreen(GUI.VideoEnums[UIButtons.GetSelection(GUI.NodeListId)], true)
  end
  if _ARG_0_ == UIEnums.Message.MenuBack or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    PlaySfxBack()
    GoScreen("Shared\\Help.lua")
  end
  if _ARG_0_ == UIEnums.Message.ButtonLeft then
    GUI.do_update = true
    UIButtons.TimeLineActive("move_left", true, 0)
    if UIButtons.GetSelectionIndex(GUI.NodeListId) == GUI.num_videos - 1 then
      UIButtons.TimeLineActive("right_fade", true)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonRight then
    GUI.do_update = true
    UIButtons.TimeLineActive("move_right", true, 0)
    if UIButtons.GetSelectionIndex(GUI.NodeListId) == 0 then
      UIButtons.TimeLineActive("left_fade", true)
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.do_update == true then
    GUI.do_update = false
    GUI.update_arrows = false
    UIButtons.ChangeText(GUI.bottom_bar_text_id, GUI.VideoBottomHelp[UIButtons.GetSelectionIndex(GUI.NodeListId) + 1])
    SetupInfoLine(UIText.INFO_PLAY_A, UIText.INFO_B_BACK)
    if UIButtons.GetSelectionIndex(GUI.NodeListId) == GUI.num_videos - 1 then
      UIButtons.TimeLineActive("right_fade", false)
    elseif UIButtons.GetSelectionIndex(GUI.NodeListId) == 0 then
      UIButtons.TimeLineActive("left_fade", false)
    end
  end
end
function EnterEnd()
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
end
function SetupVideoNode(_ARG_0_)
  UIButtons.AddListItem(GUI.NodeListId, UIButtons.CloneXtGadgetByName("Shared\\Help_Video.lua", "video_node"), _ARG_0_)
  UIButtons.ChangeTexture({
    filename = GUI.VideoTextures[_ARG_0_]
  }, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Shared\\Help_Video.lua", "video_node"), "image")))
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Shared\\Help_Video.lua", "video_node"), "title"), GUI.VideoTitles[_ARG_0_])
  UIButtons.SetActive(UIButtons.CloneXtGadgetByName("Shared\\Help_Video.lua", "video_node"), true)
end
