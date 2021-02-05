GUI = {
  finished = false,
  option = {
    username = 1,
    password = 2,
    password_check = 3,
    serial_key = 4,
    create = 5,
    back = 6,
    max = 7
  }
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  GUI.menu_id = SCUI.name_to_id.menu
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.username_node, GUI.option.username)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.password_node, GUI.option.password)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.password_check_node, GUI.option.password_check)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.serial_key_node, GUI.option.serial_key)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.create_node, GUI.option.create)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.back_node, GUI.option.back)
  UIGlobals.NetAccountActive = true
  UIScreen.BlockInputToContext(true)
  UIScreen.Suspend(UIEnums.Context.Main)
end
function PostInit()
  GUI.username_id = UIButtons.FindChildByName(SCUI.name_to_id.username_node, "textbox")
  GUI.password_id = UIButtons.FindChildByName(SCUI.name_to_id.password_node, "textbox")
  GUI.password_check_id = UIButtons.FindChildByName(SCUI.name_to_id.password_check_node, "textbox")
  GUI.license_id = UIButtons.FindChildByName(SCUI.name_to_id.serial_key_node, "textbox")
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if UIButtons.GetSelection(GUI.menu_id) == GUI.option.create then
      NetRegister_Create()
    elseif UIButtons.GetSelection(GUI.menu_id) == GUI.option.back then
      NetRegister_Back()
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    NetRegister_Back()
  elseif _ARG_0_ == UIEnums.Message.Tab and _ARG_2_ == true then
    if UIButtons.GetSelection(GUI.menu_id) < GUI.option.max then
      UIButtons.SetSelection(GUI.menu_id, UIButtons.GetSelection(GUI.menu_id) + 1)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.RegisterAccountSuccess then
    NetRegister_Back()
  end
end
function FrameUpdate(_ARG_0_)
end
function EndLoop(_ARG_0_)
end
function End()
  RestoreInfoLine()
  UIGlobals.NetAccountActive = false
  UIScreen.Resume(UIEnums.Context.Main)
end
function NetRegister_Create()
  if NetServices.CheckAccountDetails(GUI.username_id, GUI.password_id, GUI.password_check_id, GUI.license_id) == 0 then
    if NetServices.CreateAccount() == true then
      SetupCustomPopup(UIEnums.CustomPopups.RegisterAccount)
    else
      SetupCustomPopup(UIEnums.CustomPopups.RegisterAccountError)
    end
  elseif NetServices.CheckAccountDetails(GUI.username_id, GUI.password_id, GUI.password_check_id, GUI.license_id) == 1 then
    SetupCustomPopup(UIEnums.CustomPopups.RegisterAccountUsernamePasswordRequired)
  elseif NetServices.CheckAccountDetails(GUI.username_id, GUI.password_id, GUI.password_check_id, GUI.license_id) == 2 then
    SetupCustomPopup(UIEnums.CustomPopups.RegisterAccountPasswordsMatch)
  end
end
function NetRegister_Back()
  GoScreen("Account\\NetLogin.lua")
end
