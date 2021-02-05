GUI = {
  finished = false,
  loading = false,
  inactive_game_invite_wait = false,
  attract_timeout = 0,
  boot_start_time = 1.3,
  start_time = 0.15,
  end_time = 0.3,
  Mode = {SinglePlayer = 1, Multiplayer = 2},
  CurrentMode = 0,
  UiCameraName = {
    UIGlobals.CameraNames.SpCarousel,
    UIGlobals.CameraNames.MpCarousel
  },
  panel_items = {"_BoxGlow", "_Icon"},
  bright_panel_items = {"_Text"},
  UiCameraTime = 0.5,
  debugdev_mode = true,
  entering_debug_menu = false,
  STAGE_PRESS_START = 0,
  STAGE_LOADING = 1,
  STAGE_MODE_SELECT = 2,
  NetConnectionTaskCount = 0
}
function Init()
  InfoLineFlush()
  UIGlobals.OptionsTable = nil
  AddSCUI_Elements()
  SetupInfoLine(UIText.INFO_A_CONTINUE, UIText.INFO_QUIT_B)
  if UIGlobals.CurrentRegion == UIEnums.Region.NorthAmerica then
    UIButtons.ChangeText(SCUI.name_to_id.LegalText, UIText.CMN_LEGAL_US)
  end
  UIGlobals.ProfileBootFinished = false
  Camera_UseFrontend()
  Amax.SetGameMode(UIEnums.GameMode.Nothing)
  GUI.debugdev_mode = Amax.GetSetDebugDevMode()
  UIButtons.ChangeText(SCUI.name_to_id.DebugR, Select(GUI.debugdev_mode, UIText.DBG_DEVMODE_DEBUG, UIText.DBG_DEVMODE_MASTER))
  UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.None
  UIGlobals.ConnectionType = UIEnums.ConnectionType.None
  GUI.allow_debug_buttons = UIGlobals.DevMode == true
  UIButtons.SetActive(SCUI.name_to_id.DebugY, GUI.allow_debug_buttons)
  UIButtons.SetActive(SCUI.name_to_id.DebugL, GUI.allow_debug_buttons)
  UIButtons.SetActive(SCUI.name_to_id.DebugR, GUI.allow_debug_buttons)
  UIButtons.ChangeText(SCUI.name_to_id.PressStart, UIText.CMN_PRESS_ENTER_TO_CONTINUE)
  UIGlobals.ReturnToBlurb = nil
  UIGlobals.FinishedCreatingNetworkSession = false
  UIGlobals.SuccessfullyCreatedNetworkSession = false
  Amax.DeleteStatsOnlyMatchingSession()
  UIGlobals.MpModShopKeyboardCheck = -1
  if Amax.GetShouldLoadDefaultCar() ~= nil and (Amax.GetShouldLoadDefaultCar() == false or UIGlobals.UserKickBackMode ~= UIEnums.UserKickBackMode.None) then
    Amax.LoadCar(Amax.GetShouldLoadDefaultCar())
  end
end
function StartScreen_SelectSp(_ARG_0_)
  if GUI.CurrentMode == GUI.Mode.SinglePlayer then
    return
  end
  GUI.CurrentMode = GUI.Mode.SinglePlayer
  if _ARG_0_ ~= true then
    UISystem.PlaySound(UIEnums.SoundEffect.CarouselLeft)
  end
  Amax.ChangeUiCamera(GUI.UiCameraName[GUI.CurrentMode], 0.5, 0)
  if UIGlobals.DevMode == true then
    UIButtons.SetActive(SCUI.name_to_id.DebugL, true)
  end
  for _FORV_4_, _FORV_5_ in ipairs(GUI.panel_items) do
    UIButtons.ChangeColour(SCUI.name_to_id["MP" .. _FORV_5_], "Main_2")
    UIButtons.ChangeColour(SCUI.name_to_id["SP" .. _FORV_5_], "Main_1")
  end
  for _FORV_4_, _FORV_5_ in ipairs(GUI.bright_panel_items) do
    UIButtons.ChangeColour(SCUI.name_to_id["MP" .. _FORV_5_], "Main_2")
    UIButtons.ChangeColour(SCUI.name_to_id["SP" .. _FORV_5_], "Main_0")
  end
  UIButtons.PrivateTimeLineActive(SCUI.name_to_id.SP_Icon, "Selected", true, 4.7, true)
  UIButtons.PrivateTimeLineActive(SCUI.name_to_id.MP_Icon, "Selected", false)
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
end
function StartScreen_SelectMp(_ARG_0_)
  if GUI.CurrentMode == GUI.Mode.Multiplayer then
    return
  end
  GUI.CurrentMode = GUI.Mode.Multiplayer
  if _ARG_0_ ~= true then
    UISystem.PlaySound(UIEnums.SoundEffect.CarouselRight)
  end
  Amax.ChangeUiCamera(GUI.UiCameraName[GUI.CurrentMode], 0.5, 0)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.panel_items) do
    UIButtons.ChangeColour(SCUI.name_to_id["SP" .. _FORV_5_], "Main_2")
    UIButtons.ChangeColour(SCUI.name_to_id["MP" .. _FORV_5_], "Main_1")
  end
  UIButtons.PrivateTimeLineActive(SCUI.name_to_id.SP_Icon, "Selected", false)
  UIButtons.PrivateTimeLineActive(SCUI.name_to_id.MP_Icon, "Selected", true, 4.7, true)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.bright_panel_items) do
    UIButtons.ChangeColour(SCUI.name_to_id["SP" .. _FORV_5_], "Main_2")
    UIButtons.ChangeColour(SCUI.name_to_id["MP" .. _FORV_5_], "Main_0")
  end
  StartScreen_ChangeUiCamera(GUI.Mode.Multiplayer)
  if UIGlobals.DevMode == true then
    UIButtons.SetActive(SCUI.name_to_id.DebugL, false)
  end
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
end
function PostInit()
  CheckRenderBuffer()
  if UIGlobals.ReturnMode == UIEnums.ReturnMode.QuitSpGame then
    GUI.current_stage = GUI.STAGE_MODE_SELECT
    UIScreen.SetScreenTimers(GUI.start_time, GUI.end_time)
    StartScreen_SelectSp(true)
    net_SetRichPresence(UIEnums.RichPresence.SignedIn)
  elseif UIGlobals.ReturnMode == UIEnums.ReturnMode.QuitMpGame then
    GUI.current_stage = GUI.STAGE_MODE_SELECT
    UIScreen.SetScreenTimers(GUI.start_time, GUI.end_time)
    StartScreen_SelectMp(true)
    net_SetRichPresence(UIEnums.RichPresence.SignedIn)
  else
    GUI.fade_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUp")
    Amax.ChangeUiCamera("CameraInit", 0, 0)
    Amax.ChangeUiCamera("Start1a", 1, 0, 2)
    GUI.current_stage = GUI.STAGE_PRESS_START
    Profile.SetPrimaryPad(-1)
    Profile.Flush()
    StartScreen_ClearProfiles()
    StartScreen_DefaultProfileVars()
    Multiplayer.SplitscreenResetScores()
    UIGlobals.splitscreen_primary_pad_original = -1
    UISystem.PlaySound(UIEnums.SoundEffect.PressStartButtonScreen)
    net_SetRichPresence(UIEnums.RichPresence.Idle)
    GUI.CurrentMode = GUI.Mode.SinglePlayer
    UIScreen.SetScreenTimers(GUI.boot_start_time, GUI.end_time)
  end
  if UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.UserChanged then
    SetupCustomPopup(UIEnums.CustomPopups.ProfileKickedYou)
  elseif UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.MpBetaExpired then
    SetupCustomPopup(UIEnums.CustomPopups.MpBetaExpired)
  elseif UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.InactiveGameInvite then
    SetupCustomPopup(UIEnums.CustomPopups.ActiveProfileChanged)
    GUI.inactive_game_invite_wait = true
  elseif UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.ProfileUploadFailed then
    SetupCustomPopup(UIEnums.CustomPopups.ProfileUploadFailed)
  elseif UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.XLSPConnectionLost then
    SetupCustomPopup(UIEnums.CustomPopups.NetConnectionError)
  elseif UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.ServiceConnectionLost then
    SetupCustomPopup(UIEnums.CustomPopups.ServiceConnectionLost)
  elseif UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.NetworkCableRemoved then
    SetupCustomPopup(UIEnums.CustomPopups.NetworkCableRemoved)
  end
  UIGlobals.ReturnMode = UIEnums.ReturnMode.None
  UIGlobals.UserKickBackMode = UIEnums.UserKickBackMode.None
  UIGlobals.UserKickBackActive = false
  CheckPumpkin()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox then
    if _ARG_2_ == SCUI.name_to_id.BoxGlowStart then
    elseif _ARG_2_ == SCUI.name_to_id.BoxGlowSP then
    else
    end
    _ARG_1_ = 0
  end
  if GUI.entering_debug_menu == true then
    if _ARG_0_ == UIEnums.GameFlowMessage.LevelDumped then
      GUI.entering_debug_menu = false
      Amax.SendMessage(UIEnums.GameFlowMessage.EnteredDebugMenu)
      Amax.SetGameMode(UIEnums.GameMode.Debug)
      GoScreen("Debug\\DebugScreen.lua")
    else
      return
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext or _ARG_0_ == UIEnums.Message.MenuBack or _ARG_0_ == UIEnums.Message.ButtonX or _ARG_0_ == UIEnums.Message.ButtonY or _ARG_0_ == UIEnums.Message.ButtonStart or _ARG_0_ == UIEnums.Message.StickLeftX or _ARG_0_ == UIEnums.Message.StickLeftY or _ARG_0_ == UIEnums.Message.StickRightX or _ARG_0_ == UIEnums.Message.StickRightY then
    GUI.attract_timeout = 0
  end
  if _ARG_0_ == UIEnums.Message.ButtonRightShoulder and _ARG_2_ == true and GUI.allow_debug_buttons == true then
    if GUI.debugdev_mode == true then
      UIButtons.ChangeText(SCUI.name_to_id.DebugR, UIText.DBG_DEVMODE_MASTER)
      GUI.debugdev_mode = Amax.GetSetDebugDevMode(false)
    else
      UIButtons.ChangeText(SCUI.name_to_id.DebugR, UIText.DBG_DEVMODE_DEBUG)
      GUI.debugdev_mode = Amax.GetSetDebugDevMode(true)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonY and _ARG_2_ == true and GUI.allow_debug_buttons == true then
    Profile.Setup(_ARG_1_, true)
    UIGlobals.ProfileState[_ARG_1_] = UIEnums.Profile.Blagged
    Profile.LockToPad(_ARG_1_)
    Profile.SetPrimaryPad(_ARG_1_)
    GameProfile.InitPrimary()
    Profile.AllowProfileChanges(false)
    Profile.ActOnProfileChanges(false)
    Profile.AllowAllPadInput(false)
    GUI.entering_debug_menu = true
    Amax.SendMessage(UIEnums.GameFlowMessage.DumpUI)
  end
  if GUI.current_stage == GUI.STAGE_PRESS_START then
    if _ARG_0_ == UIEnums.Message.MenuBack then
      SetupCustomPopup(UIEnums.CustomPopups.KillApplication)
    elseif (true == true or _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_) == true and UIScreen.IsContextActive(UIEnums.Context.LoadSave) == false then
      UISystem.PlaySound(UIEnums.SoundEffect.Start)
      UISystem.PlaySound(UIEnums.SoundEffect.GraphicStartFlyForward)
      UIButtons.SetSelected(SCUI.name_to_id.OnShape, false)
      StartScreen_SelectSp(true)
      UIButtons.TimeLineActive("Open", true)
      Sp_NewGame()
      Profile.Flush()
      Amax.GameDataLogDisplaySettings()
      Amax.ChangeUiCamera("Start1b", 8, 0)
      if UIGlobals.LastInputDevice < 2 then
        _ARG_1_ = 0
      end
      StartProfileLoad(_ARG_1_)
      GUI.current_stage = GUI.STAGE_LOADING
      UIGlobals.ProfileBootFinished = false
      Profile.AllowProfileChanges(true)
      Profile.ActOnProfileChanges(false)
      Profile.AllowAllPadInput(false)
      net_SetRichPresence(UIEnums.RichPresence.SignedIn)
      Amax.InitTwitter()
      Amax.InitFacebook()
    end
  elseif GUI.current_stage == GUI.STAGE_MODE_SELECT then
    if _ARG_0_ == UIEnums.Message.ButtonX and UIGlobals.DevMode == true then
      if selection == 0 then
        StartProfileNew(_ARG_1_)
        EnterSpRaceBook(true)
        StartAsyncSave()
      end
    elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
      if Amax.CanUseShare() == true then
        UIGlobals.ShareFromWhatPopup = -1
        SetupCustomPopup(UIEnums.CustomPopups.SharingOptions)
      end
    elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Intro\\StartScreen.lua")
      if _ARG_3_ == UIEnums.ShareOptions.Facebook then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.PlayingBlur, 1, -1)
        GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
      elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.PlayingBlur, 0, -1)
        GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
      elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.PlayingBlur, 2, -1)
      end
    elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or true == true and GUI.CurrentMode == GUI.Mode.SinglePlayer or true == true and GUI.CurrentMode == GUI.Mode.Multiplayer then
      if UIGlobals.ProfileState[_ARG_1_] == UIEnums.Profile.PreLoad then
        SetupCustomPopup(UIEnums.CustomPopups.ProfilePreLoad)
        return
      end
      UISystem.PlaySound(UIEnums.SoundEffect.Start)
      if GUI.CurrentMode == GUI.Mode.SinglePlayer then
        Amax.SetGameMode(UIEnums.GameMode.SinglePlayer)
        PlaySfxNext()
        UIButtons.TimeLineActive("Open_Sp", false)
        UIButtons.TimeLineActive("Close_Mp", true)
        Amax.SetPlayingSpGameLatest(true)
        EnterSpRaceBook(true)
      elseif GUI.CurrentMode == GUI.Mode.Multiplayer then
        Amax.SetGameMode(UIEnums.GameMode.MultiPlayer)
        PlaySfxNext()
        UIButtons.TimeLineActive("Open_Mp", false)
        UIButtons.TimeLineActive("Close_Sp", true)
        Amax.SetPlayingSpGameLatest(false)
        EnterMpRaceBook()
      end
      net_EnableGlobalUpdate(true, true)
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      if IsTable(GUI.camera) == true then
        return
      end
      UIButtons.TimeLineActive("Open", false, 0)
      UIButtons.TimeLineActive("Selected", false)
      Amax.ChangeUiCamera("Start1a", 1, 0)
      GUI.current_stage = GUI.STAGE_PRESS_START
      SetupInfoLine(UIText.INFO_A_CONTINUE, UIText.INFO_QUIT_B)
      PlaySfxBack()
      UISystem.PlaySound(UIEnums.SoundEffect.GraphicStartFlyBackward)
      UIButtons.SetSelected(SCUI.name_to_id.OnShape, true)
      StartScreen_DefaultProfileVars()
      net_SetRichPresence(UIEnums.RichPresence.Idle)
      Multiplayer.SplitscreenResetScores()
      UIGlobals.splitscreen_primary_pad_original = -1
    elseif (true == true or _ARG_0_ == UIEnums.Message.ButtonLeft and _ARG_2_) == true and UIGlobals.LaunchMode ~= UIEnums.LaunchMode.Press and UIGlobals.LaunchMode ~= UIEnums.LaunchMode.E3Mp then
      StartScreen_SelectSp()
    elseif (true == true or _ARG_0_ == UIEnums.Message.ButtonRight and _ARG_2_) == true and UIGlobals.LaunchMode ~= UIEnums.LaunchMode.Press and UIGlobals.LaunchMode ~= UIEnums.LaunchMode.E3Mp then
      StartScreen_SelectMp()
    end
  end
end
function FrameUpdate(_ARG_0_)
  DeferCam_Update(_ARG_0_)
  if GUI.finished == false and GUI.current_stage == GUI.STAGE_PRESS_START and UIScreen.IsPopupActive() == false then
    Amax.SetLoadingScreen(false)
    Amax.SendMessage(UIEnums.GameFlowMessage.StartGameRendering)
    GUI.attract_timeout = GUI.attract_timeout + _ARG_0_
    if GUI.attract_timeout > 30 then
      StoreScreen(UIEnums.ScreenStorage.LOAD_NEXT)
      GoScreen("Intro\\AttractSplash.lua")
    end
  else
    GUI.attract_timeout = 0
  end
  if GUI.entering_debug_menu == true then
    return
  end
  if GUI.inactive_game_invite_wait == true then
    GUI.inactive_game_invite_wait = UIScreen.IsPopupActive()
  end
  if GUI.current_stage == GUI.STAGE_PRESS_START and GUI.inactive_game_invite_wait == false then
    if NetServices.GameInvitePending() == true then
      if NetServices.FindGameInvitePadIndex() ~= -1 then
        UIScreen.CancelPopup()
        ContextTable[UIEnums.Context.Main].MessageUpdate(UIEnums.Message.ButtonStart, NetServices.FindGameInvitePadIndex(), true)
      end
    elseif UIGlobals.ActUponFriendChallenges == true and UIGlobals.PendingFriendChallengeInfo.Pending == true and UIGlobals.PendingFriendChallengeInfo.Pad ~= -1 then
      UIScreen.CancelPopup()
      ContextTable[UIEnums.Context.Main].MessageUpdate(UIEnums.Message.ButtonStart, UIGlobals.PendingFriendChallengeInfo.Pad, true)
    end
  end
  if GUI.current_stage == GUI.STAGE_LOADING and UIGlobals.ProfileBootFinished == true then
    GUI.current_stage = GUI.STAGE_MODE_SELECT
    if Amax.HasBeenPlayingSpGameLatest() == true then
      StartScreen_SelectSp(true)
    else
      StartScreen_SelectMp(true)
    end
    Profile.AllowProfileChanges(true)
    Profile.ActOnProfileChanges(true)
    Profile.AllowAllPadInput(false)
    Profile.GetPrimaryProfilePicture()
    Amax.GetAchievementDetails()
    CheckPumpkin()
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
    if NetServices.GameInvitePending() == true and UIGlobals.Network.GlobalUpdateEnabled == false then
      net_EnableGlobalUpdate(true, true)
    end
    if Amax.CanPlayGameModeVideo(UIEnums.SPVideoConfig.VIDEO_GLOSSY_INTRO) == true then
      Amax.SetVideoPlayedBitInProfile(UIEnums.SPVideoConfig.VIDEO_GLOSSY_INTRO)
      UIGlobals.ActiveSPMovie[1].Filename, UIGlobals.ActiveSPMovie[1].Skipable, UIGlobals.ActiveSPMovie[1].FullScreen = Amax.GetGameModeVideoFile(UIEnums.SPVideoConfig.VIDEO_GLOSSY_INTRO)
      UIGlobals.SpMovieScreenShouldSave = false
      PushScreen("SinglePlayer\\SpMovieScreen.lua")
      DeferCam_Init(GUI.UiCameraName[GUI.Mode.SinglePlayer], 0.5)
      return
    end
    if Amax.CanShowPreviouslyOnBlur() == true and UIGlobals.CanShowPreviouslyOnBlur == true then
      FriendDemand.RetrieveFromServer(true)
      UIGlobals.CanShowPreviouslyOnBlur = false
      PushScreen("Intro\\PreviouslyOnBlur.lua")
    else
      Amax.ChangeUiCamera(GUI.UiCameraName[GUI.CurrentMode], 2, 0)
    end
  end
end
function EnterEnd()
end
function EndLoop(_ARG_0_)
end
function End()
  if GUI.current_stage == GUI.STAGE_LOADING then
    print("Warning cancelled load unsafely")
    EndScreen(UIEnums.Context.LoadSave)
  end
  StartScreen_DefaultProfileVars = nil
  StartScreen_ChangeUiCamera = nil
end
function StartProfileLoad(_ARG_0_)
  UIGlobals.ProfilePressedStart = _ARG_0_
  Profile.SetPrimaryPad(UIGlobals.ProfilePressedStart)
  Profile.LockToPad(_ARG_0_)
  GameProfile.InitPrimary()
  Amax.SetGameMode(UIEnums.GameMode.SinglePlayer)
  StartScreen_ClearProfiles()
  UIGlobals.ProfilePrimaryPad = -1
  UIGlobals.ProfilesFound = 0
  UIGlobals.ProfileLookingFor = -1
  PushScreen("Profile\\Boot.lua")
end
function EnterMpRaceBook()
  Amax.SetUICarToMultiplayer(true)
  Amax.SendMessage(UIEnums.GameFlowMessage.LoadSPProfileCar)
  GoScreen(GUINetwork.multiplayer_root)
  Amax.SetLoadStateIntoUI()
  LSP.GetLinkCode()
end
function StartScreen_DefaultProfileVars()
  UIGlobals.FileParams = {}
  UIGlobals.ScreenOptions = {}
  UIGlobals.DebugEvent = nil
  UIGlobals.LoadFromDebug = false
  UIGlobals.FadeUpLoading = nil
  UIGlobals.FriendDemandFilterFriend = 0
  UIGlobals.FriendDemandAttemptFromMessage = false
  Profile.AllowProfileChanges(true)
  Profile.ActOnProfileChanges(false)
  Profile.AllowAllPadInput(true)
  net_EnableGlobalUpdate(false)
  net_CloseServiceConnection()
end
function StartScreen_ClearProfiles()
  for _FORV_3_ = 0, 3 do
    Profile.ClearProfile(_FORV_3_)
    Profile.ReadPadProfile(_FORV_3_)
    GameProfile.ClearGameProfile(_FORV_3_)
    UIGlobals.ProfileState[_FORV_3_] = UIEnums.Profile.None
    UIGlobals.LoadProfile[_FORV_3_] = false
  end
end
function StartScreen_ChangeUiCamera(_ARG_0_)
  Amax.ChangeUiCamera(GUI.UiCameraName[_ARG_0_], GUI.UiCameraTime, 0)
  if GUI.UiCameraTime ~= 0.5 then
    GUI.UiCameraTime = 0.5
  end
end
function CheckPumpkin()
  if Amax.ShouldDisplayPumpkin() == true then
    UIShape.ChangeSceneName(SCUI.name_to_id.SP_Icon, "fe_icons")
    UIShape.ChangeObjectName(SCUI.name_to_id.SP_Icon, "bizarre")
  else
    UIShape.ChangeSceneName(SCUI.name_to_id.SP_Icon, "common_icons")
    UIShape.ChangeObjectName(SCUI.name_to_id.SP_Icon, "bio")
  end
end
function StartScreen_StartLogo()
  if GUI.current_stage == GUI.STAGE_PRESS_START then
    UIButtons.SetSelected(SCUI.name_to_id.OnShape, true)
  end
end
