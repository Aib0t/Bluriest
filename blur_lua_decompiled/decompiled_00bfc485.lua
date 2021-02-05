GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  spinner_id = -1,
  can_save = false,
  is_online = false,
  should_unhide_enumerate_screen = true
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_2", UIGlobals.CameraLerpTime, 0)
  UIButtons.TimeLineActive("Hide_LightPaint", true)
  StoreInfoLine()
  if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
  end
  if Amax.CanUseShare() == true and Amax.CanViewUserContent() == true and not NetServices.UserHasAgeRestriction() == true and Amax.FacebookHasPublisherFile() == true then
    SetupInfoLine(UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
  else
    SetupInfoLine(UIText.INFO_B_BACK)
  end
  GUI.spinner_id = SCUI.name_to_id.uploading_spinner
  GUI.can_save = CanSave(Profile.GetPrimaryPad(), true) == true
end
function PostInit()
  UIButtons.TimeLineActive("hide_asyncenumerate", true)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if GUI.finished == true then
    return
  end
  if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
  end
  if _ARG_0_ == UIEnums.Message.MenuBack then
    GUI.should_unhide_enumerate_screen = true
    PlaySfxBack()
    PopScreen()
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
    if Amax.CanUseShare() == true and Amax.CanViewUserContent() == true and not NetServices.UserHasAgeRestriction() == true and Amax.FacebookHasPublisherFile() == true then
      SetupCustomPopup(UIEnums.CustomPopups.OnlinePhotoSharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.OnlinePhotoSharingOptions then
    if _ARG_3_ == UIEnums.ShareOptions.FacebookAlbum then
      if Amax.CanUseShare() == true and Amax.CanViewUserContent() == true and not NetServices.UserHasAgeRestriction() == true then
        UIHardware.StartKeyboard(_ARG_1_, UIText.RBC_MY_PHOTO, UIText.RBC_FACEBOOK_KEYB_HEADER, UIText.RBC_FACEBOOK_KEYB_PHOTO_UPLOAD_HEADER, 128, UIEnums.XboxKeyboardType.StandardHighlight)
      end
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      PushScreen("Photos\\ChoosePhotoSlot.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.KeyboardFinished and UIScreen.IsContextActive(UIScreen.Context()) then
    SetupCustomPopup(UIEnums.CustomPopups.UploadPhotoToFacebook)
  end
end
function FrameUpdate(_ARG_0_)
end
function Render()
end
function EnterEnd()
  if GUI.should_unhide_enumerate_screen == true then
    UIButtons.TimeLineActive("hide_asyncenumerate", false)
    UIButtons.TimeLineActive("Hide_LightPaint", false)
  end
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
end
