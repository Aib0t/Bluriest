GUI = {
  finished = false,
  carousel_branch = "Blurb",
  node_list_id = -1,
  node_ids = {},
  pic_ids = {},
  current_selection = -1,
  num_items = -1,
  current_sort = -1,
  pic_wait_time = 0.3,
  pic_wait_timer = 0,
  pic_requested = {},
  CanExit = function(_ARG_0_)
    PlaySfxGraphicBack()
    return true
  end
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_2", UIGlobals.CameraLerpTime, 0)
  CarouselApp_SetScreenTimers()
  net_SetRichPresence(UIEnums.RichPresence.FriendChallenges)
  StoreInfoLine()
  if FriendDemand.HasOldChallenges() == 0 then
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, UIText.INFO_X_SORT)
  else
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, UIText.INFO_X_SORT, UIText.INFO_Y_REMOVE_OLD_CHALLENGES)
  end
end
function PostInit()
  if UIGlobals.FriendDemandCurrentSort ~= nil and UIGlobals.FriendDemandCurrentSort ~= -1 then
    GUI.current_sort = UIGlobals.FriendDemandCurrentSort
  else
    GUI.current_sort = UIEnums.FriendDemandSort.New
  end
  SetupScreenTitle(UIText.FDE_FRIEND_DEMANDS, SCUI.name_to_id.screen, "message", "common_icons", 1, UIEnums.Justify.TopCentre, nil, nil, UIEnums.Panel._3DAA_WORLD, nil, UIEnums.Justify.TopCentre)
  GUI.help_text_id = SetupBottomHelpBar(UIText.FDE_INBOX_HELP, nil, 1, nil)
  GUI.num_items = #FriendDemand.SortFriends(GUI.current_sort)
  GUI.node_list_id = SCUI.name_to_id.node_list
  for _FORV_6_, _FORV_7_ in ipairs((FriendDemand.SortFriends(GUI.current_sort))) do
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "friend_challenge_node"), "friend_name"), "GAME_FRIEND_DEMAND_FRIEND_" .. _FORV_7_)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "friend_challenge_node"), "friend_text_new_info"), "GAME_FRIEND_DEMAND_NEW_COUNT_" .. _FORV_7_)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "friend_challenge_node"), "friend_text_accept_info"), "GAME_FRIEND_DEMAND_ACTIVE_COUNT_" .. _FORV_7_)
    UIButtons.AddListItem(GUI.node_list_id, UIButtons.CloneXtGadgetByName("SpSCUI", "friend_challenge_node"), _FORV_7_)
    GUI.node_ids[_FORV_7_] = UIButtons.CloneXtGadgetByName("SpSCUI", "friend_challenge_node")
    GUI.pic_ids[_FORV_7_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "friend_challenge_node"), "friend_pic")
  end
  BlurbMainMenu_NextSort(true)
  UIButtons.SetSelection(GUI.node_list_id, UIGlobals.FriendDemandFilterFriend)
  ContextTable[UIScreen.Context()].FrameUpdate(0)
  BlurbMainMenu_InitialiseGamerpics()
  BlurbMainMenu_RequestGamerpics()
  BlurbMainMenu_UpdateGamerpics()
  UIGlobals.FriendDemandDoNotRefresh = true
  SetupCustomPopup(UIEnums.CustomPopups.FriendDemandRetrieving)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.MiscMessage.FriendsUpdated then
    if Amax.GetNumFriends() == 0 then
      Amax.ChangeUiCamera(UIGlobals.CameraNames.SpCarousel, 1, 0)
      UIButtons.TimeLineActive("Hide_Carousel", false)
      CloseCurrentApp()
    else
      GoScreen("Shared\\BlurbMainMenu.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.FriendDemandRemoveOldChallenges then
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, UIText.INFO_X_SORT)
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.FriendDemandInboxOptions then
    if _ARG_3_ == 0 then
      UIGlobals.FriendDemandFilter = 2
      UIGlobals.FriendDemandFilterFriend = GUI.current_selection
      GoScreen("Shared\\Blurb.lua")
      BlurbMainMenu_RequestGamerpics()
    elseif _ARG_3_ == 1 then
      UIGlobals.FriendDemandFilter = 1
      UIGlobals.FriendDemandFilterFriend = GUI.current_selection
      GoScreen("Shared\\Blurb.lua")
      BlurbMainMenu_RequestGamerpics()
    elseif _ARG_3_ == 2 then
      UIGlobals.FriendDemandFilterFriend = GUI.current_selection
      FriendDemand.GetTaleOfTheTape(UIGlobals.FriendDemandFilterFriend)
      GoScreen("Shared\\BlurbStats.lua")
      BlurbMainMenu_RequestGamerpics()
    end
  end
  if IsControllerLocked() == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    UIGlobals.FriendDemandFilterFriend = GUI.current_selection
    SetupCustomPopup(UIEnums.CustomPopups.FriendDemandInboxOptions)
  elseif _ARG_0_ == UIEnums.Message.ButtonX or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonX then
    UISystem.PlaySound(UIEnums.SoundEffect.Filter)
    BlurbMainMenu_NextSort()
  elseif _ARG_0_ == UIEnums.Message.ButtonY or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonY then
    if 0 < FriendDemand.HasOldChallenges() then
      SetupCustomPopup(UIEnums.CustomPopups.FriendDemandRemoveOldChallenges)
    end
  elseif getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonBack then
    UIScreen.SpawnFriendScreen()
  end
end
function FrameUpdate(_ARG_0_)
  if Amax.GetNumFriends() ~= GUI.num_items then
    GoScreen("Shared\\BlurbMainMenu.lua")
  end
  if UIButtons.GetSelection(GUI.node_list_id) ~= GUI.current_selection then
    if GUI.current_selection ~= -1 then
      UIButtons.PrivateTimeLineActive(GUI.node_ids[GUI.current_selection], "flash", false)
    end
    GUI.current_selection = UIButtons.GetSelection(GUI.node_list_id)
    UIButtons.PrivateTimeLineActive(GUI.node_ids[GUI.current_selection], "flash", true, 0)
    GUI.pic_wait_timer = 0
  end
  if GUI.pic_wait_timer < GUI.pic_wait_time then
    GUI.pic_wait_timer = GUI.pic_wait_timer + _ARG_0_
    if GUI.pic_wait_timer > GUI.pic_wait_time then
      BlurbMainMenu_RequestGamerpics()
      BlurbMainMenu_UpdateGamerpics()
    end
  end
  if Amax.GetNumFriends() == 0 then
    Amax.ChangeUiCamera(UIGlobals.CameraNames.SpCarousel, 1, 0)
    UIButtons.TimeLineActive("Hide_Carousel", false)
    CloseCurrentApp()
  end
end
function EnterEnd()
  UIGlobals.FriendDemandDoNotRefresh = false
  UIGlobals.FriendDemandCurrentSort = GUI.current_sort
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
  UIScreen.CancelPopup()
end
function BlurbMainMenu_NextSort(_ARG_0_)
  if _ARG_0_ ~= true then
    if GUI.current_sort == UIEnums.FriendDemandSort.New then
      GUI.current_sort = UIEnums.FriendDemandSort.Active
    elseif GUI.current_sort == UIEnums.FriendDemandSort.Active then
      GUI.current_sort = UIEnums.FriendDemandSort.Alpha
    elseif GUI.current_sort == UIEnums.FriendDemandSort.Alpha then
      GUI.current_sort = UIEnums.FriendDemandSort.New
    end
  end
  if GUI.current_sort == UIEnums.FriendDemandSort.New then
    UIButtons.ChangeText(SCUI.name_to_id.sorting_info, UIText.FDE_SORTING_NEW_CHALLENGES)
  elseif GUI.current_sort == UIEnums.FriendDemandSort.Active then
    UIButtons.ChangeText(SCUI.name_to_id.sorting_info, UIText.FDE_SORTING_ACTIVE_CHALLENGES)
  elseif GUI.current_sort == UIEnums.FriendDemandSort.Alpha then
    UIButtons.ChangeText(SCUI.name_to_id.sorting_info, UIText.FDE_SORTING_ALPHA)
  end
  GUI.num_items = #FriendDemand.SortFriends(GUI.current_sort)
  for _FORV_6_, _FORV_7_ in ipairs((FriendDemand.SortFriends(GUI.current_sort))) do
    UIButtons.SetNodeSortKey(GUI.node_list_id, _FORV_7_, _FORV_6_, true)
  end
  UIGlobals.FriendDemandFilterFriend = FriendDemand.SortFriends(GUI.current_sort)[1]
  UIButtons.NodeListSort(GUI.node_list_id)
  if UIGlobals.FriendDemandFilterFriend == 0 then
    UIButtons.SetSelectionByIndex(GUI.node_list_id, 0)
  else
    UIButtons.SetSelection(GUI.node_list_id, UIGlobals.FriendDemandFilterFriend)
  end
  UIButtons.PrivateTimeLineActive(GUI.node_list_id, "new_sort", true, 0)
end
function BlurbMainMenu_InitialiseGamerpics()
  for _FORV_4_, _FORV_5_ in pairs((Profile.GetRemoteGamerPictureMap())) do
    GUI.pic_requested[_FORV_4_] = true
  end
end
function BlurbMainMenu_RequestGamerpics()
  if GUI.pic_requested[GUI.current_selection] == nil then
    for _FORV_5_, _FORV_6_ in pairs(GUI.pic_requested) do
    end
    if 0 + 1 == 19 then
      Profile.ClearRemotePictureByRef(_FORV_5_)
      GUI.pic_requested[_FORV_5_] = nil
    end
    FriendDemand.RequestRemotePicture(GUI.current_selection, GUI.current_selection)
    GUI.pic_requested[GUI.current_selection] = true
  end
end
function BlurbMainMenu_UpdateGamerpics()
  for _FORV_4_, _FORV_5_ in pairs(GUI.pic_ids) do
    if Profile.GetRemoteGamerPictureMap()[_FORV_4_] ~= nil then
      UIButtons.ChangeTexture({
        filename = "REMOTE_GAMERPIC_" .. Profile.GetRemoteGamerPictureMap()[_FORV_4_]
      }, 1, _FORV_5_)
    else
      UIButtons.ChangeTexture({
        filename = "default_gamerpic"
      }, 1, _FORV_5_)
    end
  end
end
