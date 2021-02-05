GUI = {
  finished = false,
  branch_name = {
    [UIEnums.RwGameBranch.Paused] = "Paused",
    [UIEnums.RwGameBranch.Retry] = "Retry",
    [UIEnums.RwGameBranch.Help] = "Help",
    [UIEnums.RwGameBranch.Options] = "Options",
    [UIEnums.RwGameBranch.Photo] = "Photo",
    [UIEnums.RwGameBranch.Quit] = "Quit",
    [UIEnums.RwGameBranch.ReturnToLobby] = "ReturnToLobby"
  },
  help_text = {
    [UIEnums.RwGameBranch.Paused] = UIText.CMN_CSLHELP_PAUSED,
    [UIEnums.RwGameBranch.Retry] = UIText.CMN_CSLHELP_RETRY,
    [UIEnums.RwGameBranch.Help] = UIText.CMN_CSLHELP_HELP,
    [UIEnums.RwGameBranch.Options] = UIText.CMN_CSLHELP_OPTIONS,
    [UIEnums.RwGameBranch.Photo] = UIText.CMN_CSLHELP_PHOTO_MODE,
    [UIEnums.RwGameBranch.Quit] = UIText.CMN_CSLHELP_QUIT,
    [UIEnums.RwGameBranch.ReturnToLobby] = UIText.CMN_CSLHELP_RETURN_TO_LOBBY
  },
  locked_table = {},
  quit_and_win = false,
  going_photo = false,
  resume_game = false,
  wait_retry = false,
  active_context = UIEnums.Context.CarouselApp,
  active_selection = -1,
  over_selection = -1,
  ResumeGame = function()
    GUI.resume_game = true
    UIButtons.TimeLineActive("start", false)
    UIButtons.TimeLineActive("end_bg", true)
    GoScreen("Ingame\\HUD.lua")
  end
}
function Init()
  Splitscreen_AddSplits()
  SetupMenuOptions()
  UnlockController()
  if IsSplitScreen() == true then
    GUI.locked_table[#GUI.locked_table + 1] = UIEnums.RwGameBranch.Photo
    UIButtons.ChangeText(SCUI.name_to_id.RetryTitle, UIText.MP_SS_RETRY)
  elseif IsNetworkRace() == true then
    GUI.locked_table[#GUI.locked_table + 1] = UIEnums.RwGameBranch.Photo
    GUI.locked_table[#GUI.locked_table + 1] = UIEnums.RwGameBranch.Retry
  end
  if NetRace.CanReturnPlayersToLobby() == false then
    GUI.locked_table[#GUI.locked_table + 1] = UIEnums.RwGameBranch.ReturnToLobby
  end
  AddSCUI_Elements()
  GUI.quit_and_win = UIGlobals.DevMode
  if Amax.GetGameMode() == UIEnums.GameMode.Debug or GUI.network_race == true then
    GUI.quit_and_win = false
  end
  UIButtons.SetActive(SCUI.name_to_id.QuitAndWin, GUI.quit_and_win)
  GUI.network_race = IsNetworkRace()
  GUI.carousel_id = SCUI.name_to_id.Carousel
  UIScreen.SetScreenTimers(0.3, 0.6)
  if UIGlobals.Ingame.RetryMenu == true then
    GUI.locked_table[#GUI.locked_table + 1] = UIEnums.RwGameBranch.Paused
    GUI.locked_table[#GUI.locked_table + 1] = UIEnums.RwGameBranch.Photo
    UIButtons.SetSelection(GUI.carousel_id, 1)
  end
  UIGlobals.IsQuickRestart = false
  net_LockoutFriendsOverlay(false)
  GUI.camera_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Cam_Carousel")
  UIButtons.SetParent(GUI.camera_id, SCUI.name_to_id.CameraDolly, UIEnums.Justify.MiddleCentre)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), GUI.camera_id, UIEnums.Justify.MiddleCentre)
  UIScreen.AddMessageNow(UIEnums.GameMessage.SetLocalPlayerIndex, player_index)
end
function PostInit()
  GUI.node_id = {}
  for _FORV_6_, _FORV_7_ in ipairs({
    UIEnums.RwGameBranch.Paused,
    UIEnums.RwGameBranch.Retry,
    UIEnums.RwGameBranch.ReturnToLobby,
    UIEnums.RwGameBranch.Help,
    UIEnums.RwGameBranch.Options,
    UIEnums.RwGameBranch.Photo,
    UIEnums.RwGameBranch.Quit
  }) do
    if CarouselIsAppLocked(_FORV_7_) ~= true then
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Title"), {
        [UIEnums.RwGameBranch.Paused] = UIText.CMN_CSL_PAUSED,
        [UIEnums.RwGameBranch.Retry] = UIText.CMN_CSL_RETRY,
        [UIEnums.RwGameBranch.Help] = UIText.CMN_CSL_HELP,
        [UIEnums.RwGameBranch.Options] = UIText.CMN_CSL_OPTIONS,
        [UIEnums.RwGameBranch.Photo] = UIText.CMN_CSL_PHOTO_MODE,
        [UIEnums.RwGameBranch.Quit] = UIText.CMN_CSL_QUIT,
        [UIEnums.RwGameBranch.ReturnToLobby] = UIText.CMN_CSL_RETURN_TO_LOBBY
      }[_FORV_7_])
      UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Shape"), {
        [UIEnums.RwGameBranch.Paused] = "pause",
        [UIEnums.RwGameBranch.Retry] = "retry inverted",
        [UIEnums.RwGameBranch.Help] = "help",
        [UIEnums.RwGameBranch.Options] = "option cog",
        [UIEnums.RwGameBranch.Photo] = "photo",
        [UIEnums.RwGameBranch.Quit] = "start",
        [UIEnums.RwGameBranch.ReturnToLobby] = "end_of_race"
      }[_FORV_7_])
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), GUI.carousel_id, UIEnums.Justify.None)
      GUI.node_id[_FORV_7_] = UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch")
    end
  end
  Amax.CarouselScan(GUI.carousel_id)
  for _FORV_6_, _FORV_7_ in pairs(GUI.branch_name) do
    if IsNumber(GUI.node_id[_FORV_6_]) == true then
      UIButtons.SetNodeValue(GUI.node_id[_FORV_6_], _FORV_6_)
    end
  end
  UIButtons.PrivateTimeLineActive(GUI.node_id[UIEnums.RwGameBranch.Paused], "Init", true, 1, true)
  CarouselSetApp(GUI, SCUI, UIEnums.RwGameBranch.Paused, true)
  UIButtons.ChangePanel(GUI.carousel_id, UIEnums.Panel._3DAA_LIGHT, true)
  GUI.help_text_id, GUI.bottom_help_id = SetupBottomHelpBar()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_) == true then
    return
  end
  if SubScreenActive() == true or GUIBank.loading == true then
    return
  end
  if GUI.wait_retry == true and _ARG_0_ == UIEnums.GameFlowMessage.LevelDumped then
    UIGlobals.Ingame = {}
    StartGameLoad()
  end
  if GUI.wait_retry == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if GUI.active_selection ~= -1 then
    if _ARG_0_ == UIEnums.Message.MenuBack and CloseApp(GUI.active_selection) == true then
      UIButtons.PrivateTimeLineActive(GUI.node_id[GUI.active_selection], "Open", false, 2)
      UIButtons.TimeLineActive("light_fade", false)
    end
  elseif (_ARG_0_ == UIEnums.Message.ButtonStart or _ARG_0_ == UIEnums.Message.MenuBack) and _ARG_2_ == true and UIGlobals.Ingame.RetryMenu ~= true then
    net_LockoutFriendsOverlay(true)
    GUI.ResumeGame()
    PlaySfxBack()
  elseif _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true then
    if GUI.quit_and_win == true then
      net_LockoutFriendsOverlay(true)
      GoScreen("Debug\\QuitandWin.lua")
      UIButtons.TimeLineActive("status_bar", false)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if CarouselIsAppLocked(UIButtons.GetSelection(GUI.carousel_id, 2)) == true then
      PlaySfxError()
    else
      if UIScreen.GetScreenActive(GUI.active_context) == true then
        return
      end
      PlaySfxNext()
      UIButtons.PrivateTimeLineActive(GUI.bottom_help_id, "Hide_BottomHelp", true)
      if UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwGameBranch.Paused and UIGlobals.Ingame.RetryMenu ~= true then
        net_LockoutFriendsOverlay(true)
        GUI.ResumeGame()
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwGameBranch.Retry then
        if IsSplitScreen() == true then
          SetupCustomPopup(UIEnums.CustomPopups.SsRetry)
        elseif GUI.network_race == false then
          SetupCustomPopup(UIEnums.CustomPopups.RetryRace)
        end
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwGameBranch.Options then
        UIButtons.TimeLineActive("HelpFade", false)
        UIButtons.TimeLineActive("light_fade", true)
        UIButtons.TimeLineActive("stage1", true)
        GUI.active_selection = UIEnums.RwGameBranch.Options
        UIScreen.SetNextScreen("Shared\\Options.lua", GUI.active_context)
        UIButtons.SetSelected(GUI.carousel_id, false)
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwGameBranch.Help then
        UIButtons.TimeLineActive("HelpFade", false)
        UIButtons.TimeLineActive("light_fade", true)
        UIButtons.TimeLineActive("stage1", true)
        GUI.active_selection = UIEnums.RwGameBranch.Help
        UIScreen.SetNextScreen("Shared\\Help.lua", GUI.active_context)
        UIButtons.SetSelected(GUI.carousel_id, false)
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwGameBranch.Photo then
        UIButtons.TimeLineActive("end_bg", true)
        net_LockoutFriendsOverlay(true)
        GUI.going_photo = true
        UIScreen.SetNextScreen("Ingame\\PhotoMode.lua")
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwGameBranch.Quit then
        SetupCustomPopup(UIEnums.CustomPopups.ExitRace)
      elseif UIButtons.GetSelection(GUI.carousel_id, 2) == UIEnums.RwGameBranch.ReturnToLobby then
        SetupCustomPopup(UIEnums.CustomPopups.ReturnToLobby)
      end
    end
  end
  if _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.RetryRace and _ARG_3_ == UIEnums.PopupOptions.Yes then
    if Amax.SP_IsStreetRaceFD() == true or Amax.SP_IsDestructionFD() == true or Amax.SP_IsCheckpointFD() == true or Amax.SP_IsFanDemandFD() == true or Amax.SP_IsBossBattleFD() == true then
      FriendDemand.ReAttempt()
      Paused_EnableCarousel(false)
      GameProfile.RetryingEvent()
      StopIngameMusic()
      Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
      Amax.SendMessage(UIEnums.GameFlowMessage.StopGameUpdate)
      UIGlobals.IsQuickRestart = true
      UIGlobals.Ingame = {}
      GoLoadingScreen("Loading\\LoadingSpGame.lua")
    elseif UIGlobals.LoadFromDebug == true and IsTable(UIGlobals.Sp) == false then
      Paused_EnableCarousel(false)
      Paused_TransmitterOn()
      GameProfile.RetryingEvent()
      StopIngameMusic()
      Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
      Amax.SendMessage(UIEnums.GameFlowMessage.StopGameUpdate)
      UIGlobals.IsQuickRestart = true
      UIGlobals.Ingame = {}
      GoLoadingScreen("Loading\\LoadingGame.lua")
    else
      UIGlobals.GarageMiniFromPause = true
      PushScreen("Shared\\GarageMini.lua")
      StartAsyncSave()
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SsRetry and _ARG_3_ == UIEnums.PopupOptions.Yes and IsSplitScreen() == true then
    Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
    Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
    Amax.SendMessage(UIEnums.GameFlowMessage.StopGameUpdate)
    UIGlobals.IsQuickRestart = true
    UIGlobals.Ingame = {}
    StopIngameMusic()
    GoLoadingScreen("Loading\\LoadingMpGame.lua")
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if IsSplitScreen() == false and Multiplayer.RaceFinished() == true then
    GoScreen("Multiplayer\\Ingame\\MpFinished.lua")
  end
  if UIButtons.GetSelection(GUI.carousel_id, 2) ~= GUI.over_selection then
    if GUI.over_selection ~= -1 then
      UIButtons.PrivateTimeLineActive(GUI.node_id[GUI.over_selection], "Selected", false)
    end
    UIButtons.PrivateTimeLineActive(GUI.node_id[UIButtons.GetSelection(GUI.carousel_id, 2)], "Selected", true, 4.7)
    if GUI.active_selection == -1 then
      UIButtons.TimeLineActive("HelpFade", true, 0)
    end
    if CarouselIsAppLocked(UIButtons.GetSelection(GUI.carousel_id, 2)) == false then
    end
    UIButtons.ChangeText(GUI.help_text_id, GUI.help_text[UIButtons.GetSelection(GUI.carousel_id, 2)])
    if GUI.over_selection ~= -1 then
      CarouselSetApp(GUI, SCUI, GUI.over_selection, false)
    end
    CarouselSetApp(GUI, SCUI, UIButtons.GetSelection(GUI.carousel_id, 2))
    GUI.over_selection = UIButtons.GetSelection(GUI.carousel_id, 2)
  end
end
function Render()
end
function EnterEnd()
  UIButtons.TimeLineActive("sc_end_", true)
  UIButtons.TimeLineActive("HelpFade", false)
  if GUI.resume_game == false and GUI.going_photo == false then
    UIButtons.TimeLineActive("GoLoad", true)
  end
end
function EndLoop(_ARG_0_)
end
function End()
  EndScreen(UIEnums.Context.CarouselApp)
  Amax.SendMessage(UIEnums.GameFlowMessage.UnPause)
  if GUI.resume_game == true then
    Camera_UseInGame()
  end
end
function IsNetworkRace()
  return Amax.GetLevelData().NetworkRace
end
function Paused_EnableCarousel(_ARG_0_)
  UIButtons.SetSelected(ContextTable[UIEnums.Context.Main].GUI.carousel_id, _ARG_0_)
end
function Paused_TransmitterOn()
  UIButtons.SetActive(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.Txt_Loading, true, true)
end
function CarouselOpenFinished()
  UIButtons.SetSelected(ContextTable[UIEnums.Context.Main].GUI.carousel_id, true)
  UnlockController()
  for _FORV_4_, _FORV_5_ in pairs(GUI.branch_name) do
    UIButtons.TimeLineActive("fade_" .. _FORV_5_, true)
  end
end
