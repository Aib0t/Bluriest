GUI = {
  finished = false,
  current_mode = UIEnums.PhotoMode.Camera,
  do_camera = false,
  do_effects = false,
  do_controls = false,
  do_photo = false,
  do_colour = false,
  can_save = false,
  inactive_slider_ids = {},
  colour_option_selected = false,
  values = {
    brightness = 0,
    contrast = 0,
    saturation = 0,
    hint_amount = 0,
    shutter_angle = 0,
    idepth = 0,
    aperture = 0
  },
  enable_render_in = -1
}
function Init()
  AddSCUI_Elements()
  Amax.SendMessage(UIEnums.GameFlowMessage.Pause)
  Amax.StartPhotoCam()
  LSP.SetInPhotoUI(false)
  GUI.current_mode = UIEnums.PhotoMode.Camera
  GUI.options = {
    {
      icon = "Brightness",
      text = UIText.HUD_PHOTO_EFFECT_BRIGHTNESS,
      num = 11,
      min = -0.25,
      max = 0.25,
      default = 5
    },
    {
      icon = "Contrast",
      text = UIText.HUD_PHOTO_EFFECT_CONTRAST,
      num = 11,
      min = -0.5,
      max = 0.5,
      default = 5
    },
    {
      icon = "Saturation",
      text = UIText.HUD_PHOTO_EFFECT_SATURATION,
      num = 11,
      min = -1,
      max = 1,
      default = 5
    },
    {
      icon = "Shutter Angle",
      text = UIText.HUD_PHOTO_EFFECT_SHUTTER_ANGLE,
      num = 11,
      min = 0,
      max = 10,
      default = 2
    },
    {
      icon = "Aperture",
      text = UIText.HUD_PHOTO_EFFECT_APERTURE,
      num = 11,
      min = 0,
      max = 1
    },
    {
      icon = "Hint_Amount",
      text = UIText.HUD_PHOTO_EFFECT_HINT_AMOUNT,
      num = 11,
      min = 0,
      max = 1
    },
    {
      icon = "Hint_Colour",
      text = UIText.HUD_PHOTO_EFFECT_HINT_COLOUR
    }
  }
  if UIEnums.CurrentPlatform == UIEnums.Platform.PS3 then
    UIShape.ChangeObjectName(SCUI.name_to_id.controls_icon, "ps3_controller_options")
  end
  SetupScreenTitle(UIText.HUD_PHOTO_TITLE, SCUI.name_to_id.screen_tile, "photo", nil, nil, nil, nil, nil, UIEnums.Panel._2DAA, true)
end
function PostInit()
  PhotoMode_UpdateMode()
  for _FORV_3_ = 1, #GUI.options do
    if _FORV_3_ ~= 1 then
    end
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), AddListNode(nil, _FORV_3_), UIEnums.Justify.MiddleCentre)
    UIButtons.AddListItem(SCUI.name_to_id.effects_node_list, (AddListNode(nil, _FORV_3_)))
    UIShape.ChangeObjectName(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), GUI.options[_FORV_3_].icon)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), "text"), GUI.options[_FORV_3_].text)
    if GUI.options[_FORV_3_].num ~= nil and GUI.options[_FORV_3_].num > 2 then
      for _FORV_12_ = 1, GUI.options[_FORV_3_].num do
        UIButtons.AddItem(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), "slider"), _FORV_12_ - 1, UIText.IDS_CMN_NOWT, false)
      end
    else
      GUI.inactive_slider_ids[#GUI.inactive_slider_ids + 1] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), "slider")
      UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), "text"), UIButtons.GetPosition((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), "text"))))
    end
    if GUI.options[_FORV_3_].default ~= nil then
      UIButtons.SetSelection(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), "slider"), GUI.options[_FORV_3_].default)
    end
    GUI.options[_FORV_3_].slider_id = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\PhotoMode.lua", "icon"), "slider")
  end
  _FOR_()
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
  if _ARG_0_ == UIEnums.Message.ButtonY then
    if GUI.current_mode == UIEnums.PhotoMode.Camera then
      PlaySfxNext()
      GUI.current_mode = UIEnums.PhotoMode.Effects
      PhotoMode_UpdateMode()
    elseif GUI.current_mode == UIEnums.PhotoMode.Viewing then
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuBack then
    if GUI.current_mode == UIEnums.PhotoMode.Camera then
      PlaySfxBack()
      GoScreen("InGame\\Paused.lua")
    elseif GUI.current_mode == UIEnums.PhotoMode.CamControls then
      PlaySfxBack()
      GUI.current_mode = UIEnums.PhotoMode.Camera
      PhotoMode_UpdateMode()
    elseif GUI.current_mode == UIEnums.PhotoMode.Effects then
      PlaySfxBack()
      GUI.current_mode = UIEnums.PhotoMode.Camera
      PhotoMode_UpdateMode()
    elseif GUI.current_mode == UIEnums.PhotoMode.EffectsColour then
      PlaySfxBack()
      GUI.current_mode = UIEnums.PhotoMode.Effects
      PhotoMode_UpdateMode()
    elseif GUI.current_mode == UIEnums.PhotoMode.Viewing then
      PlaySfxBack()
      GUI.current_mode = UIEnums.PhotoMode.Camera
      PhotoMode_UpdateMode()
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    if GUI.current_mode == UIEnums.PhotoMode.Camera then
      UISystem.PlaySound(UIEnums.SoundEffect.PhotoTaken)
      UISystem.Render(false)
      Amax.TakePhoto()
      GUI.enable_render_in = 1
      GUI.current_mode = UIEnums.PhotoMode.Viewing
      PhotoMode_UpdateMode()
    elseif GUI.current_mode == UIEnums.PhotoMode.Viewing then
      if GUI.can_save == true then
        PlaySfxNext()
        StartAsyncSavePhotos()
      end
    elseif GUI.current_mode == UIEnums.PhotoMode.Effects and GUI.colour_option_selected == true then
      PlaySfxNext()
      GUI.current_mode = UIEnums.PhotoMode.EffectsColour
      PhotoMode_UpdateMode()
    end
  end
end
function FrameUpdate(_ARG_0_)
  PhotoMode_UpdateMode()
  PhotoMode_UpdateFilters()
  if GUI.enable_render_in >= 0 then
    if GUI.enable_render_in == 0 then
      UISystem.Render(true)
    end
    GUI.enable_render_in = GUI.enable_render_in - 1
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  Amax.EndPhotoCam()
end
function PhotoMode_UpdateMode()
  GUI.do_camera = false
  GUI.do_effects = false
  GUI.do_photo = false
  GUI.do_colour = false
  GUI.do_controls = false
  if GUI.current_mode == UIEnums.PhotoMode.Camera then
    SetupInfoLine(UIText.INFO_PHOTO_TAKE_A, UIText.INFO_B_BACK, UIText.INFO_PHOTO_EFFECTS_Y)
    GUI.do_camera = true
  elseif GUI.current_mode == UIEnums.PhotoMode.CamControls then
    SetupBack()
    GUI.do_controls = true
  elseif GUI.current_mode == UIEnums.PhotoMode.Effects then
    if UIButtons.GetSelection(SCUI.name_to_id.effects_node_list) == 7 then
      GUI.colour_option_selected = true
      SetupMenuOptions()
    else
      GUI.colour_option_selected = false
      SetupBack()
    end
    GUI.do_effects = true
  elseif GUI.current_mode == UIEnums.PhotoMode.EffectsColour then
    SetupInfoLine(UIText.INFO_B_BACK)
    GUI.do_colour = true
    GUI.do_controls = false
  elseif GUI.current_mode == UIEnums.PhotoMode.Viewing then
    GUI.can_save = CanSave(Profile.GetPrimaryPad(), true) == true
    GUI.do_controls = false
    if GUI.can_save == true then
      SetupInfoLine(UIText.INFO_PHOTO_SAVE_A, UIText.INFO_B_BACK)
    else
      SetupBack()
    end
    GUI.do_photo = true
  end
  UIButtons.TimeLineActive("reticule_on", GUI.do_camera)
  UIButtons.TimeLineActive("controls_on", GUI.do_controls)
  UIButtons.TimeLineActive("effects_on", GUI.do_effects)
  UIButtons.TimeLineActive("colour_on", GUI.do_colour)
  if GUI.do_photo == true then
    UIButtons.TimeLineActive("reticule_on", false, 0.01)
    UIButtons.TimeLineActive("controls_on", false, 0.01)
  end
  UIButtons.SetActive(SCUI.name_to_id.photo_dummy, GUI.do_photo, true)
  UIButtons.SetSelected(SCUI.name_to_id.colour_picker, GUI.do_colour)
  UIButtons.SetSelected(SCUI.name_to_id.effects_node_list, GUI.do_effects)
  for _FORV_3_ = 1, #GUI.inactive_slider_ids do
    UIButtons.SetActive(GUI.inactive_slider_ids[_FORV_3_], false)
  end
  _FOR_.LockPhotoCamControls(GUI.do_effects or GUI.do_photo or GUI.do_colour)
end
function PhotoMode_GetValue(_ARG_0_)
  return GUI.options[_ARG_0_].min + (GUI.options[_ARG_0_].max - GUI.options[_ARG_0_].min) / (GUI.options[_ARG_0_].num - 1) * UIButtons.GetSelection(GUI.options[_ARG_0_].slider_id)
end
function PhotoMode_UpdateFilters()
  GUI.values.brightness = PhotoMode_GetValue(1)
  GUI.values.contrast = PhotoMode_GetValue(2)
  GUI.values.saturation = PhotoMode_GetValue(3)
  GUI.values.shutter_angle = PhotoMode_GetValue(4)
  GUI.values.max_shutter_angle = GUI.options[4].max
  GUI.values.aperture = PhotoMode_GetValue(5)
  GUI.values.hint_amount = PhotoMode_GetValue(6)
  Amax.SetPhotoFilters(GUI.values, SCUI.name_to_id.colour_picker)
end
function PhotoMode_OnAutoFocus()
  if UIButtons.GetSelection(ContextTable[UIEnums.Context.Main].GUI.options[5].slider_id) == 0 then
    UIButtons.SetSelection(ContextTable[UIEnums.Context.Main].GUI.options[5].slider_id, 3)
  end
end
