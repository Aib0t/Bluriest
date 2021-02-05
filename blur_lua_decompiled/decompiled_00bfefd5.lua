GUI = {
  finished = false,
  net_global_update_enabled = false,
  first_save = false,
  textId = -1,
  is_multiplayer = false,
  done_info_lines = false,
  upload_finished = true,
  local_finished = false,
  local_error = 0,
  upload_result = false
}
function Init()
  UIGlobals.AsyncSave_FailMessageActive = nil
  AddSCUI_Elements()
  GUI.is_multiplayer = Amax.IsGameModeOnline()
  GUI.default_box_height = UIButtons.GetSize(SCUI.name_to_id.box)
  UIScreen.SetScreenTimers(0, 0)
  GUI.net_global_update_enabled = UIGlobals.Network.GlobalUpdateEnabled
  net_EnableGlobalUpdate(false)
  GUI.timer = 0
  GUI.errorStarting = false
  GUI.errorSaving = false
  GUI.saving = false
  GUI.finishedSaving = false
  GUI.finishedText = UIText.CMN_NOWT
  GUI.noStorageDevice = false
  GUI.noFreeSpace = false
  GUI.deleting = false
  GUI.fileExists = false
  GUI.userCancelled = false
  GUI.finishedSuccess = false
  print("save index - ", UIGlobals.ProfileSaveIndex)
end
function PostInit()
  GUI.textId = SCUI.name_to_id.text
  GUI.first_save = UIScreen.GetCurrentScreen() == "intro\\startscreen.lua"
  if GUI.first_save == false then
    UIButtons.SetActive(SCUI.name_to_id.black, true)
  end
  GUI.bleep_bleep_id = AddTransmitter(30, 0, 35, 35, UIEnums.Panel._3DAA_1, 5, false, true)
  UIButtons.SetParent(GUI.bleep_bleep_id, SCUI.name_to_id.box, UIEnums.Justify.MiddleRight)
  StartSave()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if GUI.finished == true or GUI.saving == true then
    return
  end
  if GUI.errorStarting == true or GUI.errorSaving == true then
    if _ARG_0_ == UIEnums.Message.MenuBack then
      AsyncSave_FinishedSaving()
    end
    return
  end
  if GUI.userCancelled == true then
    if _ARG_0_ == UIEnums.Message.MenuNext then
      StartSave(true)
      return
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      AsyncSave_ChangeText(UIText.CMN_NOWT)
      AsyncSave_SetupInfoLine(UIText.CMN_NOWT)
      AsyncSave_FinishedSaving()
      return
    end
  end
  if GUI.fileExists == true then
    if _ARG_0_ == UIEnums.Message.MenuNext then
      GoScreen("Profile\\AsyncSave.lua")
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      AsyncSave_ChangeText(UIText.CMN_NOWT)
      AsyncSave_SetupInfoLine(UIText.CMN_NOWT)
      AsyncSave_FinishedSaving()
    end
    return
  end
  if GUI.noStorageDevice == true then
    if _ARG_0_ == UIEnums.Message.MenuNext then
      UIHardware.FindXbox360SaveLocation(UIGlobals.ProfileSaveIndex, 0, UIEnums.XboxDeviceSelector.ForceUI)
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      UIGlobals.DoNotSave[UIGlobals.ProfileSaveIndex] = true
      AsyncSave_FinishedSaving()
    elseif _ARG_0_ == UIEnums.Message.SaveLocationFound then
      Profile.StoreDeviceId(UIGlobals.ProfileSaveIndex)
      UIGlobals.DoNotSave[UIGlobals.ProfileSaveIndex] = false
      GoScreen("Profile\\AsyncSave.lua")
      UIButtons.TimeLineActive("save_on", false)
    end
    return
  end
  if GUI.noFreeSpace == true then
    if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
      if _ARG_0_ == UIEnums.Message.MenuNext then
        UIHardware.FindXbox360SaveLocation(UIGlobals.ProfileSaveIndex, Profile.GetCurrentSaveSize(), UIEnums.XboxDeviceSelector.ForceUI)
      elseif _ARG_0_ == UIEnums.Message.MenuBack then
        UIGlobals.DoNotSave[UIGlobals.ProfileSaveIndex] = true
        AsyncSave_FinishedSaving()
      elseif _ARG_0_ == UIEnums.Message.SaveLocationFound then
        Profile.StoreDeviceId(UIGlobals.ProfileSaveIndex)
        UIGlobals.DoNotSave[UIGlobals.ProfileSaveIndex] = false
        GoScreen("Profile\\AsyncSave.lua")
        UIButtons.TimeLineActive("save_on", false)
      end
      return
    elseif UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
      if _ARG_0_ == UIEnums.Message.ButtonX then
        GUI.deleting = true
        Profile.StartAsyncDelete(UIGlobals.ProfileSaveIndex, true)
      elseif _ARG_0_ == UIEnums.Message.MenuNext then
        GoScreen("Profile\\AsyncSave.lua")
      elseif _ARG_0_ == UIEnums.Message.MenuBack then
        UIGlobals.DoNotSave[UIGlobals.ProfileSaveIndex] = true
        AsyncSave_FinishedSaving()
      end
      return
    else
      if _ARG_0_ == UIEnums.Message.MenuBack then
        AsyncSave_FinishedSaving()
      end
      return
    end
  end
end
function FrameUpdate(_ARG_0_)
  GUI.timer = GUI.timer + _ARG_0_
  if GUI.saving == true then
    if GUI.upload_finished == false then
      GUI.upload_result = NetServices.ContinueProfileUpload()
      GUI.upload_finished = GUI.upload_result ~= UIEnums.StorageWriterState.InProgress
    end
    if GUI.local_finished == false then
      GUI.local_finished, GUI.local_error = Profile.ContinueAsyncSave()
    end
    if GUI.local_finished == true and GUI.upload_finished == true then
      print("FINISHED SAVING")
      print("local_error", GUI.local_error, "upload_result", GUI.upload_result)
      if GUI.local_error == UIEnums.ProfileError.Okay then
        GUI.saving = false
        GUI.finishedSaving = true
        GUI.finishedText = UIText.PRO_SAVE_COMPLETE
        GUI.finishedSuccess = true
      elseif GUI.local_error == UIEnums.ProfileError.DeviceNotConnected then
        GUI.saving = false
        GUI.noStorageDevice = true
        AsyncSave_ChangeText(UIText.PRO_DEVICE_REMOVED_SAVE)
        AsyncSave_SetupInfoLine(UIText.INFO_CHOOSE_STORAGE_A, UIText.INFO_CONTINUE_B)
        TransmitterOff(GUI.bleep_bleep_id)
      elseif GUI.local_error == UIEnums.ProfileError.NoFreeSpace then
        GUI.saving = false
        GUI.noFreeSpace = true
        AsyncSave_ChangeText(UIText.PRO_NO_SPACE)
        AsyncSave_SetupInfoLine(UIText.INFO_CONTINUE_B)
        TransmitterOff(GUI.bleep_bleep_id)
        if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
          AsyncSave_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileSaveIndex .. "_NO_SPACE")
          AsyncSave_SetupInfoLine(UIText.INFO_CHOOSE_STORAGE_A, UIText.INFO_CONTINUE_B)
        elseif UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
          AsyncSave_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileSaveIndex .. "_NO_SPACE_PS3")
          AsyncSave_SetupInfoLine(UIText.INFO_TRY_AGAIN_A, UIText.INFO_CONTINUE_B, UIText.INFO_FREE_SPACE_X)
        end
      elseif GUI.local_error == UIEnums.ProfileError.FileExists then
        GUI.saving = false
        GUI.fileExists = true
        AsyncSave_ChangeText(UIText.PRO_SAVE_FILE_EXISTS)
        AsyncSave_SetupInfoLine(UIText.INFO_YES_A, UIText.INFO_NO_B)
        TransmitterOff(GUI.bleep_bleep_id)
      elseif GUI.local_error == UIEnums.ProfileError.UserCancelled then
        if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
          GUI.saving = false
          GUI.userCancelled = true
          AsyncSave_ChangeText(UIText.PRO_SAVE_USER_CANCELLED)
          AsyncSave_SetupInfoLine(UIText.INFO_YES_A, UIText.INFO_NO_B)
          TransmitterOff(GUI.bleep_bleep_id)
        else
          print("*****")
          print("ERROR: UIEnums.ProfileError.UserCancelled - got here not on PS3")
          print("*****")
        end
      else
        print("ERROR saving!")
        AsyncSave_ChangeText(UIText.PRO_SAVE_ERROR)
        AsyncSave_SetupInfoLine(UIText.INFO_CONTINUE_B)
        GUI.errorSaving = true
        GUI.saving = false
        TransmitterOff(GUI.bleep_bleep_id)
      end
      if GUI.local_error ~= UIEnums.ProfileError.Okay then
        UIButtons.SetActive(SCUI.name_to_id.saving_icon, false)
      end
    end
  end
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 and GUI.deleting == true and Profile.ContinueAsyncDelete() == true then
    GUI.deleting = false
  end
  if GUI.finishedSaving == true and GUI.timer >= 3 then
    TransmitterOff(GUI.bleep_bleep_id)
    UIGlobals.FileParams.FinishedSuccess = GUI.finishedSuccess
    AsyncSave_FinishedSaving()
    print("save time - ", GUI.timer)
  end
end
function EnterEnd()
  if UIGlobals.AsyncSave_FailMessageActive == true and UIScreen.IsPopupActive() == false then
    UIButtons.TimeLineActive("Popup_Active", false)
    UIGlobals.AsyncSave_FailMessageActive = nil
  end
  if GUI.done_info_lines == true then
    RestoreInfoLine_F()
    InfoLineUnlock(true)
  end
  UIButtons.TimeLineActive("show_save_box", false)
end
function EndLoop(_ARG_0_)
end
function End()
end
function AsyncSave_FinishedSaving()
  print("finished saving")
  if IsNumber(UIGlobals.FileParams.FinishedMessage) == true then
    Amax.SendMessage(UIGlobals.FileParams.FinishedMessage)
  end
  net_EnableGlobalUpdate(GUI.net_global_update_enabled)
  AsyncSave_Finished()
end
function AsyncSave_Finished()
  if GUI.upload_result ~= UIEnums.StorageWriterState.Successful and UserKickBackActive() == false then
    ReturnToStartScreen(UIEnums.UserKickBackMode.ProfileUploadFailed)
  end
  GoScreen(GetStoredScreen(UIEnums.ScreenStorage.SAVE_NEXT))
  if UIGlobals.FileParams.FinishedSuccess ~= true then
    UIGlobals.FileParams.FinishedSuccess = false
  end
  UIButtons.TimeLineActive("save_on", false)
end
function StartSave(_ARG_0_)
  GUI.upload_finished = true
  GUI.local_finished = false
  GUI.local_error = 0
  GUI.upload_result = UIEnums.StorageWriterState.Successful
  UIGlobals.FileParams.SetInterface(false)
  if _ARG_0_ == true then
    AsyncSave_ChangeText(UIText.PRO_SAVING)
    AsyncSave_SetupInfoLine()
    TransmitterOn(GUI.bleep_bleep_id)
  else
    UIButtons.SetActive(SCUI.name_to_id.saving_icon, true)
  end
  if Profile.StartAsyncSave(UIGlobals.ProfileSaveIndex) == false then
    print("ERROR starting the save thread, bailing out")
    GUI.errorStarting = true
    AsyncSave_ChangeText(UIText.PRO_SAVE_ERROR)
    AsyncSave_SetupInfoLine(UIText.INFO_CONTINUE_B)
    UIButtons.SetActive(SCUI.name_to_id.saving_icon, false)
  else
    if GUI.is_multiplayer == true then
      print("AsyncSave - Uploading Multiplayer Profile")
      GUI.upload_result = NetServices.StartProfileUpload()
      if GUI.upload_result ~= UIEnums.StorageWriterState.InProgress then
        GUI.upload_finished = true
      else
        GUI.upload_finished = false
      end
    end
    GUI.saving = true
  end
end
function AsyncSave_ChangeText(_ARG_0_)
  UIButtons.ChangeText(GUI.textId, _ARG_0_)
  UIGlobals.AsyncSave_FailMessageActive = true
  UIButtons.TimeLineActive("Popup_Active", true)
  UIButtons.ChangeSize(SCUI.name_to_id.box, UIButtons.GetSize(SCUI.name_to_id.box))
  UIButtons.ChangeSize(SCUI.name_to_id.box_inner, UIButtons.GetSize(SCUI.name_to_id.box))
  UIScreen.SetScreenTimers(0, 0.3)
  UIButtons.TimeLineActive("show_save_box", true)
  UIScreen.BlockInputToContext(true)
  UISystem.PlaySound(UIEnums.SoundEffect.GraphicTextBox)
end
function AsyncSave_SetupInfoLine(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_ == nil then
    _ARG_0_ = UIText.CMN_NOWT
  end
  if _ARG_1_ == nil then
    _ARG_1_ = UIText.CMN_NOWT
  end
  if _ARG_2_ == nil then
    _ARG_2_ = UIText.CMN_NOWT
  end
  UIButtons.ChangeText(SCUI.name_to_id.info_1, _ARG_0_)
  UIButtons.ChangeText(SCUI.name_to_id.info_2, _ARG_1_)
  UIButtons.ChangeText(SCUI.name_to_id.info_3, _ARG_2_)
  if GUI.done_info_lines == false then
    GUI.done_info_lines = true
    InfoLineLock()
    StoreInfoLine_F()
    SetupInfoLine_F()
  end
end
