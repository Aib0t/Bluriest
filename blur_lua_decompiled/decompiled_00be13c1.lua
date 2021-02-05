GUI = {
  finished = false,
  disable_loading = false,
  resources_loaded = false,
  can_move_on = false,
  num_views = 1,
  team_result_titles = {
    team_a = UIText.MP_TEAM_A_WINS,
    team_b = UIText.MP_TEAM_B_WINS
  },
  team_draw_texture = {
    filename = "team_icons",
    pos = {u = 0, v = 0},
    size = {u = 1, v = 1}
  }
}
function Init()
  if net_Disconnecting() == false then
    UIScreen.CancelPopup()
  end
  AddSCUI_Elements()
  Amax.SetupResults()
  if IsSplitScreen() == true then
    Amax.SetNumViewports(1)
  else
    NetRace.EnterResults()
  end
  if NetRace.IsTeamGame() == true then
    GUI.Results = Multiplayer.GetTeamResults()
    GUI.WinnerIndex = GUI.Results[GUI.Results.winner][1].vehicle_index
  else
    GUI.Results = Multiplayer.GetRaceResults()
    GUI.WinnerIndex = GUI.Results.standings[1].vehicle_index
  end
  GUI.GamerPictures = Profile.GetRemoteGamerPictureMap()
end
function PostInit()
  if NetRace.IsTeamGame() == true then
    Winner_SetupTeam(GUI.Results.winner, GUI.Results.draw)
  else
    for _FORV_3_, _FORV_4_ in ipairs(GUI.Results.standings) do
      if _FORV_3_ <= 3 then
        Winner_SetupPlayer(_FORV_4_, _FORV_3_)
      end
    end
  end
  Amax.RepairVehicle(GUI.WinnerIndex)
  for _FORV_3_ = 1, Amax.GetNumViewports() do
    if Amax.IsRaceMpDestruction() == true then
      Amax.AutoSelectAnimatedCamera(GUI.WinnerIndex, _FORV_3_ - 1)
      Amax.DisableCarControls()
    else
      Amax.StartAnimatedCamera(UIEnums.AnimatedCameraSequenceType.MpWinner, false, GUI.WinnerIndex, _FORV_3_ - 1)
    end
  end
  _FOR_.PlaySound(UIEnums.SoundEffect.MPFocusOnWinner)
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
  if _ARG_0_ == UIEnums.GameFlowMessage.UILoaded then
    GUI.resources_loaded = true
    Debug.IncrementMemoryTag("ui")
    Amax.ExitNetworkLoad()
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if GUI.resources_loaded == true and GUI.can_move_on == true then
    if IsSplitScreen() == true then
      GoScreen("Multiplayer\\Ingame\\MpSplitscreenResults.lua")
    elseif NetRace.IsTeamGame() == true then
      GoScreen("Multiplayer\\Ingame\\MpTeamResults.lua")
    else
      GoScreen("Multiplayer\\Ingame\\MpRaceResults.lua")
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  Profile.ForceProfileUpdate()
  Profile.ActOnProfileChanges(true)
  net_EnableGlobalUpdate(true)
end
function Winner_SetupPlayer(_ARG_0_, _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "gamertag"), "MPL_RESULT_NAME" .. _ARG_1_ - 1)
  UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "rank"), "MPL_RESULT_RANK" .. _ARG_1_ - 1)
  if _ARG_1_ == 1 then
    UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "streak"), "MPL_RESULT_STREAK" .. _ARG_1_ - 1)
  end
  if IsSplitScreen() == true and GUI.Results.standings[_ARG_1_].vehicle_index < #UIGlobals.Splitscreen.players then
    LocalGamerPicture(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "gamerpic"), UIGlobals.Splitscreen.players[GUI.Results.standings[_ARG_1_].vehicle_index + 1].pad)
  elseif _ARG_1_ == GUI.Results.player_index then
    LocalGamerPicture(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "gamerpic"), Profile.GetPrimaryPad())
  elseif _ARG_0_.ai_driver == true then
    AIGamerPicture(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "gamerpic"), _ARG_0_.ai_avatar_id)
  else
    RemoteGamerPicture(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "gamerpic"), GUI.GamerPictures[_ARG_0_.join_ref])
  end
  if IsSplitScreen() == true then
    UIButtons.SetActive(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "rank"), false, true)
    if _ARG_1_ == 1 then
      UIButtons.ChangePosition(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "gamertag"), 0, -6, 0)
    else
      UIButtons.ChangePosition(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "gamertag"), 0, -2.5, 0)
    end
  else
    Mp_RankIcon(UIButtons.FindChildByName(SCUI.name_to_id["player_node_" .. _ARG_1_], "rank_icon"), _ARG_0_.rank, _ARG_0_.legend)
  end
  UIButtons.SetActive(SCUI.name_to_id["player_node_" .. _ARG_1_], true)
end
function Winner_SetupTeam(_ARG_0_, _ARG_1_)
  if _ARG_1_ == true then
    UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.team_node, "team"), UIText.MP_TEAM_DRAW)
    UIButtons.ChangeSize(UIButtons.FindChildByName(SCUI.name_to_id.team_node, "icon"), 26, 13, 0)
    UIButtons.ChangeTexture(GUI.team_draw_texture, 0, (UIButtons.FindChildByName(SCUI.name_to_id.team_node, "icon")))
  else
    UIButtons.ChangeText(UIButtons.FindChildByName(SCUI.name_to_id.team_node, "team"), GUI.team_result_titles[_ARG_0_])
    UIButtons.ChangeColour(UIButtons.FindChildByName(SCUI.name_to_id.team_node, "team"), UIGlobals.TeamColours[_ARG_0_])
    UIButtons.ChangeColour(UIButtons.FindChildByName(SCUI.name_to_id.team_node, "icon"), UIGlobals.TeamColours[_ARG_0_])
    UIButtons.ChangeTextureUV(UIButtons.FindChildByName(SCUI.name_to_id.team_node, "icon"), 0, UIGlobals.TeamIcons[_ARG_0_].u, UIGlobals.TeamIcons[_ARG_0_].v)
  end
  UIButtons.SetActive(SCUI.name_to_id.team_node, true)
end
function Winner_StartLoad()
  if ContextTable[UIEnums.Context.Main].GUI.disable_loading == true or net_Disconnecting() == true then
    return
  end
  if ContextTable[UIEnums.Context.Main].GUI.resources_loaded == false then
    Profile.AllowProfileChanges(true)
    Profile.ActOnProfileChanges(false)
    net_EnableGlobalUpdate(false)
    Amax.EnterNetworkLoad()
    Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
    Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
    Amax.SendMessage(UIEnums.GameFlowMessage.StartUILoad)
  end
end
function Winner_NextScreen()
  ContextTable[UIEnums.Context.Main].GUI.can_move_on = true
end
function Winner_Snapshot()
  Amax.TakePhoto(1, false, false)
  UIButtons.SetActive(SCUI.name_to_id.background, true)
  UIButtons.TimeLineActive("fade_bg", true)
end
