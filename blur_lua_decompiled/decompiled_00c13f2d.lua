GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  GUI.MessageListId = SCUI.name_to_id.OptionsList
  GUI.GammaId = SCUI.name_to_id.Sdr_Gamma
  for _FORV_3_ = 1, 10 do
    UIButtons.AddItem(GUI.GammaId, _FORV_3_, _FORV_3_, false)
  end
  _FOR_.SetSelection(GUI.GammaId, UIGlobals.OptionsTable.gamma)
  GUI.gamma = UIGlobals.OptionsTable.gamma
  GUI.initialGamma = GUI.gamma
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_CONFIRM, UIText.INFO_B_CANCEL, UIText.INFO_RESET_TO_DEFAULT)
end
function PostInit()
  if UIGlobals.IsIngame == true then
    UIButtons.TimeLineActive("DarkenScreen", false)
    UIButtons.SetActive(SCUI.name_to_id.Gfx_Image, false)
    UIButtons.ChangePanel(SCUI.name_to_id.Dummy, 1, true)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    PlaySfxNext()
    if UIGlobals.OptionsTable.gamma ~= UIButtons.GetSelection(GUI.GammaId) then
      Amax.GameDataLogBrightnessChanged(UIGlobals.OptionsTable.gamma, (UIButtons.GetSelection(GUI.GammaId)))
      UIGlobals.OptionsTable.gamma = UIButtons.GetSelection(GUI.GammaId)
      UIGlobals.SaveOptions = true
    end
    GoScreen("Shared\\Options_Graphics.lua")
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    PlaySfxBack()
    if GUI.initialGamma ~= UIButtons.GetSelection(GUI.GammaId) then
      Amax.GammaCorrection(GUI.initialGamma)
    end
    GoScreen("Shared\\Options_Graphics.lua")
  end
  if _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true then
    PlaySfxError()
    Amax.GammaCorrection(5)
    UIButtons.SetSelection(GUI.GammaId, 5)
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.gamma ~= UIButtons.GetSelection(GUI.GammaId) then
    GUI.gamma = UIButtons.GetSelection(GUI.GammaId)
    Amax.GammaCorrection((UIButtons.GetSelection(GUI.GammaId)))
  end
end
function Render()
end
function EnterEnd()
  RestoreInfoLine()
  if UIGlobals.IsIngame == true then
    UIButtons.TimeLineActive("DarkenScreen", true)
  end
end
function EndLoop(_ARG_0_)
end
function End()
  Amax.GammaCorrection(UIGlobals.OptionsTable.gamma)
end
