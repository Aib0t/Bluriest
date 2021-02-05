GUI = {
  finished = false,
  active_context = UIEnums.Context.CarouselApp,
  active_selection = -1,
  over_selection = -1,
  launched_screen = false,
  branch_name = {
    [UIEnums.RwMpBranch.Online] = "MpOnline",
    [UIEnums.RwMpBranch.Splitscreen] = "MpSplitscreenSignIn",
    [UIEnums.RwMpBranch.Options] = "Options",
    [UIEnums.RwMpBranch.Quit] = "Quit",
    [UIEnums.RwMpBranch.Help] = "Help",
    [UIEnums.RwMpBranch.Stickers] = "Stickers",
    [UIEnums.RwMpBranch.Lan] = "MpLan"
  },
  help_text = {
    [UIEnums.RwMpBranch.Online] = UIText.RBU_TABHELP_ONLINE,
    [UIEnums.RwMpBranch.Splitscreen] = UIText.RBU_TABHELP_PARTY_MODE,
    [UIEnums.RwMpBranch.Options] = UIText.RBU_TABHELP_OPTIONS,
    [UIEnums.RwMpBranch.Quit] = UIText.RBU_TABHELP_QUIT,
    [UIEnums.RwMpBranch.Help] = UIText.RBU_TABHELP_HELP,
    [UIEnums.RwMpBranch.Stickers] = UIText.RBU_TABHELP_STICKERS,
    [UIEnums.RwMpBranch.Lan] = UIText.RBU_TABHELP_SYSTEM_LINK
  },
  ShowUnrecoverableError = false,
  ShowRouterError = false,
  Ready = false,
  CarouselActive = false,
  node_id = {}
}
function Init()
  net_LockoutFriendsOverlay(false)
  AddSCUI_Elements()
  if UIGlobals.Network.UnrecoverableRouterError == true then
    GUI.ShowRouterError = true
    UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.None
  elseif UIGlobals.Network.UnrecoverableSessionError == true then
    GUI.ShowUnrecoverableError = true
    UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.None
  end
  if UIGlobals.Network.GameInviteState == UIEnums.MpGameInviteState.Initialising then
    UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.None
  end
  if UIGlobals.Multiplayer.LaunchScreen == UIEnums.MpLaunchScreen.MultiplayerLobby or UIGlobals.Multiplayer.LaunchScreen == UIEnums.MpLaunchScreen.SplitscreenLobby then
    Amax.ChangeUiCamera(UIGlobals.CameraNames.MpLobby, 0, 0)
  elseif UIGlobals.Multiplayer.LaunchScreen ~= UIEnums.MpLaunchScreen.None then
    Amax.ChangeUiCamera(UIGlobals.CameraNames.MpAppBase, 0, 0)
  else
    Amax.ChangeUiCamera(UIGlobals.CameraNames.MpCarousel, 0, 0)
  end
  if UIGlobals.Multiplayer.LaunchScreen == UIEnums.MpLaunchScreen.None then
    net_SetRichPresence(UIEnums.RichPresence.MpMain)
  end
  CheckRenderBuffer()
  LockController()
  UIScreen.SetScreenTimers(0.3, 0.3)
  if UIGlobals.Network.UnrecoverableRouterError == true then
    GUI.ShowRouterError = true
  elseif UIGlobals.Network.UnrecoverableSessionError == true then
    GUI.ShowUnrecoverableError = true
  end
  UIGlobals.InitialLobby = true
  GUINetwork.load_started = false
  GUI.carousel_id = SCUI.name_to_id.Carousel
  SetupInfoLine(UIText.INFO_OPEN_A, UIText.INFO_QUIT_B)
  EnableCarousel(false)
  GUI.camera_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Cam_Carousel")
  UIButtons.SetParent(GUI.camera_id, SCUI.name_to_id.CameraDolly, UIEnums.Justify.MiddleCentre)
  UIButtons.SetParent(AddStatusBar(true), GUI.camera_id, UIEnums.Justify.MiddleCentre)
end
function PostInit()
  GUI.help_text_id, GUI.bottom_help_id = SetupBottomHelpBar()
  UIButtons.ChangeText(GUI.help_text_id, GUI.help_text[UIEnums.RwMpBranch.Online])
  for _FORV_8_, _FORV_9_ in ipairs({
    UIEnums.RwMpBranch.Online,
    UIEnums.RwMpBranch.Splitscreen,
    UIEnums.RwMpBranch.Options,
    UIEnums.RwMpBranch.Quit,
    UIEnums.RwMpBranch.Help,
    UIEnums.RwMpBranch.Stickers,
    UIEnums.RwMpBranch.Lan
  }) do
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Title"), {
      [UIEnums.RwMpBranch.Online] = UIText.MP_ONLINE_PLATFORM,
      [UIEnums.RwMpBranch.Splitscreen] = UIText.CMN_PARTY_MODE,
      [UIEnums.RwMpBranch.Options] = UIText.RBC_OPTIONS,
      [UIEnums.RwMpBranch.Quit] = UIText.CMN_CSL_QUIT,
      [UIEnums.RwMpBranch.Help] = UIText.RBC_HELP,
      [UIEnums.RwMpBranch.Stickers] = UIText.RBC_STICKERS,
      [UIEnums.RwMpBranch.Lan] = UIText.MP_LAN
    }[_FORV_9_])
    if IsString({
      [UIEnums.RwMpBranch.Splitscreen] = "fe_icons",
      [UIEnums.RwMpBranch.Lan] = "fe_icons"
    }[_FORV_9_]) == true then
      UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Shape"), {
        [UIEnums.RwMpBranch.Splitscreen] = "fe_icons",
        [UIEnums.RwMpBranch.Lan] = "fe_icons"
      }[_FORV_9_])
    end
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Shape"), {
      [UIEnums.RwMpBranch.Online] = "groups",
      [UIEnums.RwMpBranch.Splitscreen] = "split_screen",
      [UIEnums.RwMpBranch.Options] = "option cog",
      [UIEnums.RwMpBranch.Quit] = "start",
      [UIEnums.RwMpBranch.Help] = "help",
      [UIEnums.RwMpBranch.Stickers] = "sticker",
      [UIEnums.RwMpBranch.Lan] = "system_link"
    }[_FORV_9_])
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), GUI.carousel_id, UIEnums.Justify.None)
    GUI.node_id[_FORV_9_] = UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch")
  end
  Amax.CarouselScan(GUI.carousel_id)
  for _FORV_8_, _FORV_9_ in pairs(GUI.branch_name) do
    if IsNumber(GUI.node_id[_FORV_8_]) == true then
      UIButtons.SetNodeValue(GUI.node_id[_FORV_8_], _FORV_8_)
    end
  end
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
    UIButtons.ChangeScale(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwMpBranch.Online], "Title"), 0.7, 0.7)
  end
  UIButtons.PrivateTimeLineActive(GUI.node_id[UIEnums.RwMpBranch.Online], "Init", true, 1, true)
  CarouselSetApp(GUI, SCUI, UIEnums.RwMpBranch.Online, true)
  if Amax.HasNewStickers() then
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwMpBranch.Stickers], "NewIcon"), true)
  end
  if UIGlobals.Multiplayer.LaunchScreen ~= UIEnums.MpLaunchScreen.None then
    UIButtons.PrivateTimeLineActive(GUI.bottom_help_id, "Hide_BottomHelp", true, 10, true)
    UIButtons.PrivateTimeLineActive(GUI.carousel_id, "open_carousel", true, 10, true)
    CarouselOpenFinished()
  end
  FadeUpLoading()
end
function FrameUpdate(_ARG_0_)
  if UIButtons.GetSelection(GUI.carousel_id, 2) ~= GUI.over_selection then
    if GUI.over_selection ~= -1 then
      UIButtons.PrivateTimeLineActive(GUI.node_id[GUI.over_selection], "Selected", false)
    end
    UIButtons.PrivateTimeLineActive(GUI.node_id[UIButtons.GetSelection(GUI.carousel_id, 2)], "Selected", true, 4.7)
    if GUI.launched_screen == false then
      UIButtons.TimeLineActive("HelpFade", true, 0)
    else
      GUI.launched_screen = false
    end
    if IsNumber(GUI.help_text_id) == true then
      if CarouselIsAppLocked(UIButtons.GetSelection(GUI.carousel_id, 2)) == false then
      end
      UIButtons.ChangeText(GUI.help_text_id, GUI.help_text[UIButtons.GetSelection(GUI.carousel_id, 2)])
    end
    if GUI.over_selection ~= -1 then
      CarouselSetApp(GUI, SCUI, GUI.over_selection, false)
    end
    CarouselSetApp(GUI, SCUI, UIButtons.GetSelection(GUI.carousel_id, 2))
    GUI.over_selection = UIButtons.GetSelection(GUI.carousel_id, 2)
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.MiscMessage.ServiceConnectionLost or _ARG_0_ == UIEnums.MiscMessage.ServiceConnectionEstablished then
    UIButtons.ChangeText(UIButtons.FindChildByName(GUIBank.MpStatusBar.branch_id, "ProfileName"), "PROFILE_PAD_NAME")
  end
  if IsControllerLocked() == true then
    return
  end
  if GUI.active_selection == -1 then
    if _ARG_0_ == UIEnums.Message.PopupEnd and _ARG_2_ == UIEnums.CustomPopups.TrophiesNotInstalled and _ARG_4_ ~= 1 then
      OpenApp(UIEnums.RwMpBranch.Stickers)
      return
    end
    if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
      if UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwMpBranch.Quit then
        SetupCustomPopup(UIEnums.CustomPopups.ExitMultiplayer)
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwMpBranch.Online then
        RemoveBlaggedProfiles()
        net_MpEnter(UIEnums.GameMode.Online)
        if NetServices.ConnectionStatusIsOnline() == true then
          net_StartStorageDownload(StorageCallback)
        else
          net_StartServiceConnection(true, ConnectionCallback, false, true)
        end
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwMpBranch.Lan then
        RemoveBlaggedProfiles()
        if NetServices.NetworkConnectionActive() == false then
          SetupCustomPopup(UIEnums.CustomPopups.InvalidNetworkConnection)
        elseif NetServices.CheckEntryRequirements(false) == 1 then
          SetupCustomPopup(UIEnums.CustomPopups.MultiplayerTooManyProfiles)
        else
          net_MpEnter(UIEnums.GameMode.SystemLink)
          net_StartServiceConnection(false, ConnectionCallback)
        end
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwMpBranch.Splitscreen then
        UIGlobals.splitscreen_enter = true
        net_MpEnter(UIEnums.GameMode.SplitScreen)
        OpenApp(UIButtons.GetSelection(GUI.carousel_id, 2))
        if UIGlobals.splitscreen_primary_pad_original == -1 then
          UIGlobals.splitscreen_primary_pad_original = Profile.GetPrimaryPad()
        end
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwMpBranch.Stickers then
        if Amax.TrophiesInstalled() == false then
          SetupCustomPopup(UIEnums.CustomPopups.TrophiesNotInstalled)
        else
          OpenApp(UIButtons.GetSelection(GUI.carousel_id, 2))
        end
      else
        OpenApp(UIButtons.GetSelection(GUI.carousel_id, 2))
      end
    elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
      SetupCustomPopup(UIEnums.CustomPopups.ExitMultiplayer)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true and CloseApp(UIButtons.GetSelection(GUI.carousel_id, 2)) == true then
    Amax.ChangeUiCamera(UIGlobals.CameraNames.MpCarousel, UIGlobals.CameraLerpTime, 0)
    net_SetRichPresence(UIEnums.RichPresence.MpMain)
  end
end
function EnterEnd()
  for _FORV_3_, _FORV_4_ in pairs(GUI.node_id) do
    if _FORV_3_ ~= UIEnums.RwMpBranch.Quit then
      UIButtons.PrivateTimeLineActive(_FORV_4_, "End", true, 0)
    else
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_4_, "Title"), "End", true, 0)
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_4_, "Shape"), "End", true, 0)
    end
  end
end
function End()
  EndScreen(UIEnums.Context.CarouselApp)
end
function MpMain_TabsOpen()
  if UIScreen.IsContextActive(UIEnums.Context.CarouselApp) == false then
    UISystem.PlaySound(UIEnums.SoundEffect.TabsOpen)
  end
end
function MpMain_TabsClose()
  if UIScreen.IsContextActive(UIEnums.Context.CarouselApp) == false then
    UISystem.PlaySound(UIEnums.SoundEffect.TabsClose)
  end
end
function MpMain_EnterOnline()
  if true == true then
    net_StartServiceConnection(true, ConnectionCallback)
  else
    net_StartStorageDownload(StorageCallback)
  end
end
function ConnectionCallback(_ARG_0_)
  if _ARG_0_ == true then
    if UIButtons.GetSelection(ContextTable[UIEnums.Context.Main].GUI.carousel_id, 2) == UIEnums.RwMpBranch.Online then
      net_StartStorageDownload(StorageCallback)
    else
      OpenApp(UIButtons.GetSelection(ContextTable[UIEnums.Context.Main].GUI.carousel_id, 2))
    end
  end
end
function StorageCallback(_ARG_0_)
  if _ARG_0_ == true then
    OpenApp(UIButtons.GetSelection(ContextTable[UIEnums.Context.Main].GUI.carousel_id, 2))
  end
end
function CarouselOpenFinished()
  if ErrorMode() == true then
    if ContextTable[UIEnums.Context.Main].GUI.ShowRouterError == true then
      ContextTable[UIEnums.Context.Main].GUI.ShowRouterError = false
      SetupCustomPopup(UIEnums.CustomPopups.MultiplayerRouterError)
    elseif ContextTable[UIEnums.Context.Main].GUI.ShowUnrecoverableError == true then
      ContextTable[UIEnums.Context.Main].GUI.ShowUnrecoverableError = false
      SetupCustomPopup(UIEnums.CustomPopups.MultiplayerUnrecoverableError)
    end
    net_CloseAllSessions()
    EnableCarousel(true)
  else
    if UIGlobals.Network.GameInviteState == UIEnums.MpGameInviteState.Initialising then
      net_StartStorageDownload()
    elseif UIGlobals.Network.ReturnPartyLobbyState == UIEnums.MpReturnPartyLobbyState.Initialising then
      UIGlobals.Network.ReturnPartyLobbyState = UIEnums.MpReturnPartyLobbyState.PreProcessing
    elseif LaunchScreen(UIGlobals.Multiplayer.LaunchScreen) == false then
      EnableCarousel(true)
      LeaveMultiplayerMode()
    end
    if UIGlobals.IdlePlayerKicked == true then
      SetupCustomPopup(UIEnums.CustomPopups.IdlePlayerKicked)
    end
  end
  UnlockController()
  UIButtons.TimeLineActive("fade_apps", true)
  GUI.Ready = true
end
function EnableCarousel(_ARG_0_)
  if IsTable(ContextTable[UIEnums.Context.Main].GUI) == false or IsNumber(ContextTable[UIEnums.Context.Main].GUI.carousel_id) == false then
    return
  end
  if _ARG_0_ ~= nil then
    UIButtons.SetSelected(ContextTable[UIEnums.Context.Main].GUI.carousel_id, _ARG_0_)
  end
  ContextTable[UIEnums.Context.Main].GUI.CarouselActive = _ARG_0_
end
function OpenApp(_ARG_0_, _ARG_1_, _ARG_2_)
  if UIScreen.GetScreenActive(ContextTable[UIEnums.Context.Main].GUI.active_context) == true then
    return
  end
  if _ARG_1_ == nil then
    _ARG_1_ = ContextTable[UIEnums.Context.Main].GUI.active_context
  end
  UIButtons.TimeLineActive("HelpFade", false)
  if IsString(ContextTable[UIEnums.Context.Main].GUI.branch_name[_ARG_0_]) == true then
    if _ARG_2_ ~= nil then
      UIScreen.SetNextScreen(_ARG_2_, _ARG_1_)
    elseif _ARG_0_ == UIEnums.RwMpBranch.Options or _ARG_0_ == UIEnums.RwMpBranch.Help or _ARG_0_ == UIEnums.RwMpBranch.Stickers then
      UIScreen.SetNextScreen("Shared\\" .. ContextTable[UIEnums.Context.Main].GUI.branch_name[_ARG_0_] .. ".lua", _ARG_1_)
    else
      UIScreen.SetNextScreen("Multiplayer\\" .. ContextTable[UIEnums.Context.Main].GUI.branch_name[_ARG_0_] .. ".lua", _ARG_1_)
    end
    if _ARG_0_ == UIEnums.RwMpBranch.Stickers then
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwMpBranch.Stickers], "NewIcon"), false)
    end
    PlaySfxNext()
    ContextTable[UIEnums.Context.Main].GUI.active_selection = _ARG_0_
    EnableCarousel(false)
    if _ARG_0_ == UIEnums.RwMpBranch.Options or _ARG_0_ == UIEnums.RwMpBranch.Help or _ARG_0_ == UIEnums.RwMpBranch.Online or _ARG_0_ == UIEnums.RwMpBranch.Splitscreen or _ARG_0_ == UIEnums.RwMpBranch.Lan then
      PlaySfxGraphicNext()
    end
  end
  UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.node_id[_ARG_0_], "Open", true, 0)
  UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.bottom_help_id, "Hide_BottomHelp", true)
end
function ForceCloseApp()
  if IsNumber(ContextTable[UIEnums.Context.Main].GUI.active_context) == true and IsTable(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context]) == true and IsTable(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI) then
    ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.finished = true
    if IsNumber(ContextTable[UIEnums.Context.Main].GUI.active_selection) and ContextTable[UIEnums.Context.Main].GUI.active_selection ~= -1 then
      UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.node_id[ContextTable[UIEnums.Context.Main].GUI.active_selection], "Open", false, 1, true)
    end
    EndScreen(ContextTable[UIEnums.Context.Main].GUI.active_context)
    PlaySfxBack()
    EndActive()
    FlushSubscreens()
    LeaveMultiplayerMode()
    UIButtons.TimeLineActive("HelpFade", true, 0)
    Amax.ChangeUiCamera(UIGlobals.CameraNames.MpCarousel, 0, 0)
    UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.bottom_help_id, "Hide_BottomHelp", false)
  end
end
function ErrorMode()
  if GUI.ShowUnrecoverableError == true or GUI.ShowRouterError == true then
    return true
  end
  return false
end
function LeaveMultiplayerMode()
  net_MpLeave()
  net_FlushEverything()
  Amax.SetGameMode(UIEnums.GameMode.MultiPlayer)
end
function LaunchScreen(_ARG_0_)
  if _ARG_0_ ~= UIEnums.MpLaunchScreen.None and _ARG_0_ ~= UIEnums.MpLaunchScreen.SplitscreenLobby then
    if _ARG_0_ == UIEnums.MpLaunchScreen.MultiplayerLobby then
    elseif _ARG_0_ == UIEnums.MpLaunchScreen.LanBrowser then
    else
    end
    if Amax.GetGameMode() == UIEnums.GameMode.SystemLink then
    else
    end
  elseif _ARG_0_ == UIEnums.MpLaunchScreen.SplitscreenLobby then
    if Amax.GetGameMode() ~= UIEnums.GameMode.SplitScreen then
      print("***Invalid GameMode***")
      show_table(UIEnums.GameMode, 1)
      return false
    end
  end
  if "Multiplayer\\MpSplitscreenLobby.lua" ~= nil and UIEnums.RwMpBranch.Splitscreen ~= nil then
    UIButtons.SetSelection(ContextTable[UIEnums.Context.Main].GUI.carousel_id, UIEnums.RwMpBranch.Splitscreen)
    UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.node_id[UIEnums.RwMpBranch.Splitscreen], "Open", true, 0)
    EnableCarousel(false)
    ContextTable[UIEnums.Context.Main].GUI.active_selection = UIEnums.RwMpBranch.Splitscreen
    GoScreen("Multiplayer\\MpSplitscreenLobby.lua", ContextTable[UIEnums.Context.Main].GUI.active_context)
    UIButtons.TimeLineActive("HelpFade", false)
    ContextTable[UIEnums.Context.Main].GUI.launched_screen = true
    UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.bottom_help_id, "Hide_BottomHelp", true, 10, true)
  end
  UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.None
  return true
end
