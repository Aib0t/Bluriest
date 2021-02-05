GUI = {
  finished = false,
  current_city = -1,
  route_index = -1,
  point_to_point = nil,
  current_mode = -1,
  start_x = 0,
  start_y = -5,
  row_spacing = 10,
  table_toggle = false,
  selection = -1,
  options = {
    game_mode = 1,
    city = 2,
    route = 3,
    limit = 4,
    class = 5
  },
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_3", UIGlobals.CameraLerpTime, 0)
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK_CONFIRM, UIText.INFO_RT_ADVANCED)
  GUI.helptext = {
    [GUI.options.game_mode] = UIText.MP_CRHELP_GAMEMODE,
    [GUI.options.city] = UIText.MP_CRHELP_LOCATION,
    [GUI.options.route] = UIText.MP_CRHELP_TRACK,
    [GUI.options.limit] = UIText.CMN_NOWT,
    [GUI.options.class] = UIText.MP_CRHELP_CARCLASS
  }
  GUI.table_id = SCUI.name_to_id.table
  GUI.limit_data = Multiplayer.GetCustomRaceLimits()
  Mp_ReadCustomRaceSettings()
  CustomRace_CreateLeftColumn()
  CustomRace_CreateCentreColumn()
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.spinner_node, false)
  UIButtons.SetActive(SCUI.name_to_id.item_node, false)
  UIButtons.SetActive(SCUI.name_to_id.toggle_node, false)
  UIButtons.ChangePanel(SetupScreenTitle(UIText.MP_CUSTOM_RACE_BASIC_TITLE, SCUI.name_to_id.centre, "race_settings"), UIEnums.Panel._3DAA_WORLD, true)
  GUI.helpline_id = SetupBottomHelpBar(UIText.MP_CRHELP_GAMEMODE)
  CustomRace_UpdateHelptext()
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIButtons.GetType(_ARG_2_) == UIEnums.ButtonTypes.BOX then
    for _FORV_9_, _FORV_10_ in ipairs(GUI.table_id) do
      if _FORV_10_ == _ARG_2_ then
        SetCurrentItemByID(GUI.table_id, _FORV_10_)
        if UIButtons.GetTableSelection(GUI.table_id) == UIButtons.GetTableSelection(GUI.table_id) then
          print("something happened omfg")
          GUI.table_toggle = true
          UIButtons.ActivateTableElement(GUI.table_id, GUI.table_toggle)
        end
      end
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    PlaySfxNext()
    GUI.table_toggle = not GUI.table_toggle
    UIButtons.ActivateTableElement(GUI.table_id, GUI.table_toggle)
  elseif _ARG_0_ == UIEnums.Message.ButtonRightTrigger and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonRightTrigger then
    if UIButtons.TableElementActivated(GUI.table_id) == false then
      CustomRace_CustomRaceTable()
      UISystem.PlaySound(UIEnums.SoundEffect.StickersPage)
      GoScreen("Multiplayer\\Shared\\MpCustomRaceAdvanced.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    PlaySfxBack()
    if UIButtons.TableElementActivated(GUI.table_id) == true then
      GUI.table_toggle = false
      UIButtons.ActivateTableElement(GUI.table_id, false)
    else
      CustomRace_CustomRaceTable()
      Amax.ChangeUiCamera(UIGlobals.CameraNames.MpLobby, UIGlobals.CameraLerpTime, 0)
      if Amax.GetGameMode() == UIEnums.GameMode.Online or Amax.GetGameMode() == UIEnums.GameMode.SystemLink then
        NetRace.SendNewRaceSettings()
        PopScreen()
      elseif Amax.GetGameMode() == UIEnums.GameMode.SplitScreen then
        GoScreen("Multiplayer\\MpSplitscreenLobby.lua")
      end
      PlaySfxGraphicNext()
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.current_mode ~= UIButtons.GetSelection(GUI.game_mode_id) then
    GUI.current_mode = UIButtons.GetSelection(GUI.game_mode_id)
    if GUI.current_mode == UIEnums.MpRaceType.Destruction then
      CustomRace_SetupTimeLimit(GUI.limit_id)
    else
      CustomRace_SetupLapLimit(GUI.limit_id)
    end
    CustomRace_BuildCityList(GUI.city_id, (UIButtons.GetSelection(GUI.game_mode_id)))
    GUI.current_city = -1
  end
  if GUI.current_city ~= UIButtons.GetSelection(GUI.city_id) then
    GUI.current_city = UIButtons.GetSelection(GUI.city_id)
    GUI.route_index = -1
    CustomRace_BuildRouteList(GUI.route_id, (UIButtons.GetSelection(GUI.game_mode_id)))
  end
  if GUI.route_index ~= UIButtons.GetSelectionIndex(GUI.route_id) + 1 then
    GUI.route_index = UIButtons.GetSelectionIndex(GUI.route_id) + 1
    if GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].point_to_point ~= GUI.point_to_point then
      GUI.point_to_point = GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].point_to_point
      UIButtons.SetActive(UIButtons.GetNodeID(GUI.table_id, GUI.options.limit), not GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].point_to_point)
      UIButtons.SetSelection(GUI.limit_id, Select(GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].point_to_point, 1, UIGlobals.CustomRaceSettings.laps))
    end
    Mp_RouteThumbnail(SCUI.name_to_id.thumbnail, GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].thumbnail, 1)
    CustomRace_UpdateTrackMap()
  end
  CustomRace_UpdateHelptext()
end
function EnterEnd()
  RestoreInfoLine()
end
function End()
end
function CustomRace_UpdateHelptext()
  if UIButtons.GetTableSelection(GUI.table_id) ~= GUI.selection then
    GUI.selection = UIButtons.GetTableSelection(GUI.table_id)
    if UIButtons.GetTableSelection(GUI.table_id) == GUI.options.limit then
      UIButtons.ChangeText(GUI.helpline_id, (Select(UIButtons.GetSelection(GUI.game_mode_id) == UIEnums.MpRaceType.Destruction, UIText.MP_CRHELP_TIMELIMIT, UIText.MP_CRHELP_LAPS)))
      UIButtons.TimeLineActive("HelpFade", true, 0.5)
    else
      UIButtons.ChangeText(GUI.helpline_id, GUI.helptext[UIButtons.GetTableSelection(GUI.table_id)])
      UIButtons.TimeLineActive("HelpFade", true, 0.5)
    end
  end
end
function CustomRace_CreateLeftColumn()
  UIButtons.AddTableCol(GUI.table_id)
  GUI.game_mode_id = CustomRace_SetupSpinner(GUI.table_id, GUI.options.game_mode, UIText.MP_GAME_MODE, "retail_demo", "common_icons")
  UIButtons.AddItem(GUI.game_mode_id, UIEnums.MpRaceType.Racing, UIText.MP_RACE_TYPE_RACING, false)
  UIButtons.AddItem(GUI.game_mode_id, UIEnums.MpRaceType.Destruction, UIText.MP_RACE_TYPE_DESTRUCTION, false)
  UIButtons.SetSelection(GUI.game_mode_id, UIGlobals.CustomRaceSettings.game_mode)
  GUI.limit_id = CustomRace_SetupSpinner(GUI.table_id, GUI.options.limit, UIText.MP_LAPS, "lap", "common_icons")
  CustomRace_SetupLapLimit(GUI.limit_id)
  GUI.class_id = CustomRace_SetupSpinner(GUI.table_id, GUI.options.class, UIText.MP_CAR_CLASS, "all_classes", "common_icons")
  UIButtons.AddItem(GUI.class_id, UIEnums.MpVehicleClass.ClassA, UIText.MP_CLASS_A, false)
  UIButtons.AddItem(GUI.class_id, UIEnums.MpVehicleClass.ClassB, UIText.MP_CLASS_B, false)
  UIButtons.AddItem(GUI.class_id, UIEnums.MpVehicleClass.ClassC, UIText.MP_CLASS_C, false)
  UIButtons.AddItem(GUI.class_id, UIEnums.MpVehicleClass.ClassD, UIText.MP_CLASS_D, false)
  UIButtons.AddItem(GUI.class_id, UIEnums.MpVehicleClass.Any, UIText.MP_CLASS_ANY, false)
  UIButtons.SetSelection(GUI.class_id, UIGlobals.CustomRaceSettings.class)
end
function CustomRace_CreateCentreColumn()
  UIButtons.AddTableCol(GUI.table_id)
  GUI.city_id = CustomRace_SetupSpinner(GUI.table_id, GUI.options.city, UIText.MP_LOCATION, "location", "fe_icons")
  CustomRace_BuildCityList(GUI.city_id, UIGlobals.CustomRaceSettings.game_mode)
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.GetNodeID(GUI.table_id, GUI.options.city), "background_box"), 48, 6, 0)
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.GetNodeID(GUI.table_id, GUI.options.city), "background_inner_box"), 48, 6, 0)
  GUI.routes = Multiplayer.GetCustomRaceRoutes(GUI.current_city, UIGlobals.CustomRaceSettings.game_mode)
  GUI.route_id = CustomRace_SetupSpinner(GUI.table_id, GUI.options.route, UIText.MP_TRACK, "route", "fe_icons")
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.GetNodeID(GUI.table_id, GUI.options.route), "background_box"), 48, 6, 0)
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.GetNodeID(GUI.table_id, GUI.options.route), "background_inner_box"), 48, 6, 0)
  for _FORV_5_, _FORV_6_ in ipairs(GUI.routes) do
    UIButtons.AddItem(GUI.route_id, _FORV_6_.id, _FORV_6_.name, false)
  end
  if GUI.route_index ~= UIButtons.GetSelectionIndex(GUI.route_id) + 1 then
    GUI.route_index = UIButtons.GetSelectionIndex(GUI.route_id) + 1
    Mp_RouteThumbnail(SCUI.name_to_id.thumbnail, GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].thumbnail, 1)
  end
end
function CustomRace_SetupSpinner(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), "spinner"), _ARG_2_)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), "icon"), _ARG_4_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), "icon"), _ARG_3_)
  UIButtons.AddTableRow(_ARG_0_, UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), _ARG_1_)
  return (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), "spinner"))
end
function CustomRace_BuildCityList(_ARG_0_, _ARG_1_)
  GUI.cities = Multiplayer.GetCustomRaceCities(_ARG_1_)
  UIButtons.ClearItems(_ARG_0_)
  for _FORV_5_, _FORV_6_ in ipairs(GUI.cities) do
    UIButtons.AddItem(_ARG_0_, _FORV_6_.id, _FORV_6_.name, false)
  end
  UIButtons.SetSelectionByIndex(_ARG_0_, 0)
  UIButtons.SetSelection(_ARG_0_, UIGlobals.CustomRaceSettings.city_id)
  GUI.current_city = UIGlobals.CustomRaceSettings.city_id
  Amax.SliderUpdateArrows(_ARG_0_)
end
function CustomRace_BuildRouteList(_ARG_0_, _ARG_1_)
  GUI.routes = Multiplayer.GetCustomRaceRoutes(GUI.current_city, _ARG_1_)
  UIButtons.ClearItems(_ARG_0_)
  for _FORV_5_, _FORV_6_ in ipairs(GUI.routes) do
    UIButtons.AddItem(_ARG_0_, _FORV_6_.id, _FORV_6_.name, false)
  end
  UIButtons.SetSelectionByIndex(_ARG_0_, 0)
  UIButtons.SetSelection(_ARG_0_, UIGlobals.CustomRaceSettings.route_id)
  Amax.SliderUpdateArrows(_ARG_0_)
end
function CustomRace_SetupLapLimit(_ARG_0_)
  Amax.ChangeText(_ARG_0_, UIText.MP_LAPS)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.GetNodeID(GUI.table_id, GUI.options.limit), "icon"), "lap")
  UIButtons.ClearItems(_ARG_0_)
  for _FORV_5_ = 1, GUI.limit_data.max_laps do
    UIButtons.AddItem(_ARG_0_, _FORV_5_, "GAME_NUM_" .. _FORV_5_, true)
  end
  _FOR_.SetSelection(_ARG_0_, UIGlobals.CustomRaceSettings.laps)
  Amax.SliderUpdateArrows(_ARG_0_)
end
function CustomRace_SetupTimeLimit(_ARG_0_)
  Amax.ChangeText(_ARG_0_, UIText.MP_TIME_LIMIT)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.GetNodeID(GUI.table_id, GUI.options.limit), "icon"), "stopwatch")
  UIButtons.ClearItems(_ARG_0_)
  for _FORV_5_ = GUI.limit_data.time_step, GUI.limit_data.max_time, GUI.limit_data.time_step do
    UIButtons.AddItem(_ARG_0_, _FORV_5_, "GAME_TIME_" .. _FORV_5_, true)
  end
  _FOR_.SetSelection(_ARG_0_, UIGlobals.CustomRaceSettings.time)
  Amax.SliderUpdateArrows(_ARG_0_)
end
function CustomRace_UpdateTrackMap()
  UIButtons.SetActive(SCUI.name_to_id.map_track, false)
  UIButtons.SetActive(SCUI.name_to_id.map_track_draw, false)
  UIButtons.SetActive(SCUI.name_to_id.map_startline, false)
  for _FORV_9_, _FORV_10_ in pairs({
    SCUI.name_to_id.map_track,
    SCUI.name_to_id.map_track_draw
  }) do
    if UIShape.ChangeSceneName(_FORV_10_, GUI.cities[UIButtons.GetSelectionIndex(GUI.city_id) + 1].debug_tag .. "_ui") == false then
      return
    end
    if UIShape.ChangeObjectName(_FORV_10_, GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].debug_tag .. "_ui") == false and UIShape.ChangeObjectName(_FORV_10_, GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].debug_tag) == false then
      return
    end
    UIButtons.SetActive(_FORV_10_, true)
  end
  if UIShape.ChangeSceneName(SCUI.name_to_id.map_startline, GUI.cities[UIButtons.GetSelectionIndex(GUI.city_id) + 1].debug_tag .. "_ui") == true and UIShape.ChangeObjectName(SCUI.name_to_id.map_startline, GUI.routes[UIButtons.GetSelectionIndex(GUI.route_id) + 1].debug_tag .. "_start_line") == true then
    UIButtons.SetActive(SCUI.name_to_id.map_startline, true)
  end
end
function CustomRace_CustomRaceTable()
  UIGlobals.CustomRaceSettings.num_players = Select(Amax.GetGameMode() == UIEnums.GameMode.SplitScreen, #UIGlobals.Splitscreen.players, 1)
  UIGlobals.CustomRaceSettings.game_mode = UIButtons.GetSelection(GUI.game_mode_id)
  UIGlobals.CustomRaceSettings.city_id = UIButtons.GetSelection(GUI.city_id)
  UIGlobals.CustomRaceSettings.route_id = UIButtons.GetSelection(GUI.route_id)
  UIGlobals.CustomRaceSettings.laps = Select(UIButtons.GetSelection(GUI.game_mode_id) == UIEnums.MpRaceType.Destruction, 1, UIButtons.GetSelection(GUI.limit_id))
  UIGlobals.CustomRaceSettings.time = Select(UIButtons.GetSelection(GUI.game_mode_id) == UIEnums.MpRaceType.Destruction, UIButtons.GetSelection(GUI.limit_id), 1)
  UIGlobals.CustomRaceSettings.class = UIButtons.GetSelection(GUI.class_id)
  Amax.SetupRace(UIGlobals.CustomRaceSettings)
end
