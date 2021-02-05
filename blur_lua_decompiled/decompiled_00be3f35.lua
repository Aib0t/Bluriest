GUI = {
  finished = false,
  carousel_branch = "MpLan",
  nodes = {},
  state = {searching = 1, finished = 2},
  current_state = 1,
  total_games = 0,
  items_table = {
    "index",
    "name",
    "players",
    "mode"
  },
  CanExit = function(_ARG_0_)
    PlaySfxGraphicBack()
    if net_CanReconnectToDemonware() == true then
      net_StartServiceConnection(true, nil)
    end
    return true
  end
}
function Init()
  AddSCUI_Elements()
  DeferCam_Init(UIGlobals.CameraNames.MpAppBase)
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_B_BACK, UIText.INFO_Y_HOST_GAME)
  GUI.lobby_list_id = SCUI.name_to_id.list
  for _FORV_3_ = 1, 10 do
    GUI.nodes[_FORV_3_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpLan.lua", "lobby_node")
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.nodes[_FORV_3_], "background_box"), Select(_FORV_3_ % 2 == 1, true, false))
    UIButtons.AddListItem(GUI.lobby_list_id, GUI.nodes[_FORV_3_], _FORV_3_ - 1)
  end
  _FOR_.CachePlaylists(UIEnums.GameMode.SystemLink)
  NetRace.EnumerateLanGames(true)
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.lobby_node, false)
  UIButtons.ChangePanel(SetupScreenTitle(UIText.MP_LAN, SCUI.name_to_id.locator, "system_link", "fe_icons"), UIEnums.Panel._3DAA_WORLD, true)
  if UIGlobals.Multiplayer.LobbyConnectionLost == true then
    UIGlobals.Multiplayer.LobbyConnectionLost = false
    SetupCustomPopup(UIEnums.CustomPopups.LostLobbyConnection)
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    if GUI.sessions_found > 0 then
      PlaySfxNext()
      UIGlobals.Network.LanEnumeratedGameIndexToJoin = UIButtons.GetSelection(GUI.lobby_list_id)
      if NetRace.CheckLanServerNetworkVersion(UIGlobals.Network.LanEnumeratedGameIndexToJoin) == UIEnums.Network.Version.eNetVersionSame then
        if NetRace.CheckLanServerNetworkVersion(UIGlobals.Network.LanEnumeratedGameIndexToJoin) == UIEnums.Network.Version.eNetVersionSame then
          SetupCustomPopup(UIEnums.CustomPopups.MultiplayerJoinLanGame)
          print("++++++++same version")
        elseif NetRace.CheckLanServerNetworkVersion(UIGlobals.Network.LanEnumeratedGameIndexToJoin) == UIEnums.Network.Version.eNetVersionOlder then
          UIGlobals.Network.JoinErrorCode = UIEnums.Network.JoinErrors.eJoinErrorPlaylistVerHost
          SetupCustomPopup(UIEnums.CustomPopups.MultiplayerJoinLanGameFailed)
          print("++++++++PV is older")
        elseif NetRace.CheckLanServerNetworkVersion(UIGlobals.Network.LanEnumeratedGameIndexToJoin) == UIEnums.Network.Version.eNetVersionNewer then
          UIGlobals.Network.JoinErrorCode = UIEnums.Network.JoinErrors.eJoinErrorPlaylistVerClient
          SetupCustomPopup(UIEnums.CustomPopups.MultiplayerJoinLanGameFailed)
          print("++++++++PV is newer")
        end
      else
        UIGlobals.Network.JoinVersionErrorCode = NetRace.CheckLanServerNetworkVersion(UIGlobals.Network.LanEnumeratedGameIndexToJoin)
        SetupCustomPopup(UIEnums.CustomPopups.MultiplayerVersionError)
        print("++++++++MultiplayerVersionError")
      end
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonX then
    if GUI.current_state == GUI.state.finished then
      NetRace.EnumerateLanGames(false)
      MpLan_RefreshLobbyList(0)
      NetRace.EnumerateLanGames(true)
      SetupInfoLine(UIText.INFO_B_BACK, UIText.INFO_Y_HOST_GAME)
      GUI.current_state = GUI.state.searching
      UIButtons.SetActive(SCUI.name_to_id.searching_branch, true)
      UISystem.PlaySound(UIEnums.SoundEffect.Filter)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonY then
    GoScreen("Multiplayer\\Shared\\MpModeSelect.lua")
    PlaySfxNext()
    PlaySfxGraphicNext()
  end
end
function StartLoop(_ARG_0_)
  DeferCam_Update(_ARG_0_)
end
function FrameUpdate(_ARG_0_)
  DeferCam_Update(_ARG_0_)
  if GUI.current_state == GUI.state.searching then
    if NetRace.NumLanServersEnumerated() ~= GUI.sessions_found then
      GUI.sessions_found = NetRace.NumLanServersEnumerated()
      for _FORV_5_ = 1, NetRace.NumLanServersEnumerated() do
        MpLan_SetupGame(GUI.nodes[_FORV_5_], _FORV_5_)
      end
    end
    if not _FOR_.IsEnumeratingLanGames() == true then
      GUI.current_state = GUI.state.finished
      UIButtons.SetActive(SCUI.name_to_id.searching_branch, false)
      print("LAN : Finished, games found ", (NetRace.NumLanServersEnumerated()))
      MpLan_RefreshLobbyList((NetRace.NumLanServersEnumerated()))
      if NetRace.NumLanServersEnumerated() > 0 then
        SetupInfoLine(UIText.INFO_JOIN_GAME, UIText.INFO_B_BACK, UIText.INFO_X_REFRESH, UIText.INFO_Y_HOST_GAME)
      else
        SetupCustomPopup(UIEnums.CustomPopups.NoLanGames)
        SetupInfoLine(UIText.INFO_B_BACK, UIText.INFO_X_REFRESH, UIText.INFO_Y_HOST_GAME)
      end
    end
  end
end
function EnterEnd()
  RestoreInfoLine()
end
function End()
  NetRace.EnumerateLanGames(false)
end
function MpLan_RefreshLobbyList(_ARG_0_)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.nodes) do
    if _ARG_0_ < _FORV_4_ then
      UIButtons.LockNode(_FORV_5_)
      for _FORV_9_, _FORV_10_ in pairs(GUI.items_table) do
        UIButtons.ChangeText(UIButtons.FindChildByName(_FORV_5_, _FORV_10_), UIText.CMN_DASH)
      end
    else
      UIButtons.UnlockNode(_FORV_5_)
    end
  end
  UIButtons.SetSelectionByIndex(GUI.lobby_list_id, 0)
  UIButtons.SetSelected(GUI.lobby_list_id, _ARG_0_ >= 1)
end
function MpLan_SetupGame(_ARG_0_, _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "index"), "GAME_NUM_" .. _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "name"), "LAN_HOST" .. _ARG_1_ - 1)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "players"), "LAN_PLAYERS" .. _ARG_1_ - 1)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "mode"), "LAN_MODE" .. _ARG_1_ - 1)
end
