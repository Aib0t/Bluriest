GUI = {
  finished = false,
  carousel_branch = "Options",
  OutputSelection = -1,
  GetSelections = function()
    UIGlobals.OptionsTable.resolution = UIButtons.GetSelection(GUI.ResolutionId)
    UIGlobals.OptionsTable.fullscreen = UIButtons.GetSelection(GUI.FullScreenId)
    UIGlobals.OptionsTable.aa = UIButtons.GetSelection(GUI.AAId)
    UIGlobals.OptionsTable.vsync = UIButtons.GetSelection(GUI.VSyncId)
    UIGlobals.OptionsTable.graphics_quality = UIButtons.GetSelection(GUI.GraphicsQualityId)
  end,
  CanExit = function(_ARG_0_)
    return false
  end,
  OptionPresets = {},
  PrevPreset = 0
}
function Init()
  AddSCUI_Elements()
  GUI.MessageListId = SCUI.name_to_id.OptionsList
  GUI.GraphicsQualityId = SCUI.name_to_id.SDR_GraphicsQuality
  GUI.ResolutionId = SCUI.name_to_id.SDR_Resolution
  GUI.FullScreenId = SCUI.name_to_id.SDR_FullScreen
  GUI.AAId = SCUI.name_to_id.SDR_AA
  GUI.VSyncId = SCUI.name_to_id.SDR_VSync
  for _FORV_3_ = 1, 4 do
    UIButtons.AddItem(GUI.GraphicsQualityId, _FORV_3_, _FORV_3_, false)
  end
  _FOR_.AddItem(GUI.FullScreenId, 0, UIText.CMN_OFF, false)
  UIButtons.AddItem(GUI.FullScreenId, 1, UIText.CMN_ON, false)
  UIButtons.AddItem(GUI.VSyncId, 0, UIText.CMN_OFF, false)
  UIButtons.AddItem(GUI.VSyncId, 1, UIText.CMN_ON, false)
  for _FORV_4_ = 2, Amax.GraphicResolutionCount() do
    UIButtons.AddItem(GUI.ResolutionId, _FORV_4_ - 1, "GAME_OPTION_RESOLUTION" .. _FORV_4_ - 1, true)
  end
  for _FORV_5_ = 1, _FOR_.GraphicAACount() do
    UIButtons.AddItem(GUI.AAId, _FORV_5_ - 1, "GAME_OPTION_AATYPE" .. _FORV_5_ - 1, true)
  end
  _FOR_.SetSelection(GUI.GraphicsQualityId, UIGlobals.OptionsTable.graphics_quality)
  UIButtons.SetSelection(GUI.ResolutionId, UIGlobals.OptionsTable.resolution)
  UIButtons.SetSelection(GUI.FullScreenId, UIGlobals.OptionsTable.fullscreen)
  UIButtons.SetSelection(GUI.VSyncId, UIGlobals.OptionsTable.vsync)
  UIButtons.SetSelection(GUI.AAId, UIGlobals.OptionsTable.aa)
  GUI.PrevPreset = UIButtons.GetSelectionIndex(GUI.GraphicsQualityId)
  if UIGlobals.SaveGraphicOptions == true then
    OptionsGraphics_BackupSettings()
  end
  UIGlobals.SaveGraphicOptions = nil
  StoreInfoLine()
  UpdateInfoLine()
end
function PostInit()
  UIButtons.NodeListScan(GUI.MessageListId)
  if IsNumber(GetScreenOtions().selection) == true then
    UIButtons.SetSelectionByIndex(GUI.MessageListId, GetScreenOtions().selection)
  else
    UIButtons.SetSelectionByIndex(GUI.MessageListId, 0)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  mouse_overide = false
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and _ARG_3_ == UIScreen.Context() then
    UIButtons.SetCurrentItemByID(GUI.MessageListId, (UIButtons.GetParent(_ARG_2_)))
    mouse_overide = true
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    PlaySfxBack()
    OptionsGraphics_RevertSettings()
    GoScreen("Shared\\Options.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or mouse_overide then
    PlaySfxNext()
    print("selected " .. UIButtons.GetSelection(GUI.MessageListId))
    if UIButtons.GetSelection(GUI.MessageListId) == 4 then
      GoScreen("Shared\\Options_ImageAdjust.lua")
    elseif UIButtons.GetSelection(GUI.MessageListId) == 5 then
      GUI.do_update_options = true
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.PrevPreset ~= UIButtons.GetSelectionIndex(GUI.GraphicsQualityId) then
    GUI.PrevPreset = UIButtons.GetSelectionIndex(GUI.GraphicsQualityId)
  end
  if GUI.do_update_options == true then
    GUI.GetSelections()
    Amax.UpdateGraphicsOptions(UIGlobals.OptionsTable)
    ChangeResolution(Amax.GetScreenResolution(UIGlobals.OptionsTable.resolution))
    GUI.do_update_options = false
    SetupCustomPopup(UIEnums.CustomPopups.ConfirmVideoSettings)
  end
  UpdateInfoLine()
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  GetScreenOtions().selection = UIButtons.GetSelectionIndex(GUI.MessageListId)
  GUI.GetSelections()
  RestoreInfoLine()
end
function UpdateInfoLine()
  if UIButtons.GetSelection(GUI.MessageListId) ~= GUI.selected_option then
    GUI.selected_option = UIButtons.GetSelection(GUI.MessageListId)
    if UIButtons.GetSelection(GUI.MessageListId) == 4 or UIButtons.GetSelection(GUI.MessageListId) == 5 then
      SetupInfoLine(UIText.INFO_B_BACK, UIText.INFO_A_SELECT)
    else
      SetupInfoLine(UIText.INFO_B_BACK)
    end
  end
end
function OptionsGraphics_BackupSettings()
  UIGlobals.RevertOptionsTable = {}
  UIGlobals.RevertOptionsTable.graphics_quality = UIGlobals.OptionsTable.graphics_quality
  UIGlobals.RevertOptionsTable.resolution = UIGlobals.OptionsTable.resolution
  UIGlobals.RevertOptionsTable.fullscreen = UIGlobals.OptionsTable.fullscreen
  UIGlobals.RevertOptionsTable.vsync = UIGlobals.OptionsTable.vsync
  UIGlobals.RevertOptionsTable.aa = UIGlobals.OptionsTable.aa
end
function OptionsGraphics_RevertSettings()
  UIButtons.SetSelection(ContextTable[UIEnums.Context.CarouselApp].GUI.GraphicsQualityId, UIGlobals.RevertOptionsTable.graphics_quality)
  UIButtons.SetSelection(ContextTable[UIEnums.Context.CarouselApp].GUI.ResolutionId, UIGlobals.RevertOptionsTable.resolution)
  UIButtons.SetSelection(ContextTable[UIEnums.Context.CarouselApp].GUI.FullScreenId, UIGlobals.RevertOptionsTable.fullscreen)
  UIButtons.SetSelection(ContextTable[UIEnums.Context.CarouselApp].GUI.VSyncId, UIGlobals.RevertOptionsTable.vsync)
  UIButtons.SetSelection(ContextTable[UIEnums.Context.CarouselApp].GUI.AAId, UIGlobals.RevertOptionsTable.aa)
  UIGlobals.OptionsTable.graphics_quality = UIGlobals.RevertOptionsTable.graphics_quality
  UIGlobals.OptionsTable.resolution = UIGlobals.RevertOptionsTable.resolution
  UIGlobals.OptionsTable.fullscreen = UIGlobals.RevertOptionsTable.fullscreen
  UIGlobals.OptionsTable.vsync = UIGlobals.RevertOptionsTable.vsync
  UIGlobals.OptionsTable.aa = UIGlobals.RevertOptionsTable.aa
  Amax.UpdateGraphicsOptions(UIGlobals.RevertOptionsTable)
  ChangeResolution(Amax.GetScreenResolution(UIGlobals.RevertOptionsTable.resolution))
end
