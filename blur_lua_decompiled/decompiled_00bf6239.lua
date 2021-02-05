GUI = {
  finished = false,
  menu_id = -1,
  selection = 1,
  options = {playlists = 1, custom_race = 2},
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
  GUI.helptext = {
    [GUI.options.playlists] = UIText.MP_HELP_TEXT_PLAYLISTS,
    [GUI.options.custom_race] = UIText.MP_HELP_TEXT_CUSTOM_GAME
  }
  GUI.menu_id = SCUI.name_to_id.menu
  Multiplayer.SplitscreenResetScores()
end
function PostInit()
  Amax.ChangeUiCamera("Mp_3", UIGlobals.CameraLerpTime, 0)
  GUI.node_id = {
    MpModeSelect_SetupItem(GUI.menu_id, UIText.MP_PLAYLISTS, GUI.options.playlists, "blur_events", true),
    MpModeSelect_SetupItem(GUI.menu_id, UIText.MP_CUSTOM_GAME, GUI.options.custom_race, "custom_game", true)
  }
  GUI.helpline_id, GUI.helpline_root_id = SetupBottomHelpBar(UIText.MP_HELP_TEXT_PLAYLISTS)
  UIButtons.PrivateTimeLineActive(GUI.node_id[GUI.options.playlists], "Selected", true, 4.2)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  click_overide = false
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
    click_overide = UIButtons.SetCurrentItemByID(GUI.menu_id, (UIButtons.GetParent(_ARG_2_)))
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or click_overide == true then
    if UIButtons.GetSelection(GUI.menu_id) == GUI.options.playlists then
      PlaySfxNext()
      net_MpEnterPlayMode(UIEnums.PlayMode.Playlist)
      PlaySfxGraphicNext()
      GoScreen("Multiplayer\\Shared\\MpPlaylists.lua")
    elseif UIButtons.GetSelection(GUI.menu_id) == GUI.options.custom_race then
      PlaySfxNext()
      Mp_ResetCustomRace()
      net_MpEnterPlayMode(UIEnums.PlayMode.CustomRace)
      Amax.SetupRace(MpModeSelect_CreateGame())
      if Amax.GetGameMode() == UIEnums.GameMode.Online then
        SetupCustomPopup(UIEnums.CustomPopups.MultiplayerCreateOnlineGame)
      elseif Amax.GetGameMode() == UIEnums.GameMode.SystemLink then
        if NetRace.CreateLanServer(MpModeSelect_CreateGame()) == true then
          PlaySfxGraphicNext()
          GoSubScreen("Multiplayer\\MpLobby.lua")
        else
          print("LAN - Failed to create game")
        end
      elseif Amax.GetGameMode() == UIEnums.GameMode.SplitScreen then
        PlaySfxGraphicNext()
        GoScreen("Multiplayer\\MpSplitscreenLobby.lua")
      end
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    PlaySfxBack()
    PlaySfxGraphicBack()
    if Amax.GetGameMode() == UIEnums.GameMode.SplitScreen then
      GoScreen("Multiplayer\\MpSplitscreenSignIn.lua")
    elseif Amax.GetGameMode() == UIEnums.GameMode.SystemLink then
      GoScreen("Multiplayer\\MpLan.lua")
    elseif Amax.GetGameMode() == UIEnums.GameMode.Online then
      GoScreen("Multiplayer\\MpOnline.lua")
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if UIButtons.GetSelection(GUI.menu_id) ~= GUI.selection then
    UIButtons.PrivateTimeLineActive(GUI.node_id[GUI.selection], "Selected", false)
    UIButtons.ChangeText(GUI.helpline_id, GUI.helptext[UIButtons.GetSelection(GUI.menu_id)])
    GUI.selection = UIButtons.GetSelection(GUI.menu_id)
    UIButtons.PrivateTimeLineActive(GUI.node_id[GUI.selection], "Selected", true, 0)
    UIButtons.TimeLineActive("HelpFade", true, 0.5)
  end
end
function EnterEnd()
  RestoreInfoLine()
  for _FORV_3_, _FORV_4_ in ipairs(GUI.node_id) do
    UIButtons.PrivateTimeLineActive(_FORV_4_, "End", true)
  end
end
function End()
end
function MpModeSelect_SetupItem(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Shape"), "fe_icons")
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Shape"), _ARG_3_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Title"), _ARG_1_)
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Title"), 0, 5, 0)
  UIButtons.AddListItem(_ARG_0_, UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), _ARG_2_)
  UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"), "Init", true, 0.5, true)
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "CarouselBranch"))
end
function MpModeSelect_CreateGame()
  UIGlobals.CustomRaceSettings.num_players = Select(Amax.GetGameMode() == UIEnums.GameMode.SplitScreen, #UIGlobals.Splitscreen.players, 1)
  return UIGlobals.CustomRaceSettings
end
