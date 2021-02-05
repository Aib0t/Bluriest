GUI = {
  finished = false,
  can_invite = false,
  party_running = nil,
  party_ready = nil,
  party_toggle = false,
  lobby_active = false,
  update_menu = nil,
  Options = {
    RankedEvents = 1,
    PrivateRace = 2,
    ModShop = 3,
    Showroom = 4,
    Challenges = 5,
    Leaderboards = 6,
    Legend = 7,
    Invite = 8,
    RaceHistory = 9
  },
  Players = {},
  Selection = -1,
  table_map = {
    "party_running",
    "lobby_active",
    "nxe_party",
    "share"
  },
  change_table = {
    party_running = nil,
    lobby_active = nil,
    nxe_party = nil,
    social_network = nil
  },
  CanExit = function(_ARG_0_)
    if NetParty.IsRunning() == true then
      return false
    else
      UIButtons.TimeLineActive("fade_vignette", false)
      PlaySfxGraphicBack()
      return true
    end
  end
}
function Init()
  AddSCUI_Elements()
  DeferCam_Init(UIGlobals.CameraNames.MpAppBase)
  StoreInfoLine()
  Online_RefreshInfoLines()
  net_SetRichPresence(UIEnums.RichPresence.OnlineMain)
  UIButtons.TimeLineActive("status_info", true)
  GUI.MenuId = SCUI.name_to_id.menu
  GUI.Lobby = SCUI.name_to_id.lobby
  Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.RankedEvents, UIText.MP_RANKED, UIText.MP_HELP_TEXT_RANKED, "ranked_Groups", nil, UIEnums.Panel._3DAA_WORLD, true)
  Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.PrivateRace, UIText.MP_PRIVATE_RACE, UIText.MP_HELP_TEXT_PRIVATE_RACE, "main_groups", nil, UIEnums.Panel._3DAA_WORLD, true)
  Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.ModShop, UIText.MP_MOD_SHOP, UIText.MP_HELP_TEXT_MOD_SHOP, "custom_shop", "common_icons", UIEnums.Panel._3DAA_WORLD, true)
  Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.Showroom, UIText.MP_SHOWROOM, UIText.MP_HELP_TEXT_SHOWROOM, "garage", "common_icons", UIEnums.Panel._3DAA_WORLD, true)
  Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.Challenges, UIText.MP_CHALLENGES, UIText.MP_HELP_TEXT_CHALLENGES, "challenge", nil, UIEnums.Panel._3DAA_WORLD, true)
  Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.Leaderboards, UIText.MP_LEADERBOARD, UIText.MP_HELP_TEXT_LEADERBOARD, "leaderboards", nil, UIEnums.Panel._3DAA_WORLD, true)
  Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.RaceHistory, UIText.RBC_RACE_HISTORY, UIText.RBU_TABHELP_RACE_HISTORY, "Style_racing", "common_icons", UIEnums.Panel._3DAA_WORLD, true)
  Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.Invite, UIText.MP_INVITE, "LOBBY_INVITE_HELPTEXT", "create_party", nil, UIEnums.Panel._3DAA_WORLD, true)
  if Multiplayer.UnlockedLegend() == true then
    UIButtons.ChangePosition(GUI.MenuId, 0, 1, 0, true)
    Mp_SetupMenuItemHelpText(GUI.MenuId, GUI.Options.Legend, UIText.MP_LEGEND_MODE, UIText.MP_HELP_LEGEND_MODE, "legend", nil, UIEnums.Panel._3DAA_WORLD)
  end
  if Multiplayer.GetFeatureUnlocked(UIEnums.MPFeatures.ModShop) == false then
    Mp_LockMenuItem(GUI.MenuId, GUI.Options.ModShop - 1, Multiplayer.GetFeatureUnlockedMap()[UIEnums.MPFeatures.ModShop])
  end
  if Multiplayer.GetNewUnlocks().mods == true and Multiplayer.GetFeatureUnlocked(UIEnums.MPFeatures.ModShop) == true then
    Mp_ShowItemNew(GUI.MenuId, GUI.Options.ModShop - 1)
  end
  if Multiplayer.GetNewUnlocks().events == true then
    Mp_ShowItemNew(GUI.MenuId, GUI.Options.RankedEvents - 1)
  end
  for _FORV_5_, _FORV_6_ in pairs(Multiplayer.GetNewCarsMap()) do
    if _FORV_6_ == true then
      Mp_ShowItemNew(GUI.MenuId, GUI.Options.Showroom - 1)
      break
    end
  end
  if Multiplayer.GetNewUnlocks().challenges == true then
    Mp_ShowItemNew(GUI.MenuId, GUI.Options.Challenges - 1)
  end
  GUI.Progression = Multiplayer.ProfileProgression()
  UIButtons.ChangeText(SCUI.name_to_id.player_gamertag, "PROFILE_PAD" .. Profile.GetPrimaryPad() .. "_NAME")
  LocalGamerPicture(SCUI.name_to_id.gamerpic, (Profile.GetPrimaryPad()))
  Mp_RankIcon(SCUI.name_to_id.player_rank, GUI.Progression.level - 1, GUI.Progression.legend)
  GUI.Progression = Multiplayer.ProfileProgression()
  if GUI.Progression.maxed == false then
  end
  UIButtons.ChangeSize(SCUI.name_to_id.progress, UIButtons.GetSize(SCUI.name_to_id.backing) * ((GUI.Progression.fans - Multiplayer.LevelProgressionData(GUI.Progression.level).fans_previous) / (Multiplayer.LevelProgressionData(GUI.Progression.level).fans_needed - Multiplayer.LevelProgressionData(GUI.Progression.level).fans_previous)), UIButtons.GetSize(SCUI.name_to_id.backing))
  for _FORV_17_, _FORV_18_ in ipairs({
    {
      stat = "MPL_STATS_RATING",
      help = UIText.MP_STAT_HELP_RATING,
      icon = "points_target",
      file = "common_icons"
    },
    {
      stat = "MPL_STATS_POWERUP_RATIO",
      help = UIText.MP_STAT_HELP_POWERUPS,
      icon = "Perk_Hit",
      file = "fe_icons"
    },
    {
      stat = "MPL_STATS_TOTAL_PLAYTIME",
      help = UIText.MP_STAT_HELP_PLAYTIME,
      icon = "stopwatch",
      file = "common_icons"
    }
  }) do
    UIButtons.SetParent(SetupStat(_FORV_18_.stat, _FORV_18_.help, _FORV_18_.icon, _FORV_18_.file, 5.5, -9), SCUI.name_to_id.player_frame, UIEnums.Justify.BottomLeft)
  end
  for _FORV_18_, _FORV_19_ in ipairs({
    {
      stat = "MPL_STATS_TOTAL_WINS",
      help = UIText.MP_STAT_HELP_TOTAL_WINS,
      icon = "powered_up_racing",
      file = "common_icons"
    },
    {
      stat = "MPL_STATS_TOTAL_RACES",
      help = UIText.MP_STAT_HELP_TOTAL_RACES,
      icon = "end_of_race",
      file = "common_icons"
    },
    {
      stat = "MPL_STATS_TOTAL_FANS",
      help = UIText.MP_STAT_HELP_TOTAL_FANS,
      icon = "fan",
      file = "common_icons"
    }
  }) do
    UIButtons.SetParent(SetupStat(_FORV_19_.stat, _FORV_19_.help, _FORV_19_.icon, _FORV_19_.file, 26, -9), SCUI.name_to_id.player_frame, UIEnums.Justify.BottomLeft)
  end
  GUI.PlayerList = SCUI.name_to_id.player_list
  for _FORV_18_ = 1, NetParty.GetMaxPartySize() do
    GUI.Players[_FORV_18_] = SetupRacer(UIButtons.CloneXtGadgetByName("Multiplayer\\MpOnline.lua", "mp_player"), _FORV_18_ - 1)
    UIButtons.AddListItem(GUI.PlayerList, UIButtons.CloneXtGadgetByName("Multiplayer\\MpOnline.lua", "mp_player"), _FORV_18_)
  end
  _FOR_()
  UIGlobals.Multiplayer.InPartyLobby = true
end
function PostInit()
  GUI.help_text_id, GUI.bottom_help_id = SetupBottomHelpBar(UIText.MP_MESSAGE_OF_THE_DAY)
  UIButtons.SetActive(SCUI.name_to_id.stat, false, true)
  UIButtons.SetActive(SCUI.name_to_id.mp_player, false)
  RefreshLobby()
  RestoreScreenSelection(GUI, "MenuId")
  if NetParty.IsRunning() == true then
    GUI.party_running = NetParty.IsRunning()
    net_EnterPartyLobby(false)
    UIButtons.TimeLineActive("show_party", true)
    if CanEnterMatchmaking() == false then
      Mp_LockMenuItem(GUI.MenuId, GUI.Options.RankedEvents - 1)
      Mp_LockMenuItem(GUI.MenuId, GUI.Options.PrivateRace - 1)
    end
  end
  if UIGlobals.Multiplayer.NotEnoughPlayersKick == true then
    UIGlobals.Multiplayer.NotEnoughPlayersKick = false
    SetupCustomPopup(UIEnums.CustomPopups.MultiplayerWorldTourNotEnoughPlayers)
  elseif UIGlobals.Multiplayer.LobbyConnectionLost == true then
    EndScreen(UIEnums.Context.Blurb)
    UIGlobals.Multiplayer.LobbyConnectionLost = false
    SetupCustomPopup(UIEnums.CustomPopups.LostLobbyConnection)
  end
  UpdateMpStatusBar()
  if UIGlobals.Network.VoiceChatRestricted == true then
    SetupCustomPopup(UIEnums.CustomPopups.PS3NoVoiceAllowed)
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ == UIEnums.Message.ChangeScreen and _ARG_1_ == 0 then
    UIButtons.SetParent(SCUI.name_to_id.gamerpic, nil)
    UIButtons.SetActive(SCUI.name_to_id.gamerpic, false, true)
  end
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or UIButtons.SetCurrentItemByID(GUI.MenuId, (UIButtons.GetParent(_ARG_2_))) == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    if GUI.lobby_active == true then
      if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon and GUI.Slots[UIButtons.GetSelection(GUI.PlayerList)].empty == false then
        UIGlobals.Multiplayer.SelectPlayerJoinRef = GUI.Slots[UIButtons.GetSelection(GUI.PlayerList)].ref
        SetupCustomPopup(UIEnums.CustomPopups.ViewPlayer)
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.RankedEvents then
      if CanEnterMatchmaking() == true then
        NetParty.EnableMatchingQoS(false)
        NetParty.EnterMatchmaking()
        net_MpEnterPlayMode(UIEnums.PlayMode.Playlist, true)
        GoScreen("Multiplayer\\Shared\\MpPlaylists.lua")
        PlaySfxNext()
        PlaySfxGraphicNext()
      else
        PlaySfxError()
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.PrivateRace then
      if CanEnterMatchmaking() == true then
        NetParty.EnableMatchingQoS(false)
        NetParty.EnterMatchmaking()
        GoScreen("Multiplayer\\Shared\\MpModeSelect.lua")
        PlaySfxNext()
        PlaySfxGraphicNext()
      else
        PlaySfxError()
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.Challenges then
      GoScreen("Multiplayer\\Challenges\\MpChallenges.lua")
      PlaySfxNext()
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.ModShop then
      if Multiplayer.GetFeatureUnlocked(UIEnums.MPFeatures.ModShop) == true then
        GoScreen("Multiplayer\\ModShop\\MpModShop.lua")
        PlaySfxNext()
      else
        PlaySfxError()
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.Showroom then
      GoScreen("Shared\\Garage.lua")
      UISystem.PlaySound(UIEnums.SoundEffect.GarageSelect)
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.Leaderboards then
      GoScreen("Multiplayer\\MpChooseLeaderboard.lua")
      PlaySfxNext()
      PlaySfxGraphicNext()
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.Invite then
      if NetParty.IsRunning() == false then
        SetupCustomPopup(UIEnums.CustomPopups.MultiplayerCreateOnlineParty)
      elseif UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
        if Mp_XenonPartyActive() == true then
          UIHardware.ShowParty360(Profile.GetPrimaryPad())
        else
          UIHardware.ShowFriends360(Profile.GetPrimaryPad())
        end
      elseif UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
        Amax.FakeOpenFriendsList()
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.Legend then
      SetupCustomPopup(UIEnums.CustomPopups.ConfirmLegendMode)
    elseif UIButtons.GetSelection(GUI.MenuId) == GUI.Options.RaceHistory then
      GoScreen("Shared\\RaceHistory.lua")
      PlaySfxNext()
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonX then
    if Mp_XenonPartyActive() == true then
      NetServices.ShowSystemCommunityUI()
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonRight and _ARG_2_ == true then
    if NetParty.IsRunning() == true then
      ToggleLobby(true)
      UISystem.PlaySound(UIEnums.SoundEffect.Right)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeft and _ARG_2_ == true then
    if NetParty.IsRunning() == true then
      ToggleLobby(false)
      UISystem.PlaySound(UIEnums.SoundEffect.Left)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    if NetParty.IsRunning() == true then
      SetupCustomPopup(UIEnums.CustomPopups.ExitPartyLobby)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
    if Amax.CanUseShare() == true then
      SetupCustomPopup(UIEnums.CustomPopups.MPOnlineSharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      if UIGlobals.SharingOptionsChosen == UIEnums.MPOnlineSharingOptions.LegendRank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.LegendRank, 1, -1)
      elseif UIGlobals.SharingOptionsChosen > UIEnums.MPOnlineSharingOptions.Rank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPBlurEventRating + UIGlobals.SharingOptionsChosen - 1, 1, -1)
      else
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPPlayersRank, 1, -1)
      end
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Multiplayer\\MpOnline.lua")
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
      if UIGlobals.SharingOptionsChosen == UIEnums.MPOnlineSharingOptions.LegendRank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.LegendRank, 0, -1)
      elseif UIGlobals.SharingOptionsChosen > UIEnums.MPOnlineSharingOptions.Rank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPBlurEventRating + UIGlobals.SharingOptionsChosen - 1, 0, -1)
      else
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPPlayersRank, 0, -1)
      end
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Multiplayer\\MpOnline.lua")
      GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      if UIGlobals.SharingOptionsChosen == UIEnums.MPOnlineSharingOptions.LegendRank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.LegendRank, 2, -1)
      elseif UIGlobals.SharingOptionsChosen > UIEnums.MPOnlineSharingOptions.Rank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPBlurEventRating + UIGlobals.SharingOptionsChosen - 1, 2, -1)
      else
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPPlayersRank, 2, -1)
      end
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    if GUI.MainMenuActive == false then
      ShowChallengePacks(false)
    else
      GoScreen("Multiplayer\\MpMain.lua")
    end
  elseif getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonBack then
    UIScreen.SpawnFriendScreen()
  end
end
function StartLoop(_ARG_0_)
  DeferCam_Update(_ARG_0_)
end
function FrameUpdate(_ARG_0_)
  DeferCam_Update(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if Multiplayer.RefreshLobby(GUI.Lobby) == true then
    RefreshLobby()
  end
  UpdateVoiceInfo()
  if GUI.party_running ~= NetParty.IsRunning() and UIScreen.IsPopupActive() == false then
    GUI.party_running = NetParty.IsRunning()
    UIButtons.TimeLineActive("show_party", GUI.party_running)
    if GUI.party_running == true and NetParty.IsHost() == true then
      if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
        if Mp_XenonPartyActive() == true then
          UIHardware.ShowParty360(Profile.GetPrimaryPad())
        else
          UIHardware.ShowFriends360(Profile.GetPrimaryPad())
        end
      elseif UIEnums.CurrentPlatform == UIEnums.Platform.PS3 or UIEnums.CurrentPlatform == UIEnums.Platform.PC then
        Profile.SetFriendsActive(true)
        Amax.FakeOpenFriendsList()
      end
    elseif GUI.party_running == false then
      Mp_UnlockMenuItem(GUI.MenuId, GUI.Options.RankedEvents - 1)
      Mp_UnlockMenuItem(GUI.MenuId, GUI.Options.PrivateRace - 1)
      ToggleLobby(false)
    end
  end
  if NetParty.IsRunning() == true and GUI.party_ready ~= CanEnterMatchmaking() then
    GUI.party_ready = CanEnterMatchmaking()
    if GUI.party_ready == true then
      Mp_UnlockMenuItem(GUI.MenuId, GUI.Options.RankedEvents - 1)
      Mp_UnlockMenuItem(GUI.MenuId, GUI.Options.PrivateRace - 1)
    else
      Mp_LockMenuItem(GUI.MenuId, GUI.Options.RankedEvents - 1)
      Mp_LockMenuItem(GUI.MenuId, GUI.Options.PrivateRace - 1)
    end
  end
  if UIGlobals.Network.RaceInviteState == UIEnums.MpRaceInviteState.Initialising and UIScreen.IsPopupActive() == false then
    UIGlobals.Network.RaceInviteState = UIEnums.MpRaceInviteState.PreProcessing
  end
  Online_RefreshInfoLines()
end
function EnterEnd()
  RestoreInfoLine()
end
function End()
  UIGlobals.Multiplayer.InPartyLobby = false
  StoreScreenSelection(GUI, "MenuId")
  UIButtons.TimeLineActive("status_info", false)
end
function SetupStat(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  UIButtons.ChangeText(UIButtons.CloneXtGadgetByName("Multiplayer\\MpOnline.lua", "stat"), _ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpOnline.lua", "stat"), "stat_help"), _ARG_1_)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpOnline.lua", "stat"), "stat_icon"), _ARG_3_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpOnline.lua", "stat"), "stat_icon"), _ARG_2_)
  UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("Multiplayer\\MpOnline.lua", "stat"), _ARG_4_, _ARG_5_, 0)
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\MpOnline.lua", "stat"))
end
function SetupRacer(_ARG_0_, _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "gamertag"), "LOBBY_PARTY_PLAYER_NAME" .. _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "rank"), "LOBBY_PARTY_PLAYER_RANK" .. _ARG_1_)
  return _ARG_0_
end
function RefreshLobby()
  GUI.Slots = Multiplayer.GetLobbySlots(GUI.Lobby)
  GUI.GamerPictures = Profile.GetRemoteGamerPictureMap()
  for _FORV_3_, _FORV_4_ in ipairs(GUI.Slots) do
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "rank_icon"), not _FORV_4_.empty, true, false)
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "empty"), _FORV_4_.empty)
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "host"), _FORV_4_.party_host)
    UIButtons.PrivateTimeLineActive(GUI.Players[_FORV_3_], "player_active", not _FORV_4_.empty)
    UIButtons.PrivateTimeLineActive(GUI.Players[_FORV_3_], "player_racing", false)
    UIButtons.SetNodeItemLocked(GUI.PlayerList, _FORV_3_ - 1, _FORV_4_.empty)
    UIButtons.GetStaticTextLength(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "rank"), true)
    if _FORV_3_ == 1 then
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "gamertag"), "Support_4")
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "frame"), "Support_4")
      LocalGamerPicture(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "gamer_picture"), Profile.GetPrimaryPad())
      Mp_RankIcon(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "rank_icon"), _FORV_4_.rank, _FORV_4_.legend)
    elseif _FORV_4_.empty == false then
      RemoteGamerPicture(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "gamer_picture"), GUI.GamerPictures[_FORV_4_.ref])
      Mp_RankIcon(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "rank_icon"), _FORV_4_.rank, _FORV_4_.legend)
    else
      RemoteGamerPicture(UIButtons.FindChildByName(GUI.Players[_FORV_3_], "gamer_picture"), nil)
    end
  end
  if NetParty.IsHost() == true then
    UIButtons.ChangeColour(SCUI.name_to_id.party_leader, "Support_4")
  else
    UIButtons.ChangeColour(SCUI.name_to_id.party_leader, "Support_1")
  end
end
function ToggleLobby(_ARG_0_)
  GUI.lobby_active = _ARG_0_
  UIButtons.SetSelected(GUI.PlayerList, _ARG_0_)
  UIButtons.SetSelected(GUI.MenuId, not _ARG_0_)
  UIButtons.TimeLineActive("highlight_lobby", _ARG_0_)
end
function UpdateVoiceInfo()
  for _FORV_4_, _FORV_5_ in ipairs(GUI.Slots) do
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), false)
    if _FORV_5_.empty == false and NetServices.GetVoiceMap(true)[_FORV_5_.ref] ~= nil then
      if NetServices.GetVoiceMap(true)[_FORV_5_.ref].speaking == true then
        UIButtons.SetActive(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), true)
        UIButtons.ChangeTextureUV(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), 0, 0.5, 0)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), "Main_White")
      elseif NetServices.GetVoiceMap(true)[_FORV_5_.ref].muted == true then
        UIButtons.SetActive(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), true)
        UIButtons.ChangeTextureUV(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), 0, 0, 0)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), "Main_White")
      elseif NetServices.GetVoiceMap(true)[_FORV_5_.ref].active == true then
        UIButtons.SetActive(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), true)
        UIButtons.ChangeTextureUV(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), 0, 0.5, 0)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.Players[_FORV_4_], "voice"), "Main_Black")
      end
    end
  end
end
function Online_RefreshInfoLines()
  for _FORV_5_, _FORV_6_ in pairs(GUI.table_map) do
    if {
      party_running = NetParty.IsRunning(),
      lobby_active = GUI.lobby_active,
      nxe_party = Mp_XenonPartyActive(),
      share = Amax.CanUseShare()
    }[_FORV_6_] ~= GUI.change_table[_FORV_6_] then
      break
    end
  end
  if true == false then
    return
  end
  GUI.change_table.party_running = NetParty.IsRunning()
  GUI.change_table.lobby_active = GUI.lobby_active
  GUI.change_table.nxe_party = Mp_XenonPartyActive()
  GUI.change_table.share = Amax.CanUseShare()
  if GUI.change_table.party_running == true then
    if GUI.change_table.lobby_active == true then
      if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
        SetupInfoLine(UIText.INFO_VIEW_PLAYER, UIText.INFO_LEAVE_PARTY)
      else
        SetupInfoLine(UIText.INFO_LEAVE_PARTY)
      end
    else
      SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_LEAVE_PARTY)
    end
  else
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
  end
  if GUI.change_table.nxe_party == true then
    PushInfoLine(UIText.INFO_X_VIEW_PARTY)
  end
  if GUI.change_table.share == true then
    PushInfoLine("GAME_SHARE_BUTTON")
  end
end
function CanEnterMatchmaking()
  if NetParty.IsRunning() == false then
    return true
  end
  if NetRace.IsRunning() == false and NetParty.CanEnterMatchmaking() == true then
    return true
  end
  return false
end
