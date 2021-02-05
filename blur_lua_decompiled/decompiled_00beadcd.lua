GUI = {
  finished = false,
  player_list_id = -1,
  player_nodes = {},
  colours = {},
  can_invite = nil,
  view_gamercard = nil
}
function Init()
  PlaySfxGraphicBack()
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_2", UIGlobals.CameraLerpTime, 0)
  UIButtons.TimeLineActive("Hide_Lobby", true)
  GUI.race_preview_id = SCUI.name_to_id.race_preview
  GUI.colours[1] = UIButtons.GetXtVar(GUI.race_preview_id, "colour_first")
  GUI.colours[2] = UIButtons.GetXtVar(GUI.race_preview_id, "colour_second")
  GUI.colours[3] = UIButtons.GetXtVar(GUI.race_preview_id, "colour_third")
  GUI.colours[4] = UIButtons.GetXtVar(GUI.race_preview_id, "colour_other")
  GUI.player_list_id = SCUI.name_to_id.player_list
  GUI.race = Multiplayer.GetCurrentRace()
  for _FORV_3_ = 1, 20 do
    GUI.player_nodes[_FORV_3_] = MpRacePreview_SetupPlayerNode(_FORV_3_)
    UIButtons.AddListItem(GUI.player_list_id, GUI.player_nodes[_FORV_3_], _FORV_3_)
  end
  _FOR_()
  StoreInfoLine()
  MpRacePreview_RefreshInfolines()
end
function PostInit()
  UIButtons.ChangePanel(SetupScreenTitle(UIText.MP_RACE_PREVIEW, SCUI.name_to_id.centre, "route", "fe_icons"), UIEnums.Panel._3DAA_WORLD, true)
  Mp_RefreshRaceOverview(SCUI.name_to_id.race_overview_node, GUI.race)
  MpRacePreview_UpdateTrackMap(GameData.GetCityData(GUI.race.city), (GameData.GetRouteData(GUI.race.route)))
  if GUI.race.type == UIEnums.MpRaceType.Racing then
    UIButtons.ChangeText(SCUI.name_to_id.limit, "LOBBY_PREVIEW_LAPS")
    UIButtons.ChangeText(SCUI.name_to_id.timeout, "LOBBY_PREVIEW_TIME")
  else
    UIButtons.ChangeText(SCUI.name_to_id.limit, "LOBBY_PREVIEW_TIME")
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    PlaySfxBack()
    PopScreen()
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if NetServices.CanViewGamerCard(Profile.GetPrimaryPad()) == true then
      NetServices.ViewGamerCard(Profile.GetPrimaryPad(), Select(GUI.preview.loading, GUI.preview.players_loading, GUI.preview.players_racing)[UIButtons.GetSelection(GUI.player_list_id)], false, false)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonY and _ARG_2_ == true and Mp_XenonGameInviteAvailable() == true then
    if Mp_XenonPartyActive() == true then
      UIHardware.ShowParty360(Profile.GetPrimaryPad())
    else
      UIHardware.ShowFriends360(Profile.GetPrimaryPad())
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if Multiplayer.RefreshRacePreview(GUI.race_preview_id) == true then
    MpRacePreview_RefreshStandings()
  end
  if NetRace.RaceInProgress() == false or NetRace.HasRaceFinished() == true then
    PlaySfxBack()
    PopScreen()
  end
  MpRacePreview_RefreshInfolines()
end
function EnterEnd()
  PlaySfxGraphicNext()
  RestoreInfoLine()
  Amax.ChangeUiCamera(UIGlobals.CameraNames.MpLobby, UIGlobals.CameraLerpTime, 0)
  UIButtons.TimeLineActive("Hide_Lobby", false)
end
function End()
  UIButtons.SetActive(SCUI.name_to_id.player_node, false, true)
end
function MpRacePreview_SetupPlayerNode(_ARG_0_)
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpRacePreview.lua", "player_node"), "background_box"), _ARG_0_ % 2 == 1)
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpRacePreview.lua", "player_node"), "position"), GUI.colours[Select(_ARG_0_ > #GUI.colours, 4, _ARG_0_)])
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpRacePreview.lua", "player_node"), "name"), GUI.colours[Select(_ARG_0_ > #GUI.colours, 4, _ARG_0_)])
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpRacePreview.lua", "player_node"), "state"), GUI.colours[Select(_ARG_0_ > #GUI.colours, 4, _ARG_0_)])
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpRacePreview.lua", "player_node"), "position"), "GAME_POS_" .. _ARG_0_)
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\MpRacePreview.lua", "player_node"))
end
function MpRacePreview_RefreshStandings()
  for _FORV_3_, _FORV_4_ in ipairs(GUI.player_nodes) do
    UIButtons.LockNode(_FORV_4_)
  end
  GUI.preview = Multiplayer.GetRacePreviewData(GUI.race_preview_id)
  if GUI.preview.loading == true then
    for _FORV_3_, _FORV_4_ in ipairs(GUI.preview.players_loading) do
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.player_nodes[_FORV_3_], "name"), "LOBBY_PLAYER_NAME" .. _FORV_4_)
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.player_nodes[_FORV_3_], "state"), UIText.MP_LOADING)
      UIButtons.UnlockNode(GUI.player_nodes[_FORV_3_])
    end
  else
    for _FORV_3_, _FORV_4_ in ipairs(GUI.preview.players_racing) do
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.player_nodes[_FORV_3_], "name"), "LOBBY_PREVIEW_NAME" .. _FORV_3_)
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.player_nodes[_FORV_3_], "state"), "LOBBY_PREVIEW_STATE" .. _FORV_3_)
      UIButtons.UnlockNode(GUI.player_nodes[_FORV_3_])
    end
  end
end
function MpRacePreview_UpdateTrackMap(_ARG_0_, _ARG_1_)
  UIButtons.SetActive(SCUI.name_to_id.track_shape, false)
  UIButtons.SetActive(SCUI.name_to_id.start_line, false)
  if UIShape.ChangeSceneName(SCUI.name_to_id.track_shape, _ARG_0_.debug_tag .. "_game") == false then
    return
  end
  if UIShape.ChangeObjectName(SCUI.name_to_id.track_shape, _ARG_1_.debug_tag) == false and UIShape.ChangeObjectName(SCUI.name_to_id.track_shape, _ARG_1_.debug_tag) == false then
    return
  end
  UIButtons.SetActive(SCUI.name_to_id.track_shape, true)
  if UIShape.ChangeSceneName(SCUI.name_to_id.start_line, _ARG_0_.debug_tag .. "_game") == false then
    return
  end
  if UIShape.ChangeObjectName(SCUI.name_to_id.start_line, _ARG_1_.debug_tag .. "_Alt") == false then
    return
  end
  UIButtons.SetActive(SCUI.name_to_id.start_line, true)
end
function MpRacePreview_RefreshInfolines()
