GUI = {
  finished = false,
  modes = {},
  race_overview_id = -1,
  pad_icons_uv = {
    {
      filename = "xbox360_buttons",
      pos = {u = 0.75, v = 0.75},
      size = {u = 0.125, v = 0.125}
    },
    {
      filename = "xbox360_buttons",
      pos = {u = 0, v = 0.875},
      size = {u = 0.125, v = 0.125}
    },
    {
      filename = "xbox360_buttons",
      pos = {u = 0.125, v = 0.875},
      size = {u = 0.125, v = 0.125}
    },
    {
      filename = "xbox360_buttons",
      pos = {u = 0.875, v = 0.75},
      size = {u = 0.125, v = 0.125}
    }
  },
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera(UIGlobals.CameraNames.MpLobby, UIGlobals.CameraLerpTime, 0)
  if Amax.GetPlayMode() == UIEnums.PlayMode.Playlist then
    UIShape.ChangeObjectName(SCUI.name_to_id.playlist_icon, Multiplayer.GetPlaylist().icon_name)
    UIButtons.ChangeText(SCUI.name_to_id.playlist_name, "MPL_PLAYLIST_NAME" .. Multiplayer.GetCurrentEventIndex())
  elseif Amax.GetPlayMode() == UIEnums.PlayMode.CustomRace then
    UIShape.ChangeObjectName(SCUI.name_to_id.playlist_icon, "misc")
    UIButtons.ChangeText(SCUI.name_to_id.playlist_name, UIText.MP_CUSTOM_GAME)
  end
  StoreInfoLine()
  if Amax.GetPlayMode() == UIEnums.PlayMode.CustomRace then
    SetupInfoLine(UIText.INFO_A_NEXT, UIText.INFO_B_BACK, UIText.INFO_RACE_SETTINGS, UIText.INFO_RESET_SCORES_Y, "GAME_SHARE_BUTTON")
  else
    SetupInfoLine(UIText.INFO_A_NEXT, UIText.INFO_B_BACK, UIText.INFO_RESET_SCORES_Y, "GAME_SHARE_BUTTON")
  end
end
function PostInit()
  for _FORV_7_ = 1, 4 do
    UIButtons.ChangePosition({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_7_], 0, 0, 0)
    UIButtons.SetParent({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_7_], SCUI.name_to_id.left, UIEnums.Justify.TopLeft)
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_7_], "gamer_picture"), "locked")
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_7_], "name"), "locked")
    UIButtons.ChangeColour({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_7_], "locked")
  end
  for _FORV_9_ = 1, #Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true))) do
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], "name"), "PROFILE_PAD" .. UIGlobals.Splitscreen.players[Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index].pad .. "_NAME")
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], "wins"), "MPL_SPLITSCREEN" .. Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index - 1 .. "_WINS_TOTAL")
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], "points"), "MPL_SPLITSCREEN" .. Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index - 1 .. "_POINTS_TOTAL")
    UIButtons.ChangeColour({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index].pad])
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], "name"), UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index].pad])
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], "gamer_picture"), "!255 255 255 255")
    UIButtons.SetAlphaIntensity(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], "gamer_picture"), nil, 1)
    UIButtons.SetAlphaIntensity(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], "name"), nil, 1)
    UIButtons.SetAlphaIntensity({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], nil, 1)
    LocalGamerPicture(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
    }[_FORV_9_], "gamer_picture"), UIGlobals.Splitscreen.players[Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index].pad)
  end
  GUI.race_overview_id = SCUI.name_to_id.race_overview_node
  Mp_RefreshRaceOverview(GUI.race_overview_id, (_FOR_.GetCurrentRace()))
  GUI.gadgets = {
    [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenLobby.lua", "frame")
  }
  if UIGlobals.Splitscreen.can_vote == true and Multiplayer.IsVotingEnabled() == true then
    SplitscreenLobby_StartVoting()
  end
  UIButtons.SetActive(SCUI.name_to_id.frame, false, true)
end
function FrameUpdate()
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true or SubScreenActive() == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    PlaySfxNext()
    GoScreen("Multiplayer\\MpSplitscreenCarSelect.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuBack or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    PlaySfxBack()
    PlaySfxGraphicBack()
    GoScreen("Multiplayer\\Shared\\MpModeSelect.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonX and Amax.GetPlayMode() == UIEnums.PlayMode.CustomRace or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonX then
    UISystem.PlaySound(UIEnums.SoundEffect.Filter)
    PlaySfxGraphicBack()
    StoreScreen(UIEnums.ScreenStorage.FE_BACK, UIScreen.GetCurrentScreen(UIScreen.Context()))
    GoScreen("Multiplayer\\Shared\\MpCustomRace.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonY or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonY then
    SetupCustomPopup(UIEnums.CustomPopups.SplitscreenResetScores)
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
    if Amax.CanUseShare() == true then
      SetupCustomPopup(UIEnums.CustomPopups.SSLobbySharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      Amax.CreateBlurb(UIGlobals.SharingOptionsChosen, 1, -1)
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Multiplayer\\MpSplitscreenLobby.lua")
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
      Amax.CreateBlurb(UIGlobals.SharingOptionsChosen, 0, -1)
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Multiplayer\\MpSplitscreenLobby.lua")
      GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      Amax.CreateBlurb(UIGlobals.SharingOptionsChosen, 2, -1)
    end
  end
end
function EnterEnd()
  Amax.LoadTextureClone(Multiplayer.GetCurrentRace().thumbnail)
  UIButtons.TimeLineActive("lobby_fade", true)
  RestoreInfoLine()
end
function End()
end
function SplitscreenLobby_DisablePopupActive(_ARG_0_)
  if IsTable(ContextTable[UIEnums.Context.CarouselApp].GUI) == false then
    return
  end
  if IsTable(ContextTable[UIEnums.Context.CarouselApp].GUI.gadgets) == false then
    return
  end
  if _ARG_0_ == false then
    for _FORV_5_, _FORV_6_ in ipairs(ContextTable[UIEnums.Context.CarouselApp].GUI.gadgets) do
      UIButtons.SetXtVar(UIButtons.FindChildByName(_FORV_6_, "gamer_picture"), "time_lines.0.label", "Popup_Active")
      if UIScreen.IsPopupActive() == false then
        UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_6_, "gamer_picture"), "Popup_Active", _ARG_0_)
      end
    end
  else
    for _FORV_5_, _FORV_6_ in ipairs(ContextTable[UIEnums.Context.CarouselApp].GUI.gadgets) do
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_FORV_6_, "gamer_picture"), "Popup_Active", _ARG_0_)
      UIButtons.SetXtVar(UIButtons.FindChildByName(_FORV_6_, "gamer_picture"), "time_lines.0.label", "hacksaw")
    end
  end
end
function SplitscreenLobby_StartVoting()
  SplitscreenLobby_DisablePopupActive(true)
  UIGlobals.Multiplayer.VotingFinished = false
  UIButtons.SetActive(SCUI.name_to_id.right, false)
  Multiplayer.StartRaceVoting()
  PushScreen("Multiplayer\\Shared\\MpVoting.lua")
end
function SplitscreenLobby_EndVoting()
  SplitscreenLobby_DisablePopupActive(false)
  UIButtons.SetActive(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].SCUI.name_to_id.right, true)
  Mp_RefreshRaceOverview(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.race_overview_id, Multiplayer.GetCurrentRace(), Multiplayer.GetCurrentRaceIndex())
  Profile.LockToPad(Profile.GetPrimaryPad())
  UIGlobals.Splitscreen.can_vote = false
  PopScreen()
end
