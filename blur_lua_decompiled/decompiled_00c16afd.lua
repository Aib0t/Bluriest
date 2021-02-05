GUI = {
  finished = false,
  carousel_branch = "Twitter",
  new_tweet = false,
  tweeting = false,
  tweeting_timer = 0,
  num_tweets = 0,
  ids = {},
  CanExit = function(_ARG_0_)
    return false
  end,
  refresh_screen = false,
  frameCounter = 0,
  message_length = 0
}
function Init()
  GUI.old_friends = net_LockoutFriendsOverlay(true)
  StoreInfoLine()
  SetupInfoLine()
  UIScreen.SetScreenTimers(0.3, 0.3)
  AddSCUI_Elements()
  UIScreen.Suspend(UIEnums.Context.Main)
  UIScreen.Suspend(UIEnums.Context.CarouselApp)
  UIScreen.Suspend(UIEnums.Context.Subscreen0)
  UIScreen.Suspend(UIEnums.Context.Subscreen1)
  UIScreen.Suspend(UIEnums.Context.Subscreen2)
  InfoLineSwitchContext(UIScreen.Context())
  SetupInfoLine(UIText.INFO_TWITTER_SEND_A, UIText.INFO_B_BACK, UIText.INFO_TWITTER_EDIT_X)
  GUI.default_box_height = SCUI.elements[SCUI.name_to_index.box].size.y
  GUI.default_box_width = SCUI.elements[SCUI.name_to_index.box].size.x
  GUI.font_style = SCUI.elements[SCUI.name_to_index.message_item].styles.name
  GUI.font_height = SCUI.elements[SCUI.name_to_index.message_item].size.y
  GUI.font_width = SCUI.elements[SCUI.name_to_index.message_item].size.x
  Amax.ClearBlurbMessage()
  GUI.dummy_text = SCUI.name_to_id.dummyText
  GUI.textbox_id = SCUI.name_to_id.message
  UIButtons.SetTextBoxLimit(GUI.textbox_id, Amax.RemainingTweetSpace())
end
function PostInit()
  Twitter_AddMessageNode()
  RefreshScreen()
  Twitter_DoNoTweetsBox()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.tweeting == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.ButtonX then
    GUI.message_length = Amax.RemainingTweetSpace()
    if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
      Twitter_EnableTextBox(true)
      PlaySfxNext()
    else
      UIHardware.StartKeyboard(_ARG_1_, "GAME_TWITTER_MSG_TEXT_DIRECT", UIText.RBC_TWITTER_KEYB_HEADER, UIText.RBC_TWITTER_KEYB_SUB_HEADER, GUI.message_length, UIEnums.XboxKeyboardType.Standard)
    end
    GUI.new_tweet = false
  elseif _ARG_0_ == UIEnums.Message.MenuNext then
    if Twitter_TextBoxActive() == false then
      if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
        Twitter_EnableTextBox(false)
        Amax.AddBlurbMessage(GUI.textbox_id)
        RefreshScreen()
      end
      if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
      end
      if not NetServices.UserHasAgeRestriction() == true then
        if GUI.num_tweets > 0 and Amax.GetTwitterTimeout() == 0 then
          SetupCustomPopup(UIEnums.CustomPopups.TwitterPost)
        end
      else
        SetupCustomPopup(UIEnums.CustomPopups.FailedAgeCheck)
      end
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    if Twitter_TextBoxActive() == true then
      Twitter_EnableTextBox(false)
    else
      EndScreen()
    end
    PlaySfxBack()
  elseif _ARG_0_ == UIEnums.Message.KeyboardFinished then
    if GUI.new_tweet == true then
      Amax.CreateNewTweet()
    else
      Amax.AddBlurbMessage()
    end
    RefreshScreen()
  end
end
function FrameUpdate(_ARG_0_)
  if UIGlobals.TwitterClose == true then
    UIGlobals.TwitterClose = false
    EndScreen()
  end
  if GUI.refresh_screen == true then
    RefreshScreen()
    GUI.refresh_screen = false
  end
  if GUI.tweeting == true then
    GUI.tweeting_timer = GUI.tweeting_timer + _ARG_0_
    if GUI.tweeting_timer > 2 and Amax.PumpTwitterCurrentTask() == false then
      GUI.tweeting = false
      if Amax.PumpTwitterCurrentTask() ~= 0 then
        if Amax.PumpTwitterCurrentTask() == 3501 or Amax.PumpTwitterCurrentTask() == 3502 then
          PopupSpawn(UIEnums.CustomPopups.TwitterPostError)
        elseif Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
          SetupCustomPopup(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
        else
          SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
        end
      else
        PopupSpawn(UIEnums.CustomPopups.TwitterPosted)
        UIGlobals.TwitterFailures = 0
        Amax.CheckStickerProgress(UIEnums.StickerType.ShareFirstExperience)
      end
      RefreshScreen()
    end
  end
end
function Render()
end
function EnterEnd()
  UIButtons.TimeLineActive("blurb_start", false)
  InfoLineSwitchContext()
  UIScreen.Resume(UIEnums.Context.Main)
  UIScreen.Resume(UIEnums.Context.CarouselApp)
  UIScreen.Resume(UIEnums.Context.Subscreen0)
  UIScreen.Resume(UIEnums.Context.Subscreen1)
  UIScreen.Resume(UIEnums.Context.Subscreen2)
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
  net_LockoutFriendsOverlay(GUI.old_friends)
end
function RefreshScreen()
  GUI.num_tweets = 1
  UIButtons.SetActive(SCUI.name_to_id.box_no, not (GUI.num_tweets > 0), true)
  UIButtons.ChangeText(GUI.ids[1].message_item, "GAME_TWITTER_MSG")
  UIButtons.ChangeSize(GUI.ids[1].box, GUI.default_box_width, GUI.default_box_height + (1 - 1) * GUI.font_height, UIButtons.GetSize(GUI.ids[1].box))
  UIButtons.ChangeSize(GUI.ids[1].box2, GUI.default_box_width + 0.75, GUI.default_box_height + (1 - 1) * GUI.font_height + 0.8125, UIButtons.GetSize(GUI.ids[1].box2))
  UIButtons.SetActive(GUI.ids[1].speech_left, true)
  UIButtons.SetActive(GUI.ids[1].icon_left, true)
  UIButtons.SetActive(GUI.ids[1].speech_right, not true)
  UIButtons.SetActive(GUI.ids[1].icon_right, not true)
end
function Twitter_AddMessageNode()
  GUI.ids[#GUI.ids + 1] = {
    box = SCUI.name_to_id.box,
    box2 = SCUI.name_to_id._box2,
    speech_left = SCUI.name_to_id._speech_left,
    speech_right = SCUI.name_to_id._speech_right,
    icon_left = SCUI.name_to_id._icon_left,
    icon_right = SCUI.name_to_id._icon_right,
    message_item = SCUI.name_to_id.message_item,
    message = SCUI.name_to_id.message
  }
end
function Twitter_DoNoTweetsBox()
  UIButtons.ChangeSize(SCUI.name_to_id.box_no, UIButtons.GetSize(SCUI.name_to_id.box_no))
end
function Twitter_EnableTextBox(_ARG_0_)
  UIButtons.TimeLineActive("show_textbox", _ARG_0_)
  UIButtons.SetTextInputActive(GUI.textbox_id, _ARG_0_)
  UIButtons.SetSelected(GUI.textbox_id, _ARG_0_)
end
function Twitter_TextBoxActive(_ARG_0_)
  return UIButtons.GetTextInputActive(GUI.textbox_id)
end
function SendTweet()
  if IsTable(ContextTable[UIEnums.Context.Blurb].GUI) ~= true then
    return
  end
  Amax.Tweet()
  ContextTable[UIEnums.Context.Blurb].GUI.tweeting = true
  ContextTable[UIEnums.Context.Blurb].GUI.tweeting_timer = 0
end
function DeleteTweet()
  if IsTable(ContextTable[UIEnums.Context.Blurb].GUI) ~= true then
    return
  end
  ContextTable[UIEnums.Context.Blurb].GUI.save_on_exit = true
  ContextTable[UIEnums.Context.Blurb].GUI.refresh_screen = true
end
