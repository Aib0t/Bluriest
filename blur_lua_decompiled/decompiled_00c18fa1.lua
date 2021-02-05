GUI = {
  finished = false,
  branch_name = {
    [UIEnums.RwBranch.Races] = "Races",
    [UIEnums.RwBranch.Garage] = "Garage",
    [UIEnums.RwBranch.Quit] = "Quit",
    [UIEnums.RwBranch.Help] = "Help",
    [UIEnums.RwBranch.Photos] = "Photos",
    [UIEnums.RwBranch.Blurb] = "Blurb",
    [UIEnums.RwBranch.Stickers] = "Stickers",
    [UIEnums.RwBranch.Options] = "Options",
    [UIEnums.RwBranch.Leaderboards] = "Leaderboards",
    [UIEnums.RwBranch.DLC] = "DLC"
  },
  screen_name = {
    [UIEnums.RwBranch.Races] = "SinglePlayer\\SpTierSelect.lua",
    [UIEnums.RwBranch.Garage] = "Shared\\Garage.lua",
    [UIEnums.RwBranch.Quit] = nil,
    [UIEnums.RwBranch.Help] = "Shared\\Help.lua",
    [UIEnums.RwBranch.Photos] = "Profile\\AsyncEnumerate.lua",
    [UIEnums.RwBranch.Blurb] = "Shared\\BlurbMainMenu.lua",
    [UIEnums.RwBranch.Stickers] = "Shared\\Stickers.lua",
    [UIEnums.RwBranch.Options] = "Shared\\Options.lua",
    [UIEnums.RwBranch.Leaderboards] = "SinglePlayer\\SpCarouselLeaderboard.lua",
    [UIEnums.RwBranch.DLC] = "SinglePlayer\\SpDlcEntry.lua"
  },
  help_text = {
    [UIEnums.RwBranch.Races] = UIText.RBU_TABHELP_RACES,
    [UIEnums.RwBranch.Garage] = UIText.RBU_TABHELP_GARAGE,
    [UIEnums.RwBranch.Quit] = UIText.RBU_TABHELP_QUIT,
    [UIEnums.RwBranch.Help] = UIText.RBU_TABHELP_HELP,
    [UIEnums.RwBranch.Photos] = UIText.RBU_TABHELP_PHOTOS,
    [UIEnums.RwBranch.Blurb] = UIText.RBU_TABHELP_BLURB,
    [UIEnums.RwBranch.Stickers] = UIText.RBU_TABHELP_STICKERS,
    [UIEnums.RwBranch.Options] = UIText.RBU_TABHELP_OPTIONS,
    [UIEnums.RwBranch.Leaderboards] = UIText.RBU_TABHELP_LEADERBOARDS,
    [UIEnums.RwBranch.DLC] = UIText.RBU_TABHELP_DLC
  },
  active_context = UIEnums.Context.CarouselApp,
  active_selection = -1,
  over_selection = -1,
  unlocks = {},
  movie_names = {},
  has_new_mail = false,
  node_id = {},
  friends_list_open = 0
}
function Init()
  net_LockoutFriendsOverlay(false)
  AddSCUI_Elements()
  UIScreen.SetScreenTimers(0.3, 0.3)
  Amax.ChangeUiCamera(UIGlobals.CameraNames.SpCarousel, 0, 0)
  SetupInfoLine(UIText.INFO_OPEN_A, UIText.INFO_QUIT_B, "GAME_SHARE_BUTTON")
  net_SetRichPresence(UIEnums.RichPresence.SpMain)
  for _FORV_3_, _FORV_4_ in ipairs(GUI.movie_names) do
    UISystem.InitMovie(_FORV_3_, "ui\\movies\\" .. _FORV_4_ .. ".bik", false)
    UISystem.PauseMovie(_FORV_3_, true)
  end
  LockController()
  UIGlobals.IsIngame = false
  GUI.carousel_id = SCUI.name_to_id.Carousel
  GUI.events_new_count_id = SCUI.name_to_id.EventsNewCount
  GUI.events_new_id = SCUI.name_to_id.EventsNew
  UIButtons.SetSelected(GUI.carousel_id, false)
  GUI.over_selection = UIEnums.RwBranch.Races
  GUI.camera_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Cam_Carousel")
  UIButtons.SetParent(GUI.camera_id, SCUI.name_to_id.CameraDolly, UIEnums.Justify.MiddleCentre)
  UIButtons.SetParent(AddStatusBar(), GUI.camera_id, UIEnums.Justify.MiddleCentre)
end
function PostInit()
  GUI.help_text_id, GUI.bottom_help_id = SetupBottomHelpBar()
  UIButtons.ChangeText(GUI.help_text_id, GUI.help_text[GUI.over_selection])
  for _FORV_8_, _FORV_9_ in ipairs({
    UIEnums.RwBranch.Races,
    UIEnums.RwBranch.Stickers,
    UIEnums.RwBranch.Garage,
    UIEnums.RwBranch.Photos,
    UIEnums.RwBranch.Options,
    UIEnums.RwBranch.Quit,
    UIEnums.RwBranch.Leaderboards,
    UIEnums.RwBranch.Help,
    UIEnums.RwBranch.Blurb,
    UIEnums.RwBranch.DLC
  }) do
    if _FORV_9_ == UIEnums.RwBranch.Photos then
    elseif _FORV_9_ == UIEnums.RwBranch.Leaderboards then
    else
    end
    if false == true then
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_FORV_9_ == UIEnums.RwBranch.Garage, "Garage_CarouselBranch", "CarouselBranch")), "Title"), {
        [UIEnums.RwBranch.Races] = UIText.RBC_RACES,
        [UIEnums.RwBranch.Garage] = UIText.RBC_GARAGE,
        [UIEnums.RwBranch.Quit] = UIText.CMN_CSL_QUIT,
        [UIEnums.RwBranch.Help] = UIText.RBC_HELP,
        [UIEnums.RwBranch.Photos] = UIText.RBC_PHOTOS,
        [UIEnums.RwBranch.Blurb] = UIText.FDE_DEMANDS,
        [UIEnums.RwBranch.Stickers] = UIText.RBC_STICKERS,
        [UIEnums.RwBranch.Options] = UIText.RBC_OPTIONS,
        [UIEnums.RwBranch.Leaderboards] = UIText.SP_CAROUSEL_LEADERBOARD,
        [UIEnums.RwBranch.DLC] = UIText.CMN_TITLE_DLC
      }[_FORV_9_])
      if IsString({
        [UIEnums.RwBranch.Leaderboards] = "fe_icons",
        [UIEnums.RwBranch.DLC] = "fe_icons"
      }[_FORV_9_]) == true then
        UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_FORV_9_ == UIEnums.RwBranch.Garage, "Garage_CarouselBranch", "CarouselBranch")), "Shape"), {
          [UIEnums.RwBranch.Leaderboards] = "fe_icons",
          [UIEnums.RwBranch.DLC] = "fe_icons"
        }[_FORV_9_])
      end
      UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_FORV_9_ == UIEnums.RwBranch.Garage, "Garage_CarouselBranch", "CarouselBranch")), "Shape"), {
        [UIEnums.RwBranch.Races] = "bio",
        [UIEnums.RwBranch.Garage] = "garage",
        [UIEnums.RwBranch.Quit] = "start",
        [UIEnums.RwBranch.Help] = "help",
        [UIEnums.RwBranch.Photos] = "photo",
        [UIEnums.RwBranch.Blurb] = "message",
        [UIEnums.RwBranch.Stickers] = "sticker",
        [UIEnums.RwBranch.Options] = "option cog",
        [UIEnums.RwBranch.Leaderboards] = "leaderboards",
        [UIEnums.RwBranch.DLC] = "unlock"
      }[_FORV_9_])
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_FORV_9_ == UIEnums.RwBranch.Garage, "Garage_CarouselBranch", "CarouselBranch")), GUI.carousel_id, UIEnums.Justify.None)
      GUI.node_id[_FORV_9_] = UIButtons.CloneXtGadgetByName("SCUIBank", Select(_FORV_9_ == UIEnums.RwBranch.Garage, "Garage_CarouselBranch", "CarouselBranch"))
    end
  end
  Amax.CarouselScan(GUI.carousel_id)
  for _FORV_8_, _FORV_9_ in pairs(GUI.branch_name) do
    if IsNumber(GUI.node_id[_FORV_8_]) == true then
      UIButtons.SetNodeValue(GUI.node_id[_FORV_8_], _FORV_8_)
    end
  end
  UIButtons.PrivateTimeLineActive(GUI.node_id[UIEnums.RwBranch.Races], "Init", true, 10, true)
  GUI.locked_table = {}
  for _FORV_8_, _FORV_9_ in ipairs(GUI.locked_table) do
    UIButtons.SetParent(GUI.node_id[_FORV_9_], nil)
    UIButtons.SetActive(GUI.node_id[_FORV_9_], false)
  end
  Amax.CarouselScan(GUI.carousel_id)
  UIButtons.SetSelection(GUI.carousel_id, GUI.over_selection)
  CarouselSetApp(GUI, SCUI, GUI.over_selection, true)
  if UIGlobals.FriendDemandAttemptFromMessage == true then
    UIGlobals.ReturnToBlurb = nil
    net_FlushEverything(false)
    Amax.SetGameMode(UIEnums.GameMode.SinglePlayer)
    EnterSpRaceBook(false)
    if FriendDemand.HasPrivilege() == true then
      GUI.active_selection = UIEnums.RwBranch.Blurb
      UIButtons.SetSelection(GUI.carousel_id, GUI.active_selection)
      UIGlobals.FriendDemandFilter = 2
      OpenApp(UIEnums.RwBranch.Blurb, nil, "Shared\\Blurb.lua")
    else
      SetupCustomPopup(UIEnums.CustomPopups.FriendChallengeNoPrivilege)
      UIGlobals.FriendDemandAttemptFromMessage = false
    end
  elseif UIGlobals.ReturnToBlurb == true then
    GUI.active_selection = UIEnums.RwBranch.Blurb
    UIButtons.SetSelection(GUI.carousel_id, GUI.active_selection)
    OpenApp(UIEnums.RwBranch.Blurb, nil, "Shared\\BlurbMainMenu.lua")
  else
    GUI.unlocks = Sp_UnlocksFilter(SinglePlayer.ProcessUnlocks())
    if #GUI.unlocks > 0 then
      for _FORV_9_, _FORV_10_ in ipairs(GUI.unlocks) do
        if _FORV_10_.kind == "boss-defeated" then
          SpMain_ProcessBossBeatenVideos(_FORV_10_)
        end
      end
      for _FORV_9_, _FORV_10_ in ipairs(GUI.unlocks) do
        if _FORV_10_.kind == "tier" then
          SpMain_ProcessTierUnlockVideos(_FORV_10_)
        end
      end
      if true == false then
        SinglePlayer.ClearUnlocks()
      end
    end
    if Sp_ReturnFromGame() == true and true == false then
      OpenApp(UIEnums.RwBranch.Races, nil, "SinglePlayer\\SpTierSelect.lua")
    end
  end
  Amax.CheckSinglePlayerStickers()
  if Amax.ShouldDisplayPumpkin() == true then
    UIShape.ChangeSceneName(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwBranch.Races], "Shape"), "fe_icons")
    UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwBranch.Races], "Shape"), "bizarre")
  end
  GUI.has_new_mail = false
  if FriendDemand.IsThereNewMail() == true then
    GUI.has_new_mail = true
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwBranch.Blurb], "NewIcon"), true)
  end
  if Amax.HasNewStickers() then
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwBranch.Stickers], "NewIcon"), true)
  end
  FadeUpLoading()
end
function CarouselOpenFinished()
  if UIGlobals.FriendDemandAttemptFromMessage ~= true and UIGlobals.ReturnToBlurb ~= true then
    UIButtons.SetSelected(ContextTable[UIEnums.Context.Main].GUI.carousel_id, true)
  end
  UIGlobals.ReturnToBlurb = nil
  UnlockController()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.MiscMessage.ServiceConnectionLost or _ARG_0_ == UIEnums.MiscMessage.ServiceConnectionEstablished then
    UIButtons.ChangeText(UIButtons.FindChildByName(GUIBank.SpStatusBar.branch_id, "ProfileName"), "PROFILE_PAD_NAME")
  end
  if IsControllerLocked() == true then
    return
  end
  if SubScreenActive() == true then
    return
  end
  if GUI.active_selection == -1 then
    if _ARG_0_ == UIEnums.Message.PopupEnd and _ARG_2_ == UIEnums.CustomPopups.TrophiesNotInstalled and _ARG_4_ ~= 1 then
      OpenApp(UIEnums.RwBranch.Stickers)
      return
    end
    if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.IsPopupActive() == false then
      UIButtons.SetCurrentItemByID(GUI.carousel_id, (UIButtons.GetParent(_ARG_2_)))
      print(UIButtons.GetSelection(GUI.carousel_id, 2) .. UIButtons.GetSelection(GUI.carousel_id, 2))
    end
    if _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
      if Amax.CanUseShare() == true then
        SetupCustomPopup(UIEnums.CustomPopups.SpMainSelectSharingOptions)
      end
    elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
      if _ARG_3_ == UIEnums.ShareOptions.Facebook then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FanStatus + UIGlobals.SharingOptionsChosen, 1, -1)
        StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "SinglePlayer\\SpMain.lua")
        GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
      elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FanStatus + UIGlobals.SharingOptionsChosen, 0, -1)
        StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "SinglePlayer\\SpMain.lua")
        GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
      elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FanStatus + UIGlobals.SharingOptionsChosen, 2, -1)
      end
    end
    if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or true == true then
      if UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwBranch.Stickers then
        if Amax.TrophiesInstalled() == false then
          SetupCustomPopup(UIEnums.CustomPopups.TrophiesNotInstalled)
        else
          OpenApp(UIButtons.GetSelection(GUI.carousel_id, 2))
        end
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwBranch.Quit then
        SetupCustomPopup(UIEnums.CustomPopups.ExitApplication)
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwBranch.Blurb then
        if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
          if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
            net_StartServiceConnection(true, nil, false)
          elseif net_CanReconnectToDemonware() == false then
            SetupCustomPopup(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
          else
            net_StartServiceConnection(true, nil, false)
          end
        elseif NetServices.UserHasAgeRestriction() == true then
          SetupCustomPopup(UIEnums.CustomPopups.FailedAgeCheck)
        elseif LSP.IsConnected() == false then
          SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
        elseif FriendDemand.HasPrivilege() == false then
          SetupCustomPopup(UIEnums.CustomPopups.FriendChallengeNoPrivilege)
        elseif Amax.GetNumFriends() == 0 then
          SetupCustomPopup(UIEnums.CustomPopups.FriendChallengeNoFriends)
        else
          OpenApp(UIButtons.GetSelection(GUI.carousel_id, 2))
        end
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwBranch.Leaderboards then
        if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
          if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
            net_StartServiceConnection(true, nil, false)
          elseif net_CanReconnectToDemonware() == false then
            SetupCustomPopup(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
          else
            net_StartServiceConnection(true, nil, false)
          end
        elseif NetServices.UserHasAgeRestriction() == true then
          SetupCustomPopup(UIEnums.CustomPopups.FailedAgeCheck)
        elseif LSP.IsConnected() == false and UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
          SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
        elseif CarouselIsAppLocked(UIButtons.GetSelection(GUI.carousel_id, 2)) == false then
          OpenApp(UIButtons.GetSelection(GUI.carousel_id, 2))
        else
          UISystem.PlaySound(UIEnums.SoundEffect.Error)
        end
      else
        if CarouselIsAppLocked(UIButtons.GetSelection(GUI.carousel_id, 2)) == false then
          OpenApp(UIButtons.GetSelection(GUI.carousel_id, 2))
        else
          UISystem.PlaySound(UIEnums.SoundEffect.Error)
        end
        if UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwBranch.Stickers then
          UIButtons.SetActive(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwBranch.Stickers], "NewIcon"), false)
        end
      end
    elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
      SetupCustomPopup(UIEnums.CustomPopups.ExitApplication)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, UIScreen.Context(), _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    if UIScreen.IsContextActive(3) then
      print("Leaving friends list (notified SpMain.lua)")
    else
      print("GOING BACK!!!!!")
      if CloseApp(UIButtons.GetSelection(GUI.carousel_id, 2)) == true then
        UIButtons.SetActive(SCUI.name_to_id.OpenLP_1, true)
        UIButtons.SetActive(SCUI.name_to_id.OpenLP_2, true)
        Amax.ChangeUiSplineCamera(0, 0, nil, nil, nil, nil, nil, 0)
        Amax.ChangeUiCamera(UIGlobals.CameraNames.SpCarousel, UIGlobals.CameraLerpTime, 0)
        net_SetRichPresence(UIEnums.RichPresence.SpMain)
        if UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwBranch.DLC then
          EndScreen(5)
        end
      end
    end
  end
end
function FrameUpdate(_ARG_0_)
  if UIGlobals.FinishedCreatingNetworkSession == false then
    UIGlobals.FinishedCreatingNetworkSession, UIGlobals.SuccessfullyCreatedNetworkSession = Amax.ContinueCreateStatsOnlyMatchingSession()
    print("SUCCESSFULLY CREATED NETWORK SESSION", UIGlobals.SuccessfullyCreatedNetworkSession)
  end
  if UIButtons.GetSelection(GUI.carousel_id, 2) ~= GUI.active_selection and GUI.active_selection ~= -1 then
    EndActive()
  end
  if UIButtons.GetSelection(GUI.carousel_id, 2) ~= GUI.over_selection then
    UIButtons.PrivateTimeLineActive(GUI.node_id[GUI.over_selection], "Selected", false)
    UIButtons.PrivateTimeLineActive(GUI.node_id[UIButtons.GetSelection(GUI.carousel_id, 2)], "Selected", true, 4.7)
    UIButtons.TimeLineActive("HelpFade", true, 0)
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
  if FriendDemand.IsThereNewMail() == true and GUI.has_new_mail == false then
    GUI.has_new_mail = true
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwBranch.Blurb], "NewIcon"), true)
  end
  if FriendDemand.IsThereNoMail() == true and GUI.has_new_mail == true then
    GUI.has_new_mail = false
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.node_id[UIEnums.RwBranch.Blurb], "NewIcon"), false)
  end
end
function Render()
end
function EnterEnd()
  for _FORV_3_, _FORV_4_ in pairs(GUI.node_id) do
    if _FORV_3_ ~= UIEnums.RwBranch.Quit then
      UIButtons.PrivateTimeLineActive(_FORV_4_, "End", true, 0)
    else
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_4_, "Title"), "End", true, 0)
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_4_, "Shape"), "End", true, 0)
    end
  end
  for _FORV_3_, _FORV_4_ in ipairs(GUI.movie_names) do
    UISystem.DestroyMovie(_FORV_3_)
  end
end
function EndLoop(_ARG_0_)
end
function End()
  EndScreen(UIEnums.Context.CarouselApp)
  FlushSubscreens()
end
function OpenApp(_ARG_0_, _ARG_1_, _ARG_2_)
  if UIScreen.GetScreenActive(ContextTable[UIEnums.Context.Main].GUI.active_context) == true then
    return
  end
  if _ARG_1_ == nil then
    _ARG_1_ = ContextTable[UIEnums.Context.Main].GUI.active_context
  end
  UIButtons.TimeLineActive("HelpFade", false)
  if _ARG_2_ ~= nil then
    UIScreen.SetNextScreen(_ARG_2_, _ARG_1_)
  else
    UIScreen.SetNextScreen(GUI.screen_name[_ARG_0_], _ARG_1_)
  end
  PlaySfxNext()
  CarouselSetApp(ContextTable[UIEnums.Context.Main].GUI, ContextTable[UIEnums.Context.Main].SCUI, _ARG_0_, false)
  ContextTable[UIEnums.Context.Main].GUI.active_selection = _ARG_0_
  UIButtons.SetSelected(ContextTable[UIEnums.Context.Main].GUI.carousel_id, false)
  UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.node_id[_ARG_0_], "Open", true, 0)
  UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.bottom_help_id, "Hide_BottomHelp", true)
  UIButtons.SetActive(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.OpenLP_1, false)
  UIButtons.SetActive(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.OpenLP_2, false)
  if _ARG_0_ == UIEnums.RwBranch.Races or _ARG_0_ == UIEnums.RwBranch.Options or _ARG_0_ == UIEnums.RwBranch.Help or _ARG_0_ == UIEnums.RwBranch.Blurb or _ARG_0_ == UIEnums.RwBranch.Photos or _ARG_0_ == UIEnums.RwBranch.Leaderboards then
    PlaySfxGraphicNext()
  end
end
function RaceWorld_UpdateProfileBar(_ARG_0_)
  UIButtons.ChangePosition(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.cash_text, 0, 0, 0)
  UIButtons.ChangePosition(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.cash_icon, 0, 0, 0)
  UIButtons.ChangePosition(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.car_text, 0, 0, 0)
  UIButtons.ChangePosition(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.car_icon, 0, 0, 0)
  UIButtons.ChangePosition(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.cash_icon, -UIButtons.GetStaticTextLength(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.cash_text) - 0.5, 0, 0)
  UIButtons.ChangePosition(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.car_text, -UIButtons.GetStaticTextLength(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.cash_text) - 0.5 - 0 - 1, 0, 0)
  UIButtons.ChangePosition(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.car_icon, -UIButtons.GetStaticTextLength(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.cash_text) - 0.5 - 0 - 1 - UIButtons.GetStaticTextLength(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.car_text) - 0.5, 0.5, 0)
end
function SpMain_ProcessTierUnlockVideos(_ARG_0_)
  if _ARG_0_.tier ~= nil then
    if IsTable(UIGlobals.Sp) == false then
      UIGlobals.Sp = {}
    end
    UIGlobals.SpReturnMode = UIGlobals.SpSelectMode_Tier
    UIGlobals.Sp.CurrentTier = _ARG_0_.tier
    PlaySPUnlockMovieFullScreen(UIEnums.SPVideoConfig.VIDEO_TIER_UNLOCKS, _ARG_0_.tier - 1)
  end
end
function SpMain_ProcessBossBeatenVideos(_ARG_0_)
  if _ARG_0_.tier ~= nil then
    PlaySPUnlockMovieFullScreen(UIEnums.SPVideoConfig.VIDEO_BOSS_BEATEN, _ARG_0_.tier - 1)
    if SinglePlayer.TierInfo() ~= nil and _ARG_0_.tier == #SinglePlayer.TierInfo() then
      UIGlobals.SPRollCredits = true
      UIButtons.SetActive(GUI.help_text_id, false)
      UIButtons.SetActive(GUI.bottom_help_id, false)
    end
  end
end
function SpMain_TabsOpen()
  if UIScreen.IsContextActive(UIEnums.Context.CarouselApp) == false then
    UISystem.PlaySound(UIEnums.SoundEffect.TabsOpen)
  end
end
function SpMain_TabsClose()
  if UIScreen.IsContextActive(UIEnums.Context.CarouselApp) == false then
    UISystem.PlaySound(UIEnums.SoundEffect.TabsClose)
  end
end
