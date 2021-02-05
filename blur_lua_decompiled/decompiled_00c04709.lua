GUI = {
  finished = false,
  carousel_branch = "Facebook",
  save_on_exit = false,
  stringNo = 0,
  sending_story = false,
  sending_story_timer = 0,
  num_stories = 0,
  ids = {},
  refresh_screen = false,
  frameCounter = 0
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
  SetupInfoLine(UIText.INFO_FACEBOOK_SEND_A, UIText.INFO_B_BACK, UIText.INFO_FACEBOOK_EDIT_X)
  Amax.ClearBlurbMessage()
  GUI.textbox_id = SCUI.name_to_id.message
end
function PostInit()
  Facebook_AddMessageNode()
  RefreshScreen()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.sending_story == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.ButtonX then
    if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
      Facebook_EnableTextBox(true)
    else
      UIHardware.StartKeyboard(_ARG_1_, "GAME_FACEBOOK_MSG" .. 0, UIText.RBC_FACEBOOK_KEYB_HEADER, UIText.RBC_FACEBOOK_KEYB_SUB_HEADER, 160, UIEnums.XboxKeyboardType.Standard)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    if Facebook_TextBoxActive() == true then
      Facebook_EnableTextBox(false)
    else
      PlaySfxBack()
      EndScreen()
    end
  elseif _ARG_0_ == UIEnums.Message.MenuNext then
    if Facebook_TextBoxActive() == false then
      if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
        Amax.AddBlurbMessage(GUI.textbox_id)
      end
      if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
      end
      if not NetServices.UserHasAgeRestriction() == true then
        if 0 < GUI.num_stories and Amax.GetFacebookTimeout() == 0 then
          SetupCustomPopup(UIEnums.CustomPopups.FacebookPost)
        end
      else
        SetupCustomPopup(UIEnums.CustomPopups.FailedAgeCheck)
      end
    end
  elseif _ARG_0_ == UIEnums.Message.KeyboardFinished then
    Amax.AddBlurbMessage()
    GUI.save_on_exit = true
    RefreshScreen()
  end
end
function FrameUpdate(_ARG_0_)
  if UIGlobals.FacebookClose == true then
    UIGlobals.FacebookClose = false
    EndScreen()
  end
  if UIGlobals.SendFacebookStory == true then
    GUI.sending_story = true
    GUI.sending_story_timer = 0
    UIGlobals.SendFacebookStory = false
  end
  if GUI.refresh_screen == true or Facebook_TextBoxActive() == true then
    RefreshScreen()
    GUI.refresh_screen = false
  end
  if GUI.sending_story == true then
    GUI.sending_story_timer = GUI.sending_story_timer + _ARG_0_
    if GUI.sending_story_timer > 2 then
      still_pumping, error = Amax.PumpFacebookCurrentTask()
      if still_pumping == false then
        GUI.sending_story = false
        print("Error ", error)
        if error ~= 0 then
          if error == 3601 or error == 3602 then
            UIGlobals.AuthenticateFromPhoto = false
            PopupSpawn(UIEnums.CustomPopups.FacebookPostError)
          elseif error == 3607 then
            UIGlobals.AuthenticateFromPhoto = false
            PopupSpawn(UIEnums.CustomPopups.FacebookConnectionError)
          elseif Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
            SetupCustomPopup(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
          else
            SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
          end
        else
          PopupSpawn(UIEnums.CustomPopups.FacebookPosted)
          UIGlobals.FacebookFailures = 0
          Amax.ClearFacebookStory(UIGlobals.CurrentFacebookStory)
          Amax.CheckStickerProgress(UIEnums.StickerType.ShareFirstExperience)
        end
        RefreshScreen()
      end
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
  GUI.num_stories = 1
  if UIGlobals.CurrentFacebookStory ~= -1 then
    UIGlobals.CurrentFacebookStory = Clamp(UIGlobals.CurrentFacebookStory, 0, GUI.num_stories - 1)
  end
  if GUI.num_stories > 0 then
    UIButtons.SetActive(SCUI.name_to_id.facebook_legal, true)
  else
    UIButtons.SetActive(SCUI.name_to_id.facebook_legal, false)
    UIButtons.TimeLineActive("no_stories", true, 0)
  end
  UIButtons.ChangeText(GUI.ids[1].story_title, "GAME_FACEBOOK_STORY_NAME" .. 0)
  UIButtons.ChangeText(GUI.ids[1].story_caption, "GAME_FACEBOOK_STORY_CAPTION" .. 0)
  UIButtons.ChangeText(GUI.ids[1].story_description, "GAME_FACEBOOK_STORY_DESCRIPTION" .. 0)
  if IsNumber((UIButtons.GetStaticTextHeight(GUI.textbox_id))) == true and UIButtons.GetStaticTextHeight(GUI.textbox_id) + 1.25 > UIButtons.GetSize(GUI.ids[1].message_box) then
    UIButtons.ChangeSize(GUI.textbox_id, UIButtons.GetSize(GUI.textbox_id))
    UIButtons.ChangeSize(GUI.ids[1].message_box, UIButtons.GetSize(GUI.ids[1].message_box))
    UIButtons.ChangeSize(GUI.ids[1].message_box2, UIButtons.GetSize(GUI.ids[1].message_box) - 0.25, UIButtons.GetStaticTextHeight(GUI.textbox_id) + 1.25 - 0.25, UIButtons.GetSize(GUI.ids[1].message_box))
  end
end
function SendStory()
  Amax.PublishFacebookStory(UIGlobals.CurrentFacebookStory)
end
function DeleteStory()
  caro_GUI.save_on_exit = true
  Amax.ClearFacebookStory(UIGlobals.CurrentFacebookStory)
  caro_GUI.refresh_screen = true
end
function Facebook_AddMessageNode()
  GUI.ids[#GUI.ids + 1] = {
    message = SCUI.name_to_id.message,
    story_image = SCUI.name_to_id.story_image,
    story_title = SCUI.name_to_id.story_title,
    story_caption = SCUI.name_to_id.story_caption,
    story_description = SCUI.name_to_id.story_description,
    message_box = SCUI.name_to_id.message_box,
    message_box2 = SCUI.name_to_id.message_box2
  }
end
function Facebook_EnableTextBox(_ARG_0_)
  UIButtons.SetSelected(GUI.textbox_id, _ARG_0_)
  UIButtons.SetTextInputActive(GUI.textbox_id, _ARG_0_)
end
function Facebook_TextBoxActive(_ARG_0_)
  return UIButtons.GetTextInputActive(GUI.textbox_id)
end
