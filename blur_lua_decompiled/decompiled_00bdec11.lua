GUI = {
  finished = false,
  current_vehicle = -1,
  current_camera = -1,
  max_vehicles = -1,
  picture_map = {},
  current_vehicle_data = {}
}
function Init()
  SetupFadeToBlack(nil, true)
  UIScreen.SetScreenTimers(0.5, 0.5)
  AddSCUI_Elements()
  Camera_UseInGame()
  Amax.SendMessage(UIEnums.GameFlowMessage.StartSpectatorMode)
  UISystem.LoadLuaScript("Screens\\Ingame\\HUD_Helpers.lua")
  if NetServices.CanViewGamerCard(Profile.GetPrimaryPad()) == true then
    SetupInfoLine(UIText.INFO_VIEW_GAMER_CARD, UIText.INFO_QUIT_RACE, UIText.INFO_CHANGE_CAMERA, UIText.INFO_VIEW_SCOREBOARD)
  else
    SetupInfoLine(UIText.INFO_QUIT_RACE, UIText.INFO_CHANGE_CAMERA, UIText.INFO_VIEW_SCOREBOARD)
  end
  GUI.current_vehicle = UIGlobals.Mp_SpectateCurrentVehicle
  GUI.current_camera = UIGlobals.Mp_SpectateCurrentCamera
  GUI.max_vehicles = Amax.GetNumVehicles()
  GUI.picture_map = Profile.GetRemoteGamerPictureMap()
  GUI.current_vehicle_data = Amax.GetSpectateVehicleData(GUI.current_vehicle)
  Amax.SpectateVehicle(GUI.current_vehicle)
  Multiplayer.SwitchSpectateCam(GUI.current_camera, GUI.current_vehicle)
end
function PostInit()
  AddCutSceneBars()
  GUI.num_players = 1
  HUD.SetupPlayerViewports()
  UIButtons.ChangeScale(SetupScreenTitle(UIText.MP_SPECTATING, HUD.ViewportId3d[1], "effects", "common_icons", 1, UIEnums.Justify.TopCentre, true, nil, UIEnums.Panel._3DAA_0, nil, UIEnums.Justify.TopCentre), 0.7, 0.7, 1)
  GUI.scoreboard_id = UIButtons.CloneXtGadgetByName("hud_objects", "Mp_DataFullScreen")
  if Amax.IsRaceMpDestruction() == true then
  else
  end
  if false == true then
    UIButtons.SetXtVar(GUI.scoreboard_id, "only_show_finished_cars", true)
  end
  UIButtons.SetXtVar(GUI.scoreboard_id, "show_fullscreen_title", false)
  UIButtons.SetXtVar(GUI.scoreboard_id, "show_fullscreen_target", false)
  UIButtons.ChangePosition(GUI.scoreboard_id, nil, -30, nil, true)
  GUI.sp = {}
  UIButtons.ChangePosition(HUD_SpCreateTimer(HUD.ViewportId[1], "HUD_0_MP_TIMEOUT"), nil, -15, nil, true)
  MpSpectate_UpdateTimeout()
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_Speaking"), HUD.ViewportId3d[1], UIEnums.Justify.BottomLeft)
  UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_Speaking"), nil, -1, nil, true)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), HUD.ViewportId3d[1], UIEnums.Justify.TopRight)
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), "Map_SpeedNumber"), "HUD_" .. 0 .. "_SPEED_MPH")
  UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad"), UIEnums.Panel._RT0 + 0)
  UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad_Alt"), UIEnums.Panel._RT0 + 0)
  UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad"), "name", "shp_MiniMapRoad" .. 0)
  UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad_Alt"), "name", "shp_MiniMapRoad_Alt" .. 0)
  UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "dmy_MiniMapTranslate"), "name", "dmy_MiniMapTranslate" .. 0)
  UIButtons.SetXtVar(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "name", "dmy_MiniMapScale" .. 0)
  UIButtons.ChangeTexture({
    filename = "MINIMAP_RT" .. 0
  }, 5, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), "Map_Main")))
  if Amax.IsRaceMpDestruction() == true then
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), HUD.ViewportId3d[1], UIEnums.Justify.TopLeft)
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), HUD.ViewportId3d[1], UIEnums.Justify.TopLeft)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), "Points_Amount"), "HUD_" .. 0 .. "_MP_CURRENT_POINTS")
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), "SpDestructionPointsSmall"), false)
  else
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), HUD.ViewportId3d[1], UIEnums.Justify.TopLeft)
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), HUD.ViewportId3d[1], UIEnums.Justify.TopLeft)
    Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), "Position_Amount"), "HUD_" .. 0 .. "_POS_NUM")
    Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), "Position_AmountOf"), "HUD_" .. 0 .. "_POS_NUM_OF")
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Laps"), UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), UIEnums.Justify.TopRight)
    Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Laps"), "Map_LapsNum"), "HUD_" .. 0 .. "_LAP")
  end
  UIScreen.AddMessageNow(UIEnums.GameMessage.SetLocalPlayerIndex, 0)
  UIButtons.SetParent(SCUI.name_to_id.gamer_picture, HUD.ViewportId3d[1], UIEnums.Justify.BottomLeft)
  UIButtons.SetParent(SCUI.name_to_id.info_change_player, HUD.ViewportId3d[1], UIEnums.Justify.BottomCentre)
  MpSpectate_UpdatePlayerInfo()
  if NetRace.IsTeamGame() == true then
    UIButtons.SwapColour(HUD.ViewportId[1], "Main_1", UIGlobals.TeamColours[Select(GUI.current_vehicle_data.team == 0, "team_a", "team_b")])
    UIButtons.SwapColour(HUD.ViewportId3d[1], "Main_1", UIGlobals.TeamColours[Select(GUI.current_vehicle_data.team == 0, "team_a", "team_b")])
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and NetServices.CanViewGamerCard(Profile.GetPrimaryPad()) == true then
    NetServices.ViewGamerCard(Profile.GetPrimaryPad(), GUI.current_vehicle_data.join_ref, false, true)
  elseif _ARG_0_ == UIEnums.Message.ButtonRightTrigger then
    MpSpectate_ChangeSpectatedCar(1)
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftTrigger then
    MpSpectate_ChangeSpectatedCar(-1)
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    SetupCustomPopup(UIEnums.CustomPopups.ExitRace)
  elseif _ARG_0_ == UIEnums.Message.ButtonY then
    MpSpectate_ChangeCamera()
  elseif _ARG_0_ == UIEnums.MiscMessage.FinishedAnimatedCamera and _ARG_1_ == 0 and _ARG_2_ == false then
    MpSpectate_ChangeCamera(true)
  end
end
function FrameUpdate(_ARG_0_)
  MpSpectate_UpdateTimeout()
  if net_Disconnecting() == true then
    return
  end
  if Multiplayer.RaceFinished() == true and NetRace.CanShowWinner() == true then
    GoScreen("Multiplayer\\Ingame\\MpWinner.lua")
  end
  if Amax.SpectatedVehicleIsEliminated(GUI.current_vehicle) == true then
    MpSpectate_ChangeSpectatedCar(1)
  end
end
function EnterEnd()
end
function EndLoop(_ARG_0_)
end
function End()
  Camera_UseFrontend()
  UIGlobals.Mp_SpectateCurrentVehicle = GUI.current_vehicle
  UIGlobals.Mp_SpectateCurrentCamera = GUI.current_camera
end
function MpSpectate_UpdatePlayerInfo()
  if GUI.current_vehicle == 0 then
    UIButtons.ChangeColour(SCUI.name_to_id.gamertag, "Support_4")
    LocalGamerPicture(SCUI.name_to_id.gamer_picture, Profile.GetPrimaryPad())
  elseif GUI.current_vehicle_data.ai_driver == true then
    UIButtons.ChangeColour(SCUI.name_to_id.gamertag, "Support_2")
    AIGamerPicture(SCUI.name_to_id.gamer_picture, GUI.current_vehicle_data.ai_avatar_id)
  else
    UIButtons.ChangeColour(SCUI.name_to_id.gamertag, "Main_2")
    RemoteGamerPicture(SCUI.name_to_id.gamer_picture, GUI.picture_map[GUI.current_vehicle_data.join_ref])
  end
  UIButtons.ChangeText(SCUI.name_to_id.gamertag, "MPL_SPECTATE_NAME" .. GUI.current_vehicle)
  UIButtons.ChangeText(SCUI.name_to_id.rank, "MPL_SPECTATE_RANK" .. GUI.current_vehicle)
  Mp_RankIcon(SCUI.name_to_id.rank_icon, GUI.current_vehicle_data.rank, GUI.current_vehicle_data.legend)
  if #GUI.current_vehicle_data.mods == 0 then
    UIButtons.SetActive(SCUI.name_to_id.loadout_1, false, true)
  else
    for _FORV_5_, _FORV_6_ in ipairs(GUI.current_vehicle_data.mods) do
      UIButtons.ChangeTextureUV(SCUI.name_to_id["loadout_" .. _FORV_5_], 0, 0.03125 * _FORV_6_.type)
      UIButtons.ChangeColour(SCUI.name_to_id["loadout_" .. _FORV_5_], UIGlobals.CategoryColour[_FORV_6_.category])
    end
  end
end
function MpSpectate_ChangeCamera(_ARG_0_)
  GUI.current_camera = GUI.current_camera + 1
  if GUI.current_camera == 6 then
    GUI.current_camera = Select(_ARG_0_, 1, 0)
  end
  Multiplayer.SwitchSpectateCam(GUI.current_camera, GUI.current_vehicle)
end
function MpSpectate_ChangeSpectatedCar(_ARG_0_)
  (function()
    if Multiplayer.GetVehiclePosition(GUI.current_vehicle) + _UPVALUE0_ > GUI.max_vehicles then
    elseif 1 < 1 then
    end
    GUI.current_vehicle = Multiplayer.GetVehicleIndexByPosition(GUI.max_vehicles)
  end)()
  while Amax.CanSpectateVehicle(GUI.current_vehicle) == false do
    (function()
      if Multiplayer.GetVehiclePosition(GUI.current_vehicle) + _UPVALUE0_ > GUI.max_vehicles then
      elseif 1 < 1 then
      end
      GUI.current_vehicle = Multiplayer.GetVehicleIndexByPosition(GUI.max_vehicles)
    end)()
    if 0 + 1 == 20 then
      GUI.current_vehicle = GUI.current_vehicle
      break
    end
  end
  if GUI.current_vehicle ~= GUI.current_vehicle then
    GoScreen("Multiplayer\\Ingame\\MpSpectate.lua")
  end
end
function MpSpectate_UpdateTimeout()
  HUD_SpTimerUpdate((Amax.MP_GetTimeout()))
end
