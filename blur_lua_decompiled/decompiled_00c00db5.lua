GUI = {
  finished = false,
  carousel_branch = "Blurb",
  blurbs = {},
  node_list_id = -1,
  node_ids = {},
  current_selection = -1,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  PlaySfxGraphicNext()
  AddSCUI_Elements()
  DeferCam_Init("Sp_1")
  CarouselApp_SetScreenTimers()
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
end
function PostInit()
  UIButtons.TimeLineActive("Hide_EventSelect", true)
  GUI.blurbs = Amax.GetBlurbs(UIGlobals.FriendDemandFilter, Select(UIGlobals.FriendDemandFilter == 3, UIGlobals.FriendDemandFilterEvent, UIGlobals.FriendDemandFilterFriend))
  if UIGlobals.FriendDemandAttemptFromMessage == true then
    SetupCustomPopup(UIEnums.CustomPopups.FriendDemandRetrieving)
  end
  if #GUI.blurbs == 0 then
    UIButtons.SetActive(SCUI.name_to_id.black_top_background, false)
    UIButtons.SetActive(SCUI.name_to_id.friend_pic_frame, false, false)
    return
  end
  if UIGlobals.FriendDemandFilter == 3 then
    UIButtons.SetActive(SCUI.name_to_id.black_top_background, false)
    UIButtons.SetActive(SCUI.name_to_id.friend_pic_frame, false, true)
  else
    UIButtons.ChangeText(SCUI.name_to_id.friend_type_info, Select(UIGlobals.FriendDemandFilter == 2, UIText.FDE_SORTING_NEW_CHALLENGES, UIText.FDE_SORTING_ACTIVE_CHALLENGES))
    UIButtons.ChangeText(SCUI.name_to_id.friend_name, "GAME_FRIEND_DEMAND_FRIEND_" .. UIGlobals.FriendDemandFilterFriend)
    if Profile.GetRemoteGamerPictureMap()[UIGlobals.FriendDemandFilterFriend] ~= nil then
      UIButtons.ChangeTexture({
        filename = "REMOTE_GAMERPIC_" .. Profile.GetRemoteGamerPictureMap()[UIGlobals.FriendDemandFilterFriend]
      }, 1, SCUI.name_to_id.friend_pic)
    else
      UIButtons.ChangeTexture({
        filename = "default_gamerpic"
      }, 1, SCUI.name_to_id.friend_pic)
    end
  end
  GUI.node_list_id = SCUI.name_to_id.node_list
  for _FORV_3_, _FORV_4_ in ipairs(GUI.blurbs) do
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_icon"), Sp_KindToShape(SinglePlayer.EventInfo(FriendDemand.GetInfo(_FORV_4_.index, _FORV_4_.type == UIEnums.FriendDemandMessageType.Server).eventid_sp).kind))
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_event_text"), Sp_KindToText(SinglePlayer.EventInfo(FriendDemand.GetInfo(_FORV_4_.index, _FORV_4_.type == UIEnums.FriendDemandMessageType.Server).eventid_sp).kind))
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_name"), Select(_FORV_4_.type == UIEnums.FriendDemandMessageType.Server, "GAME_BLURB_SERVER_MSG", "GAME_BLURB_NORMAL_MSG") .. _FORV_4_.index .. "_NAME")
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_info_time_sent"), Select(_FORV_4_.type == UIEnums.FriendDemandMessageType.Server, "GAME_BLURB_SERVER_MSG", "GAME_BLURB_NORMAL_MSG") .. _FORV_4_.index .. "_TIME_SENT")
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_info_days_left"), Select(_FORV_4_.type == UIEnums.FriendDemandMessageType.Server, "GAME_BLURB_SERVER_MSG", "GAME_BLURB_NORMAL_MSG") .. _FORV_4_.index .. Select(_FORV_4_.type == UIEnums.FriendDemandMessageType.Server, "_DAYS_LEFT", "_ATTEMPTS"))
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_type_icon"), Select(_FORV_4_.type == UIEnums.FriendDemandMessageType.Server, "challenge_received", "challenge_open"))
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_type_icon"), Select(FriendDemand.GetInfo(_FORV_4_.index, _FORV_4_.type == UIEnums.FriendDemandMessageType.Server).rechallenge, "Support_4", "Support_0"))
    if UIGlobals.FriendDemandFilter == 3 then
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_sender"), Select(_FORV_4_.type == UIEnums.FriendDemandMessageType.Server, "GAME_BLURB_SERVER_MSG", "GAME_BLURB_NORMAL_MSG") .. _FORV_4_.index .. "_SENDER")
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_icon"), false)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), "blurb_event_text"), false)
    end
    UIButtons.AddListItem(GUI.node_list_id, UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node"), _FORV_3_)
    GUI.node_ids[_FORV_3_] = UIButtons.CloneXtGadgetByName("SpSCUI", "blurb_node")
  end
  Fd_CreatePanel(SCUI.name_to_id.panel_dummy, 2, true)
  UIButtons.ChangePanel(GUI.fd_panel_id, UIEnums.Panel._3DAA_WORLD, true)
  SetupScreenTitle(UIText.FDE_FRIEND_DEMANDS, SCUI.name_to_id.screen, "message", "common_icons", 1, UIEnums.Justify.TopCentre, nil, nil, UIEnums.Panel._3DAA_LIGHT, nil, UIEnums.Justify.TopCentre)
  GUI.help_text_id = SetupBottomHelpBar(UIText.FDE_BLURB_HELP, nil, 1, nil)
  ContextTable[UIScreen.Context()].FrameUpdate(0)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.FriendDemandOptions then
    if _ARG_3_ == UIEnums.FriendDemandOptions.Attempt then
      if FriendDemand.IsFriend(UIGlobals.FriendDemandFilterFriend) == false then
        SetupCustomPopup(UIEnums.CustomPopups.FriendDemandNotFriend)
      elseif UIGlobals.FriendDemandCurrentType == UIEnums.FriendDemandMessageType.Local then
        AttemptFriendDemand(GUI.blurbs[GUI.current_selection].index)
      elseif UIGlobals.FriendDemandCurrentType == UIEnums.FriendDemandMessageType.Server then
        UIGlobals.CurrentFriendDemandMessageIndex = GUI.blurbs[GUI.current_selection].index
        if FriendDemand.GetFreeSlot() == -1 then
          SetupCustomPopup(UIEnums.CustomPopups.FriendDemandNoFreeSlots)
        else
          UIGlobals.FriendDemandAttemptFromServer = true
          UIGlobals.CurrentFriendFreeSlot = FriendDemand.GetFreeSlot()
          SetupCustomPopup(UIEnums.CustomPopups.AcceptingFriendDemand)
        end
      end
    elseif _ARG_3_ == UIEnums.FriendDemandOptions.Store then
      if FriendDemand.IsFriend(UIGlobals.FriendDemandFilterFriend) == false then
        SetupCustomPopup(UIEnums.CustomPopups.FriendDemandNotFriend)
      elseif UIGlobals.FriendDemandCurrentType == UIEnums.FriendDemandMessageType.Server then
        UIGlobals.CurrentFriendDemandMessageIndex = GUI.blurbs[GUI.current_selection].index
        if FriendDemand.GetFreeSlot() == -1 then
          SetupCustomPopup(UIEnums.CustomPopups.FriendDemandNoFreeSlots)
        else
          UIGlobals.FriendDemandAttemptFromServer = false
          UIGlobals.CurrentFriendFreeSlot = FriendDemand.GetFreeSlot()
          SetupCustomPopup(UIEnums.CustomPopups.AcceptingFriendDemand)
        end
      end
    elseif _ARG_3_ == UIEnums.FriendDemandOptions.Delete then
      UIGlobals.CurrentFriendDemandMessageIndex = GUI.blurbs[GUI.current_selection].index
      SetupCustomPopup(UIEnums.CustomPopups.FriendDemandDelete)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.FriendDemandNoBlurbs then
    if UIGlobals.FriendDemandFilter == 3 then
      SpPopToEventSelect()
    else
      GoScreen("Shared\\BlurbMainMenu.lua")
    end
  end
  if #GUI.blurbs == 0 then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    UIGlobals.FriendDemandCurrentType = GUI.blurbs[GUI.current_selection].type
    SetupCustomPopup(UIEnums.CustomPopups.FriendDemandOptions)
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    if UIGlobals.FriendDemandFilter == 3 then
      SpPopToEventSelect()
    else
      GoScreen("Shared\\BlurbMainMenu.lua")
    end
    PlaySfxBack()
    PlaySfxGraphicBack()
  end
end
function StartLoop(_ARG_0_)
  DeferCam_Update(_ARG_0_)
end
function FrameUpdate(_ARG_0_)
  DeferCam_Update(_ARG_0_)
  if UIGlobals.RefreshFriendDemandScreen == true then
    if UIGlobals.FriendDemandAttemptFromMessage == true then
      UIGlobals.FriendDemandAttemptFromMessage = false
      if FriendDemand.GetKeyedIndex() ~= -1 then
        if FriendDemand.GetKeyedIndex() == true then
          UIGlobals.CurrentFriendDemandMessageIndex = FriendDemand.GetKeyedIndex()
          if FriendDemand.GetFreeSlot() == -1 then
            SetupCustomPopup(UIEnums.CustomPopups.FriendDemandNoFreeSlots)
          else
            UIGlobals.FriendDemandAttemptFromServer = true
            UIGlobals.CurrentFriendFreeSlot = FriendDemand.GetFreeSlot()
            SetupCustomPopup(UIEnums.CustomPopups.AcceptingFriendDemand)
          end
        else
          AttemptFriendDemand(FriendDemand.GetKeyedIndex())
        end
      else
        SetupCustomPopup(UIEnums.CustomPopups.FriendDemandNotOnServer)
      end
    elseif UIGlobals.FriendDemandAttemptFromServer == true then
      UIGlobals.FriendDemandAttemptFromServer = false
      AttemptFriendDemand(UIGlobals.CurrentFriendFreeSlot)
    else
      GoScreen("Shared\\Blurb.lua")
    end
    UIGlobals.RefreshFriendDemandScreen = false
  end
  if UIGlobals.FriendDemandAttemptFromMessage == true or UIScreen.IsPopupActive() then
    return
  end
  if #GUI.blurbs == 0 or GUI.blurbs == nil then
    if UIGlobals.FriendDemandFilter == 3 then
      UIGlobals.SelectEventMenu = true
      SpPopToEventSelect()
    else
      GoScreen("Shared\\BlurbMainMenu.lua")
    end
    return
  end
  if UIButtons.GetSelection(GUI.node_list_id) ~= GUI.current_selection then
    if GUI.current_selection ~= -1 then
      UIButtons.PrivateTimeLineActive(GUI.node_ids[GUI.current_selection], "flash", false)
    end
    GUI.current_selection = UIButtons.GetSelection(GUI.node_list_id)
    UIButtons.PrivateTimeLineActive(GUI.node_ids[GUI.current_selection], "flash", true, 0)
    if GUI.blurbs[GUI.current_selection].type == UIEnums.FriendDemandMessageType.Server then
      Fd_UpdatePanel(GUI.blurbs[GUI.current_selection].index, true)
    elseif GUI.blurbs[GUI.current_selection].type == UIEnums.FriendDemandMessageType.Local then
      Fd_UpdatePanel(GUI.blurbs[GUI.current_selection].index)
    end
  end
end
function EnterEnd()
  UIButtons.TimeLineActive("Hide_EventSelect", false)
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
end
function AttemptFriendDemand(_ARG_0_)
  show_table((FriendDemand.GetInfo(_ARG_0_)))
  UIGlobals.FriendDemandAttemptingIndex = _ARG_0_
  Amax.SetSPEvent(FriendDemand.GetInfo(_ARG_0_).eventid_sp)
  Amax.SetCurrentEvent(FriendDemand.GetInfo(_ARG_0_).eventid)
  Amax.SetCurrentCar(FriendDemand.GetInfo(_ARG_0_).vehicleid)
  SinglePlayer.EventSetLastVehicle(FriendDemand.GetInfo(_ARG_0_).eventid_sp, FriendDemand.GetInfo(_ARG_0_).vehicleid)
  SinglePlayer.GameSetLastVehicle(FriendDemand.GetInfo(_ARG_0_).vehicleid)
  FriendDemand.SetupRaceMode(_ARG_0_, UIGlobals.FriendDemandFilterFriend)
  UIGlobals.ReturnToBlurb = true
  SpGoLoadingScreen()
  Amax.LoadTextureClone(GameData.GetEvent(SinglePlayer.EventInfo(FriendDemand.GetInfo(_ARG_0_).eventid_sp).eventId).route_tag, 0)
end
