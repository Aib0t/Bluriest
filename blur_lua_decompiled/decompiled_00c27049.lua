GUI = {
  finished = false,
  carousel_branch = "DLC",
  CanExit = function(_ARG_0_)
    if UIScreen.IsPopupActive() == true then
      return false
    else
      return true
    end
  end,
  finished = false,
  option = {
    code = 1,
    submit = 2,
    max = 3
  },
  Submit = function()
    if Amax.IsCodeValid(GUI.code_id) == true then
      if Amax.SetDLCUnlocked(1) == 0 then
        StartAsyncSave()
        UIButtons.SetActive(GUI.viper_popup_id, true, true)
        GUI.viper_popup_active = true
        UIButtons.SetActive(GUI.input_root_id, false, true)
      elseif Amax.SetDLCUnlocked(1) == 1 then
        SetupCustomPopup(UIEnums.CustomPopups.FailedToUnlockDLCFailToLoad)
      else
        SetupCustomPopup(UIEnums.CustomPopups.FailedToUnlockDLCBadProfile)
      end
    else
      SetupCustomPopup(UIEnums.CustomPopups.InvalidUnlockCode)
    end
  end
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_2", UIGlobals.CameraLerpTime, 0)
  CarouselApp_SetScreenTimers()
  Amax.LoadUnlockCodes()
  StoreInfoLine()
  SetupMenuOptions()
end
function PostInit()
  GUI.menu_id = SCUI.name_to_id.menu
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.code_node, GUI.option.code)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.submit_node, GUI.option.submit)
  GUI.code_id = UIButtons.FindChildByName(SCUI.name_to_id.code_node, "textbox")
  GUI.input_root_id = SCUI.name_to_id.code_input_frame
  GUI.viper_popup_id = SCUI.name_to_id.viper_frame
  GUI.viper_popup_active = false
  UIButtons.SetActive(GUI.viper_popup_id, false, true)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.viper_popup_active == true then
    if (_ARG_0_ == UIEnums.Message.MenuNext or _ARG_0_ == UIEnums.Message.MenuBack) and _ARG_2_ == true then
      UIButtons.SetActive(GUI.viper_popup_id, false, true)
      GUI.viper_popup_active = false
      UIButtons.SetActive(GUI.input_root_id, true, true)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if UIButtons.GetSelection(GUI.menu_id) == GUI.option.submit then
      GUI.Submit()
    end
  elseif _ARG_0_ == UIEnums.Message.Tab and _ARG_2_ == true and UIButtons.GetSelection(GUI.menu_id) < GUI.option.max then
    UIButtons.SetSelection(GUI.menu_id, UIButtons.GetSelection(GUI.menu_id) + 1)
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
