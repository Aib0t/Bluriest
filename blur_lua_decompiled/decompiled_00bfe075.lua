GUI = {
  finished = false,
  delay_time = 1.5,
  textId = -1,
  success = false,
  net_global_update_enabled = false
}
function Init()
  AddSCUI_Elements()
  InfoLineLock()
  StoreInfoLine_F()
  SetupInfoLine_F()
  UISystem.PlaySound(UIEnums.SoundEffect.GraphicTextBox)
  GUI.default_box_height = UIButtons.GetSize(SCUI.name_to_id.box)
  GUI.net_global_update_enabled = UIGlobals.Network.GlobalUpdateEnabled
  net_EnableGlobalUpdate(false)
  UIScreen.SetScreenTimers(0.3, 0.3, UIScreen.Context())
  GUI.textId = SCUI.name_to_id.text
  GUI.blaggedAProfile = false
  GUI.foundProfileToLoad = false
  GUI.finishedLookingForProfiles = false
  GUI.checkForDevice = false
  GUI.loading = false
  GUI.allowPadInput = false
  GUI.allowSaveLocationChange = false
  GUI.enoughFreeSpace = true
  GUI.freeSpaceAmount = 1048576
  GUI.profileReturnCode = UIEnums.ProfileError.Okay
  GUI.allowProfileOverwrite = false
  GUI.deleting = false
  GUI.errorWhenDeleting = false
  GUI.timer = 0
  AsyncLoad_ChangeText(UIText.IDS_CMN_NOWT)
  UIGlobals.FileParams.SetInterface(true)
  Profile.ActOnProfileChanges(true)
  for _FORV_6_ = 0, 3 do
    UIGlobals.ProfileLookingFor = _FORV_6_
    print("UIGlobals.ProfileLookingFor", UIGlobals.ProfileLookingFor)
    if Profile.PadProfileActive(_FORV_6_) == true then
      print("found profile on ", UIGlobals.ProfileLookingFor)
      Profile.Setup(_FORV_6_)
      GameProfile.ClearGameProfile(_FORV_6_)
      UIGlobals.ProfilesFound = UIGlobals.ProfilesFound + 1
      UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = false
      UIGlobals.ProfileState[_FORV_6_] = UIEnums.Profile.GamerProfile
      if _FORV_6_ ~= UIGlobals.ProfilePressedStart then
        print("pre load on slot " .. _FORV_6_)
        UIGlobals.ProfileState[_FORV_6_] = UIEnums.Profile.PreLoad
      end
      if UIGlobals.ProfileState[_FORV_6_] == UIEnums.Profile.GamerProfile then
        GUI.foundProfileToLoad = true
      end
    elseif UIGlobals.ProfileLookingFor == UIGlobals.ProfilePressedStart then
      print("blagged profile for slot ", UIGlobals.ProfilePressedStart)
      Profile.Setup(UIGlobals.ProfilePressedStart, true)
      GameProfile.ClearGameProfile(UIGlobals.ProfilePressedStart)
      UIGlobals.ProfilesFound = UIGlobals.ProfilesFound + 1
      UIGlobals.ProfileState[_FORV_6_] = UIEnums.Profile.Blagged
      GUI.blaggedAProfile = true
    else
      UIGlobals.ProfileState[_FORV_6_] = UIEnums.Profile.None
      UIGlobals.ProfileDevice[_FORV_6_] = -1
    end
  end
  _FOR_.checkForDevice = true
  if GUI.foundProfileToLoad == false and GUI.blaggedAProfile == false then
    GUI.finishedLookingForProfiles = true
    GUI.checkForDevice = false
  end
  if GUI.blaggedAProfile == true then
    GUI.checkForDevice = false
    GUI.allowPadInput = true
    AsyncLoad_ChangeText("PROFILE_PAD" .. UIGlobals.ProfilePressedStart .. "_BLAGGED")
    AsyncLoad_SetupInfoLine(UIText.INFO_A_NEXT)
  else
    Amax.InitialiseAdverts()
  end
  UIGlobals.ProfileLookingFor = UIGlobals.ProfilePressedStart
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if GUI.finished == true or GUI.loading == true or GUI.deleting == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.SaveLocationNotFound then
    GUI.allowPadInput = true
    GUI.allowSaveLocationChange = true
    UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = true
    AsyncLoad_ChangeText(UIText.PRO_NO_STORAGE_DEVICE)
    AsyncLoad_SetupInfoLine(UIText.INFO_CHOOSE_STORAGE_A, UIText.INFO_CONTINUE_B)
    return
  end
  if _ARG_0_ == UIEnums.Message.SaveLocationFound then
    GUI.allowPadInput = false
    GUI.allowSaveLocationChange = false
    GUI.enoughFreeSpace = true
    UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = false
    AsyncLoad_ChangeText(UIText.PRO_LOADING)
    AsyncLoad_SetupInfoLine()
    print("start async load")
    GUI.loading = true
    Profile.StartAsyncLoad(UIGlobals.ProfileLookingFor)
    UIButtons.TimeLineActive("auto_save_warning_on", true, 0)
    UIButtons.PrivateTimeLineActive(UIGlobals.boot_bottom_help_id, "Hide_BottomHelp", false)
    GUI.timer = 0
    return
  end
  if GUI.allowPadInput == false then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext or getMouseButton(_ARG_0_, UIScreen.Context(), _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    PlaySfxNext()
    if GUI.allowSaveLocationChange == true then
      if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
        UIHardware.FindXbox360SaveLocation(UIGlobals.ProfileLookingFor, 0, UIEnums.XboxDeviceSelector.ForceUI)
      end
      return
    end
    if GUI.allowProfileOverwrite == true then
      GUI.deleting = true
      Profile.StartAsyncDelete(UIGlobals.ProfileLookingFor)
      GUI.allowPadInput = false
      return
    end
    if GUI.blaggedAProfile == true then
      Finished()
      return
    end
    if GUI.errorWhenDeleting == true then
      return
    end
    if GUI.profileReturnCode == UIEnums.ProfileError.FileDoesNotExist then
      if GUI.enoughFreeSpace == false then
        UIHardware.FindXbox360SaveLocation(UIGlobals.ProfileLookingFor, GUI.freeSpaceAmount, UIEnums.XboxDeviceSelector.ForceUI)
        return
      else
        StoreScreen(UIEnums.ScreenStorage.SAVE_NEXT, GetStoredScreen(UIEnums.ScreenStorage.LOAD_NEXT))
        UIGlobals.ProfileSaveIndex = UIGlobals.ProfileLookingFor
        GoScreen("Profile\\AsyncSave.lua")
        GUI.success = nil
        return
      end
    else
      Finished()
      return
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack or getMouseButton(_ARG_0_, UIScreen.Context(), _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    if GUI.allowSaveLocationChange == true or GUI.enoughFreeSpace == false then
      Finished()
      return
    end
    if GUI.allowProfileOverwrite == true or GUI.errorWhenDeleting == true then
      if UIEnums.CurrentPlatform ~= UIEnums.Platform.PS3 then
        UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = true
        UIGlobals.LoadProfile[UIGlobals.ProfileLookingFor] = false
        Finished()
      end
      return
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.checkForDevice == true then
    print("check for storage device")
    if Profile.GuideActive() == false then
      if GUI.foundProfileToLoad == true then
        if UIEnums.CurrentPlatform == UIEnums.Platform.PC or UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
          UIScreen.AddMessage(UIEnums.Message.SaveLocationFound)
        else
          UIHardware.FindXbox360SaveLocation(UIGlobals.ProfileLookingFor, 0)
        end
      elseif GUI.blaggedAProfile == false and UIGlobals.ProfileLookingFor >= 3 then
        GUI.finishedLookingForProfiles = true
      end
      GUI.checkForDevice = false
    end
  end
  if GUI.loading == true then
    GUI.timer = GUI.timer + _ARG_0_
    if Profile.ContinueAsyncLoad() == true and GUI.timer > GUI.delay_time then
      GUI.profileReturnCode = Profile.ContinueAsyncLoad()
      GUI.loading = false
      GUI.allowPadInput = true
      print("FINISHED LOAD", Profile.ContinueAsyncLoad())
      if Profile.ContinueAsyncLoad() == UIEnums.ProfileError.Okay then
        UIGlobals.LoadProfile[UIGlobals.ProfileLookingFor] = false
        UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = false
        GUI.success = true
        Finished()
      elseif Profile.ContinueAsyncLoad() == UIEnums.ProfileError.FileDoesNotExist then
        if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
          if UIHardware.SpaceLeftOnDevice() == false then
            GUI.profileReturnCode = UIEnums.ProfileError.DeviceNotConnected
            GUI.allowSaveLocationChange = true
            UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = true
            AsyncLoad_ChangeText(UIText.PRO_DEVICE_REMOVED_LOAD)
            AsyncLoad_SetupInfoLine(UIText.INFO_CHOOSE_STORAGE_A, UIText.INFO_CONTINUE_B)
          elseif UIHardware.SpaceLeftOnDevice() < GUI.freeSpaceAmount then
            GUI.enoughFreeSpace = false
            UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = true
            AsyncLoad_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileLookingFor .. "_NO_SPACE")
            AsyncLoad_SetupInfoLine(UIText.INFO_CHOOSE_STORAGE_A, UIText.INFO_CONTINUE_B)
          else
            UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = false
            Profile.Setup(UIGlobals.ProfileLookingFor)
            GameProfile.ClearGameProfile(UIGlobals.ProfileLookingFor)
            AsyncLoad_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileLookingFor .. "_CREATED")
            AsyncLoad_SetupInfoLine(UIText.INFO_A_NEXT)
          end
        else
          UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = false
          Profile.Setup(UIGlobals.ProfileLookingFor)
          GameProfile.ClearGameProfile(UIGlobals.ProfileLookingFor)
          AsyncLoad_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileLookingFor .. "_CREATED")
          AsyncLoad_SetupInfoLine(UIText.INFO_A_NEXT)
        end
      elseif Profile.ContinueAsyncLoad() == UIEnums.ProfileError.CannotReadFile then
        GUI.allowProfileOverwrite = true
        UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = true
        AsyncLoad_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileLookingFor .. "_CORRUPT")
        if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
          AsyncLoad_SetupInfoLine(UIText.INFO_DELETE_A)
        else
          AsyncLoad_SetupInfoLine(UIText.INFO_OVERWRITE_A, UIText.INFO_CONTINUE_B)
        end
      elseif Profile.ContinueAsyncLoad() == UIEnums.ProfileError.DeviceNotConnected then
        GUI.allowSaveLocationChange = true
        UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = true
        AsyncLoad_ChangeText(UIText.PRO_DEVICE_REMOVED_LOAD)
        AsyncLoad_SetupInfoLine(UIText.INFO_CHOOSE_STORAGE_A, UIText.INFO_CONTINUE_B)
      elseif Profile.ContinueAsyncLoad() == UIEnums.ProfileError.DifferentOwner then
        GUI.allowProfileOverwrite = true
        UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = true
        AsyncLoad_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileLookingFor .. "_DIFFERENT_OWNER")
        AsyncLoad_SetupInfoLine(UIText.INFO_DELETE_A)
      end
    end
  end
  if GUI.deleting == true and Profile.ContinueAsyncDelete() == true then
    GUI.deleting = false
    GUI.allowPadInput = true
    print("FINISHED DELETION")
    if Profile.ContinueAsyncDelete() == UIEnums.ProfileError.Okay then
      Profile.Setup(UIGlobals.ProfileLookingFor)
      GameProfile.ClearGameProfile(UIGlobals.ProfileLookingFor)
      UIGlobals.LoadProfile[UIGlobals.ProfileLookingFor] = false
      UIGlobals.DoNotSave[UIGlobals.ProfileLookingFor] = false
      StoreScreen(UIEnums.ScreenStorage.SAVE_NEXT, GetStoredScreen(UIEnums.ScreenStorage.LOAD_NEXT))
      UIGlobals.ProfileSaveIndex = UIGlobals.ProfileLookingFor
      GoScreen("Profile\\AsyncSave.lua")
      GUI.success = nil
    elseif Profile.ContinueAsyncDelete() == UIEnums.ProfileError.CannotDeleteFile then
      GUI.errorWhenDeleting = true
      AsyncLoad_ChangeText("PROFILE_PAD" .. UIGlobals.ProfileLookingFor .. "_DELETE_FAILED")
      AsyncLoad_SetupInfoLine(UIText.INFO_CONTINUE_B)
    end
  end
  if GUI.finishedLookingForProfiles == true then
    Finished()
  end
end
function EnterEnd()
  RestoreInfoLine_F()
  InfoLineUnlock(true)
end
function EndLoop(_ARG_0_)
end
function End()
  UIGlobals.FileParams.FinishedSuccess = GUI.success
end
function Finished()
  if IsNumber(UIGlobals.FileParams.FinishedMessage) == true then
    Amax.SendMessage(UIGlobals.FileParams.FinishedMessage)
  end
  Amax.Options(nil)
  SinglePlayer.ProcessUnlocks()
  SinglePlayer.ClearUnlocks()
  net_EnableGlobalUpdate(GUI.net_global_update_enabled)
  UIGlobals.LoadProfile[UIGlobals.ProfileLookingFor] = false
  GoScreen(GetStoredScreen(UIEnums.ScreenStorage.LOAD_NEXT))
end
function AsyncLoad_ChangeText(_ARG_0_)
  UIButtons.ChangeText(GUI.textId, _ARG_0_)
  UIButtons.ChangeSize(SCUI.name_to_id.box, UIButtons.GetSize(SCUI.name_to_id.box))
  UIButtons.ChangeSize(SCUI.name_to_id.box_inner, UIButtons.GetSize(SCUI.name_to_id.box))
end
function AsyncLoad_SetupInfoLine(_ARG_0_, _ARG_1_)
  if _ARG_0_ == nil then
    _ARG_0_ = UIText.CMN_NOWT
  end
  if _ARG_1_ == nil then
    _ARG_1_ = UIText.CMN_NOWT
  end
  UIButtons.ChangeText(SCUI.name_to_id.info_1, _ARG_0_)
  UIButtons.ChangeText(SCUI.name_to_id.info_2, _ARG_1_)
end
