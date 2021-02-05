GUI = {
  finished = false,
  carousel_branch = "Photos",
  textId = -1,
  ids = {},
  node_list_id = -1,
  num_items = 200,
  enumeration_indices = {},
  preview_title = -1,
  total_photos = -1,
  photo_count = 0,
  photo_preview = {},
  Current_Selection = -1,
  wait_time = 0.25,
  wait_timer = 0.25,
  waiting = true,
  can_view_fullscreen = false,
  can_select_nodelist = true,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  net_LockoutFriendsOverlay(true)
  Amax.ChangeUiCamera("Sp_2", UIGlobals.CameraLerpTime, 0)
  CarouselApp_SetScreenTimers()
  net_SetRichPresence(UIEnums.RichPresence.Photos)
  GUI.textId = SCUI.name_to_id.text
  GUI.node_list_id = SCUI.name_to_id.node_list
  GUI.enumerating = false
  GUI.profileReturnCode = UIEnums.ProfileError.Okay
  GUI.allowSaveLocationChange = false
  GUI.errorWhenEnumerating = false
  GUI.allowLoad = false
  GUI.loading = false
  GUI.corruptData = false
  GUI.userCancelled = false
  StoreInfoLine()
  SetupInfoLine()
  GUI.default_box_height = UIButtons.GetSize(SCUI.name_to_id.box)
  GUI.font_style = UIButtons.GetXtVar(SCUI.name_to_id.text, "styles.name")
  GUI.font_height = UIButtons.GetSize(SCUI.name_to_id.text)
  GUI.font_width = UIButtons.GetSize(SCUI.name_to_id.text)
end
function PostInit()
  UIButtons.TimeLineActive("Hide_Carousel", true)
  for _FORV_3_ = 1, GUI.num_items do
    UIButtons.AddListItem(GUI.node_list_id, UIButtons.CloneXtGadgetByName("Profile\\AsyncEnumerate.lua", "_node"), _FORV_3_)
    GUI.ids[#GUI.ids + 1] = {
      node = UIButtons.CloneXtGadgetByName("Profile\\AsyncEnumerate.lua", "_node"),
      text = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Profile\\AsyncEnumerate.lua", "_node"), "_text"),
      image = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Profile\\AsyncEnumerate.lua", "_node"), "_preview")
    }
  end
  SetupScreenTitle(UIText.RBU_PHOTO_LOCAL_PHOTOS_PAGE_TITLE, SCUI.name_to_id.screen, "Local_Photos", "fe_icons")
  GUI.photo_preview = {
    node = SCUI.name_to_id.photo_preview_dummy,
    background = UIButtons.FindChildByName(SCUI.name_to_id.photo_preview_dummy, "background"),
    bottom_text = UIButtons.FindChildByName(SCUI.name_to_id.photo_preview_dummy, "bottom_bar_text"),
    top_text = UIButtons.FindChildByName(SCUI.name_to_id.photo_preview_dummy, "top_bar_text")
  }
  GUI.bottom_text_id = SetupBottomHelpBar(UIText.HLP_PHOTO, SCUI.name_to_id.screen)
  UIButtons.SetParent(SCUI.name_to_id.node_list_dummy, GUI.photo_preview.background, UIEnums.Justify.MiddleCentre)
  StartEnumeration()
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
    UIButtons.SetSelected(GUI.node_list_id, false)
    GUI.can_select_nodelist = false
    UIButtons.SetActive(SCUI.name_to_id.Right_Arrow, false)
    UIButtons.SetActive(SCUI.name_to_id.Left_Arrow, false)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if GUI.finished == true or GUI.enumerating == true or GUI.loading == true or GUI.waiting_to_enumerate == true then
    return
  end
  if SubScreenActive() == true then
    if _ARG_0_ == UIEnums.Message.MenuBack and GUI.can_select_nodelist == true then
      UIButtons.SetSelected(GUI.node_list_id, true)
    end
    return
  end
  if _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.NoLocalPhotos then
    Amax.ChangeUiCamera(UIGlobals.CameraNames.SpCarousel, UIGlobals.CameraLerpTime, 0)
    UIButtons.TimeLineActive("Hide_Carousel", false)
    CloseCurrentApp(true)
    return
  end
  if _ARG_0_ == UIEnums.Message.SaveLocationNotFound then
    GUI.allowSaveLocationChange = true
    AsyncEnumerate_ChangeText(UIText.PRO_NO_STORAGE_DEVICE)
    return
  end
  if _ARG_0_ == UIEnums.Message.SaveLocationFound then
    GUI.allowSaveLocationChange = false
    Profile.StoreDeviceId(Profile.GetPrimaryPad())
    StartEnumeration()
    return
  end
  if GUI.userCancelled == true then
    if _ARG_0_ == UIEnums.Message.MenuNext then
      PlaySfxNext()
      StartEnumeration()
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      PlaySfxBack()
      AsyncEnumerate_Finished(true)
    end
    return
  end
  if GUI.errorWhenEnumerating == true then
    if _ARG_0_ == UIEnums.Message.MenuNext then
      GoScreen("Profile\\AsyncEnumerate.lua")
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      PlaySfxBack()
      AsyncEnumerate_Finished(true)
    end
    return
  end
  if GUI.allowSaveLocationChange == true then
    if _ARG_0_ == UIEnums.Message.MenuNext then
      if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
        UIHardware.FindXbox360SaveLocation(UIGlobals.ProfileEnumerateIndex, 0, UIEnums.XboxDeviceSelector.ForceUI)
      end
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      PlaySfxBack()
      AsyncEnumerate_Finished(true)
    end
    return
  end
  if GUI.corruptData == true then
    if _ARG_0_ == UIEnums.Message.MenuNext then
      GoScreen("Profile\\AsyncEnumerate.lua")
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      PlaySfxBack()
      AsyncEnumerate_Finished(true)
    end
    return
  end
  if GUI.can_view_fullscreen == true then
    if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
    end
    if _ARG_0_ == UIEnums.Message.MenuNext then
      PlaySfxNext()
      PushScreen("Photos\\ViewPhoto.lua")
      if GUI.can_select_nodelist == true then
        UIButtons.SetSelected(GUI.node_list_id, false)
      end
    elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
      if Amax.CanUseShare() == true and Amax.CanViewUserContent() == true and not NetServices.UserHasAgeRestriction() == true and Amax.FacebookHasPublisherFile() == true then
        SetupCustomPopup(UIEnums.CustomPopups.OnlinePhotoSharingOptions)
      end
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      PlaySfxBack()
      AsyncEnumerate_Finished(true)
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
    return
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.waiting_to_enumerate == true then
    if UIScreen.IsContextActive(UIEnums.Context.LoadSave) == false then
      GUI.waiting_to_enumerate = false
      StartEnumeration(GUI.waiting_to_enumerate_index)
    end
    return
  end
  if GUI.enumerating == true or GUI.loading == true then
    GUI.timer = GUI.timer + _ARG_0_
    if Profile.ContinueAsyncLoad() == true and GUI.timer > 0 then
      AsyncEnumerate_ChangeText(UIText.CMN_NOWT, true)
      if Profile.ContinueAsyncLoad() == UIEnums.ProfileError.Okay then
        UIButtons.TimeLineActive("Intro", false)
        if GUI.can_select_nodelist == true then
          UIButtons.SetSelected(GUI.node_list_id, true)
        end
        if GUI.enumerating == true then
          GUI.enumeration_indices = {}
          for _FORV_7_ = 1, Profile.GetEnumerationCount() do
            if Profile.IsValidEnumerationFileType(_FORV_7_) then
            end
          end
          _FOR_.photo_count = 0 + 1
          if 0 + 1 == 0 then
            SetupCustomPopup(UIEnums.CustomPopups.NoLocalPhotos)
            GUI.allowLoad = false
            SetupInfoLine()
          else
            for _FORV_8_ = 1, Profile.GetEnumerationCount() do
              if Profile.IsValidEnumerationFileType(_FORV_8_) then
                UIButtons.SetNodeItemLocked(GUI.node_list_id, 0 + 1 - 1, false)
                GUI.enumeration_indices[#GUI.enumeration_indices + 1] = _FORV_8_
              end
            end
            for _FORV_8_ = 0 + 1 + 1, #GUI.ids do
              UIButtons.SetNodeItemLocked(GUI.node_list_id, _FORV_8_ - 1, true)
            end
            if _FOR_.can_select_nodelist == true then
              UIButtons.SetSelection(GUI.node_list_id, 1)
            end
            GUI.allowLoad = true
            SetupInfoLine()
          end
        else
          AsyncEnumerate_SetupInfoLine()
          UIGlobals.FileParams.FinishedSuccess = true
          for _FORV_6_ = 1, #GUI.ids do
            UIButtons.ChangeTexture({filename = ""}, 0, GUI.ids[_FORV_6_].image)
          end
          _FOR_.ChangeTexture({filename = "PHOTOMODE"}, 0, GUI.ids[GUI.Current_Selection].image)
          UIButtons.TimeLineActive("Photo_Loaded", true, 0)
          GUI.can_view_fullscreen = true
          if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
          end
          if Amax.CanUseShare() == true and Amax.CanViewUserContent() == true and not NetServices.UserHasAgeRestriction() == true and Amax.FacebookHasPublisherFile() == true then
            SetupInfoLine(UIText.INFO_OPEN_A, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
          else
            SetupInfoLine(UIText.INFO_OPEN_A, UIText.INFO_B_BACK)
          end
        end
      elseif Profile.ContinueAsyncLoad() == UIEnums.ProfileError.DeviceNotConnected then
        GUI.allowSaveLocationChange = true
        AsyncEnumerate_SetupInfoLine(UIText.INFO_CHOOSE_STORAGE_A, UIText.INFO_CONTINUE_B)
        if GUI.enumerating == true then
          AsyncEnumerate_ChangeText(UIText.PRO_DEVICE_REMOVED_ENUMERATE)
        else
          AsyncEnumerate_ChangeText(UIText.PRO_DEVICE_REMOVED_LOAD)
        end
      elseif GUI.loading == true and Profile.ContinueAsyncLoad() == UIEnums.ProfileError.CannotReadFile then
        GUI.corruptData = true
        AsyncEnumerate_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileEnumerateIndex .. "_ENUMERATION_CORRUPT")
        AsyncEnumerate_SetupInfoLine(UIText.INFO_TRY_AGAIN_A, UIText.INFO_CONTINUE_B)
      elseif Profile.ContinueAsyncLoad() == UIEnums.ProfileError.UserCancelled then
        if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
          AsyncEnumerate_SetupInfoLine()
          AsyncEnumerate_Finished(true)
        else
          print("*****")
          print("ERROR: UIEnums.ProfileError.UserCancelled - got here not on PS3")
          print("*****")
        end
      else
        GUI.errorWhenEnumerating = true
        if GUI.enumerating == true then
          AsyncEnumerate_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileEnumerateIndex .. "_ENUMERATION_FAILED")
          AsyncEnumerate_SetupInfoLine(UIText.INFO_TRY_AGAIN_A, UIText.INFO_CONTINUE_B)
        else
          AsyncEnumerate_SetupInfoLine(UIText.INFO_SKIP_A)
          AsyncEnumerate_ChangeText(UIText.PRO_PHOTO_NOT_EXIST)
        end
      end
      if GUI.enumerating == true then
        GUI.enumerating = false
        print("FINISHED ENUMERATION")
      else
        GUI.loading = false
        print("FINISHED LOAD")
      end
    end
  end
  if UIButtons.GetSelectionIndex(SCUI.name_to_id.node_list) + 1 ~= GUI.Current_Selection then
    UIButtons.PrivateTimeLineActive(SCUI.name_to_id.Left_Arrow, "more", UIButtons.GetSelectionIndex(SCUI.name_to_id.node_list) + 1 ~= 1)
    UIButtons.PrivateTimeLineActive(SCUI.name_to_id.Left_Arrow, "push", UIButtons.GetSelectionIndex(SCUI.name_to_id.node_list) + 1 < GUI.Current_Selection, 0)
    UIButtons.PrivateTimeLineActive(SCUI.name_to_id.Right_Arrow, "more", UIButtons.GetSelectionIndex(SCUI.name_to_id.node_list) + 1 ~= GUI.photo_count)
    UIButtons.PrivateTimeLineActive(SCUI.name_to_id.Right_Arrow, "push", UIButtons.GetSelectionIndex(SCUI.name_to_id.node_list) + 1 > GUI.Current_Selection, 0)
    GUI.Current_Selection = UIButtons.GetSelectionIndex(SCUI.name_to_id.node_list) + 1
    GUI.waiting = true
    GUI.wait_timer = GUI.wait_time
    UIButtons.TimeLineActive("Photo_Loaded", false, 0)
    GUI.can_view_fullscreen = false
  end
  if GUI.waiting == true then
    GUI.wait_timer = GUI.wait_timer - _ARG_0_
  end
  if GUI.allowLoad == true and UIEnums.CurrentPlatform ~= UIEnums.Platform.PS3 and GUI.waiting == true and 0 >= GUI.wait_timer then
    GUI.waiting = false
    StartEnumeration(GUI.enumeration_indices[UIButtons.GetSelection(GUI.node_list_id)])
  end
  if GUI.enumerating == false and 0 < #GUI.ids and GUI.enumeration_indices[UIButtons.GetSelection(GUI.node_list_id)] ~= nil then
    UIButtons.ChangeText(GUI.photo_preview.top_text, "PROFILE_SAVE_ENUMERATION" .. GUI.enumeration_indices[UIButtons.GetSelection(GUI.node_list_id)])
    UIButtons.ChangeText(GUI.photo_preview.bottom_text, "SPL_PHOTOMODE_TOTAL_PHOTOS_" .. GUI.enumeration_indices[UIButtons.GetSelection(GUI.node_list_id)] .. "_" .. GUI.photo_count)
  end
end
function EndLoop(_ARG_0_)
end
function EnterEnd()
  RestoreInfoLine()
  PlaySfxGraphicBack()
end
function End()
  net_LockoutFriendsOverlay(false)
  net_SetRichPresence(UIEnums.RichPresence.SpMain)
end
function StartEnumeration(_ARG_0_)
  if UIScreen.IsContextActive(UIEnums.Context.LoadSave) == true then
    GUI.waiting_to_enumerate = true
    GUI.waiting_to_enumerate_index = _ARG_0_
    return
  end
  StartAsyncLoadPhotos()
  UIGlobals.FileParams.SetInterface(true, _ARG_0_)
  Profile.StartAsyncLoad(UIGlobals.ProfileEnumerateIndex)
  if _ARG_0_ == nil and UIEnums.CurrentPlatform ~= UIEnums.Platform.PS3 then
    print("enumerate")
    AsyncEnumerate_ChangeText(UIText.PRO_ENUMERATING_PHOTOS, true)
    GUI.enumerating = true
  else
    print("load")
    if UIEnums.CurrentPlatform ~= UIEnums.Platform.PS3 then
      AsyncEnumerate_ChangeText(UIText.PRO_LOADING, true)
    else
      UIButtons.TimeLineActive("Intro", false)
    end
    GUI.loading = true
  end
  AsyncEnumerate_SetupInfoLine()
  SetupInfoLine()
  UIButtons.SetSelected(GUI.node_list_id, false)
  GUI.timer = 0
  GUI.userCancelled = false
end
function AsyncEnumerate_Finished(_ARG_0_)
  if _ARG_0_ == nil then
    _ARG_0_ = false
  end
  print("FinishedMessage", UIGlobals.FileParams.FinishedMessage)
  if IsNumber(UIGlobals.FileParams.FinishedMessage) == true then
    Amax.SendMessage(UIGlobals.FileParams.FinishedMessage)
  end
  if UIGlobals.FileParams.FinishedSuccess ~= true then
    UIGlobals.FileParams.FinishedSuccess = false
  end
  if (UIGlobals.FileParams.FinishedSuccess == true and _ARG_0_ == false) == true then
    PushScreen(GetStoredScreen(UIEnums.ScreenStorage.SAVE_NEXT))
  else
    Amax.ChangeUiCamera(UIGlobals.CameraNames.SpCarousel, UIGlobals.CameraLerpTime, 0)
    UIButtons.TimeLineActive("Hide_Carousel", false)
    CloseCurrentApp()
  end
end
function AsyncEnumerate_ChangeText(_ARG_0_, _ARG_1_)
  if _ARG_1_ == true then
    UIButtons.ChangeText(SCUI.name_to_id.text_small, _ARG_0_)
  else
    UIButtons.ChangeText(GUI.textId, _ARG_0_)
    UIButtons.ChangeSize(SCUI.name_to_id.box, UIButtons.GetSize(SCUI.name_to_id.box))
    UIButtons.ChangeSize(SCUI.name_to_id.box_inner, UIButtons.GetSize(SCUI.name_to_id.box))
    UIButtons.TimeLineActive("Intro", true, 0)
  end
end
function AsyncEnumerate_SetupInfoLine(_ARG_0_, _ARG_1_)
  if _ARG_0_ == nil then
    _ARG_0_ = UIText.CMN_NOWT
  end
  if _ARG_1_ == nil then
    _ARG_1_ = UIText.CMN_NOWT
  end
  UIButtons.ChangeText(SCUI.name_to_id.info_1, _ARG_0_)
  UIButtons.ChangeText(SCUI.name_to_id.info_2, _ARG_1_)
end
