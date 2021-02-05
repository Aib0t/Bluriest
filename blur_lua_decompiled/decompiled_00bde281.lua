GUI = {
  finished = false,
  PlayerGadgets = {},
  countdown = 5,
  SelectedSlot = -1,
  PlayerColour = "Support_4",
  FailedColour = "Support_3",
  TimeoutColour = "Support_2",
  OtherColour = "Support_1",
  WinnerColour = "Support_1",
  SetupResults = false
}
function Init()
  AddSCUI_Elements()
  GUI.PlayersMenu = SCUI.name_to_id.players_list
  GUI.Results = Multiplayer.GetRaceResults()
  GUI.num_finished = 0
  GUI.num_racers = Multiplayer.VehiclesFinished().num_players
  GUI.GamerPictures = Profile.GetRemoteGamerPictureMap()
  for _FORV_5_ = 1, GUI.num_racers do
    GUI.PlayerGadgets[_FORV_5_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceResults.lua", {
      [1] = "player_left",
      [2] = "player_right"
    }[1])
    UIButtons.AddListItem(GUI.PlayersMenu, GUI.PlayerGadgets[_FORV_5_], _FORV_5_)
    if 1 == 1 then
    else
    end
    UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_5_], "position"), "GAME_POS_" .. _FORV_5_)
  end
  if _FOR_.CanViewGamerCard(Profile.GetPrimaryPad()) == true or NetServices.CanSubmitPlayerReview(Profile.GetPrimaryPad()) == true then
    SetupInfoLine(UIText.INFO_QUIT_RACE)
  else
    SetupInfoLine(UIText.INFO_QUIT_RACE)
  end
  UISystem.PlaySound(UIEnums.SoundEffect.Toggle)
  UIGlobals.Multiplayer.ViewingResults = true
end
function StartLoop(_ARG_0_)
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.player_left, false, true)
  UIButtons.SetActive(SCUI.name_to_id.player_right, false, true)
  RefreshList()
  MpRaceResults_RefreshInfoLines()
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon and GUI.Results.standings[UIButtons.GetSelectionIndex(GUI.PlayersMenu) + 1].ai_driver == false then
      UIGlobals.Multiplayer.SelectPlayerJoinRef = GUI.Results.standings[UIButtons.GetSelectionIndex(GUI.PlayersMenu) + 1].join_ref
      SetupCustomPopup(UIEnums.CustomPopups.ViewPlayer)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    SetupCustomPopup(UIEnums.CustomPopups.ExitRace)
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  GUI.countdown = GUI.countdown - _ARG_0_
  if GUI.countdown <= 0 and net_Disconnecting() == false then
    GUI.countdown = 0
    if Amax.IsGameModeRanked() == true then
      GoScreen("Multiplayer\\Ingame\\MpProgression.lua")
    else
      GoScreen("Multiplayer\\Ingame\\MpRaceAwards.lua")
    end
  end
  MpRaceResults_RefreshInfoLines()
end
function MpRaceResults_RefreshInfoLines()
  if GUI.ai_driver ~= GUI.Results.standings[UIButtons.GetSelectionIndex(GUI.PlayersMenu) + 1].ai_driver then
    if GUI.Results.standings[UIButtons.GetSelectionIndex(GUI.PlayersMenu) + 1].ai_driver == true then
      SetupInfoLine(UIText.INFO_QUIT_RACE)
    else
      SetupInfoLine(UIText.INFO_QUIT_RACE)
    end
  end
end
function RefreshList()
  GUI.Results = Multiplayer.GetRaceResults()
  for _FORV_3_, _FORV_4_ in ipairs(GUI.Results.standings) do
    if _FORV_4_.racing == false then
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "gamertag"), "MPL_RESULT_NAME" .. _FORV_3_ - 1)
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "rank"), "MPL_RESULT_RANK" .. _FORV_3_ - 1)
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "result"), "MPL_RESULT_RESULT" .. _FORV_3_ - 1)
      Mp_RankIcon(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "rank_icon"), _FORV_4_.rank, _FORV_4_.legend)
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "gamerpic"), "fly_in", true)
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "gamertag"), GUI.OtherColour)
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "frame"), GUI.OtherColour)
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "position"), "Support_2")
      UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "result"), "Main_White")
      if _FORV_4_.timeout == true then
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "result"), GUI.TimeoutColour)
      elseif _FORV_4_.finished == false then
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "result"), GUI.FailedColour)
      end
      if _FORV_4_.ai_driver == true then
        AIGamerPicture(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "gamerpic_image"), _FORV_4_.ai_avatar_id)
      elseif _FORV_3_ == GUI.Results.player_index then
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "gamertag"), GUI.PlayerColour)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "frame"), GUI.PlayerColour)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "position"), GUI.PlayerColour)
        LocalGamerPicture(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "gamerpic_image"), Profile.GetPrimaryPad())
      else
        RemoteGamerPicture(UIButtons.FindChildByName(GUI.PlayerGadgets[_FORV_3_], "gamerpic_image"), GUI.GamerPictures[_FORV_4_.join_ref])
      end
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  UIScreen.SetScreenTimers(0, 0)
  UIScreen.CancelPopup()
  UIGlobals.Multiplayer.ViewingResults = false
end
