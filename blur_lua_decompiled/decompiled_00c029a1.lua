GUI = {
  finished = false,
  timer = 0,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  DeferCam_Init("Sp_1")
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
  UISystem.PlaySound(UIEnums.SoundEffect.FriendTaleOfTheTape)
end
function PostInit()
  PlaySfxGraphicNext()
  SetupScreenTitle(UIText.FDE_FRIEND_DEMANDS, SCUI.name_to_id.screen, "message", "common_icons", 1, UIEnums.Justify.TopCentre, nil, nil, UIEnums.Panel._3DAA_LIGHT, nil, UIEnums.Justify.TopCentre)
  UIButtons.ChangeTexture({
    filename = "GAMERPIC_" .. Profile.GetPrimaryPad()
  }, 1, SCUI.name_to_id.pic_0)
  UIButtons.ChangeText(SCUI.name_to_id.name_0, "PROFILE_PAD_NAME")
  if Profile.GetRemoteGamerPictureMap()[UIGlobals.FriendDemandFilterFriend] ~= nil then
    UIButtons.ChangeTexture({
      filename = "REMOTE_GAMERPIC_" .. Profile.GetRemoteGamerPictureMap()[UIGlobals.FriendDemandFilterFriend]
    }, 1, SCUI.name_to_id.pic_1)
  end
  UIButtons.ChangeText(SCUI.name_to_id.name_1, "GAME_FRIEND_DEMAND_FRIEND_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_sent_you, "GAME_FRIEND_DEMAND_STATS_SENT_YOU_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_sent_them, "GAME_FRIEND_DEMAND_STATS_SENT_THEM_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_won_you, "GAME_FRIEND_DEMAND_STATS_WON_YOU_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_won_them, "GAME_FRIEND_DEMAND_STATS_WON_THEM_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_aces_you, "GAME_FRIEND_DEMAND_STATS_KOS_YOU_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_aces_them, "GAME_FRIEND_DEMAND_STATS_KOS_THEM_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_most_attempts_you, "GAME_FRIEND_DEMAND_STATS_MOST_ATTEMPTS_YOU_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_most_attempts_them, "GAME_FRIEND_DEMAND_STATS_MOST_ATTEMPTS_THEM_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_avg_attempts_you, "GAME_FRIEND_DEMAND_STATS_AVG_ATTEMPTS_YOU_" .. UIGlobals.FriendDemandFilterFriend)
  UIButtons.ChangeText(SCUI.name_to_id.info_avg_attempts_them, "GAME_FRIEND_DEMAND_STATS_AVG_ATTEMPTS_THEM_" .. UIGlobals.FriendDemandFilterFriend)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack then
    PlaySfxBack()
    GoScreen("Shared\\BlurbMainMenu.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder then
    if Amax.CanUseShare() == true then
      SetupCustomPopup(UIEnums.CustomPopups.TaleOfTheTapeSharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.TaleOfTheTapeAccepted + UIGlobals.SharingOptionsChosen, 1, UIGlobals.FriendDemandFilterFriend)
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK)
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.TaleOfTheTapeAccepted + UIGlobals.SharingOptionsChosen, 0, UIGlobals.FriendDemandFilterFriend)
      StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK)
      GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.TaleOfTheTapeAccepted + UIGlobals.SharingOptionsChosen, 2, UIGlobals.FriendDemandFilterFriend)
    end
  end
end
function StartLoop(_ARG_0_)
  DeferCam_Update(_ARG_0_)
end
function FrameUpdate(_ARG_0_)
  DeferCam_Update(_ARG_0_)
  GUI.timer = GUI.timer + _ARG_0_
  if GUI.timer > 2 and GUI.has_done_stat_colours ~= true then
    BlurbStats_DoStatColours()
    GUI.has_done_stat_colours = true
  end
  if FriendDemand.IsFriend(UIGlobals.FriendDemandFilterFriend) == false then
    PlaySfxBack()
    GoScreen("Shared\\BlurbMainMenu.lua")
  end
end
function EnterEnd()
  RestoreInfoLine()
  PlaySfxGraphicBack()
end
function EndLoop(_ARG_0_)
end
function End()
end
function BlurbStats_DoStatColours()
  if FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend) == nil then
    return
  end
  UIButtons.ChangeColour(SCUI.name_to_id.icon_sent_you, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)(Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).sent_you == FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).sent_them, 0, Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).sent_you > FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).sent_them, 1, -1)), true))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_sent_them, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)(Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).sent_you == FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).sent_them, 0, Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).sent_you > FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).sent_them, 1, -1)), false))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_won_you, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)(Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).won_you == FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).won_them, 0, Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).won_you > FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).won_them, 1, -1)), true))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_won_them, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)(Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).won_you == FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).won_them, 0, Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).won_you > FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).won_them, 1, -1)), false))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_aces_you, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)(Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).aces_you == FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).aces_them, 0, Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).aces_you > FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).aces_them, 1, -1)), true))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_aces_them, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)(Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).aces_you == FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).aces_them, 0, Select(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).aces_you > FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).aces_them, 1, -1)), false))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_most_attempts_you, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)((function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 and _ARG_1_ ~= 0 then
    elseif _ARG_1_ == 0 and _ARG_0_ ~= 0 then
    else
    end
    return (Select(_ARG_0_ == _ARG_1_, 0, Select(_ARG_0_ < _ARG_1_, 1, -1)))
  end)(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).most_attempts_you, FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).most_attempts_them), true))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_most_attempts_them, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)((function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 and _ARG_1_ ~= 0 then
    elseif _ARG_1_ == 0 and _ARG_0_ ~= 0 then
    else
    end
    return (Select(_ARG_0_ == _ARG_1_, 0, Select(_ARG_0_ < _ARG_1_, 1, -1)))
  end)(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).most_attempts_you, FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).most_attempts_them), false))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_avg_attempts_you, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)((function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 and _ARG_1_ ~= 0 then
    elseif _ARG_1_ == 0 and _ARG_0_ ~= 0 then
    else
    end
    return (Select(_ARG_0_ == _ARG_1_, 0, Select(_ARG_0_ < _ARG_1_, 1, -1)))
  end)(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).avg_attempts_you, FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).avg_attempts_them), true))
  UIButtons.ChangeColour(SCUI.name_to_id.icon_avg_attempts_them, (function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 then
      return "Main_1"
    else
      return Select(_ARG_0_ == Select(_ARG_1_, 1, -1), "Support_0", "Support_3")
    end
  end)((function(_ARG_0_, _ARG_1_)
    if _ARG_0_ == 0 and _ARG_1_ ~= 0 then
    elseif _ARG_1_ == 0 and _ARG_0_ ~= 0 then
    else
    end
    return (Select(_ARG_0_ == _ARG_1_, 0, Select(_ARG_0_ < _ARG_1_, 1, -1)))
  end)(FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).avg_attempts_you, FriendDemand.GetTaleOfTheTapeData(UIGlobals.FriendDemandFilterFriend).avg_attempts_them), false))
end
