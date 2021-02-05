GUI = {
  finished = false,
  carousel_branch = "Options",
  GetSelections = function()
    UIGlobals.OptionsTable.texture_quality = UIButtons.GetSelection(GUI.TextureQualityId)
    UIGlobals.OptionsTable.shadow_quality = UIButtons.GetSelection(GUI.ShadowQualityId)
    UIGlobals.OptionsTable.effects_quality = UIButtons.GetSelection(GUI.EffectsQualityId)
    if UIGlobals.OptionsTable.shadow_quality == 0 then
      UIGlobals.OptionsTable.BlobShadowEnable = 0
    else
      UIGlobals.OptionsTable.BlobShadowEnable = 1
    end
    if UIGlobals.OptionsTable.effects_quality == 0 then
      UIGlobals.OptionsTable.GameReflectionEnable = 0
      UIGlobals.OptionsTable.CameraSplashEnable = 0
      UIGlobals.OptionsTable.TyreTracksEnable = 0
    elseif UIGlobals.OptionsTable.effects_quality == 1 then
      UIGlobals.OptionsTable.GameReflectionEnable = 0
      UIGlobals.OptionsTable.CameraSplashEnable = 1
      UIGlobals.OptionsTable.TyreTracksEnable = 0
    else
      UIGlobals.OptionsTable.GameReflectionEnable = 1
      UIGlobals.OptionsTable.CameraSplashEnable = 1
      UIGlobals.OptionsTable.TyreTracksEnable = 1
    end
  end,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  GUI.TextureQualityId = SCUI.name_to_id.SDR_TextureQuality
  GUI.ShadowQualityId = SCUI.name_to_id.SDR_ShadowQuality
  GUI.EffectsQualityId = SCUI.name_to_id.SDR_EffectsQuality
  GUI.MessageListId = SCUI.name_to_id.OptionsList
  UIButtons.AddItem(GUI.TextureQualityId, 0, UIText.CMN_OPT_GRAPHICS_LOW, false)
  UIButtons.AddItem(GUI.TextureQualityId, 1, UIText.CMN_OPT_GRAPHICS_MEDIUM, false)
  UIButtons.AddItem(GUI.TextureQualityId, 2, UIText.CMN_OPT_GRAPHICS_HIGH, false)
  UIButtons.AddItem(GUI.ShadowQualityId, 0, UIText.CMN_OPT_GRAPHICS_LOW, false)
  UIButtons.AddItem(GUI.ShadowQualityId, 1, UIText.CMN_OPT_GRAPHICS_MEDIUM, false)
  UIButtons.AddItem(GUI.ShadowQualityId, 2, UIText.CMN_OPT_GRAPHICS_HIGH, false)
  UIButtons.AddItem(GUI.EffectsQualityId, 0, UIText.CMN_OPT_GRAPHICS_LOW, false)
  UIButtons.AddItem(GUI.EffectsQualityId, 1, UIText.CMN_OPT_GRAPHICS_MEDIUM, false)
  UIButtons.AddItem(GUI.EffectsQualityId, 2, UIText.CMN_OPT_GRAPHICS_HIGH, false)
  UIButtons.AddItem(GUI.FullScreenId, 0, UIText.CMN_OFF, false)
  UIButtons.AddItem(GUI.FullScreenId, 1, UIText.CMN_ON, false)
  UIButtons.SetSelection(GUI.TextureQualityId, UIGlobals.OptionsTable.texture_quality)
  UIButtons.SetSelection(GUI.ShadowQualityId, UIGlobals.OptionsTable.shadow_quality)
  UIButtons.SetSelection(GUI.EffectsQualityId, UIGlobals.OptionsTable.effects_quality)
  StoreInfoLine()
  SetupMenuOptions()
end
function PostInit()
  UIButtons.NodeListScan(GUI.MessageListId)
  if IsNumber(GetScreenOtions().selection) == true then
    UIButtons.SetSelectionByIndex(GUI.MessageListId, GetScreenOtions().selection)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    PlaySfxBack()
    GUI.GetSelections()
    GoScreen("Shared\\Options_Graphics.lua")
  end
end
function FrameUpdate(_ARG_0_)
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  RestoreInfoLine()
end
