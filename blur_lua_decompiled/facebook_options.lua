GUI = {
  finished = false,
  carousel_branch = "Options",
  option = 0,
  authenticating = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  timeout = 0,
  BlockInput = false,
  UnblockDontChange = false
}
function Init()
  GUI.old_friends = net_LockoutFriendsOverlay(true)
  AddSCUI_Elements()
  StoreInfoLine()
  SetupInfoLine()
  UIScreen.SetScreenTimers(0.3, 0.3)
  GUI.UsernameID = SCUI.name_to_id.username_text
  GUI.PasswordID = SCUI.name_to_id.password_text
  UIScreen.Suspend(UIEnums.Context.Main)
  UIScreen.Suspend(UIEnums.Context.CarouselApp)
  UIScreen.Suspend(UIEnums.Context.Subscreen0)
  UIScreen.Suspend(UIEnums.Context.Subscreen1)
  UIScreen.Suspend(UIEnums.Context.Subscreen2)
  InfoLineSwitchContext(UIScreen.Context())
  SetupMenuOptions()
  SetupCustomPopup(UIEnums.CustomPopups.FacebookLegal)
end
function PostInit()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if GUI.authenticating == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if GUI.BlockInput == true then
    if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
      GUI.UnblockDontChange = true
    end
    return
  end
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    PlaySfxBack()
    if UIGlobals.FacebookBackToStoryScreen == false or UIGlobals.FacebookUploadingPhoto == true then
      UIScreen.EndScreen()
    else
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
      if GUI.option ~= 2 then
        GUI.BlockInput = true
        if GUI.option == 0 then
          GUI.CurrentSelectId = SCUI.name_to_id.username_text
        elseif GUI.option == 1 then
          GUI.CurrentSelectId = SCUI.name_to_id.password_text
        end
        UIButtons.AcceptingUserInput(true)
      elseif GUI.option == 2 then
        GUI.timeout = 0
        SetupCustomPopup(UIEnums.CustomPopups.FacebookAuthenticating)
        Amax.FacebookAuthenticate()
        GUI.authenticating = true
      end
    elseif GUI.option == 0 then
      UIHardware.StartKeyboard(_ARG_1_, "GAME_FACEBOOK_USERNAME", UIText.RBC_FACEBOOK_KEYB_HEADER, UIText.RBU_FACEBOOK_KEYB_USERNAME, 256, UIEnums.XboxKeyboardType.Standard)
    elseif GUI.option == 1 then
      UIHardware.StartKeyboard(_ARG_1_, UIText.CMN_NOWT, UIText.RBC_FACEBOOK_KEYB_HEADER, UIText.RBU_FACEBOOK_KEYB_PASSWORD, 256, UIEnums.XboxKeyboardType.Password)
    elseif GUI.option == 2 then
      GUI.timeout = 0
      SetupCustomPopup(UIEnums.CustomPopups.FacebookAuthenticating)
      Amax.FacebookAuthenticate()
      GUI.authenticating = true
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonDown and _ARG_2_ == true then
    GUI.option = GUI.option + 1
    if GUI.option == 3 then
      GUI.option = 0
    end
    PlaySfxDown()
  elseif _ARG_0_ == UIEnums.Message.ButtonUp and _ARG_2_ == true then
    GUI.option = GUI.option - 1
    if GUI.option == -1 then
      GUI.option = 2
    end
    PlaySfxUp()
  elseif _ARG_0_ == UIEnums.Message.KeyboardFinished then
    if GUI.option == 0 then
      Amax.StoreFacebookUsername()
      UIButtons.ChangeText(SCUI.name_to_id.username_text, "GAME_FACEBOOK_USERNAME")
    elseif GUI.option == 1 then
      Amax.StoreFacebookPassword()
      UIButtons.ChangeText(SCUI.name_to_id.password_text, "GAME_FACEBOOK_PASSWORD_ASTERISK")
    end
  end
end
function FrameUpdate(_ARG_0_)
  if UIGlobals.FacebookClose == true then
    UIGlobals.FacebookClose = false
    StartAsyncSave()
    if UIGlobals.FacebookBackToStoryScreen == false or UIGlobals.FacebookUploadingPhoto == true then
      UIScreen.EndScreen()
    else
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    end
  end
  if GUI.BlockInput == true then
    if GUI.UnblockDontChange == true then
      GUI.UnblockDontChange = false
      UIButtons.ClearItems(GUI.CurrentSelectId)
      GUI.BlockInput = false
      UIButtons.AcceptingUserInput(false)
      Amax.AddCursor(GUI.CurrentSelectId, 0, false)
      return
    end
    if UIButtons.GetUserInputString(40) == nil then
      print("LUA input UNBLOCKED")
      GUI.BlockInput = false
      UIButtons.AcceptingUserInput(false)
      Amax.AddCursor(GUI.CurrentSelectId, 0, false)
    else
      UIButtons.ClearItems(GUI.CurrentSelectId)
      if GUI.CurrentSelectId == GUI.UsernameID then
        Amax.StoreFacebookUsername((UIButtons.GetUserInputString(40)))
        UIButtons.ChangeText(GUI.CurrentSelectId, "GAME_FACEBOOK_USERNAME")
      else
        Amax.StoreFacebookPassword((UIButtons.GetUserInputString(40)))
        UIButtons.ChangeText(GUI.PasswordID, "GAME_FACEBOOK_PASSWORD_ASTERISK")
      end
      Amax.AddCursor(GUI.CurrentSelectId, 0, true)
    end
  end
  if GUI.authenticating == true then
    GUI.timeout = GUI.timeout + _ARG_0_
    if GUI.timeout > 2 then
      still_pumping, error = Amax.PumpFacebookCurrentTask()
      if GUI.timeout > 59 then
        still_pumping = false
        error = -1
      end
      if still_pumping == false then
        GUI.authenticating = false
        if LSP.IsTwitterConnected() == false or error == -1 then
          if net_CanReconnectToDemonware() == false then
            PopupSpawn(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
          else
            PopupSpawn(UIEnums.CustomPopups.ContentServerGeneralError)
          end
        elseif error ~= 0 then
          Amax.FacebookUnAuthenticate()
          PopupSpawn(UIEnums.CustomPopups.FacebookUserUnknown)
        else
          UIGlobals.RefreshOptions = true
          PopupSpawn(UIEnums.CustomPopups.FacebookAuthenticated)
        end
      end
    end
  elseif GUI.option == 0 then
    UIButtons.TimeLineActive("username", true)
    UIButtons.TimeLineActive("password", false)
    UIButtons.TimeLineActive("login", false)
  elseif GUI.option == 1 then
    UIButtons.TimeLineActive("username", false)
    UIButtons.TimeLineActive("password", true)
    UIButtons.TimeLineActive("login", false)
  elseif GUI.option == 2 then
    UIButtons.TimeLineActive("username", false)
    UIButtons.TimeLineActive("password", false)
    UIButtons.TimeLineActive("login", true)
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
