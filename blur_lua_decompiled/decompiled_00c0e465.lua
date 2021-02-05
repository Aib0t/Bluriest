GUI = {
  finished = false,
  carousel_branch = "Options",
  CanExit = function(_ARG_0_)
    if UIGlobals.SaveOptions == true then
      Amax.UpdateCustomKeyboardControls(UIGlobals.OptionsTable)
      Amax.Options(UIGlobals.OptionsTable)
      StartAsyncSave()
      UIGlobals.SaveOptions = nil
    end
    UIGlobals.OptionsTable = nil
    Amax.UpdateAudioOptions(Amax.Options())
    PlaySfxGraphicBack()
    return true
  end,
  fb_disconnecting_timer = 0
}
function Init()
  AddSCUI_Elements()
  if UIGlobals.IsIngame == false then
    Amax.ChangeUiCamera("Op_1", 0.6, 0)
  end
  CarouselApp_SetScreenTimers()
  if IsTable(UIGlobals.OptionsTable) == false then
    UIGlobals.OptionsTable = Amax.Options()
    UIGlobals.OptionsTable.IsCustom = Amax.UpdateCustomKeyboardControls().IsCustom
    UIGlobals.OptionsTable.Throttle = Amax.UpdateCustomKeyboardControls().Throttle
    UIGlobals.OptionsTable.Brake = Amax.UpdateCustomKeyboardControls().Brake
    UIGlobals.OptionsTable.SteerLeft = Amax.UpdateCustomKeyboardControls().SteerLeft
    UIGlobals.OptionsTable.SteerRight = Amax.UpdateCustomKeyboardControls().SteerRight
    UIGlobals.OptionsTable.EBrake = Amax.UpdateCustomKeyboardControls().EBrake
    UIGlobals.OptionsTable.Fire = Amax.UpdateCustomKeyboardControls().Fire
    UIGlobals.OptionsTable.SwitchPerk = Amax.UpdateCustomKeyboardControls().SwitchPerk
    UIGlobals.OptionsTable.PowerUpFwd = Amax.UpdateCustomKeyboardControls().PowerUpFwd
    UIGlobals.OptionsTable.PowerUpBwd = Amax.UpdateCustomKeyboardControls().PowerUpBwd
    UIGlobals.OptionsTable.ChangeView = Amax.UpdateCustomKeyboardControls().ChangeView
    UIGlobals.OptionsTable.Pause = Amax.UpdateCustomKeyboardControls().Pause
    UIGlobals.OptionsTable.RearView = Amax.UpdateCustomKeyboardControls().RearView
  end
  if IsTable(UIGlobals.DefaultOptionsTable) == false then
    UIGlobals.DefaultOptionsTable = Amax.GetOptionsDefaults()
  end
  GUI.MenuId = SCUI.name_to_id.menu
  if UIGlobals.IsIngame == false and Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
    Mp_SetupMenuItemHelpText(GUI.MenuId, 0, UIText.CMN_OPT_DIFFICULTY, UIText.CMN_HLP_OPT_DIFFICULTY, "ai_difficulty", "common_icons", true)
  end
  if UIGlobals.IsIngame == false or UIGlobals.IsIngame == true and IsSplitScreen() == false then
    Mp_SetupMenuItemHelpText(GUI.MenuId, 1, UIText.CMN_OPT_CONTROL, UIText.CMN_HLP_OPT_KEYBOARD, "Keyboard_Mouse", "common_icons", true)
    Mp_SetupMenuItemHelpText(GUI.MenuId, 2, UIText.CMN_OPT_CONTROLS_CONFIG, UIText.CMN_HLP_OPT_CONTROLS_CONFIG, "ps3_controller_options", "common_icons", true)
  end
  if false == true then
    Mp_SetupMenuItemHelpText(GUI.MenuId, 3, UIText.CMN_OPT_AUDIO, UIText.CMN_HLP_OPT_AUDIO, "large_speaker", "common_icons", true)
    Mp_SetupMenuItemHelpText(GUI.MenuId, 4, UIText.CMN_OPT_GRAPHICS, UIText.CMN_HLP_OPT_GRAPHICS, "Graphics", "common_icons", true)
  end
  if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon and CanSave(Profile.GetPrimaryPad(), true) == true then
    Mp_SetupMenuItemHelpText(GUI.MenuId, 3, UIText.CMN_OPT_SAVE_LOCATION, UIText.CMN_HLP_OPT_SAVE_LOCATION, "load_save", "common_icons", true)
  end
  if UIGlobals.IsIngame == false then
    Mp_SetupMenuItemHelpText(GUI.MenuId, 5, UIText.CMN_OPT_SHOW_CREDITS, UIText.CMN_HLP_OPT_SHOW_CREDITS, "summery", "common_icons", true)
  end
  if Amax.GetGameMode() ~= UIEnums.GameMode.SinglePlayer and IsSplitScreen() == false then
    Mp_SetupMenuItemHelpText(GUI.MenuId, 6, UIText.CMN_OPT_MULTIPLAYER, UIText.CMN_HLP_OPT_MULTIPLAYER, "online", "common_icons", true)
  end
  if UIGlobals.IsIngame == false and Amax.CanUseShare() == true then
    if Amax.FacebookHasPublisherFile() == true then
      if Amax.FacebookIsRegistered() == true then
      end
      UIButtons.ChangeColour(UIButtons.FindChildByName(Mp_SetupMenuItemHelpText(GUI.MenuId, 7, UIText.CMN_OPT_UNAUTHENTICATE_FACEBOOK, UIText.CMN_HLP_OPT_AUTHENTICATE_FACEBOOK, "facebook", "common_icons", true), "icon"), "NonBloomWhite")
      UIButtons.SetXtVar(UIButtons.FindChildByName(Mp_SetupMenuItemHelpText(GUI.MenuId, 7, UIText.CMN_OPT_UNAUTHENTICATE_FACEBOOK, UIText.CMN_HLP_OPT_AUTHENTICATE_FACEBOOK, "facebook", "common_icons", true), "icon"), "time_lines.0.label", "hacksaw")
    end
    if Amax.TwitterHasPublisherFile() == true then
      Mp_SetupMenuItemHelpText(GUI.MenuId, 8, UIText.CMN_OPT_AUTHENTICATE_TWITTER, UIText.CMN_HLP_OPT_AUTHENTICATE_TWITTER, "twitter", "common_icons", true)
    end
  end
  if 1 > 1 - (0 + 1 + 2 + 2 + 1 + 1 + 1 + 1 + 1 - 6) * 0.06 then
    UIButtons.ChangeScale(SCUI.name_to_id.ScaleDummy, 1 - (0 + 1 + 2 + 2 + 1 + 1 + 1 + 1 + 1 - 6) * 0.06, 1 - (0 + 1 + 2 + 2 + 1 + 1 + 1 + 1 + 1 - 6) * 0.06, 1 - (0 + 1 + 2 + 2 + 1 + 1 + 1 + 1 + 1 - 6) * 0.06)
  end
  StoreInfoLine()
  SetupMenuOptions()
  SetupScreenTitle(UIText.CMN_OPT_OPTIONS, SCUI.name_to_id._CarouselDummy, "option cog")
end
function PostInit()
  UIButtons.NodeListScan(GUI.MenuId)
  UIButtons.SetSelection(GUI.MenuId, 1)
  if IsNumber(GetScreenOtions().selection) == true then
    UIButtons.SetSelection(GUI.MenuId, GetScreenOtions().selection)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if IsControllerLocked() == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.SaveLocationFound then
    SetupCustomPopup(UIEnums.CustomPopups.OptionsChangeStorageDevice)
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or UIButtons.SetCurrentItemByID(GUI.MenuId, (UIButtons.GetParent(_ARG_2_))) == true then
    PlaySfxNext()
    if UIButtons.GetSelection(GUI.MenuId) == 0 then
      GoScreen("Shared\\Options_DrivingAssists.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 1 then
      GoScreen("Shared\\Options_Control.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 2 then
      GoScreen("Shared\\Options_Controller.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 3 then
      UIGlobals.SaveOptions = true
      GoScreen("Shared\\Options_Audio.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 4 then
      UIGlobals.SaveGraphicOptions = true
      GoScreen("Shared\\Options_Graphics.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 5 then
      GoScreen("Shared\\Options_Credits.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 6 then
      UIGlobals.SaveOptions = true
      GoScreen("Shared\\Options_Multiplayer.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 7 then
      if Amax.FacebookIsRegistered() == true then
        GUI.fb_disconnecting_timer = 0
        SetupCustomPopup(UIEnums.CustomPopups.DisconnectFromFacebook)
      else
        UIGlobals.FacebookUploadingPhoto = false
        UIGlobals.FacebookBackToStoryScreen = false
        GoScreen("Shared\\FacebookAuthenticate.lua", UIEnums.Context.Blurb)
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == 8 then
      UIGlobals.TwitterBackToTweetScreen = false
      GoScreen("Shared\\TwitterAuthenticate.lua", UIEnums.Context.Blurb)
    else
      print("whaatisit?", (UIButtons.GetSelection(GUI.MenuId)))
    end
  end
end
function FrameUpdate(_ARG_0_)
  if UIGlobals.RefreshOptions == true then
    UIGlobals.RefreshOptions = nil
    GoScreen("Shared\\Options.lua")
  end
  if UIGlobals.fb_disconnecting == true then
    GUI.fb_disconnecting_timer = GUI.fb_disconnecting_timer + _ARG_0_
    if GUI.fb_disconnecting_timer > 2 then
      still_pumping, error = Amax.PumpFacebookCurrentTask()
      if still_pumping == false then
        UIGlobals.fb_disconnecting = nil
        if error ~= 0 then
          PopupSpawn(UIEnums.CustomPopups.ContentServerGeneralError)
        else
          PopupSpawn(UIEnums.CustomPopups.FacebookDisconnected)
          GoScreen("Shared\\Options.lua")
        end
      end
    end
  end
end
function Render()
end
function EnterEnd()
end
function EndLoop(_ARG_0_)
end
function End()
  GetScreenOtions().selection = UIButtons.GetSelection(GUI.MenuId)
end
