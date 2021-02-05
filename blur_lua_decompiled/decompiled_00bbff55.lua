GUI = {
  finished = false,
  help_text_id = -1,
  help_text = {
    UIText.FDE_TITLE_HELP,
    UIText.FDE_MESSAGE_HELP,
    UIText.FDE_EXTRA_CHALLENGE_HELP,
    UIText.FDE_SEND_HELP
  },
  fd_node_list_id = -1,
  option_text_ids = {},
  current_option_selection = -1,
  textbox_id = -1
}
function Init()
  AddSCUI_Elements()
  SetupInfoLine()
  GUI.camera_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Cam_Carousel")
  UIButtons.SetParent(GUI.camera_id, SCUI.name_to_id.CameraDolly, UIEnums.Justify.MiddleCentre)
  GUI.block_input = false
  GUI.textbox_id = SCUI.name_to_id.textbox
end
function PostInit()
  SetupScreenTitle(UIText.FDE_FRIEND_DEMAND, SCUI.name_to_id.screen, "message", "common_icons", 1, UIEnums.Justify.TopCentre, true, nil, UIEnums.Panel._3DAA_LIGHT, nil, UIEnums.Justify.TopCentre)
  GUI.help_text_id, GUI.bottom_bar_id = SetupBottomHelpBar(nil, nil, 1, true)
  FriendDemand.Create()
  Fd_CreatePanel(SCUI.name_to_id.screen, 4)
  Fd_UpdatePanel()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
    if _ARG_0_ == UIEnums.Message.KeyboardFinished then
      if GUI.current_option_selection == 1 then
        FriendDemand.StoreName(GUI.textbox_id)
        UIButtons.ChangeText(GUI.option_text_ids[GUI.current_option_selection], "GAME_FRIEND_DEMAND_NAME")
      elseif GUI.current_option_selection == 2 then
        FriendDemand.StoreDescription(GUI.textbox_id)
        UIButtons.ChangeText(GUI.option_text_ids[GUI.current_option_selection], "GAME_FRIEND_DEMAND_DESCRIPTION")
      end
    elseif _ARG_0_ == UIEnums.Message.KeyboardCancelled then
      if GUI.current_option_selection == 1 then
        UIButtons.ChangeText(GUI.option_text_ids[GUI.current_option_selection], "GAME_FRIEND_DEMAND_NAME")
      elseif GUI.current_option_selection == 2 then
        UIButtons.ChangeText(GUI.option_text_ids[GUI.current_option_selection], "GAME_FRIEND_DEMAND_DESCRIPTION")
      end
    end
  elseif _ARG_0_ == UIEnums.Message.KeyboardFinished then
    if GUI.current_option_selection == 1 then
      FriendDemand.StoreName()
      UIButtons.ChangeText(GUI.option_text_ids[GUI.current_option_selection], "GAME_FRIEND_DEMAND_NAME")
    elseif GUI.current_option_selection == 2 then
      FriendDemand.StoreDescription()
      UIButtons.ChangeText(GUI.option_text_ids[GUI.current_option_selection], "GAME_FRIEND_DEMAND_DESCRIPTION")
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    if GUI.current_option_selection == 1 then
      if FriendDemand.CheckingName() == false then
        if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
          UIHardware.StartKeyboard(_ARG_1_, "GAME_FRIEND_DEMAND_NAME", UIText.FDE_FRIEND_DEMAND, UIText.FDE_ENTER_NAME, 26, UIEnums.XboxKeyboardType.StandardHighlight)
        elseif UIEnums.CurrentPlatform == UIEnums.Platform.PC then
          print("Start input for PC Friend Demand Name")
          LaunchPopupKeyboard(UIText.FDE_FRIEND_DEMAND, 26)
        end
      else
        PlaySfxError()
      end
    elseif GUI.current_option_selection == 2 then
      if FriendDemand.CheckingDesc() == false then
        if UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
          UIHardware.StartKeyboard(_ARG_1_, "GAME_FRIEND_DEMAND_DESCRIPTION", UIText.FDE_FRIEND_DEMAND, UIText.FDE_ENTER_DESCRIPTION, 52, UIEnums.XboxKeyboardType.StandardHighlight)
        elseif UIEnums.CurrentPlatform == UIEnums.Platform.PC then
          print("Start input for PC Friend Demand Desc")
          LaunchPopupKeyboard(UIText.FDE_FRIEND_DEMAND, 52)
        end
      else
        PlaySfxError()
      end
    elseif GUI.current_option_selection == 3 then
      PlaySfxNext()
      UIButtons.PrivateTimeLineActive(GUI.bottom_bar_id, "Hide_BottomHelp", true)
      PushScreen("Ingame\\CreateFriendDemand.lua")
    elseif GUI.current_option_selection == 4 then
      for _FORV_9_ = 1, 3 do
        if UIGlobals.FriendDemandFriends[_FORV_9_] ~= nil and FriendDemand.IsFriend(UIGlobals.FriendDemandFriends[_FORV_9_]) == false then
          UIGlobals.FriendDemandFriends[_FORV_9_] = nil
        end
      end
      if true == false then
        PlaySfxNext()
        UIGlobals.FriendDemandIsResend = false
        GoScreen("Ingame\\SendingFriendDemand.lua")
      else
        SetupCustomPopup(UIEnums.CustomPopups.FriendDemandRemovedFriend)
      end
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    PlaySfxBack()
    GoScreen("Ingame\\AddFriendsToFriendDemand.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonX and UIGlobals.FriendDemandSwitchChosen > -1 then
    PlaySfxError()
    Fd_ClearExtraChallenge()
    Fd_UpdateExtraChallenge()
    FdAddText_SetupInfoLines()
  end
end
function FrameUpdate(_ARG_0_)
  if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
  end
  if UIButtons.GetSelection(GUI.fd_node_list_id) ~= GUI.current_option_selection then
    if GUI.current_option_selection ~= -1 then
      UIButtons.PrivateTimeLineActive(GUI.option_box_ids[GUI.current_option_selection], "flash", false)
    end
    GUI.current_option_selection = UIButtons.GetSelection(GUI.fd_node_list_id)
    UIButtons.PrivateTimeLineActive(GUI.option_box_ids[GUI.current_option_selection], "flash", true, 0)
    FdAddText_SetupInfoLines()
    FdAddText_SetupHelpText()
  end
  if UIGlobals.FdAddText_DoUpdate == true then
    UIGlobals.FdAddText_DoUpdate = false
    Fd_UpdateExtraChallenge()
    FdAddText_SetupInfoLines()
    UIButtons.PrivateTimeLineActive(GUI.bottom_bar_id, "Hide_BottomHelp", false)
  end
end
function EnterEnd()
end
function EndLoop(_ARG_0_)
end
function End()
end
function FdAddText_SetupInfoLines()
  if UIGlobals.FriendDemandSwitchChosen > -1 then
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, UIText.INFO_X_CLEAR_EXTRA_CHALLENGE)
  else
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
  end
end
function FdAddText_SetupHelpText()
  UIButtons.ChangeText(GUI.help_text_id, GUI.help_text[GUI.current_option_selection])
  UIButtons.TimeLineActive("HelpFade", true, 0.5)
end
