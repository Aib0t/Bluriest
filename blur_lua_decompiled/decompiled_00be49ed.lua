GUI = {
  finished = false,
  stringNo = 0,
  NetTimer = 0,
  NetTimeStep = 0.5,
  CooldownTime = 2,
  GarageTimer = 2,
  ModShopTimer = 2,
  CanStart = false,
  CanViewOptions = true,
  SubScreenActive = nil,
  SubScreensFlushed = false,
  current_item = 1,
  CurrentList = 0,
  CurrentEvent = 0,
  PlaylistSize = 1,
  RaceOverviewID = -1,
  EnableColour = "Support_0",
  DisabledColour = "Support_3",
  SelectedSlot = -1,
  Players = {},
  MaxPlayers = 20,
  RaceFinished = false,
  RaceIndex = -1,
  ChangeTable = {
    view = nil,
    options = nil,
    invite = nil
  },
  TableMap = {
    "view",
    "options",
    "invite"
  },
  NewItemsAvailible = false,
  TeamCountdown = 0,
  CountdownTime = 0,
  CountdownTimeSfx = 0,
  TimerPrefix = {},
  CountdownDefaults = {},
  Disconnecting = false,
  Migrating = false,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera(UIGlobals.CameraNames.MpLobby, UIGlobals.CameraLerpTime, 0)
  net_SetRichPresence(UIEnums.RichPresence.MpLobby)
  net_LockoutFriendsOverlay(false)
  net_FlushSessionEnumerator()
  NetRace.EnterLobby()
  UIScreen.SetScreenTimers(0.3, 0.3)
  UISystem.PlaySound(UIEnums.SoundEffect.LobbyJoin)
  StoreInfoLine()
  SetupInfoLine()
  GUI.TimerPrefix = {
    [UIEnums.MpLobbyState.FindingPlayers] = UIText.MP_CMN_NOWT,
    [UIEnums.MpLobbyState.Waiting] = UIText.MP_CMN_NOWT,
    [UIEnums.MpLobbyState.WaitingToVote] = "MPL_TIMER_VOTE_START",
    [UIEnums.MpLobbyState.Voting] = "MPL_TIMER_VOTE_TIME",
    [UIEnums.MpLobbyState.Countdown] = "MPL_TIMER_COUNTDOWN",
    [UIEnums.MpLobbyState.TeamCountdown] = "MPL_TIMER_COUNTDOWN",
    [UIEnums.MpLobbyState.TeamBalanceWait] = "MPL_TIMER_COUNTDOWN",
    [UIEnums.MpLobbyState.WaitingForHost] = UIText.MP_CMN_NOWT,
    [UIEnums.MpLobbyState.Ready] = UIText.MP_CMN_NOWT
  }
  GUI.CountdownDefaults = {
    [UIEnums.MpLobbyState.FindingPlayers] = 0,
    [UIEnums.MpLobbyState.Waiting] = 0,
    [UIEnums.MpLobbyState.WaitingToVote] = 3,
    [UIEnums.MpLobbyState.Voting] = 10,
    [UIEnums.MpLobbyState.Countdown] = 40,
    [UIEnums.MpLobbyState.TeamCountdown] = 10,
    [UIEnums.MpLobbyState.TeamBalanceWait] = 0,
    [UIEnums.MpLobbyState.WaitingForHost] = 0,
    [UIEnums.MpLobbyState.Ready] = 0
  }
  UIGlobals.Multiplayer.InitialLobby = NetRace.IsFirstRace()
  UIGlobals.Multiplayer.InLobby = true
  if Amax.GetPlayMode() ~= UIEnums.PlayMode.Playlist then
    Multiplayer.CacheNetRaceSettings()
  end
  if NetRace.IsHost() == true then
    if Amax.IsGameModeRanked() == true then
      UIGlobals.Multiplayer.LobbyState = Select(UIGlobals.Multiplayer.InitialLobby, UIEnums.MpLobbyState.FindingPlayers, UIEnums.MpLobbyState.Waiting)
    else
      UIGlobals.Multiplayer.LobbyState = Select(UIGlobals.Multiplayer.InitialLobby, UIEnums.MpLobbyState.WaitingForHost, UIEnums.MpLobbyState.Waiting)
    end
  else
    MpLobby_ValidateState()
    UIGlobals.Multiplayer.LobbyState, UIGlobals.Multiplayer.LobbyTimer = NetRace.GetLobbyState()
  end
  GUI.RaceIndex = Multiplayer.GetCurrentRaceIndex()
  print("-----------Enter Lobby-------------")
  print("Lobby MpLobbyState", UIGlobals.Multiplayer.LobbyState)
  show_table(UIEnums.MpLobbyState, 1)
  GUI.RaceOverviewID = SCUI.name_to_id.node_current_race
  if UIGlobals.Multiplayer.InitialLobby == true and IsFunction(EnableCarousel) == true then
    EnableCarousel(false)
  end
  GUI.Lobby = SCUI.name_to_id.lobby
  GUI.TimeoutID = SCUI.name_to_id.lobby_info
  GUI.PlayersLeft = SCUI.name_to_id.left_list
  GUI.PlayersRight = SCUI.name_to_id.right_list
  GUI.MaxPlayers = NetRace.MaxPlayerCount()
  for _FORV_5_ = 1, GUI.MaxPlayers / 2 do
    GUI.Players[1] = SetupPlayer(UIButtons.CloneXtGadgetByName("Multiplayer\\MpLobby.lua", "mp_player_left"), 1 - 1)
    UIButtons.AddListItem(GUI.PlayersLeft, UIButtons.CloneXtGadgetByName("Multiplayer\\MpLobby.lua", "mp_player_left"), 1)
  end
  for _FORV_5_ = 1, GUI.MaxPlayers / 2 do
    GUI.Players[1 + 1] = SetupPlayer(UIButtons.CloneXtGadgetByName("Multiplayer\\MpLobby.lua", "mp_player_right"), 1 + 1 - 1)
    UIButtons.AddListItem(GUI.PlayersRight, UIButtons.CloneXtGadgetByName("Multiplayer\\MpLobby.lua", "mp_player_right"), 1 + 1)
  end
  GUI.CurrentList = GUI.PlayersLeft
  if Amax.GetGameMode() == UIEnums.GameMode.Online then
    net_EnableGlobalUpdateRichPresence(true)
  end
  GUI.Slots = Multiplayer.GetLobbySlots(GUI.Lobby)
  if UIGlobals.IsIngame == true then
    GUI.camera_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Cam_Carousel")
    UIButtons.SetParent(GUI.camera_id, SCUI.name_to_id.CameraDolly, UIEnums.Justify.MiddleCentre)
  end
  if NetRace.IsPrivateGame() == true then
    UIButtons.ChangeText(SCUI.name_to_id.title, UIText.MP_PRIVATE_LOBBY)
  end
  if Amax.GetPlayMode() == UIEnums.PlayMode.Playlist then
    UIButtons.ChangeText(SCUI.name_to_id.title, "MPL_PLAYLIST_NAME" .. Multiplayer.GetCurrentEventIndex())
    UIShape.ChangeObjectName(SCUI.name_to_id.title_icon, Multiplayer.GetPlaylist().icon_name)
  else
    UIButtons.ChangeText(SCUI.name_to_id.title, UIText.MP_CUSTOM_GAME)
  end
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
    UIButtons.ChangeScale(SCUI.name_to_id.start_button, 2.2, 2.2, 2.2)
  end
end
function PostInit()
  UpdateLoadout()
  UpdateCar()
  UIButtons.SetSelected(GUI.PlayersLeft, true)
  UIButtons.SetSelected(GUI.PlayersRight, false)
  UIButtons.SetActive(SCUI.name_to_id.mp_player_left, false)
  UIButtons.SetActive(SCUI.name_to_id.mp_player_right, false)
  MpLobby_RefreshCurrentRace()
  RefreshLobby()
  UpdateLobbyInfo(true)
  MpLobby_ShowNew(false)
  if NetRace.IsHost() == false and UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Voting then
    StartVoting()
  end
  GetSetLobbyCar()
  if UIGlobals.Network.VoiceChatRestricted == true then
    SetupCustomPopup(UIEnums.CustomPopups.PS3NoVoiceAllowed)
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.GameMessage.RefreshLobby then
    MpLobby_RefreshCurrentRace()
    GetSetLobbyCar()
    UpdateCar()
    UpdateLoadout()
    if NetRace.IsHost() == false and _ARG_1_ == 0 then
      SetupCustomPopup(UIEnums.CustomPopups.HostChangedSettings)
    end
  end
  if SubScreenActive() == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
    if UIButtons.GetParent((UIButtons.GetParent(_ARG_2_))) == GUI.CurrentList then
      UIButtons.SetCurrentItemByID(GUI.CurrentList, (UIButtons.GetParent(_ARG_2_)))
    elseif UIButtons.GetParent((UIButtons.GetParent(_ARG_2_))) == GUI.PlayersLeft then
      UIButtons.SetSelected(GUI.PlayersLeft, true)
      UIButtons.SetSelected(GUI.PlayersRight, false)
      GUI.CurrentList = GUI.PlayersLeft
    else
      UIButtons.SetSelected(GUI.PlayersLeft, false)
      UIButtons.SetSelected(GUI.PlayersRight, true)
      GUI.CurrentList = GUI.PlayersRight
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon and GUI.Slots[UIButtons.GetSelection(GUI.CurrentList)].local_player == false and GUI.Slots[UIButtons.GetSelection(GUI.CurrentList)].empty == false then
      UIGlobals.Multiplayer.SelectPlayerJoinRef = GUI.Slots[UIButtons.GetSelection(GUI.CurrentList)].ref
      SetupCustomPopup(UIEnums.CustomPopups.ViewPlayer)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    SetupCustomPopup(UIEnums.CustomPopups.ExitRaceLobby)
  elseif _ARG_0_ == UIEnums.Message.ButtonRight and _ARG_2_ == true then
    if CanMoveRight() == true then
      UIButtons.SetSelected(GUI.PlayersLeft, false)
      UIButtons.SetSelected(GUI.PlayersRight, true)
      UIButtons.SetSelectionByIndex(GUI.PlayersRight, UIButtons.GetSelectionIndex(GUI.PlayersLeft))
      GUI.CurrentList = GUI.PlayersRight
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeft and _ARG_2_ == true then
    if CanMoveLeft() == true then
      UIButtons.SetSelected(GUI.PlayersLeft, true)
      UIButtons.SetSelected(GUI.PlayersRight, false)
      UIButtons.SetSelectionByIndex(GUI.PlayersLeft, UIButtons.GetSelectionIndex(GUI.PlayersRight))
      GUI.CurrentList = GUI.PlayersLeft
    end
  elseif (_ARG_0_ == UIEnums.Message.ButtonY and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonY) and Mp_XenonGameInviteAvailable() == true then
    if Mp_XenonPartyActive() == true then
      UIHardware.ShowParty360(Profile.GetPrimaryPad())
    else
      UIHardware.ShowFriends360(Profile.GetPrimaryPad())
    end
  end
  if Amax.GetPlayMode() == UIEnums.PlayMode.Playlist and (UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.WaitingToVote or UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Voting) then
    return
  end
  if _ARG_0_ == UIEnums.Message.ButtonStart and MpLobby_HostCanPressStart() == true and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonStart then
    NetRace.LaunchCustomRace()
    UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.Ready
  elseif (_ARG_0_ == UIEnums.Message.ButtonRightShoulder or _ARG_0_ == UIEnums.Message.RightThumb) and NetRace.RaceInProgress() == true and NetRace.HasRaceFinished() == false then
    PushScreen("Multiplayer\\MpRacePreview.lua")
  elseif MpLobby_CanViewMenu() == true and (_ARG_0_ == UIEnums.Message.ButtonX or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonX) then
    SetupCustomPopup(UIEnums.CustomPopups.LobbyOptions)
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.LobbyOptions then
    if _ARG_3_ == UIEnums.LobbyOptions.CarSelect then
      UIGlobals.GarageMiniClassFilter = NetRace.GetGarageMiniClassFilters()
      PushScreen("Shared\\Garage.lua")
    elseif _ARG_3_ == UIEnums.LobbyOptions.ModShop then
      PushScreen("Multiplayer\\ModShop\\MpModShop.lua")
    elseif _ARG_3_ == UIEnums.LobbyOptions.Challenges then
      PushScreen("Multiplayer\\Challenges\\MpChallenges.lua")
    elseif _ARG_3_ == UIEnums.LobbyOptions.SessionScoreboard then
      PushScreen("Multiplayer\\MpShowSessionLeaderboard.lua")
    elseif _ARG_3_ == UIEnums.LobbyOptions.RaceSummery then
      PushScreen("Multiplayer\\MpShowRaceSummary.lua")
    elseif _ARG_3_ == UIEnums.LobbyOptions.RacePreview then
      PushScreen("Multiplayer\\MpRacePreview.lua")
    elseif _ARG_3_ == UIEnums.LobbyOptions.Settings then
      PlaySfxGraphicBack()
      PushScreen("Multiplayer\\Shared\\MpCustomRace.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
    if Amax.CanShareInLobby() == true and Amax.CanUseShare() == true and GUI.Slots[UIButtons.GetSelectionIndex(GUI.CurrentList) + 1].empty == false then
      UIGlobals.SharingOptionsChosen = -1
      if UIButtons.GetSelection(GUI.CurrentList) == 1 then
        SetupCustomPopup(UIEnums.CustomPopups.MPLobbyLocalSharingOptions)
      else
        UIGlobals.ShareFromWhatPopup = -1
        SetupCustomPopup(UIEnums.CustomPopups.SharingOptions)
      end
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      if UIGlobals.SharingOptionsChosen == -1 then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPRelativePlayerPositionAbove, 1, UIButtons.GetSelection(GUI.CurrentList))
      elseif UIGlobals.SharingOptionsChosen == UIEnums.MPLobbyLocalSharingOptions.Position then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPFinishingPosition, 1, GUI.Slots[UIButtons.GetSelectionIndex(GUI.CurrentList) + 1].ref)
      elseif UIGlobals.SharingOptionsChosen == UIEnums.MPLobbyLocalSharingOptions.Rank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPPlayersRank, 1, -1)
      else
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPRaceAward, 1, UIGlobals.SharingOptionsChosen - UIEnums.MPLobbyLocalSharingOptions.Award1)
      end
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Multiplayer\\MpLobby.lua")
      PushScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
      if UIGlobals.SharingOptionsChosen == -1 then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPRelativePlayerPositionAbove, 0, UIButtons.GetSelection(GUI.CurrentList))
      elseif UIGlobals.SharingOptionsChosen == UIEnums.MPLobbyLocalSharingOptions.Position then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPFinishingPosition, 0, GUI.Slots[UIButtons.GetSelectionIndex(GUI.CurrentList) + 1].ref)
      elseif UIGlobals.SharingOptionsChosen == UIEnums.MPLobbyLocalSharingOptions.Rank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPPlayersRank, 0, -1)
      else
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPRaceAward, 0, UIGlobals.SharingOptionsChosen - UIEnums.MPLobbyLocalSharingOptions.Award1)
      end
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Multiplayer\\MpLobby.lua")
      PushScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      if UIGlobals.SharingOptionsChosen == -1 then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPRelativePlayerPositionAbove, 2, UIButtons.GetSelection(GUI.CurrentList))
      elseif UIGlobals.SharingOptionsChosen == UIEnums.MPLobbyLocalSharingOptions.Position then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPFinishingPosition, 2, GUI.Slots[UIButtons.GetSelectionIndex(GUI.CurrentList) + 1].ref)
      elseif UIGlobals.SharingOptionsChosen == UIEnums.MPLobbyLocalSharingOptions.Rank then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPPlayersRank, 2, -1)
      else
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPRaceAward, 2, UIGlobals.SharingOptionsChosen - UIEnums.MPLobbyLocalSharingOptions.Award1)
      end
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true or UIGlobals.Multiplayer.NotEnoughPlayersKick == true or GUI.Disconnecting == true then
    return
  end
  if NetRace.LocalPlayerDisconnecting() == true then
    GUI.Disconnecting = NetRace.LocalPlayerDisconnecting()
    return
  end
  if NetRace.IsSessionMigrating() ~= GUI.Migrating then
    GUI.Migrating = NetRace.IsSessionMigrating()
    UpdateLobbyInfo(nil, true)
  end
  UpdateVoiceInfo()
  if GUI.SubScreenActive ~= SubScreenActive() then
    GUI.SubScreenActive = SubScreenActive()
    EnablePlayerList(not GUI.SubScreenActive)
  end
  if NetRace.IsHost() == true then
    GUI.NetTimer = GUI.NetTimer + _ARG_0_
    if GUI.NetTimer >= GUI.NetTimeStep then
      NetRace.SendLobbyState(UIGlobals.Multiplayer.LobbyState, UIGlobals.Multiplayer.LobbyTimer)
      GUI.NetTimer = 0
    end
  else
    MpLobby_ValidateState()
    if math.abs(UIGlobals.Multiplayer.LobbyTimer - NetRace.GetLobbyState()) >= 1.5 then
      UIGlobals.Multiplayer.LobbyTimer = NetRace.GetLobbyState()
    end
    if UIGlobals.Multiplayer.LobbyState ~= NetRace.GetLobbyState() then
      print("LOBBY - Change state", NetRace.GetLobbyState())
      if UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Voting then
        EndVoting()
      end
      if NetRace.GetLobbyState() == UIEnums.MpLobbyState.WaitingToVote then
        UIScreen.CancelPopup()
        FlushSubscreens()
      elseif NetRace.GetLobbyState() == UIEnums.MpLobbyState.Voting then
        StartVoting()
      end
      UIGlobals.Multiplayer.LobbyState = NetRace.GetLobbyState()
      UIGlobals.Multiplayer.LobbyTimer = NetRace.GetLobbyState()
      UpdateLobbyInfo()
    end
    if GUI.RaceIndex ~= Multiplayer.GetCurrentRaceIndex() then
      print("Resyncing lobby race index ", (Multiplayer.GetCurrentRaceIndex()))
      GUI.RaceIndex = Multiplayer.GetCurrentRaceIndex()
      MpLobby_RefreshCurrentRace()
    end
  end
  if MpLobby_CanCountdown() == true and GUI.Migrating == false then
    UIGlobals.Multiplayer.LobbyTimer = UIGlobals.Multiplayer.LobbyTimer - _ARG_0_
    UIButtons.ChangeText(GUI.TimeoutID, GUI.TimerPrefix[UIGlobals.Multiplayer.LobbyState] .. math.ceil(UIGlobals.Multiplayer.LobbyTimer))
    if UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Countdown and math.ceil(UIGlobals.Multiplayer.LobbyTimer) ~= GUI.CountdownTimeSfx then
      GUI.CountdownTimeSfx = math.ceil(UIGlobals.Multiplayer.LobbyTimer)
      if 0 < math.ceil(UIGlobals.Multiplayer.LobbyTimer) then
        if math.ceil(UIGlobals.Multiplayer.LobbyTimer) <= 3 then
          UISystem.PlaySound(UIEnums.SoundEffect.LobbyCountDown03)
        elseif math.ceil(UIGlobals.Multiplayer.LobbyTimer) <= 10 then
          UISystem.PlaySound(UIEnums.SoundEffect.LobbyCountDown10)
        end
      end
    end
    if UIGlobals.Multiplayer.LobbyTimer <= 0 then
      UIGlobals.Multiplayer.LobbyTimer = 0
    end
  end
  if UIGlobals.Multiplayer.LobbyUpdateLoadout == true then
    UpdateLoadout()
    UIGlobals.Multiplayer.LobbyUpdateLoadout = false
  end
  if UIGlobals.Multiplayer.LobbyUpdateCar then
    UpdateCar()
    UIGlobals.Multiplayer.LobbyUpdateCar = false
  end
  if UIButtons.GetSelectionIndex(GUI.CurrentList) + 1 ~= GUI.SelectedSlot then
    GUI.SelectedSlot = UIButtons.GetSelectionIndex(GUI.CurrentList) + 1
  end
  if Multiplayer.RefreshLobby(GUI.Lobby) == true then
    RefreshLobby()
  end
  if UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.FindingPlayers and MpLobby_PlayersValid() == true and NetRace.IsHost() == true then
    UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.Countdown
    UpdateLobbyInfo()
  end
  if NetRace.IsHost() == true then
    if UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Waiting then
      if Amax.GetPlayMode() == UIEnums.PlayMode.Playlist then
        if NetRace.CanStartVoting() == true then
          if Multiplayer.IsVotingEnabled() == true then
            UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.WaitingToVote
            UIScreen.CancelPopup()
            FlushSubscreens()
          elseif Amax.IsGameModeRanked() == true then
            UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.Countdown
          else
            UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.WaitingForHost
          end
          UpdateLobbyInfo()
        end
      else
        UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.WaitingForHost
        UpdateLobbyInfo()
      end
    elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.WaitingToVote then
      if UIGlobals.Multiplayer.LobbyTimer <= 0 then
        StartVoting()
      end
    elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Voting then
      if UIGlobals.Multiplayer.VotingFinished == true then
        EndVoting()
      end
    elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Countdown then
      if MpLobby_PlayersValid() == false then
        GUI.TeamCountdown = UIGlobals.Multiplayer.LobbyTimer
        UIGlobals.Multiplayer.LobbyState = Select(NetRace.IsTeamGame(), UIEnums.MpLobbyState.TeamBalanceWait, UIEnums.MpLobbyState.FindingPlayers)
        UpdateLobbyInfo()
      elseif UIGlobals.Multiplayer.LobbyTimer <= 0 then
        UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.Ready
        UpdateLobbyInfo()
      end
    elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.TeamBalanceWait then
      if MpLobby_PlayersValid() == true then
        UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.Countdown
        UpdateLobbyInfo()
        if GUI.TeamCountdown < GUI.CountdownDefaults[UIEnums.MpLobbyState.TeamCountdown] then
          UIGlobals.Multiplayer.LobbyTimer = GUI.CountdownDefaults[UIEnums.MpLobbyState.TeamCountdown]
        else
          UIGlobals.Multiplayer.LobbyTimer = GUI.TeamCountdown
        end
      end
    elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Ready then
      if Amax.IsGameModeRanked() == true then
        if MpLobby_PlayersValid() == false then
          UIGlobals.Multiplayer.LobbyState = Select(NetRace.IsTeamGame(), UIEnums.MpLobbyState.TeamBalanceWait, UIEnums.MpLobbyState.FindingPlayers)
          UpdateLobbyInfo()
        elseif NetRace.IsHost() == true and NetRace.CanStartCustomRace() then
          NetRace.LaunchCustomRace()
        end
      end
      UIGlobals.Multiplayer.LobbyTimer = 0
    end
  end
  if UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Waiting and NetRace.HasRaceFinished() ~= GUI.RaceFinished then
    GUI.RaceFinished = NetRace.HasRaceFinished()
    UpdateLobbyInfo()
  end
  if Amax.IsGameModeRanked() == false and GUI.CanStart ~= MpLobby_HostCanPressStart() then
    GUI.CanStart = MpLobby_HostCanPressStart()
    UpdateLobbyInfo()
  end
  if NetRace.IsStartRaceDataValid() == true then
    if SubScreenActive() == true then
      if GUI.SubScreensFlushed == false then
        GUI.SubScreensFlushed = true
        FlushSubscreens()
      end
    else
      if IsTable((Multiplayer.GetCurrentRace())) == true then
        Amax.LoadTextureClone(Multiplayer.GetCurrentRace().thumbnail)
        UIButtons.TimeLineActive("lobby_fade", true)
      end
      StartLobbyNetworkLoad()
      GUI.finished = true
    end
  end
  if SubScreenActive() == false then
    Lobby_RefreshInfoLine()
  end
  if GUI.NewItemsAvailible ~= (Multiplayer.GetNewCarsForClass(NetRace.GetCarClass()) or Multiplayer.GetNewUnlocks().mods or Multiplayer.GetNewUnlocks().challenges) then
    GUI.NewItemsAvailible = Multiplayer.GetNewCarsForClass(NetRace.GetCarClass()) or Multiplayer.GetNewUnlocks().mods or Multiplayer.GetNewUnlocks().challenges
    MpLobby_ShowNew(GUI.NewItemsAvailible)
  end
  UIGlobals.Multiplayer.CountdownStarted = UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Countdown
end
function EnterEnd()
  UISystem.PlaySound(UIEnums.SoundEffect.LobbyLeave)
  RestoreInfoLine()
end
function End()
  UIGlobals.Multiplayer.InLobby = false
  FlushSubscreens()
end
function EnablePlayerList(_ARG_0_)
  UIButtons.SetSelected(GUI.CurrentList, _ARG_0_)
end
function UpdateLobbyInfo(_ARG_0_, _ARG_1_)
  UIButtons.ChangeColour(SCUI.name_to_id.lobby_info, "Support_2")
  UIButtons.SetActive(SCUI.name_to_id.button, false)
  if UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.FindingPlayers then
    UIShape.ChangeSceneName(SCUI.name_to_id.lobby_info_icon, "fe_icons")
    UIShape.ChangeObjectName(SCUI.name_to_id.lobby_info_icon, "join_game")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info_icon, "Support_3")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info, "Support_3")
    UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_PLEASE_WAIT)
    UIButtons.ChangeText(SCUI.name_to_id.lobby_info, UIText.MP_WAITING_FOR_PLAYERS)
    UIButtons.ChangeText(SCUI.name_to_id.summery_title, UIText.MP_NEXT_RACE)
    UpdateCar(true)
  elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Waiting then
    if GUI.RaceFinished == true then
      UIShape.ChangeSceneName(SCUI.name_to_id.lobby_info_icon, "common_icons")
      UIShape.ChangeObjectName(SCUI.name_to_id.lobby_info_icon, "end_of_race")
      UIButtons.ChangeColour(SCUI.name_to_id.lobby_info_icon, "Support_1")
      UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_PLEASE_WAIT)
      UIButtons.ChangeText(SCUI.name_to_id.lobby_info, UIText.MP_FINISHED)
      UIButtons.ChangeText(SCUI.name_to_id.summery_title, UIText.MP_RACE_SUMMARY)
    else
      UIShape.ChangeSceneName(SCUI.name_to_id.lobby_info_icon, "fe_icons")
      UIShape.ChangeObjectName(SCUI.name_to_id.lobby_info_icon, "racing")
      UIButtons.ChangeColour(SCUI.name_to_id.lobby_info_icon, "Support_3")
      UIButtons.ChangeColour(SCUI.name_to_id.lobby_info, "Support_3")
      UIButtons.ChangeText(SCUI.name_to_id.lobby_info, UIText.MP_RACE_IN_PROGRESS)
      UIButtons.ChangeText(SCUI.name_to_id.summery_title, UIText.MP_RACE_SUMMARY)
      if NetRace.RaceInProgress() == true then
        UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_RACE_PREVIEW)
        UIButtons.SetActive(SCUI.name_to_id.button, true)
      else
        UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_PLEASE_WAIT)
      end
    end
    UpdateCar(true)
  elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.WaitingToVote then
    UIShape.ChangeSceneName(SCUI.name_to_id.lobby_info_icon, "common_icons")
    UIShape.ChangeObjectName(SCUI.name_to_id.lobby_info_icon, "vote")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info_icon, "Main_White")
    UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_PLEASE_WAIT)
    UIButtons.ChangeText(SCUI.name_to_id.summery_title, UIText.MP_RACE_SUMMARY)
    UpdateCar(true)
  elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Countdown then
    UIShape.ChangeSceneName(SCUI.name_to_id.lobby_info_icon, "fe_icons")
    UIShape.ChangeObjectName(SCUI.name_to_id.lobby_info_icon, "steering_wheel")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info_icon, "Support_0")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info, "Support_0")
    UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_GET_READY_TO_RACE)
    UIButtons.ChangeText(SCUI.name_to_id.summery_title, UIText.MP_NEXT_RACE)
    UpdateCar()
  elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.WaitingForHost then
    if Amax.IsGameModeRanked() == false then
      UIShape.ChangeSceneName(SCUI.name_to_id.lobby_info_icon, "fe_icons")
      UIShape.ChangeObjectName(SCUI.name_to_id.lobby_info_icon, "steering_wheel")
      UpdateCar()
      UIButtons.ChangeColour(SCUI.name_to_id.lobby_info_icon, "Support_0")
      UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_GET_READY_TO_RACE)
      UIButtons.ChangeText(SCUI.name_to_id.summery_title, UIText.MP_NEXT_RACE)
      if NetRace.IsHost() == true then
        UIButtons.ChangeText(GUI.TimeoutID, Select(MpLobby_HostCanPressStart(), UIText.CMN_NOWT, UIText.MP_WAITING_FOR_PLAYERS))
      else
        UIButtons.ChangeText(GUI.TimeoutID, UIText.MP_WAITING_FOR_HOST)
      end
    end
  elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.TeamBalanceWait then
    UIShape.ChangeSceneName(SCUI.name_to_id.lobby_info_icon, "fe_icons")
    UIShape.ChangeObjectName(SCUI.name_to_id.lobby_info_icon, "join_game")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info_icon, "Support_3")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info, "Support_3")
    UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_PLEASE_WAIT)
    UIButtons.ChangeText(SCUI.name_to_id.lobby_info, UIText.MP_BALANCING_TEAMS)
    UIButtons.ChangeText(SCUI.name_to_id.summery_title, UIText.MP_NEXT_RACE)
    UpdateCar()
  elseif UIGlobals.Multiplayer.LobbyState == UIEnums.MpLobbyState.Ready then
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info, "Support_0")
    UpdateCar()
  end
  if GUI.Migrating == true then
    UIShape.ChangeSceneName(SCUI.name_to_id.lobby_info_icon, "fe_icons")
    UIShape.ChangeObjectName(SCUI.name_to_id.lobby_info_icon, "join_game")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info_icon, "Support_3")
    UIButtons.ChangeColour(SCUI.name_to_id.lobby_info, "Support_3")
    UIButtons.ChangeText(SCUI.name_to_id.lobby_state, UIText.MP_PLEASE_WAIT)
    UIButtons.ChangeText(SCUI.name_to_id.lobby_info, UIText.MP_HOST_MIGRATING)
  end
  if NetRace.IsHost() == true and _ARG_1_ ~= true then
    UIGlobals.Multiplayer.LobbyTimer = GUI.CountdownDefaults[UIGlobals.Multiplayer.LobbyState]
  end
  if _ARG_0_ ~= true then
    PlaySfxToggle()
  end
end
function Lobby_RefreshInfoLine()
