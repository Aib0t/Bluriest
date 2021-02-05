GUI = {
  finished = false,
  node_list_id = -1,
  node_list_friends_id = -1,
  current_option_selection = -1,
  current_friend_selection = -1,
  friend_text_ids = {},
  friend_icon_ids = {},
  friend_list = {},
  friend_list_text_ids = {},
  box_ids = {},
  choosing_friend = false,
  num_friends_chosen = 0
}
function Init()
  AddSCUI_Elements()
  SetupInfoLine()
  GUI.camera_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Cam_Carousel")
  UIButtons.SetParent(GUI.camera_id, SCUI.name_to_id.CameraDolly, UIEnums.Justify.MiddleCentre)
  GUI.friend_list[1] = UIGlobals.FriendDemandFriends[1]
  GUI.friend_list[2] = UIGlobals.FriendDemandFriends[2]
  GUI.friend_list[3] = UIGlobals.FriendDemandFriends[3]
end
function PostInit()
  SetupScreenTitle(UIText.FDE_FRIEND_DEMAND, SCUI.name_to_id.screen, "message", "common_icons", nil, UIEnums.Justify.TopCentre, true, nil, UIEnums.Panel._3DAA_LIGHT, nil, UIEnums.Justify.TopCentre)
  GUI.bottom_bar_add_id = SetupBottomHelpBar(UIText.FDE_HELP_CHOOSE_FRIENDS, nil, nil, true)
  SetupScreenTitle(UIText.FDE_FRIEND_DEMAND, SCUI.name_to_id.screen_friends, "message", "common_icons", nil, UIEnums.Justify.TopCentre, true, nil, UIEnums.Panel._3DAA_LIGHT, nil, UIEnums.Justify.TopCentre)
  GUI.bottom_bar_choose_id = SetupBottomHelpBar(UIText.FDE_HELP_CHOOSE_FRIEND, nil, nil, true)
  UIButtons.PrivateTimeLineActive(GUI.bottom_bar_choose_id, "Hide_BottomHelp", true, 1, true)
  GUI.node_list_id = SCUI.name_to_id.node_list_options
  for _FORV_9_ = 1, 3 do
    if _FORV_9_ == 3 then
      UIButtons.ChangeSize(UIButtons.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_friend_node"), UIButtons.GetSize((UIButtons.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_friend_node"))))
    end
    GUI.box_ids[_FORV_9_] = SetupSelectionBox(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_friend_node"), "_friend_dummy"), UIText.FDE_FRIEND_SLOT_EMPTY, nil, nil, nil, nil, UIEnums.Justify.MiddleLeft, true)
    GUI.friend_text_ids[_FORV_9_] = SetupSelectionBox(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_friend_node"), "_friend_dummy"), UIText.FDE_FRIEND_SLOT_EMPTY, nil, nil, nil, nil, UIEnums.Justify.MiddleLeft, true)
    GUI.friend_icon_ids[_FORV_9_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_friend_node"), "_friend_pic")
    if GUI.friend_list[_FORV_9_] ~= nil then
      UIButtons.ChangeText(GUI.friend_text_ids[_FORV_9_], "GAME_FRIEND_DEMAND_FRIEND_" .. GUI.friend_list[_FORV_9_])
    end
    UIButtons.AddListItem(GUI.node_list_id, UIButtons.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_friend_node"), _FORV_9_)
  end
  GUI.box_ids[4] = SetupSelectionBox(_FOR_.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_setup_node"), UIText.FDE_CREATE_CHALLENGE)
  UIButtons.AddListItem(GUI.node_list_id, _FOR_.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_setup_node"), 4)
  UIButtons.SetParent(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._friends_stencil_read_on]), SCUI.name_to_id.screen_friends, UIEnums.Justify.MiddleCentre)
  GUI.node_list_friends_id = UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._node_list_friends])
  UIButtons.SetParent(GUI.node_list_friends_id, SCUI.name_to_id.screen_friends, UIEnums.Justify.MiddleCentre)
  for _FORV_11_ = 1, Amax.GetNumFriends() do
    GUI.friend_list_text_ids[_FORV_11_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_friend_list_node"), "_friend_list_name")
    UIButtons.ChangeText(GUI.friend_list_text_ids[_FORV_11_], "GAME_FRIEND_DEMAND_FRIEND_" .. Amax.GetFriendsIDFromIndex(_FORV_11_ - 1))
    UIButtons.AddListItem(GUI.node_list_friends_id, UIButtons.CloneXtGadgetByName("Ingame\\AddFriendsToFriendDemand.lua", "_friend_list_node"), (Amax.GetFriendsIDFromIndex(_FORV_11_ - 1)))
  end
  UIButtons.SetParent(_FOR_.AddButton(SCUI.elements[SCUI.name_to_index._friends_stencil_read_off]), SCUI.name_to_id.screen_friends, UIEnums.Justify.MiddleCentre)
  for _FORV_12_ = 1, Amax.GetNumFriends() do
    UIButtons.SetNodeItemLocked(GUI.node_list_friends_id, Amax.GetFriendsIDFromIndex(_FORV_12_ - 1), false)
  end
  _FOR_.SetSelected(GUI.node_list_friends_id, false)
  FdAddFriends_SetupInfoLines()
  FdAddFriends_UpdateGamerpics()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.MiscMessage.FriendsUpdated then
    for _FORV_8_ = 1, 3 do
      UIGlobals.FriendDemandFriends[_FORV_8_] = nil
      if GUI.friend_list[_FORV_8_] ~= nil and FriendDemand.IsFriend(GUI.friend_list[_FORV_8_]) == true then
        UIGlobals.FriendDemandFriends[_FORV_8_] = GUI.friend_list[_FORV_8_]
      end
    end
    GoScreen("Ingame\\AddFriendsToFriendDemand.lua")
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    if GUI.choosing_friend == false then
      if GUI.current_option_selection == 4 then
        if GUI.friend_list[1] ~= nil or GUI.friend_list[2] ~= nil or GUI.friend_list[3] ~= nil then
          UIGlobals.FriendDemandFriends[1] = GUI.friend_list[1]
          UIGlobals.FriendDemandFriends[2] = GUI.friend_list[2]
          UIGlobals.FriendDemandFriends[3] = GUI.friend_list[3]
          FriendDemand.Create()
          GoScreen("Ingame\\AddTextToFriendDemand.lua")
          PlaySfxNext()
        else
          SetupCustomPopup(UIEnums.CustomPopups.FriendDemandNoFriendsChosen)
        end
      else
        for _FORV_10_ = 0, Amax.GetNumFriends() - 1 do
          UIButtons.SetNodeItemLocked(GUI.node_list_friends_id, Amax.GetFriendsIDFromIndex(_FORV_10_), false, true)
          if Amax.GetFriendsIDFromIndex(_FORV_10_) == GUI.friend_list[1] or Amax.GetFriendsIDFromIndex(_FORV_10_) == GUI.friend_list[2] or Amax.GetFriendsIDFromIndex(_FORV_10_) == GUI.friend_list[3] then
            UIButtons.ChangeColour(GUI.friend_list_text_ids[_FORV_10_ + 1], "Main_Black")
            UIButtons.SetNodeItemLocked(GUI.node_list_friends_id, Amax.GetFriendsIDFromIndex(_FORV_10_), true, true)
          else
            UIButtons.ChangeColour(GUI.friend_list_text_ids[_FORV_10_ + 1], "Main_White")
          end
        end
        if Amax.GetNumFriends() > _FOR_.num_friends_chosen and Amax.GetNumFriends() - 1 > 0 then
          UIButtons.PrivateTimeLineActive(GUI.bottom_bar_add_id, "Hide_BottomHelp", true)
          UIButtons.PrivateTimeLineActive(GUI.bottom_bar_choose_id, "Hide_BottomHelp", false)
          UIButtons.SetSelected(GUI.node_list_friends_id, true)
          UIButtons.SetSelected(GUI.node_list_id, false)
          GUI.choosing_friend = true
          UIButtons.TimeLineActive("stage1", true)
          FdAddFriends_SetupInfoLines()
          PlaySfxNext()
          PlaySfxGraphicNext()
        else
          PlaySfxError()
        end
      end
    else
      PlaySfxNext()
      PlaySfxGraphicBack()
      Profile.ClearRemotePictureByRef(GUI.current_option_selection - 1)
      FriendDemand.AddFriend(GUI.current_option_selection - 1, (UIButtons.GetSelection(GUI.node_list_friends_id)))
      if GUI.friend_list[GUI.current_option_selection] == nil then
        GUI.num_friends_chosen = GUI.num_friends_chosen + 1
      end
      GUI.friend_list[GUI.current_option_selection] = UIButtons.GetSelection(GUI.node_list_friends_id)
      UIButtons.SetSelected(GUI.node_list_friends_id, false)
      UIButtons.SetSelected(GUI.node_list_id, true)
      UIButtons.ChangeText(GUI.friend_text_ids[GUI.current_option_selection], "GAME_FRIEND_DEMAND_FRIEND_" .. GUI.friend_list[GUI.current_option_selection])
      UIButtons.PrivateTimeLineActive(GUI.bottom_bar_add_id, "Hide_BottomHelp", false)
      UIButtons.PrivateTimeLineActive(GUI.bottom_bar_choose_id, "Hide_BottomHelp", true)
      GUI.choosing_friend = false
      UIButtons.TimeLineActive("stage1", false)
      FdAddFriends_SetupInfoLines()
      FdAddFriends_UpdateGamerpics()
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    if GUI.choosing_friend == true then
      UIButtons.SetSelected(GUI.node_list_friends_id, false)
      UIButtons.SetSelected(GUI.node_list_id, true)
      UIButtons.PrivateTimeLineActive(GUI.bottom_bar_add_id, "Hide_BottomHelp", false)
      UIButtons.PrivateTimeLineActive(GUI.bottom_bar_choose_id, "Hide_BottomHelp", true)
      GUI.choosing_friend = false
      UIButtons.TimeLineActive("stage1", false)
      FdAddFriends_SetupInfoLines()
      PlaySfxGraphicBack()
    else
      GoScreen(GetStoredScreen(UIEnums.ScreenStorage.FE_FRIEND_DEMAND))
    end
    PlaySfxBack()
  elseif _ARG_0_ == UIEnums.Message.ButtonX then
    if GUI.choosing_friend == false and GUI.current_option_selection ~= 4 then
      FriendDemand.AddFriend(GUI.current_option_selection - 1, -1)
      GUI.friend_list[GUI.current_option_selection] = nil
      UIButtons.ChangeText(GUI.friend_text_ids[GUI.current_option_selection], UIText.FDE_FRIEND_SLOT_EMPTY)
      GUI.num_friends_chosen = GUI.num_friends_chosen - 1
      FdAddFriends_SetupInfoLines()
      FdAddFriends_UpdateGamerpics()
      PlaySfxError()
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonY and UIEnums.CurrentPlatform == UIEnums.Platform.Xenon then
    if GUI.choosing_friend == false and GUI.current_option_selection ~= 4 then
      if GUI.friend_list[GUI.current_option_selection] ~= nil then
        FriendDemand.ShowFriendGamerCard(GUI.friend_list[GUI.current_option_selection])
      end
    elseif GUI.choosing_friend == true then
      FriendDemand.ShowFriendGamerCard((UIButtons.GetSelection(GUI.node_list_friends_id)))
    end
  end
end
function FrameUpdate(_ARG_0_)
  if UIButtons.GetSelection(GUI.node_list_id) ~= GUI.current_option_selection then
    if GUI.current_option_selection ~= -1 then
      UIButtons.PrivateTimeLineActive(GUI.box_ids[GUI.current_option_selection], "flash", false)
    end
    GUI.current_option_selection = UIButtons.GetSelection(GUI.node_list_id)
    UIButtons.PrivateTimeLineActive(GUI.box_ids[GUI.current_option_selection], "flash", true, 0)
    FdAddFriends_SetupInfoLines()
  end
  if UIButtons.GetSelectionIndex(GUI.node_list_friends_id) ~= GUI.current_friend_selection then
    UIButtons.PrivateTimeLineActive(SCUI.name_to_id.arrow_top, "more", UIButtons.GetSelectionIndex(GUI.node_list_friends_id) ~= 0)
    UIButtons.PrivateTimeLineActive(SCUI.name_to_id.arrow_top, "push", UIButtons.GetSelectionIndex(GUI.node_list_friends_id) < GUI.current_friend_selection, 0)
    UIButtons.PrivateTimeLineActive(SCUI.name_to_id.arrow_bottom, "more", UIButtons.GetSelectionIndex(GUI.node_list_friends_id) ~= Amax.GetNumFriends() - 1)
    UIButtons.PrivateTimeLineActive(SCUI.name_to_id.arrow_bottom, "push", UIButtons.GetSelectionIndex(GUI.node_list_friends_id) > GUI.current_friend_selection, 0)
    GUI.current_friend_selection = UIButtons.GetSelectionIndex(GUI.node_list_friends_id)
  end
end
function EnterEnd()
end
function EndLoop(_ARG_0_)
end
function End()
end
function FdAddFriends_SetupInfoLines()
  if GUI.current_option_selection == 4 then
    if GUI.friend_list[1] ~= nil or GUI.friend_list[2] ~= nil or GUI.friend_list[3] ~= nil then
      SetupInfoLine(UIText.INFO_A_CONTINUE, UIText.INFO_B_BACK)
    else
      SetupInfoLine(UIText.INFO_B_BACK)
    end
  elseif GUI.choosing_friend == true then
    SetupInfoLine(UIText.INFO_A_ADD_FRIEND, UIText.INFO_B_BACK, Select(UIEnums.CurrentPlatform == UIEnums.Platform.Xenon, UIText.INFO_Y_VIEW_GAMER_CARD, nil))
  elseif GUI.friend_list[GUI.current_option_selection] ~= nil then
    for _FORV_4_ = 1, 3 do
    end
    if Amax.GetNumFriends() - 1 > 0 then
      SetupInfoLine(UIText.INFO_A_CHANGE_FRIEND, UIText.INFO_B_BACK, UIText.INFO_REMOVE_FRIEND, Select(UIEnums.CurrentPlatform == UIEnums.Platform.Xenon, UIText.INFO_Y_VIEW_GAMER_CARD, nil))
    else
      SetupInfoLine(UIText.INFO_B_BACK, UIText.INFO_REMOVE_FRIEND, Select(UIEnums.CurrentPlatform == UIEnums.Platform.Xenon, UIText.INFO_Y_VIEW_GAMER_CARD, nil))
    end
  else
    for _FORV_5_ = 1, 3 do
    end
    if Amax.GetNumFriends() > 0 + 1 then
      SetupInfoLine(UIText.INFO_A_ADD_FRIEND, UIText.INFO_B_BACK)
    else
      SetupInfoLine(UIText.INFO_B_BACK)
    end
  end
end
function FdAddFriends_UpdateGamerpics()
  for _FORV_4_, _FORV_5_ in ipairs(GUI.friend_icon_ids) do
    if GUI.friend_list[_FORV_4_] ~= nil and Profile.GetRemoteGamerPictureMap()[_FORV_4_ - 1] ~= nil then
      UIButtons.ChangeTexture({
        filename = "REMOTE_GAMERPIC_" .. Profile.GetRemoteGamerPictureMap()[_FORV_4_ - 1]
      }, 1, _FORV_5_)
    else
      UIButtons.ChangeTexture({
        filename = "default_gamerpic"
      }, 1, _FORV_5_)
    end
  end
end
