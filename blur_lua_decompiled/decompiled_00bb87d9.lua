UISystem.LoadLuaScript("Screens\\Multiplayer\\Shared\\MpCustomRaceHelper.lua")
function ServiceConnectionLost()
  if Amax.GetGameMode() ~= UIEnums.GameMode.Online or UIGlobals.UserKickBackMode ~= UIEnums.UserKickBackMode.XLSPConnectionLost and UIGlobals.UserKickBackMode ~= UIEnums.UserKickBackMode.None then
    return
  end
  if Amax.GetGameMode() == UIEnums.GameMode.Online and UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.None then
    return
  end
  if UIGlobals.IsLoading == true then
    print("ERROR - ServiceConnectionLost while on the loading screen")
    return
  end
  print("Connection to service lost!")
  Amax.KickedOutOfGame()
  ReturnToStartScreen(UIGlobals.UserKickBackMode)
end
function XLSPConnectionLost()
  if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
    return
  end
  if Amax.GetGameMode() ~= UIEnums.GameMode.Online or UserKickBackActive() == true then
    return
  end
  if UIGlobals.IsLoading == true then
    print("ERROR - XLSPConnectionLost while on the loading screen")
    return
  end
  print("Connection to LSP lost!")
  Amax.KickedOutOfGame()
  ReturnToStartScreen(UIEnums.UserKickBackMode.XLSPConnectionLost)
end
function LobbyConnectionLost()
  if UserKickBackActive() == true or UIGlobals.IdlePlayerKicked == true then
    return
  end
  print("LobbyConnectionLost!")
  UIGlobals.Multiplayer.LobbyConnectionLost = true
  net_DisconnectFromRace()
end
function NetworkCableRemoved()
  if Amax.GetGameMode() ~= UIEnums.GameMode.SystemLink or UserKickBackActive() == true then
    return
  end
  print("NetworkCableRemoved!")
  ReturnToStartScreen(UIEnums.UserKickBackMode.NetworkCableRemoved)
end
function MultiplayerBetaExpired()
  if UserKickBackActive() == true then
    return
  end
  print("Multiplayer Beta has expired!")
  ReturnToStartScreen(UIEnums.UserKickBackMode.MpBetaExpired)
end
function Mp_SetupMenuItem(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if _ARG_4_ ~= nil then
    UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "icon"), _ARG_4_)
  end
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "text"), _ARG_2_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "icon"), _ARG_3_)
  UIButtons.AddListItem(_ARG_0_, UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), _ARG_1_)
  UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "text"), "time_lines.0.label", "unknown")
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"))
end
function Mp_SetupMenuItemHelpText(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_)
  if IsString(_ARG_5_) == true then
    UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "icon"), _ARG_5_)
  end
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "helptext"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "text"), UIEnums.Justify.BottomLeft)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "text"), _ARG_2_)
  UIButtons.ChangeText(UIButtons.CloneXtGadgetByName("SCUIBank", "helptext"), _ARG_3_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "icon"), _ARG_4_)
  UIButtons.AddListItem(_ARG_0_, UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), _ARG_1_)
  if IsNumber(_ARG_6_) == true then
    UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), _ARG_6_, true)
    UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("SCUIBank", "helptext"), _ARG_6_, true)
  end
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"))
end
function Mp_SetupMenuItemCheckbox(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_4_ ~= nil then
    UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "icon"), _ARG_4_)
  end
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "checkbox_item"), UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), UIEnums.Justify.MiddleRight)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "text"), _ARG_2_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), "icon"), _ARG_3_)
  UIButtons.AddListItem(_ARG_0_, UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"), _ARG_1_)
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "node_item"))
end
function Mp_LockMenuItem(_ARG_0_, _ARG_1_, _ARG_2_)
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.GetNodeID(_ARG_0_, _ARG_1_), "text"), "dark_white")
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.GetNodeID(_ARG_0_, _ARG_1_), "icon"), "dark_white")
  if _ARG_2_ ~= nil then
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.GetNodeID(_ARG_0_, _ARG_1_), "helptext"), "dark_white")
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.GetNodeID(_ARG_0_, _ARG_1_), "helptext"), "MPL_UNLOCK_AT_RANK" .. _ARG_2_)
  end
  UIButtons.SetNodeItemLocked(_ARG_0_, _ARG_1_, true)
end
function Mp_UnlockMenuItem(_ARG_0_, _ARG_1_)
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.GetNodeID(_ARG_0_, _ARG_1_), "text"), "NonBloomWhite")
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.GetNodeID(_ARG_0_, _ARG_1_), "icon"), "Main_2")
  UIButtons.SetNodeItemLocked(_ARG_0_, _ARG_1_, false)
end
function Mp_ShowItemNew(_ARG_0_, _ARG_1_)
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.GetNodeID(_ARG_0_, _ARG_1_), "new"), true)
end
function Mp_HideItemNew(_ARG_0_, _ARG_1_)
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.GetNodeID(_ARG_0_, _ARG_1_), "new"), false)
end
function Mp_SetupGroupDetailItem(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "detail_node"), "detail_icon"), _ARG_3_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "detail_node"), "detail_icon"), _ARG_2_)
  UIButtons.AddListItem(_ARG_0_, (UIButtons.CloneXtGadgetByName("SCUIBank", "detail_node")))
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "detail_node"))
end
function Mp_RankIcon(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ ~= nil and _ARG_1_ ~= nil then
    if _ARG_2_ > 0 then
      _ARG_1_ = Multiplayer.GetMaxRank() + _ARG_2_ - 1
    end
    UIButtons.ChangeTexture({
      filename = "rank_icons",
      name = "rank_icons",
      pos = {
        u = 0.015625 * _ARG_1_,
        v = 0
      },
      size = {u = 0.015625, v = 1}
    }, 0, _ARG_0_)
  end
end
function Mp_RouteThumbnail(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_1_ == nil then
    return
  end
  if _ARG_2_ == nil then
    _ARG_2_ = 0
  end
  UIButtons.ChangeTexture({
    filename = _ARG_1_,
    name = _ARG_1_,
    pos = {u = 0, v = 0},
    size = {u = 1, v = 1}
  }, _ARG_2_, _ARG_0_)
end
function Mp_RaceTypeIcon(_ARG_0_, _ARG_1_)
  if _ARG_1_ == nil then
    return
  end
  if _ARG_1_.type == UIEnums.MpRaceType.Racing then
  elseif _ARG_1_.type == UIEnums.MpRaceType.Elimination then
  elseif _ARG_1_.type == UIEnums.MpRaceType.Points then
  elseif _ARG_1_.type == UIEnums.MpRaceType.Destruction then
  else
  end
  UIShape.ChangeObjectName(_ARG_0_, "style_racing")
end
function Mp_RaceEndIcon(_ARG_0_, _ARG_1_)
  if _ARG_1_ == nil then
    return
  end
  if _ARG_1_.type == UIEnums.MpRaceType.Racing then
    if _ARG_1_.laps > 0 then
    else
    end
  elseif _ARG_1_.type == UIEnums.MpRaceType.Elimination then
  elseif _ARG_1_.type == UIEnums.MpRaceType.Points then
    if _ARG_1_.laps > 0 then
    elseif 0 < _ARG_1_.score_limit then
    else
    end
  else
  end
  UIShape.ChangeObjectName(_ARG_0_, "stopwatch")
end
function Mp_RaceWinIcon(_ARG_0_, _ARG_1_)
  if _ARG_1_ == nil then
    return
  end
  UIShape.ChangeObjectName(_ARG_0_, "end_of_race")
end
function Mp_ReturnToPartyLobby()
  FlushSubscreens()
  if UIGlobals.IsIngame == true then
    UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.PartyLobby
    GoScreen("Loading\\LoadingUi.lua")
  elseif UIScreen.GetCurrentScreen(UIEnums.Context.CarouselApp) ~= GUINetwork.multiplayer_party_root then
    GoScreen(GUINetwork.multiplayer_party_root, UIEnums.Context.CarouselApp)
  end
end
function Mp_RefreshRaceOverview(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_2_ == nil then
    _ARG_2_ = Multiplayer.GetCurrentRaceIndex()
  end
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "city"), Select(Amax.GetPlayMode() == UIEnums.PlayMode.Playlist, "MPL_PLAYLIST_RACE" .. _ARG_2_, "MPL_CUSTOM_RACE") .. "_CITY")
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "route"), Select(Amax.GetPlayMode() == UIEnums.PlayMode.Playlist, "MPL_PLAYLIST_RACE" .. _ARG_2_, "MPL_CUSTOM_RACE") .. "_ROUTE")
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "mode"), Select(Amax.GetPlayMode() == UIEnums.PlayMode.Playlist, "MPL_PLAYLIST_RACE" .. _ARG_2_, "MPL_CUSTOM_RACE") .. "_TYPE")
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "class"), Select(Amax.GetPlayMode() == UIEnums.PlayMode.Playlist, "MPL_PLAYLIST_RACE" .. _ARG_2_, "MPL_CUSTOM_RACE") .. "_CLASS")
  if _ARG_1_.type == UIEnums.MpRaceType.Racing or _ARG_1_.type == UIEnums.MpRaceType.Hardcore then
    if UIButtons.FindChildByName(_ARG_0_, "laps") ~= nil and UIButtons.FindChildByName(_ARG_0_, "num_laps") ~= nil and UIButtons.FindChildByName(_ARG_0_, "time") ~= nil then
      UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "laps"), true, true)
      UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "time"), false, true)
      UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "num_laps"), Select(Amax.GetPlayMode() == UIEnums.PlayMode.Playlist, "MPL_PLAYLIST_RACE" .. _ARG_2_, "MPL_CUSTOM_RACE") .. "_LAPS")
      UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "laps"), Select(Amax.GetPlayMode() == UIEnums.PlayMode.Playlist, "MPL_PLAYLIST_RACE" .. _ARG_2_, "MPL_CUSTOM_RACE") .. "_LAP_TEXT")
    end
  elseif UIButtons.FindChildByName(_ARG_0_, "laps") ~= nil and UIButtons.FindChildByName(_ARG_0_, "num_laps") ~= nil and UIButtons.FindChildByName(_ARG_0_, "time") ~= nil then
    UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "laps"), false, true)
    UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "time"), true, true)
    UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "time"), Select(Amax.GetPlayMode() == UIEnums.PlayMode.Playlist, "MPL_PLAYLIST_RACE" .. _ARG_2_, "MPL_CUSTOM_RACE") .. "_TIME")
  end
  if UIButtons.FindChildByName(_ARG_0_, "city_icon") ~= nil then
    UIShape.ChangeObjectName(UIButtons.FindChildByName(_ARG_0_, "city_icon"), Amax.GetCityIconName(_ARG_1_.city))
  end
  if UIButtons.FindChildByName(_ARG_0_, "class_icon") ~= nil then
    UIShape.ChangeObjectName(UIButtons.FindChildByName(_ARG_0_, "class_icon"), UIGlobals.ClassIcons[_ARG_1_.class])
  end
  Mp_RaceTypeIcon(UIButtons.FindChildByName(_ARG_0_, "mode_icon"), _ARG_1_)
  if UIButtons.FindChildByName(_ARG_0_, "thumbnail") ~= nil then
    Mp_RouteThumbnail(UIButtons.FindChildByName(_ARG_0_, "thumbnail"), _ARG_1_.thumbnail, 1)
  end
  if _ARG_3_ ~= false then
    if UIButtons.GetStaticTextLength((UIButtons.FindChildByName(_ARG_0_, "city"))) > UIButtons.GetStaticTextLength((UIButtons.FindChildByName(_ARG_0_, "route"))) then
      UIButtons.ChangePosition(UIButtons.FindChildByName(_ARG_0_, "city"), 2.5 - UIButtons.GetStaticTextLength((UIButtons.FindChildByName(_ARG_0_, "city"))) * 0.5, UIButtons.GetPosition((UIButtons.FindChildByName(_ARG_0_, "city"))))
    else
      UIButtons.ChangePosition(UIButtons.FindChildByName(_ARG_0_, "city"), 2.5 - UIButtons.GetStaticTextLength((UIButtons.FindChildByName(_ARG_0_, "route"))) * 0.5, UIButtons.GetPosition((UIButtons.FindChildByName(_ARG_0_, "city"))))
    end
  end
end
function Mp_SetupPlayerProgressBar(_ARG_0_)
  GUI.Progression = Multiplayer.ProfileProgression()
  if GUI.Progression.maxed == false then
  end
  UIButtons.ChangeSize(UIButtons.FindChildByName(_ARG_0_, "progress"), UIButtons.GetSize(UIButtons.FindChildByName(_ARG_0_, "backing")) * ((GUI.Progression.fans - Multiplayer.LevelProgressionData(GUI.Progression.level).fans_previous) / (Multiplayer.LevelProgressionData(GUI.Progression.level).fans_needed - Multiplayer.LevelProgressionData(GUI.Progression.level).fans_previous)), UIButtons.GetSize(UIButtons.FindChildByName(_ARG_0_, "backing")))
end
function Mp_XenonGameInviteAvailable()
  if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon and NetServices.GameInviteBeingSent() == false and NetRace.CanSendGameInvite() == true then
    return true
  end
  return false
end
function Mp_XenonPartyInviteAvailable()
  if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon and NetServices.GameInviteBeingSent() == false and NetParty.CanSendGameInvite() == true then
    return true
  end
  return false
end
function Mp_XenonPartyActive()
  if UIEnums.CurrentPlatform ~= UIEnums.Platform.Xenon then
    return false
  end
  return NetServices.IsInExternalPartySession()
end
function Mp_ResetCustomRace()
  UIGlobals.CustomRaceSettings = {
    num_players = nil,
    game_mode = Multiplayer.GetCustomRaceDefaults().game_mode,
    city_id = Multiplayer.GetCustomRaceDefaults().city,
    route_id = Multiplayer.GetCustomRaceDefaults().route,
    laps = Multiplayer.GetCustomRaceDefaults().laps,
    time = Multiplayer.GetCustomRaceDefaults().time,
    class = Multiplayer.GetCustomRaceDefaults().class,
    damage = Multiplayer.GetCustomRaceDefaults().damage,
    respawn = Multiplayer.GetCustomRaceDefaults().respawn,
    timeout = Multiplayer.GetCustomRaceDefaults().timeout,
    mods = Multiplayer.GetCustomRaceDefaults().mods,
    upgrades = Multiplayer.GetCustomRaceDefaults().upgrades,
    lock_host = Multiplayer.GetCustomRaceDefaults().lock_host,
    ai = Multiplayer.GetCustomRaceDefaults().ai,
    ai_padding = Multiplayer.GetCustomRaceDefaults().ai_padding,
    handicap = Multiplayer.GetCustomRaceDefaults().handicap,
    powerups = {
      nitro = true,
      repair = true,
      shock = true,
      barge = true,
      mine = true,
      shunt = true,
      bolt = true,
      shield = true
    },
    powerup_respawn = Multiplayer.GetCustomRaceDefaults().powerup_respawn,
    random_powerups = Multiplayer.GetCustomRaceDefaults().random_powerups
  }
end
function Mp_ReadCustomRaceSettings()
  UIGlobals.CustomRaceSettings = {
    num_players = Select(Amax.GetGameMode() == UIEnums.GameMode.SplitScreen, #UIGlobals.Splitscreen.players, 1),
    game_mode = Multiplayer.GetCustomRaceSettings().game_mode,
    city_id = Multiplayer.GetCustomRaceSettings().city_id,
    route_id = Multiplayer.GetCustomRaceSettings().route_id,
    laps = Multiplayer.GetCustomRaceSettings().laps,
    time = Multiplayer.GetCustomRaceSettings().time,
    class = Multiplayer.GetCustomRaceSettings().class,
    damage = Multiplayer.GetCustomRaceSettings().damage,
    respawn = Multiplayer.GetCustomRaceSettings().respawn,
    timeout = Multiplayer.GetCustomRaceSettings().timeout,
    mods = Multiplayer.GetCustomRaceSettings().mods,
    upgrades = Multiplayer.GetCustomRaceSettings().upgrades,
    lock_host = Multiplayer.GetCustomRaceSettings().lock_host,
    ai = Multiplayer.GetCustomRaceSettings().ai,
    ai_padding = Multiplayer.GetCustomRaceSettings().ai_padding,
    handicap = Multiplayer.GetCustomRaceSettings().handicap,
    powerups = Multiplayer.GetCustomRaceSettings().powerups,
    powerup_respawn = Multiplayer.GetCustomRaceSettings().powerup_respawn,
    random_powerups = Multiplayer.GetCustomRaceSettings().random_powerups
  }
end
function Mp_ResetSpectateVars()
  UIGlobals.Mp_SpectateCurrentVehicle = Amax.GetPlayerVehicleIndex(0)
  UIGlobals.Mp_SpectateCurrentCamera = 1
end
