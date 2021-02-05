GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    if UIButtons.AcceptingUserInput() == true then
      return false
    elseif UIScreen.IsPopupActive() == true then
      return false
    else
      return true
    end
  end,
  FriendId = 0,
  FriendString = "",
  frameCounter = 0
}
function Init()
  AddSCUI_Elements()
  GUI.FriendId = SCUI.name_to_id.Sdr_FriendName
  UIButtons.AddItem(GUI.FriendId, 0, UIText.MP_ACCOUNT_NAME_ENTER, false)
  StoreInfoLine()
  SetupMenuOptions()
end
function PostInit()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    print("retuuuurn")
    return
  end
  if _ARG_0_ == UIEnums.Message.Select or _ARG_0_ == UIEnums.Message.MenuNext or _ARG_0_ == UIEnums.Message.MouseClickInBox then
    print("mouse click or enter or space")
    print("accepting input")
    UIButtons.AcceptingUserInput(true)
  end
  if _ARG_0_ == UIEnums.Message.MenuBack then
    UIButtons.AcceptingUserInput(false)
    Amax.AddCursor(GUI.FriendId, 0, false)
    UIScreen.EndScreen()
  end
end
function FrameUpdate(_ARG_0_)
  if UIButtons.AcceptingUserInput() == true then
    if UIButtons.GetUserInputString(24, false) == nil then
      UIButtons.AcceptingUserInput(false)
      Amax.AddCursor(GUI.FriendId, 0, false)
      print("Attempting to add user: " .. GUI.FriendString)
      if GUI.FriendId ~= nil and GUI.FriendString ~= "" then
        Amax.AddNewFriend(GUI.FriendString)
      end
      UIScreen.EndScreen()
    else
      UIButtons.ClearItems(GUI.FriendId)
      GUI.FriendString = UIButtons.GetUserInputString(24, false)
      Amax.AddCursor(GUI.FriendId, 0, true)
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  RestoreInfoLine()
end
