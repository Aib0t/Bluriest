PopupGUI = {
  finished = false,
  error = false,
  state = nil,
  task = nil,
  cancel = false,
  next_screen = nil,
  go_subscreen = nil,
  go_launch_screen = nil,
  next_button_id = -1,
  back_button_id = -1,
  title_button_id = -1,
  message_button_id = -1,
  timer = 0,
  join_started = false,
  spawn_next = nil,
  timeout = -1,
  timeout_timer = 0,
  profile_download_failed = false
}
function PopupInit()
  if UIGlobals.PopupSpawned == false then
    InfoLineLock()
    StoreInfoLine_F()
    SetupInfoLine_F()
  end
  UIGlobals.PopupSpawned = false
  PopupGUI.send_next = false
  PopupGUI.send_back = false
  PopupGUI.send_arg1 = nil
  PopupGUI.send_arg2 = CustomPopup.CurrentType
  PopupGUI.send_arg3 = nil
  if CustomPopup.CurrentData == nil then
    PopupGUI.error = true
    print("Current data == nil : That's not right at all")
    return
  end
  UIScreen.SetPopupTimers(UIGlobals.screen_time.popup_start, UIGlobals.screen_time.popup_end)
  SCUI_Popup.name_to_index = {}
  for _FORV_4_, _FORV_5_ in pairs(SCUI_Popup.elements) do
    if IsString(_FORV_5_.name) then
      SCUI_Popup.name_to_index[_FORV_5_.name] = _FORV_4_
    end
  end
  if CustomPopup.CurrentData.init_CB ~= nil then
    CustomPopup.CurrentData.init_CB()
  end
  if IsNumber(CustomPopup.CurrentData.title_text_ID) == true then
    SCUI_Popup.elements[SCUI_Popup.name_to_index.title].text_id = CustomPopup.CurrentData.title_text_ID
    SCUI_Popup.elements[SCUI_Popup.name_to_index.title].text_string = nil
  elseif IsString(CustomPopup.CurrentData.title_text_ID) == true then
    SCUI_Popup.elements[SCUI_Popup.name_to_index.title].text_string, SCUI_Popup.elements[SCUI_Popup.name_to_index.title].text_id = CustomPopup.CurrentData.title_text_ID, nil
  end
  if IsNumber(CustomPopup.CurrentData.message_text_ID) == true then
    SCUI_Popup.elements[SCUI_Popup.name_to_index.message].text_id = CustomPopup.CurrentData.message_text_ID
    SCUI_Popup.elements[SCUI_Popup.name_to_index.message].text_string = nil
  elseif IsString(CustomPopup.CurrentData.message_text_ID) == true then
    SCUI_Popup.elements[SCUI_Popup.name_to_index.message].text_string, SCUI_Popup.elements[SCUI_Popup.name_to_index.message].text_id = CustomPopup.CurrentData.message_text_ID, nil
  end
  if CustomPopup.CurrentData.options ~= nil then
    for _FORV_12_, _FORV_13_ in ipairs(CustomPopup.CurrentData.options) do
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("TheCustomPopup.lua", "menu_node"), "option_name"), _FORV_13_.name)
      if _FORV_13_.locked ~= nil then
        UIButtons.AddListItem(SCUI_Popup.name_to_id.options, UIButtons.CloneXtGadgetByName("TheCustomPopup.lua", "menu_node"), _FORV_13_.value, _FORV_13_.locked)
        if _FORV_13_.locked == true then
          UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("TheCustomPopup.lua", "menu_node"), "option_name"), "Dark_White")
        end
      else
        UIButtons.AddListItem(SCUI_Popup.name_to_id.options, UIButtons.CloneXtGadgetByName("TheCustomPopup.lua", "menu_node"), _FORV_13_.value)
      end
    end
  end
  if IsMultiplayerMode() == true then
    SCUI_Popup.elements[SCUI_Popup.name_to_index.icon].object_name = "groups"
  else
    SCUI_Popup.elements[SCUI_Popup.name_to_index.icon].object_name = "bio"
  end
  if IsTable(CustomPopup.CurrentData.pos) == true then
    SCUI_Popup.elements[SCUI_Popup.name_to_index.box_frame].pos = CustomPopup.CurrentData.pos
  end
  if UIGlobals.CurrentLanguage == UIEnums.Language.English == false then
  end
  if IsNumber(CustomPopup.CurrentData.next_text_ID) then
    {
      SCUI_Popup.elements[SCUI_Popup.name_to_index.next],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.back],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2],
      [3] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1_o],
      [4] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2_o]
    }[1].text_id = CustomPopup.CurrentData.next_text_ID
  end
  if IsNumber(CustomPopup.CurrentData.back_text_ID) then
    {
      SCUI_Popup.elements[SCUI_Popup.name_to_index.next],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.back],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2],
      [3] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1_o],
      [4] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2_o]
    }[1 + 1].text_id = CustomPopup.CurrentData.back_text_ID
  end
  if IsNumber(CustomPopup.CurrentData.x_text_ID) then
    {
      SCUI_Popup.elements[SCUI_Popup.name_to_index.next],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.back],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2],
      [3] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1_o],
      [4] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2_o]
    }[1 + 1 + 1].text_id = CustomPopup.CurrentData.x_text_ID
  end
  if IsNumber(CustomPopup.CurrentData.y_text_ID) then
    {
      SCUI_Popup.elements[SCUI_Popup.name_to_index.next],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.back],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2],
      [3] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1_o],
      [4] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2_o]
    }[1 + 1 + 1 + 1].text_id = CustomPopup.CurrentData.y_text_ID
  end
  for _FORV_22_ = 1 + 1 + 1 + 1 + 1, #{
    SCUI_Popup.elements[SCUI_Popup.name_to_index.next],
    SCUI_Popup.elements[SCUI_Popup.name_to_index.back],
    SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1],
    SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2],
    [3] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1_o],
    [4] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2_o]
  } do
    {
      SCUI_Popup.elements[SCUI_Popup.name_to_index.next],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.back],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1],
      SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2],
      [3] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_1_o],
      [4] = SCUI_Popup.elements[SCUI_Popup.name_to_index.info_2_o]
    }[_FORV_22_].pos.x = 0
  end
  AddSCUI_Elements(SCUI_Popup)
  UIButtons.SetActive(SCUI_Popup.name_to_id.menu_node, false)
  PopupGUI.next_button_id = SCUI_Popup.name_to_id.next
  PopupGUI.back_button_id = SCUI_Popup.name_to_id.back
  PopupGUI.title_button_id = SCUI_Popup.name_to_id.title
  PopupGUI.message_button_id = SCUI_Popup.name_to_id.message
  PopupGUI.timeout = -1
  PopupGUI.timeout_timer = 0
  print("popup clickable start ...")
  UIButtons.ChangeMouseClickable(PopupGUI.next_button_id, true, UIEnums.ControlMessageType.CtrlButton_A)
  UIButtons.ChangeMouseClickable(PopupGUI.back_button_id, true, UIEnums.CtrlButton_B)
  print("popup clickable end ...")
  if CustomPopup.CurrentData.timeout ~= nil then
    PopupGUI.timeout = CustomPopup.CurrentData.timeout
  end
  if CustomPopup.CurrentType == UIEnums.CustomPopups.Keyboard then
    UIButtons.SetActive(SCUI_Popup.name_to_id.frame_fill, true)
    UIButtons.SetActive(SCUI_Popup.name_to_id.frame, true)
    UIButtons.SetActive(SCUI_Popup.name_to_id.textbox, true)
    UIButtons.SetTextInputActive(SCUI_Popup.name_to_id.textbox, true)
  end
  if IsTable(CustomPopup.CurrentData.size) == true then
    UIButtons.ChangeSize(SCUI_Popup.name_to_id.box_frame, CustomPopup.CurrentData.size.x, CustomPopup.CurrentData.size.y)
    UIButtons.ChangeSize(SCUI_Popup.name_to_id.box_inner, CustomPopup.CurrentData.size.x, CustomPopup.CurrentData.size.y)
  else
    if CustomPopup.CurrentType == UIEnums.CustomPopups.Keyboard then
    end
    if 0 < UIButtons.GetStaticTextHeight(SCUI_Popup.name_to_id.message) then
      UIButtons.ChangePosition(SCUI_Popup.name_to_id.options, UIButtons.GetPosition(SCUI_Popup.name_to_id.options))
    else
    end
    UIButtons.ChangeSize(SCUI_Popup.name_to_id.box_frame, UIButtons.GetSize(SCUI_Popup.name_to_id.box_frame))
    UIButtons.ChangeSize(SCUI_Popup.name_to_id.box_inner, UIButtons.GetSize(SCUI_Popup.name_to_id.box_frame))
  end
  if CustomPopup.CurrentData.show_progress ~= nil then
    UIButtons.SetParent(AddLoadingSegs(-20, -20, 20, 20, UIEnums.Panel._2DAA), SCUI_Popup.name_to_id.box_frame, UIEnums.Justify.BottomRight)
    UIButtons.ChangeSize(SCUI_Popup.name_to_id.box_frame, UIButtons.GetSize(SCUI_Popup.name_to_id.box_frame) + 20, UIButtons.GetSize(SCUI_Popup.name_to_id.box_frame))
    UIButtons.ChangeSize(SCUI_Popup.name_to_id.box_inner, UIButtons.GetSize(SCUI_Popup.name_to_id.box_frame) + 20, UIButtons.GetSize(SCUI_Popup.name_to_id.box_frame))
  end
  if CustomPopup.CurrentData.save_icon == true then
    UIButtons.SetActive(SCUI_Popup.name_to_id.saving_icon, true)
  end
end
function PopupPostInit()
  UIButtons.TimeLineActive("Popup_Active", true, 0, true)
  if CustomPopup.CurrentType == UIEnums.CustomPopups.LobbyOptions and UIGlobals.MpLobbyMenuSelection ~= nil then
    UIButtons.SetSelection(SCUI_Popup.name_to_id.options, UIGlobals.MpLobbyMenuSelection)
  end
  if IsNumber(CustomPopup.CurrentData.default_option) == true then
    UIButtons.SetSelection(SCUI_Popup.name_to_id.options, CustomPopup.CurrentData.default_option)
  end
  if CustomPopup.CurrentData.silent == true then
    UIButtons.SetActive(SCUI_Popup.name_to_id.popup_rb, false)
  else
    UISystem.PlaySound(UIEnums.SoundEffect.GraphicTextBox)
  end
  if CustomPopup.CurrentData.darken == false then
    UIButtons.SetActive(SCUI_Popup.name_to_id.filter, false)
  end
end
function PopupStartLoop(_ARG_0_)
  return true
end
function PopupMessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if PopupGUI.error == true or PopupGUI.finished == true then
    return
  end
  if CustomPopup.CurrentData.message_CB ~= nil and CustomPopup.CurrentData.message_CB(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, arg4) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and _ARG_3_ == UIScreen.Context() then
    if UIButtons.GetType(_ARG_2_) == UIEnums.ButtonTypes.STATIC_SHAPE then
      print("something ok")
      if _ARG_2_ == SCUI_Popup.name_to_id.region_left_arrow then
        print("something good")
        UIButtons.SetSelection(UIButtons.FindChildByName(SCUI_Popup.name_to_id.options, "region_rule_slider"), UIButtons.GetSelection((UIButtons.FindChildByName(SCUI_Popup.name_to_id.options, "region_rule_slider"))) - 1)
      elseif _ARG_2_ == SCUI_Popup.name_to_id.region_right_arrow then
        print("something good")
        UIButtons.SetSelection(UIButtons.FindChildByName(SCUI_Popup.name_to_id.options, "region_rule_slider"), UIButtons.GetSelection((UIButtons.FindChildByName(SCUI_Popup.name_to_id.options, "region_rule_slider"))) + 1)
      elseif _ARG_2_ == SCUI_Popup.name_to_id.progress_left_arrow then
        print("something good")
        UIButtons.SetSelection(UIButtons.FindChildByName(SCUI_Popup.name_to_id.options, "race_in_progress"), UIButtons.GetSelection((UIButtons.FindChildByName(SCUI_Popup.name_to_id.options, "race_in_progress"))) - 1)
      elseif _ARG_2_ == SCUI_Popup.name_to_id.progress_right_arrow then
        print("something good")
        UIButtons.SetSelection(UIButtons.FindChildByName(SCUI_Popup.name_to_id.options, "race_in_progress"), UIButtons.GetSelection((UIButtons.FindChildByName(SCUI_Popup.name_to_id.options, "race_in_progress"))) + 1)
      end
    elseif UIButtons.GetType(_ARG_2_) == UIEnums.ButtonTypes.BOX and UIButtons.GetType((UIButtons.GetParent(_ARG_2_))) == UIEnums.ButtonTypes.NODE then
      UIButtons.SetCurrentItemByID(SCUI_Popup.name_to_id.options, (UIButtons.GetParent(_ARG_2_)))
      if UIButtons.GetSelection(SCUI_Popup.name_to_id.options) == UIButtons.GetSelection(SCUI_Popup.name_to_id.options) then
        _ARG_0_ = UIEnums.Message.MenuNext
      end
    end
  end
  if (_ARG_0_ == UIEnums.Message.MenuNext or getMouseButton(_ARG_0_, UIScreen.Context(), _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA) and CustomPopup.CurrentData.no_next ~= true then
    PlaySfxNext()
    if CustomPopup.CurrentType == UIEnums.CustomPopups.Keyboard then
    end
    if UIButtons.GetTextInputActive(SCUI_Popup.name_to_id.textbox) == false then
      PopupGUI.finished = true
      PopupGUI.cancel = true
      PopupGUI.next_screen = CustomPopup.CurrentData.next_screen
      PopupGUI.go_subscreen = CustomPopup.CurrentData.go_subscreen
      PopupGUI.go_launch_screen = CustomPopup.CurrentData.go_launch_screen
      if CustomPopup.CurrentData.next_CB ~= nil then
        CustomPopup.CurrentData.next_CB()
      end
      PopupGUI.send_next = true
      PopupGUI.send_back = false
      PopupGUI.send_arg1 = _ARG_1_
      PopupGUI.send_arg2 = CustomPopup.CurrentType
      PopupGUI.send_arg3 = nil
      if CustomPopup.CurrentData.options ~= nil then
        PopupGUI.send_arg3 = UIButtons.GetSelection(SCUI_Popup.name_to_id.options)
      end
    end
  elseif (_ARG_0_ == UIEnums.Message.MenuBack or getMouseButton(_ARG_0_, UIScreen.Context(), _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB) and CustomPopup.CurrentData.no_back ~= true then
    PlaySfxBack()
    PopupGUI.finished = true
    PopupGUI.cancel = true
    PopupGUI.next_screen = CustomPopup.CurrentData.prev_screen
    PopupGUI.go_subscreen = CustomPopup.CurrentData.go_subscreen
    PopupGUI.go_launch_screen = CustomPopup.CurrentData.go_launch_screen
    if CustomPopup.CurrentData.back_CB ~= nil then
      CustomPopup.CurrentData.back_CB()
    end
    PopupGUI.send_next = false
    PopupGUI.send_back = true
    PopupGUI.send_arg1 = _ARG_1_
    PopupGUI.send_arg2 = CustomPopup.CurrentType
    PopupGUI.send_arg3 = nil
  end
end
function PopupFrameUpdate(_ARG_0_)
  if PopupGUI.error == true then
    return
  end
  if CustomPopup.CurrentData.update_CB ~= nil then
    CustomPopup.CurrentData.update_CB(_ARG_0_)
  end
  if PopupGUI.timeout ~= -1 then
    PopupGUI.timeout_timer = PopupGUI.timeout_timer + _ARG_0_
    if PopupGUI.timeout_timer >= PopupGUI.timeout and CustomPopup.CurrentData.timeout_CB ~= nil then
      CustomPopup.CurrentData.timeout_CB()
      PopupGUI.timeout = -1
    end
  end
  if PopupGUI.cancel == true then
    UIScreen.CancelPopup()
    PopupGUI.cancel = false
  end
end
function PopupRender()
end
function PopupEnterEnd()
  if PopupGUI.spawn_next == nil then
    RestoreInfoLine_F()
    InfoLineUnlock(true)
    if UIGlobals.AsyncSave_FailMessageActive ~= true then
      UIButtons.TimeLineActive("Popup_Active", false)
    end
  else
    UIGlobals.PopupSpawned = true
  end
end
function PopupEndLoop(_ARG_0_)
  return true
end
function Popup_BoolToInt(_ARG_0_)
  return Select(_ARG_0_ == true, 1, 0)
end
function PopupEnd()
  if CustomPopup.CurrentData.end_CB ~= nil then
    CustomPopup.CurrentData.end_CB()
  end
  if PopupGUI.send_next == true then
    UIScreen.AddMessage(UIEnums.Message.PopupNext, PopupGUI.send_arg1, PopupGUI.send_arg2, PopupGUI.send_arg3)
  end
  if PopupGUI.send_back == true then
    UIScreen.AddMessage(UIEnums.Message.PopupBack, PopupGUI.send_arg1, PopupGUI.send_arg2, PopupGUI.send_arg3)
  end
  UIScreen.AddMessage(UIEnums.Message.PopupEnd, nil, PopupGUI.send_arg2, Popup_BoolToInt(PopupGUI.send_next), Popup_BoolToInt(PopupGUI.send_back))
  CustomPopup.CurrentData = nil
  if PopupGUI.go_launch_screen == true and IsNumber(PopupGUI.next_screen) == true then
    LaunchScreen(PopupGUI.next_screen)
    PopupGUI.next_screen = nil
    PopupGUI.go_subscreen = nil
    PopupGUI.go_launch_screen = nil
  elseif IsString(PopupGUI.next_screen) == true then
    print("Custom Popup Going to ", PopupGUI.next_screen)
    if PopupGUI.go_subscreen == true then
      GoSubScreen(PopupGUI.next_screen)
    else
      GoScreen(PopupGUI.next_screen, PopupGUI.context)
    end
    PopupGUI.next_screen = nil
    PopupGUI.go_subscreen = nil
    PopupGUI.go_launch_screen = nil
  elseif IsNumber(PopupGUI.spawn_next) == true then
    print("Spawn", PopupGUI.spawn_next)
    CustomPopup.CurrentType = PopupGUI.spawn_next
    CustomPopup.CurrentData = CustomPopup.Data[PopupGUI.spawn_next]
    if CustomPopup.CurrentData == nil then
      print("Error Spawned next custom popup : ", PopupGUI.spawn_next, "not found")
      CustomPopup.CurrentData = CustomPopup.Data[UIEnums.CustomPopups.Default]
    else
      UIScreen.AddPopup("TheCustomPopup.lua", true)
    end
  end
  SCUI_Popup = nil
  PopupInit = nil
  PopupPostInit = nil
  PopupStartLoop = nil
  PopupMessageUpdate = nil
  PopupFrameUpdate = nil
  PopupRender = nil
  PopupEnterEnd = nil
  PopupEndLoop = nil
  PopupEnd = nil
end
