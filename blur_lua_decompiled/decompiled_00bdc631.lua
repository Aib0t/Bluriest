GUI = {
  finished = false,
  current_time = 0,
  wait_time = 1,
  end_time = 6,
  ready = false
}
function Init()
  net_LockoutFriendsOverlay(true)
  AddSCUI_Elements()
  NetRace.FlagInRace(false)
  if UIScreen.IsContextActive(UIEnums.Context.SpWrecked) == true then
    UIScreen.SetScreenTimers(0, 0, UIEnums.Context.SpWrecked)
    EndScreen(UIEnums.Context.SpWrecked)
  end
end
function PostInit()
  UIButtons.TimeLineActive("show_finished", true, 0)
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
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  GUI.current_time = GUI.current_time + _ARG_0_
  if GUI.current_time > GUI.wait_time and GUI.ready == false then
    GUI.ready = true
    if Amax.IsRaceMpDestruction() == true and NetRace.IsTeamGame() == true then
      GUI.end_time = GUI.end_time - 2
    else
      SetupPlayerResult()
    end
  elseif GUI.current_time > GUI.end_time then
    NetRace.ChangeLocalPlayerState(Profile.GetPrimaryPad(), UIEnums.Network.PlayerStates.eNetPlayerStateFinished)
    if Multiplayer.RaceFinished() == true and NetRace.CanShowWinner() == true then
      GoScreen("Multiplayer\\Ingame\\MpWinner.lua")
    else
      Mp_ResetSpectateVars()
      GoScreen("Multiplayer\\Ingame\\MpSpectate.lua")
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
function SetupPlayerResult()
  UIButtons.SwapColour(SCUI.name_to_id.PosDummy, "Main_1", GetResultColour(Multiplayer.GetRaceResults().player_index))
  if Multiplayer.GetRaceResults().player_index <= 3 then
    UIButtons.SetActive(SCUI.name_to_id["Dummy_" .. Multiplayer.GetRaceResults().player_index], true)
  end
  if IsTable(Multiplayer.GetRaceResults().standings[Multiplayer.GetRaceResults().player_index]) then
    UIButtons.ChangeText(SCUI.name_to_id.Pos_Place, "MPL_RESULT_POS_WHOLE" .. Multiplayer.GetRaceResults().player_index - 1)
  end
  UIButtons.TimeLineActive("show_result", true)
end
