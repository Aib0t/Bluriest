GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  car_node_list_ids = {},
  stat_ids = {},
  ready_ids = {},
  colour_ids = {
    {}
  },
  current_car_selection = {},
  current_colour_selection = {},
  previous_colour_selection = {},
  ready_time = 1,
  ready_countdown = 0,
  player_ready = {},
  mode = {car = 0, colour = 1},
  current_mode = {},
  class_icon_names = {
    [UIEnums.VehicleClass.A] = "Class_A",
    [UIEnums.VehicleClass.B] = "Class_B",
    [UIEnums.VehicleClass.C] = "Class_C",
    [UIEnums.VehicleClass.D] = "Class_D",
    [UIEnums.VehicleClass.E] = "Class_E"
  },
  style_names = {
    [UIEnums.VehicleUiStyle.Balanced] = UIText.RBC_STYLE_BALANCED,
    [UIEnums.VehicleUiStyle.Drifty] = UIText.RBC_STYLE_DRIFTY,
    [UIEnums.VehicleUiStyle.VeryDrifty] = UIText.RBC_STYLE_VERY_DRIFTY,
    [UIEnums.VehicleUiStyle.Grippy] = UIText.RBC_STYLE_GRIPPY,
    [UIEnums.VehicleUiStyle.VeryGrippy] = UIText.RBC_STYLE_VERY_GRIPPY,
    [UIEnums.VehicleUiStyle.OffRoad] = UIText.RBC_STYLE_OFF_ROAD
  }
}
function Init()
  Profile.LockToPad(-1)
  AddSCUI_Elements()
  GUI.stencil_justify = {
    [SCUI.name_to_id.dummy_1] = UIEnums.Justify.BottomRight,
    [SCUI.name_to_id.dummy_2] = UIEnums.Justify.BottomLeft,
    [SCUI.name_to_id.dummy_3] = UIEnums.Justify.TopRight,
    [SCUI.name_to_id.dummy_4] = UIEnums.Justify.TopLeft,
    [SCUI.name_to_id.dummy_top] = UIEnums.Justify.BottomCentre,
    [SCUI.name_to_id.dummy_bottom] = UIEnums.Justify.TopCentre
  }
  StoreInfoLine()
  SetupInfoLine()
  GUI.cars = {}
  GUI.car_info = {}
  for _FORV_4_, _FORV_5_ in pairs((Multiplayer.GetSplitscreenVehicles())) do
    GUI.cars[#GUI.cars + 1] = _FORV_4_
    GUI.car_info[_FORV_4_] = GameData.GetVehicle(_FORV_4_)
  end
  table.sort(GUI.cars, function(_ARG_0_, _ARG_1_)
    if GUI.car_info[_ARG_0_].class == GUI.car_info[_ARG_1_].class then
      if GUI.car_info[_ARG_0_].man_tag == GUI.car_info[_ARG_1_].man_tag then
        return GUI.car_info[_ARG_0_].tag < GUI.car_info[_ARG_1_].tag
      end
      return GUI.car_info[_ARG_0_].man_tag < GUI.car_info[_ARG_1_].man_tag
    end
    return GUI.car_info[_ARG_0_].class < GUI.car_info[_ARG_1_].class
  end)
  GUI.car_colours = Multiplayer.GetSplitscreenResprays()
end
function PostInit()
  for _FORV_3_ = 1, 4 do
    UIButtons.SetActive(SCUI.name_to_id["dummy_" .. _FORV_3_], false, true)
  end
  _FOR_.SetActive(SCUI.name_to_id.dummy_top, false, true)
  UIButtons.SetActive(SCUI.name_to_id.dummy_bottom, false, true)
  for _FORV_3_, _FORV_4_ in ipairs(UIGlobals.Splitscreen.players) do
    UIButtons.SetActive(Splitscreen_GetDummyId(_FORV_3_), true, true)
    if _FORV_3_ ~= 1 then
    end
    SplitscreenGarage_PushStencil(Splitscreen_GetDummyId(_FORV_3_), _FORV_3_)
    SplitscreenGarage_PopStencil(Splitscreen_GetDummyId(_FORV_3_), _FORV_3_)
    for _FORV_12_, _FORV_13_ in pairs(GUI.cars) do
      UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_car_node"), "_car_icon"), GUI.car_info[_FORV_13_].sheet)
      UIButtons.ChangeMouseClickable(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_car_node"), "_car_icon"), true)
      UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_car_node"), "_car_icon"), GUI.car_info[_FORV_13_].icon)
      UIButtons.AddListItem(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "car_node_list_parent"), "car_node_list"), UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_car_node"), _FORV_12_)
    end
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), Splitscreen_GetDummyId(_FORV_3_), UIEnums.Justify.MiddleCentre)
    UIButtons.SetParent(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "car_node_list_parent"), "car_node_list"), Splitscreen_GetDummyId(_FORV_3_), UIEnums.Justify.MiddleCentre)
    GUI.stat_ids[_FORV_3_] = {
      car_name = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "stat_car_name"),
      man_rect = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "stat_man_rect"),
      man_square = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "stat_man_square"),
      class_icon = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "stat_class_icon"),
      style_text = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "stat_style_text"),
      acceleration = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "chick_acceleration"),
      speed = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "chick_speed"),
      off_road = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "chick_off_road"),
      difficulty = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "chick_difficulty"),
      health = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "stat_parent"), "chick_health")
    }
    UIButtons.SetPad(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "car_node_list_parent"), "car_node_list"), _FORV_4_.pad)
    if _FORV_4_.car_id == 0 then
      GUI.current_car_selection[_FORV_3_] = -1
      GUI.current_colour_selection[_FORV_3_] = -1
      GUI.previous_colour_selection[_FORV_3_] = -1
    else
      GUI.current_car_selection[_FORV_3_] = FindSelectionIdFromCarId(_FORV_4_.car_id)
      GUI.current_colour_selection[_FORV_3_] = FindSelectionIdFromColourId(_FORV_4_.colour_id)
      GUI.previous_colour_selection[_FORV_3_] = GUI.current_colour_selection[_FORV_3_]
      UIButtons.SetSelection(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "car_node_list_parent"), "car_node_list"), GUI.current_car_selection[_FORV_3_])
    end
    SplitscreenGarage_CreateColours(_FORV_3_)
    GUI.car_node_list_ids[_FORV_3_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "car_node_list_parent"), "car_node_list")
    GUI.player_ready[_FORV_3_] = false
    GUI.current_mode[_FORV_3_] = GUI.mode.car
    SplitscreenGarage_CreateReady(_FORV_3_)
    SplitscreenGarage_UpdateStats(_FORV_3_)
  end
  Splitscreen_SetFrontendSplits()
  SplitscreenGarage_CheckForChange()
  SplitscreenGarage_UpdateColourPicker()
  SplitscreenGarage_CheckInfoLines()
  UIButtons.SetActive(SCUI.name_to_id.car_node_list_parent, false, true)
end
function FindSelectionIdFromCarId(_ARG_0_)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.cars) do
    if _ARG_0_ == _FORV_5_ then
      return _FORV_4_
    end
  end
  return -1
end
function FindSelectionIdFromColourId(_ARG_0_)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.car_colours) do
    if _ARG_0_ == _FORV_5_.id then
      return _FORV_4_
    end
  end
  return -1
end
function FrameUpdate(_ARG_0_)
  SplitscreenGarage_CheckForChange()
  SplitscreenGarage_CheckInfoLines()
  if SplitscreenGarage_AllReady() == true then
    GUI.ready_countdown = GUI.ready_countdown - _ARG_0_
    if GUI.ready_countdown <= 0 then
      GUI.ready_countdown = GUI.ready_time
      SplitscreenGarage_LoadRace()
    end
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_1_ == Profile.GetPrimaryPad() and _ARG_0_ == UIEnums.Message.MenuBack and GUI.current_mode[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] == GUI.mode.car then
    if GUI.player_ready[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] == false then
      PlaySfxBack()
      GoScreen("Multiplayer\\MpSplitscreenLobby.lua")
      return
    end
    GUI.ready_countdown = GUI.ready_time
  end
  if GUI.current_mode[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] == GUI.mode.car then
    if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIButtons.GetType(_ARG_2_) == UIEnums.ButtonTypes.STATIC_SHAPE and UIButtons.GetType((UIButtons.GetParent(_ARG_2_))) == UIEnums.ButtonTypes.NODE and UIButtons.GetParent((UIButtons.GetParent(_ARG_2_))) == UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "car_node_list_parent"), "car_node_list") then
      UIButtons.SetCurrentItemByID(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "car_node_list_parent"), "car_node_list"), _ARG_2_)
    end
    if _ARG_0_ == UIEnums.Message.ButtonX or mouseButton == UIEnums.Message.ButtonX then
      if GUI.player_ready[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] == false then
        if GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]])]].respray == true then
          PlaySfxNext()
          GUI.current_mode[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = GUI.mode.colour
          UIButtons.TimeLineActive("colour_" .. Splitscreen_GetDummyName(UIGlobals.Splitscreen.pad_to_player[_ARG_1_]), true)
          GUI.previous_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]]
          if GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] == -1 then
            GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = UIGlobals.Splitscreen.pad_to_player[_ARG_1_]
            SplitscreenGarage_UpdateColourPicker(UIGlobals.Splitscreen.pad_to_player[_ARG_1_])
          end
          UIButtons.SetSelected(GUI.car_node_list_ids[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]], false)
        else
          PlaySfxError()
        end
      end
    elseif _ARG_0_ == UIEnums.Message.MenuNext then
      if GUI.player_ready[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] == false then
        PlaySfxNext()
        GUI.player_ready[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = true
        UIButtons.TimeLineActive("ready_" .. Splitscreen_GetDummyName(UIGlobals.Splitscreen.pad_to_player[_ARG_1_]), true)
        UIButtons.SetSelected(GUI.car_node_list_ids[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]], false)
        if SplitscreenGarage_AllReady() == true then
          GUI.ready_countdown = GUI.ready_time
        end
      end
    elseif _ARG_0_ == UIEnums.Message.MenuBack then
      if GUI.player_ready[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] == true then
        PlaySfxBack()
        GUI.player_ready[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = false
        UIButtons.TimeLineActive("ready_" .. Splitscreen_GetDummyName(UIGlobals.Splitscreen.pad_to_player[_ARG_1_]), false)
        UIButtons.SetSelected(GUI.car_node_list_ids[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]], true)
      end
    elseif mouseButton == UIEnums.Message.ButtonB then
      print("cheeseB")
    end
  elseif GUI.current_mode[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] == GUI.mode.colour then
    if _ARG_0_ == UIEnums.Message.MenuNext or mouseButton == UIEnums.Message.ButtonA then
      UISystem.PlaySound(UIEnums.SoundEffect.GarageReSpray)
      GUI.current_mode[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = GUI.mode.car
      UIButtons.TimeLineActive("colour_" .. Splitscreen_GetDummyName(UIGlobals.Splitscreen.pad_to_player[_ARG_1_]), false)
      SplitscreenGarage_UpdateColour(UIGlobals.Splitscreen.pad_to_player[_ARG_1_])
      UIButtons.SetSelected(GUI.car_node_list_ids[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]], true)
      GUI.player_ready[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = true
      UIButtons.TimeLineActive("ready_" .. Splitscreen_GetDummyName(UIGlobals.Splitscreen.pad_to_player[_ARG_1_]), true)
      UIButtons.SetSelected(GUI.car_node_list_ids[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]], false)
    elseif _ARG_0_ == UIEnums.Message.MenuBack or mouseButton == UIEnums.Message.ButtonB then
      PlaySfxBack()
      GUI.current_mode[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = GUI.mode.car
      UIButtons.TimeLineActive("colour_" .. Splitscreen_GetDummyName(UIGlobals.Splitscreen.pad_to_player[_ARG_1_]), false)
      GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = GUI.previous_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]]
      SplitscreenGarage_UpdateColourPicker(UIGlobals.Splitscreen.pad_to_player[_ARG_1_], GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]])
      UIButtons.SetSelected(GUI.car_node_list_ids[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]], true)
    elseif _ARG_0_ == UIEnums.Message.ButtonLeft then
      SplitscreenGarage_UpdateColourPicker(UIGlobals.Splitscreen.pad_to_player[_ARG_1_], GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] - 1)
      if GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] ~= GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] then
        PlaySfxLeft()
      end
    elseif _ARG_0_ == UIEnums.Message.ButtonRight then
      SplitscreenGarage_UpdateColourPicker(UIGlobals.Splitscreen.pad_to_player[_ARG_1_], GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] + 1)
      if GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] ~= GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] then
        PlaySfxRight()
      end
    elseif _ARG_0_ == UIEnums.Message.ButtonX then
      UISystem.PlaySound(UIEnums.SoundEffect.GarageReSpray)
      GUI.current_mode[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = GUI.mode.car
      UIButtons.TimeLineActive("colour_" .. Splitscreen_GetDummyName(UIGlobals.Splitscreen.pad_to_player[_ARG_1_]), false)
      GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]] = -1
      SplitscreenGarage_UpdateColourPicker(UIGlobals.Splitscreen.pad_to_player[_ARG_1_], GUI.current_colour_selection[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]])
      SplitscreenGarage_UpdateColour(UIGlobals.Splitscreen.pad_to_player[_ARG_1_])
      UIButtons.SetSelected(GUI.car_node_list_ids[UIGlobals.Splitscreen.pad_to_player[_ARG_1_]], true)
    end
  end
end
function EnterEnd()
  RestoreInfoLine()
  Profile.LockToPad(Profile.GetPrimaryPad())
end
function End()
end
function SplitscreenGarage_LoadRace()
  for _FORV_3_, _FORV_4_ in ipairs(UIGlobals.Splitscreen.players) do
    _FORV_4_.car_id = GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_FORV_3_])]
    if GUI.current_colour_selection[_FORV_3_] == -1 or GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_FORV_3_])]].respray == false then
      _FORV_4_.colour_id = 0
    else
      _FORV_4_.colour_id = GUI.car_colours[GUI.current_colour_selection[_FORV_3_]].id
    end
  end
  Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
  Amax.SendMessage(UIEnums.GameFlowMessage.StopGameUpdate)
  UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.SplitscreenLobby
  StoreScreen(UIEnums.ScreenStorage.FE_RETURN)
  UIGlobals.Splitscreen.primary_pad = Profile.GetPrimaryPad()
  UIGlobals.Multiplayer.LobbyLoad = true
  UIGlobals.Splitscreen.can_vote = Amax.GetPlayMode() == UIEnums.PlayMode.Playlist
  PlaySfxNext()
  StopFrontendMusic()
  UIGlobals.IsLoading = true
  GoLoadingScreen("Loading\\LoadingMpGame.lua")
end
function SplitscreenGarage_CreateReady(_ARG_0_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"), SCUI.name_to_id["ready_dummy_" .. Splitscreen_GetDummyName(_ARG_0_)], UIEnums.Justify.MiddleCentre)
  GUI.ready_ids[_ARG_0_] = {
    class_icon = UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"),
    car_icon = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"), "_ready_car_icon"),
    car_name = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"), "_ready_car_name"),
    man_rect = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"), "_ready_man_rect"),
    man_square = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"), "_ready_man_square"),
    colour_frame = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"), "_car_colour_frame"),
    colour_fill = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"), "_car_colour")
  }
  UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\MpSplitscreenCarSelect.lua", "_ready_class_icon"), "_ready_text"), UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[_ARG_0_].pad])
end
function SplitscreenGarage_CreateColours(_ARG_0_)
  GUI.colour_ids[_ARG_0_] = {}
  for _FORV_8_, _FORV_9_ in ipairs(GUI.car_colours) do
    SCUI.elements[SCUI.name_to_index._colour_square].pos.x = SCUI.elements[SCUI.name_to_index._colour_square].pos.x + (SCUI.elements[SCUI.name_to_index._colour_square].pos.x - SCUI.elements[SCUI.name_to_index._colour_square].size.x * 0.9 * (#GUI.car_colours - 1) / 2)
    SCUI.elements[SCUI.name_to_index._colour_square].colour_style = "!" .. _FORV_9_.colour
    UIButtons.SetParent(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._colour_square]), SCUI.name_to_id["colour_dummy_" .. Splitscreen_GetDummyName(_ARG_0_)], UIEnums.Justify.MiddleCentre)
    SCUI.elements[SCUI.name_to_index._colour_square].pos.x = SCUI.elements[SCUI.name_to_index._colour_square].pos.x
    GUI.colour_ids[_ARG_0_][_FORV_8_] = UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._colour_square])
  end
  UIButtons.SetParent(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._colour_square_background]), SCUI.name_to_id["colour_dummy_" .. Splitscreen_GetDummyName(_ARG_0_)], UIEnums.Justify.MiddleCentre)
  GUI.colour_ids[_ARG_0_].background_id = UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._colour_square_background])
  GUI.colour_ids[_ARG_0_].size_x = SCUI.elements[SCUI.name_to_index._colour_square].size.x
end
function SplitscreenGarage_CheckForChange()
  for _FORV_3_, _FORV_4_ in ipairs(UIGlobals.Splitscreen.players) do
    if GUI.current_car_selection[_FORV_3_] ~= UIButtons.GetSelection(GUI.car_node_list_ids[_FORV_3_]) then
      GUI.current_car_selection[_FORV_3_] = UIButtons.GetSelection(GUI.car_node_list_ids[_FORV_3_])
      SplitscreenGarage_UpdateStats(_FORV_3_)
    end
  end
end
function SplitscreenGarage_UpdateStats(_ARG_0_)
  if GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].man_texture_square == true then
    UIButtons.SetActive(GUI.stat_ids[_ARG_0_].man_square, true)
    UIButtons.SetActive(GUI.stat_ids[_ARG_0_].man_rect, false)
    UIButtons.ChangeTexture({
      filename = GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].man_texture
    }, 0, GUI.stat_ids[_ARG_0_].man_square)
    UIButtons.SetActive(GUI.ready_ids[_ARG_0_].man_square, true)
    UIButtons.SetActive(GUI.ready_ids[_ARG_0_].man_rect, false)
    UIButtons.ChangeTexture({
      filename = GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].man_texture
    }, 0, GUI.ready_ids[_ARG_0_].man_square)
  else
    UIButtons.SetActive(GUI.stat_ids[_ARG_0_].man_square, false)
    UIButtons.SetActive(GUI.stat_ids[_ARG_0_].man_rect, true)
    UIButtons.ChangeTexture({
      filename = GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].man_texture
    }, 0, GUI.stat_ids[_ARG_0_].man_rect)
    UIButtons.SetActive(GUI.ready_ids[_ARG_0_].man_square, false)
    UIButtons.SetActive(GUI.ready_ids[_ARG_0_].man_rect, true)
    UIButtons.ChangeTexture({
      filename = GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].man_texture
    }, 0, GUI.ready_ids[_ARG_0_].man_rect)
  end
  UIShape.ChangeObjectName(GUI.stat_ids[_ARG_0_].class_icon, GUI.class_icon_names[GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].class])
  UIShape.ChangeObjectName(GUI.ready_ids[_ARG_0_].class_icon, GUI.class_icon_names[GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].class])
  UIShape.ChangeSceneName(GUI.ready_ids[_ARG_0_].car_icon, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].sheet)
  UIShape.ChangeObjectName(GUI.ready_ids[_ARG_0_].car_icon, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].icon)
  UIButtons.ChangeText(GUI.stat_ids[_ARG_0_].car_name, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].name)
  UIButtons.ChangeText(GUI.ready_ids[_ARG_0_].car_name, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].name)
  UIButtons.ChangeText(GUI.stat_ids[_ARG_0_].style_text, GUI.style_names[GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].style])
  Amax.SetChickletsValue(GUI.stat_ids[_ARG_0_].acceleration, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].acceleration)
  Amax.SetChickletsValue(GUI.stat_ids[_ARG_0_].speed, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].speed)
  Amax.SetChickletsValue(GUI.stat_ids[_ARG_0_].off_road, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].stability)
  Amax.SetChickletsValue(GUI.stat_ids[_ARG_0_].difficulty, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].difficulty)
  Amax.SetChickletsValue(GUI.stat_ids[_ARG_0_].health, GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].strength)
  if GUI.car_info[GUI.cars[UIButtons.GetSelection(GUI.car_node_list_ids[_ARG_0_])]].respray == true then
    UIButtons.TimeLineActive("respray_" .. Splitscreen_GetDummyName(_ARG_0_), true)
    SplitscreenGarage_UpdateColour(_ARG_0_)
  else
    UIButtons.TimeLineActive("respray_" .. Splitscreen_GetDummyName(_ARG_0_), false)
    SplitscreenGarage_UpdateColour(_ARG_0_, -1)
  end
end
function SplitscreenGarage_UpdateColourPicker(_ARG_0_, _ARG_1_)
  if _ARG_0_ == nil then
    for _FORV_5_, _FORV_6_ in ipairs(UIGlobals.Splitscreen.players) do
      SplitscreenGarage_UpdateColourPicker(_FORV_5_)
      SplitscreenGarage_UpdateColour(_FORV_5_)
    end
    return
  end
  if _ARG_1_ == nil then
    _ARG_1_ = GUI.current_colour_selection[_ARG_0_]
  end
  if _ARG_1_ == nil then
    _ARG_1_ = _ARG_0_
  end
  if _ARG_1_ ~= -1 then
    _ARG_1_ = Clamp(_ARG_1_, 1, #GUI.car_colours)
  end
  GUI.current_colour_selection[_ARG_0_] = _ARG_1_
  if _ARG_1_ == -1 then
    _ARG_1_ = 1
  end
  UIButtons.ChangePosition(GUI.colour_ids[_ARG_0_].background_id, -(GUI.colour_ids[_ARG_0_].size_x * 0.9 * (#GUI.car_colours - 1)) / 2 + GUI.colour_ids[_ARG_0_].size_x * 0.9 * (_ARG_1_ - 1), UIButtons.GetPosition(GUI.colour_ids[_ARG_0_].background_id))
end
function SplitscreenGarage_UpdateColour(_ARG_0_, _ARG_1_)
  if _ARG_1_ == -1 then
    UIButtons.SetActive(SCUI.name_to_id["colour_frame_" .. Splitscreen_GetDummyName(_ARG_0_)], false, true)
    UIButtons.SetActive(GUI.ready_ids[_ARG_0_].colour_frame, false, true)
  else
    UIButtons.SetActive(SCUI.name_to_id["colour_frame_" .. Splitscreen_GetDummyName(_ARG_0_)], true, true)
    UIButtons.ChangeColour(SCUI.name_to_id["colour_" .. Splitscreen_GetDummyName(_ARG_0_)], "!" .. GUI.car_colours[_ARG_1_].colour)
    UIButtons.SetActive(GUI.ready_ids[_ARG_0_].colour_frame, true, true)
    UIButtons.ChangeColour(GUI.ready_ids[_ARG_0_].colour_fill, "!" .. GUI.car_colours[_ARG_1_].colour)
  end
end
function SplitscreenGarage_AllReady(_ARG_0_)
  if _ARG_0_ == nil then
    _ARG_0_ = false
  end
  for _FORV_4_, _FORV_5_ in ipairs(GUI.player_ready) do
    if _FORV_5_ == _ARG_0_ then
      return false
    end
  end
  return true
end
function SplitscreenGarage_CheckInfoLines()
  if SplitscreenGarage_AllReady() == true then
    SetupInfoLine(UIText.INFO_B_BACK)
  else
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
  end
end
function SplitscreenGarage_PushStencil(_ARG_0_, _ARG_1_)
  UIButtons.SetXtVar(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._stencil_write_on]), "render_state.stencil_state.ref", _ARG_1_)
  UIButtons.SetXtVar(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._stencil_read_on]), "render_state.stencil_state.ref", _ARG_1_)
  UIButtons.SetParent(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._stencil_write_on]), _ARG_0_, GUI.stencil_justify[_ARG_0_])
  UIButtons.SetParent(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index["_stencil_" .. Splitscreen_GetDummyName(_ARG_1_)]]), _ARG_0_, GUI.stencil_justify[_ARG_0_])
  UIButtons.SetParent(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._stencil_read_on]), _ARG_0_, GUI.stencil_justify[_ARG_0_])
end
function SplitscreenGarage_PopStencil(_ARG_0_, _ARG_1_)
  UIButtons.SetParent(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._stencil_read_off]), _ARG_0_, GUI.stencil_justify[_ARG_0_])
  UIButtons.SetXtVar(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._stencil_read_off]), "render_state.stencil_state.ref", _ARG_1_)
end
