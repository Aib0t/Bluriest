GUI = {
  finished = false,
  Selection = nil,
  PlaylistNodes = {},
  show_total_count = nil,
  show_count = nil,
  Options = {Scoreboards = 1},
  CanExit = function(_ARG_0_)
    return false
  end,
  CurrentEventSelectionIsLocked = false
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Mp_2", UIGlobals.CameraLerpTime, 0)
  StoreInfoLine()
  SetupInfoLine()
  Multiplayer.CachePlaylists(Amax.GetGameMode())
  UIGlobals.Splitscreen.can_vote = false
  GUI.Events = Multiplayer.GetPlaylists(Amax.IsGameModeRanked())
  GUI.MenuId = SCUI.name_to_id.menu
  for _FORV_3_, _FORV_4_ in ipairs(GUI.Events) do
    GUI.PlaylistNodes[_FORV_3_] = SetupPlaylist(_FORV_4_, _FORV_3_)
  end
  if Amax.IsGameModeRanked() == true then
    SetupInfoLine(UIText.INFO_FIND_GAME, UIText.INFO_B_BACK, UIText.MP_MATCHMAKING_OPTIONS)
    if NetServices.ConnectionStatusIsOnline() == true then
      NetServices.AllowPlayerCountUpdate()
    end
  else
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
  end
end
function PostInit()
  if #GUI.Events > 0 then
    GUI.CurrentEventSelectionIsLocked = GUI.Events[UIButtons.GetSelectionIndex(GUI.MenuId) + 1].locked
  else
    GUI.CurrentEventSelectionIsLocked = true
  end
  UIButtons.SetActive(SCUI.name_to_id.playlist_node, false)
  if NetServices.ConnectionStatusIsOnline() == false or Amax.IsGameModeRanked() == false then
    UIButtons.SetActive(SCUI.name_to_id.online_players_title, false, true)
  else
    MpPlaylist_ShowTotalPlayerCount()
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
    UIButtons.SetCurrentItemByID(GUI.MenuId, (UIButtons.GetParent(_ARG_2_)))
  end
  if Amax.IsGameModeRanked() == true then
    Multiplayer.EventViewed(UIButtons.GetSelectionIndex(GUI.MenuId))
    Mp_HideItemNew(GUI.MenuId, UIButtons.GetSelectionIndex(GUI.MenuId))
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or true == true then
    if GUI.Events[UIButtons.GetSelection(GUI.MenuId)].not_available == true or Amax.IsGameModeRanked() == true and GUI.Events[UIButtons.GetSelection(GUI.MenuId)].locked == true then
      PlaySfxError()
    else
      PlaySfxNext()
      Multiplayer.SetCurrentEventIndex(GUI.Events[UIButtons.GetSelection(GUI.MenuId)].playlist_index)
      if Amax.GetGameMode() == UIEnums.GameMode.Online then
        if Amax.IsGameModeRanked() == true then
          net_SetGroupPresence(GUI.Events[UIButtons.GetSelection(GUI.MenuId)].playlist_index)
          NetRace.SetRaceParameters(Playlist_OnlineSetupTable(true))
          NetRace.SetOnlineSessionEnumerationParameters(Playlist_OnlineSetupTable(true))
          SetupCustomPopup(UIEnums.CustomPopups.MultiplayerSearchOnlineGame)
        else
          Amax.SetupRace(Playlist_OnlineSetupTable(false))
          SetupCustomPopup(UIEnums.CustomPopups.MultiplayerCreateOnlineGame)
        end
      elseif Amax.GetGameMode() == UIEnums.GameMode.SystemLink then
        if NetRace.CreateLanServer(Playlist_LanSetupTable()) == true then
          GoSubScreen("Multiplayer\\MpLobby.lua")
        else
          print("LAN - Failed to create game")
        end
      elseif Amax.GetGameMode() == UIEnums.GameMode.SplitScreen then
        Amax.SetupRace(Playlist_SplitScreenSetupTable())
        PlaySfxGraphicNext()
        GoScreen("Multiplayer\\MpSplitscreenLobby.lua")
      end
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true then
    if Amax.IsGameModeRanked() == true then
      SetupCustomPopup(UIEnums.CustomPopups.MatchMakingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeft and _ARG_2_ == true then
    UIButtons.TimeLineActive("move_left", true, 0)
    if 1 <= UIButtons.GetSelectionIndex(GUI.MenuId) + 1 - 1 then
      Ranked_RefreshInfoLine(GUI.Events[UIButtons.GetSelectionIndex(GUI.MenuId) + 1 - 1].locked)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonRight and _ARG_2_ == true then
    UIButtons.TimeLineActive("move_right", true, 0)
    if UIButtons.GetSelectionIndex(GUI.MenuId) + 1 + 1 <= #GUI.Events then
      Ranked_RefreshInfoLine(GUI.Events[UIButtons.GetSelectionIndex(GUI.MenuId) + 1 + 1].locked)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    PlaySfxBack()
    PlaySfxGraphicBack()
    if Amax.IsGameModeRanked() == true then
      net_SetGroupPresence()
      GoScreen("Multiplayer\\MpOnline.lua")
    else
      GoScreen("Multiplayer\\Shared\\MpModeSelect.lua")
    end
  end
end
function FrameUpdate(_ARG_0_)
  if UIButtons.GetSelectionIndex(GUI.MenuId) ~= GUI.Selection then
    if GUI.Selection ~= nil then
      Amax.ChangeChildrenLayer(GUI.PlaylistNodes[GUI.Selection + 1], 1)
    end
    GUI.Selection = UIButtons.GetSelectionIndex(GUI.MenuId)
    Amax.ChangeChildrenLayer(GUI.PlaylistNodes[GUI.Selection + 1], 2)
    if UIButtons.GetSelectionIndex(GUI.MenuId) == 0 then
      UIButtons.TimeLineActive("left_fade", false)
      UIButtons.TimeLineActive("right_fade", true)
    elseif UIButtons.GetSelectionIndex(GUI.MenuId) == #GUI.Events - 1 then
      UIButtons.TimeLineActive("left_fade", true)
      UIButtons.TimeLineActive("right_fade", false)
    else
      UIButtons.TimeLineActive("left_fade", true)
      UIButtons.TimeLineActive("right_fade", true)
    end
    GUI.show_count = nil
  end
  if Amax.IsGameModeRanked() == true then
    MpPlaylist_ShowTotalPlayerCount()
  end
end
function EnterEnd()
  RestoreInfoLine()
end
function End()
  NetServices.StopPlayerCountUpdate()
end
function MpPlaylist_ShowTotalPlayerCount()
  if NetServices.ConnectionStatusIsOnline() == false then
    return
  end
  if NetServices.ShowTotalPlayerCount() ~= GUI.show_total_count then
    GUI.show_total_count = NetServices.ShowTotalPlayerCount()
    UIButtons.SetActive(SCUI.name_to_id.online_players_title, NetServices.ShowTotalPlayerCount(), true)
  end
end
function MpPlaylist_ShowPlaylistPlayerCount(_ARG_0_)
  if NetServices.ShowPlaylistPlayerCount(_ARG_0_) ~= GUI.show_count then
    GUI.show_count = NetServices.ShowPlaylistPlayerCount(_ARG_0_)
    if GUI.Events[_ARG_0_ + 1].locked == false then
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.PlaylistNodes[_ARG_0_ + 1], "players_title"), NetServices.ShowPlaylistPlayerCount(_ARG_0_), true)
    end
  end
end
function SetupPlaylist(_ARG_0_, _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "name"), "MPL_PLAYLIST_NAME" .. _ARG_0_.playlist_index)
  if _ARG_0_.not_available == true or Amax.IsGameModeRanked() == true and _ARG_0_.locked == true then
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "desc"), Select(_ARG_0_.not_available, UIText.MP_PLAYLIST_NOT_AVAILABLE, "MPL_UNLOCK_AT_RANK" .. _ARG_0_.rank))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "image"), UIEnums.EffectIndex.GreyScale)
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "name"), "Dark_White")
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "desc"), "Dark_white")
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "icon"), "Dark_White")
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "lock"), true)
  else
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "new"), Amax.IsGameModeRanked() == true and _ARG_0_.new == true)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "desc"), "MPL_PLAYLIST_DESC" .. _ARG_0_.playlist_index)
  end
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "icon"), _ARG_0_.icon_name)
  if _ARG_0_.image_name ~= nil then
    UIButtons.ChangeTexture({
      filename = _ARG_0_.image_name
    }, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "image")))
  end
  if NetServices.ConnectionStatusIsOnline() == false or Amax.IsGameModeRanked() == false or _ARG_0_.locked == true then
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "players_title"), false, true)
  else
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), "players"), "MPL_ACTIVE_PLAYERS" .. _ARG_0_.playlist_index)
  end
  UIButtons.AddListItem(GUI.MenuId, UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"), _ARG_1_)
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpPlaylists.lua", "playlist_node"))
end
function Ranked_RefreshInfoLine(_ARG_0_)
  if Amax.IsGameModeRanked() == false then
    return
  end
  if GUI.CurrentEventSelectionIsLocked == _ARG_0_ then
    return
  else
    SetupInfoLine()
    if _ARG_0_ == true then
      SetupInfoLine(UIText.INFO_B_BACK, UIText.MP_MATCHMAKING_OPTIONS)
    else
      SetupInfoLine(UIText.INFO_FIND_GAME, UIText.INFO_B_BACK, UIText.MP_MATCHMAKING_OPTIONS)
    end
    GUI.CurrentEventSelectionIsLocked = _ARG_0_
  end
end
function Playlist_OnlineSetupTable(_ARG_0_)
  return {
    num_players = 1,
    public_game = _ARG_0_,
    world_tour = true,
    user_created_group = false
  }
end
function Playlist_LanSetupTable(_ARG_0_)
  return {
    num_players = 1,
    public_game = _ARG_0_,
    world_tour = true,
    user_created_group = false
  }
end
function Playlist_SplitScreenSetupTable()
  return {
    num_players = #UIGlobals.Splitscreen.players
  }
end
