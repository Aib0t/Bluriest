GUI = {
  finished = false,
  State = {
    Voting = 1,
    Voted = 2,
    Results = 3,
    Finished = 4
  },
  CurrentState = 1,
  NextPlayTime = 0,
  Timer = 0,
  ResultTime = 1.5,
  EndTime = 3,
  RaceIndex = -1,
  RaceOverviewID = -1,
  VotePassed = false,
  LocalVoteTable = {
    [0] = -1,
    [1] = -1,
    [2] = -1,
    [3] = -1
  }
}
function Init()
  UIScreen.SetScreenTimers(0.3, 0.3)
  AddSCUI_Elements()
  GUI.VoteInfo = SCUI.name_to_id.vote_info
  GUI.TimerID = SCUI.name_to_id.timer
  GUI.VotesID = SCUI.name_to_id.votes
  GUI.Timer = UIGlobals.Multiplayer.LobbyTimer
  if IsSplitScreen() == true then
    GUI.Timer = 10
    Profile.LockToPad(-1)
  end
  GUI.NextPlayTime = GUI.Timer - 1
  UIGlobals.Multiplayer.VotingFinished = false
  UIButtons.ChangeText(GUI.TimerID, "MPL_TIMER_VOTE_TIME" .. GUI.Timer)
  StoreInfoLine()
  if IsSplitScreen() == true then
    SetupInfoLine(UIText.INFO_CAST_VOTE)
  else
    SetupInfoLine(UIText.INFO_EXIT_LOBBY, UIText.INFO_CAST_VOTE)
  end
end
function PostInit()
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "race_overview_node"), SCUI.name_to_id.left_backing, UIEnums.Justify.MiddleCentre)
  Mp_RefreshRaceOverview(UIButtons.CloneXtGadgetByName("SCUIBank", "race_overview_node"), Multiplayer.GetPlaylistRace(Multiplayer.GetVoteRaceIndicies()), Multiplayer.GetVoteRaceIndicies())
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "race_overview_node"), SCUI.name_to_id.right_backing, UIEnums.Justify.MiddleCentre)
  Mp_RefreshRaceOverview(UIButtons.CloneXtGadgetByName("SCUIBank", "race_overview_node"), Multiplayer.GetPlaylistRace(Multiplayer.GetVoteRaceIndicies()), Multiplayer.GetVoteRaceIndicies())
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true and IsSplitScreen() == false then
    SetupCustomPopup(UIEnums.CustomPopups.ExitRaceLobby)
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftTrigger and GUI.CurrentState == GUI.State.Voting and _ARG_2_ == true then
    PlaySfxNext()
    if IsSplitScreen() == true then
      if GUI.LocalVoteTable[_ARG_1_] == -1 then
        Multiplayer.CastLocalVote(0)
        GUI.LocalVoteTable[_ARG_1_] = 0
        UIButtons.TimeLineActive("vote_cast_local_a", true, 0)
      end
    else
      UIButtons.TimeLineActive("vote_cast", true)
      UIButtons.SetActive(SCUI.name_to_id.right_trigger, false)
      NetRace.VoteOnNextRace(0)
      GUI.CurrentState = GUI.State.Voted
      SetupInfoLine(UIText.INFO_EXIT_LOBBY)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonRightTrigger and GUI.CurrentState == GUI.State.Voting and _ARG_2_ == true then
    PlaySfxNext()
    if IsSplitScreen() == true then
      if GUI.LocalVoteTable[_ARG_1_] == -1 then
        Multiplayer.CastLocalVote(1)
        GUI.LocalVoteTable[_ARG_1_] = 1
        UIButtons.TimeLineActive("vote_cast_local_b", true, 0)
      end
    else
      UIButtons.TimeLineActive("vote_cast", true)
      UIButtons.SetActive(SCUI.name_to_id.left_trigger, false)
      NetRace.VoteOnNextRace(1)
      GUI.CurrentState = GUI.State.Voted
      SetupInfoLine(UIText.INFO_EXIT_LOBBY)
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  GUI.Timer = GUI.Timer - _ARG_0_
  if GUI.Timer < 0 then
    GUI.Timer = 0
  end
  if GUI.CurrentState == GUI.State.Voting or GUI.CurrentState == GUI.State.Voted then
    if IsSplitScreen() == false and NetRace.IsHost() == false and math.abs(UIGlobals.Multiplayer.LobbyTimer - GUI.Timer) >= 1 then
      GUI.Timer = UIGlobals.Multiplayer.LobbyTimer
    end
    if Multiplayer.GetVotingValues() == true then
      GUI.Timer = 0
    end
    if GUI.Timer < GUI.NextPlayTime then
      if GUI.NextPlayTime <= 3 then
        UISystem.PlaySound(UIEnums.SoundEffect.LobbyCountDown03)
      elseif GUI.NextPlayTime <= 10 then
        UISystem.PlaySound(UIEnums.SoundEffect.LobbyCountDown10)
      end
      GUI.NextPlayTime = GUI.NextPlayTime - 1
      if 0 > GUI.NextPlayTime then
        GUI.NextPlayTime = 0
      end
    end
    if GUI.Timer <= 0 then
      if IsSplitScreen() == true then
        Multiplayer.CalculateLocalVoteResults()
      elseif NetRace.IsHost() and NetRace.ReceivedVotingResults() == false then
        NetRace.SendVoteResults()
      end
      if NetRace.ReceivedVotingResults() == true then
        GUI.Timer = GUI.ResultTime
        GUI.CurrentState = GUI.State.Results
        UIButtons.SetActive(SCUI.name_to_id.left_trigger, false)
        UIButtons.SetActive(SCUI.name_to_id.right_trigger, false)
        UIButtons.SetActive(SCUI.name_to_id.vote_ends_in, false, true)
        Voting_ShowWinner()
        SetupInfoLine(UIText.INFO_EXIT_LOBBY)
      end
    end
    UIButtons.ChangeText(GUI.TimerID, "MPL_TIMER_VOTE_TIME" .. math.ceil(GUI.Timer))
  elseif GUI.CurrentState == GUI.State.Results then
    if GUI.Timer <= 0 and net_Disconnecting() == false then
      GUI.CurrentState = GUI.State.Finished
      GUI.Timer = 0
    end
  elseif GUI.CurrentState == GUI.State.Finished and GUI.Timer <= 0 and net_Disconnecting() == false then
    UIGlobals.Multiplayer.VotingFinished = true
    if IsSplitScreen() == true then
      SplitscreenLobby_EndVoting()
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function EnterEnd()
  RestoreInfoLine()
  UIButtons.TimeLineActive("end_voting", true, 0)
  UIButtons.TimeLineActive("darken", false)
  UIButtons.SetActive(SCUI.name_to_id.vote_info, false, true)
end
function End()
end
function Voting_ShowWinner()
  UIButtons.ChangeText(SCUI.name_to_id[{
    [0] = "left",
    [1] = "right"
  }[Multiplayer.GetVotingResults()] .. "_votes"], UIText.MP_VOTE_RESULT)
  UIButtons.ChangeColour(SCUI.name_to_id[{
    [0] = "left",
    [1] = "right"
  }[Multiplayer.GetVotingResults()] .. "_votes"], "Support_0")
  UIButtons.TimeLineActive({
    [0] = "left",
    [1] = "right"
  }[Multiplayer.GetVotingResults()] .. "_winner", true)
  if Multiplayer.GetVotingResults() == true then
    UIButtons.ChangeText(SCUI.name_to_id[{
      [0] = "left",
      [1] = "right"
    }[Multiplayer.GetVotingResults()] .. "_votes"], UIText.MP_VOTE_TIE)
    UIButtons.ChangeColour(SCUI.name_to_id[{
      [0] = "left",
      [1] = "right"
    }[Multiplayer.GetVotingResults()] .. "_votes"], "Support_4")
  end
  if IsString(Multiplayer.GetPlaylistRace(Select(Multiplayer.GetVotingResults() == 0, Multiplayer.GetVoteRaceIndicies())).thumbnail) == true then
    UISystem.PlaySound(UIEnums.SoundEffect[Multiplayer.GetPlaylistRace(Select(Multiplayer.GetVotingResults() == 0, Multiplayer.GetVoteRaceIndicies())).thumbnail])
  end
end
