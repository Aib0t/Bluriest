GUI = {
  finished = false,
  option = {
    username = 1,
    password = 2,
    login = 3,
    create = 4,
    skip = 5,
    max = 6
  }
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  UIGlobals.NetAccountActive = true
  UIScreen.BlockInputToContext(true)
  UIScreen.Suspend(UIEnums.Context.Main)
end
function PostInit()
  GUI.menu_id = SCUI.name_to_id.menu
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.username_node, GUI.option.username)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.password_node, GUI.option.password)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.login_node, GUI.option.login)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.create_node, GUI.option.create)
  UIButtons.AddListItem(GUI.menu_id, SCUI.name_to_id.skip_node, GUI.option.skip)
  GUI.username_id = UIButtons.FindChildByName(SCUI.name_to_id.username_node, "textbox")
  GUI.password_id = UIButtons.FindChildByName(SCUI.name_to_id.password_node, "textbox")
  NetLogin_ReadDetails()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if UIButtons.GetSelection(GUI.menu_id) == GUI.option.login then
      NetLogin_Login()
    elseif UIButtons.GetSelection(GUI.menu_id) == GUI.option.create then
      NetLogin_Create()
    elseif UIButtons.GetSelection(GUI.menu_id) == GUI.option.skip then
      NetLogin_Skip()
    end
  elseif _ARG_0_ == UIEnums.Message.Tab and _ARG_2_ == true then
    if UIButtons.GetSelection(GUI.menu_id) < GUI.option.max then
      UIButtons.SetSelection(GUI.menu_id, UIButtons.GetSelection(GUI.menu_id) + 1)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    NetLogin_Skip()
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
function NetLogin_ReadDetails()
  if NetServices.ReadOnlineAccountDetails(GUI.username_id, GUI.password_id) == true then
    UIButtons.SetSelection(GUI.menu_id, GUI.option.login)
  else
    UIButtons.SetSelection(GUI.menu_id, GUI.option.create)
  end
end
function NetLogin_Login()
  if NetServices.StoreOnlineAccountDetails(GUI.username_id, GUI.password_id) == true then
    net_StartServiceConnection(true, UIGlobals.server_connection.callback)
  else
    SetupCustomPopup(UIEnums.CustomPopups.RegisterAccountUsernamePasswordRequired)
  end
end
function NetLogin_Create()
  GoScreen("Account\\NetRegister.lua")
end
function NetLogin_Skip()
  if IsFunction(UIGlobals.server_connection.callback) == true then
    UIGlobals.server_connection.callback(false)
  end
  SetupCustomPopup(UIEnums.CustomPopups.NetAccountNotSignedIn)
  EndScreen(UIEnums.Context.Subscreen2)
end
