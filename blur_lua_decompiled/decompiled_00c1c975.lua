GUI = {
  scoreboard_has_read = false,
  leaderboard_initialised = false,
  finished = false
}
function Init()
  net_LockoutFriendsOverlay(true)
  AddSCUI_Elements()
  DeferCam_Init("Sp_1")
  UIScreen.SetScreenTimers(0.3, UIGlobals.screen_time.default_end)
  StoreInfoLine()
  SetupInfoLine()
  SpMiniLeaderboard_Init()
  GUI.boss_unlocked = UIGlobals.Sp.BossInfo[UIGlobals.Sp.CurrentTier].unlocked
end
function PostInit()
  UIButtons.TimeLineActive("Hide_EventSelect", true)
  GUI.pr_owner_node = SCUI.name_to_id.Owner_Node
  GUI.pr_primary_stars = {}
  for _FORV_8_ = 1, 5 do
    GUI.pr_primary_stars[_FORV_8_] = Sp_CreateStar(nil, _FORV_8_, nil, false, false)
    UIButtons.SetParent(GUI.pr_primary_stars[_FORV_8_][1], SCUI.name_to_id.PrimaryLight_Root, UIEnums.Justify.MiddleCentre)
    UIButtons.SetParent(GUI.pr_primary_stars[_FORV_8_][2], SCUI.name_to_id.PrimaryLight_Root, UIEnums.Justify.MiddleCentre)
  end
  GUI.pr_boss_stars = {}
  for _FORV_9_ = 1, SP_MaxStars() do
    GUI.pr_boss_stars[_FORV_9_] = Sp_CreateStar(nil, _FORV_9_, nil, false, false)
    UIButtons.SetParent(GUI.pr_boss_stars[_FORV_9_][1], _FOR_.name_to_id.BossLight_Root, UIEnums.Justify.MiddleCentre)
    UIButtons.SetParent(GUI.pr_boss_stars[_FORV_9_][2], _FOR_.name_to_id.BossLight_Root, UIEnums.Justify.MiddleCentre)
  end
  GUI.pr_secondary_star = Sp_CreateStar(nil, nil, nil, true, false)
  UIButtons.SetParent(GUI.pr_secondary_star[1], _FOR_.name_to_id.SecondaryLight_Root, UIEnums.Justify.MiddleCentre)
  UIButtons.SetParent(GUI.pr_secondary_star[2], _FOR_.name_to_id.SecondaryLight_Root, UIEnums.Justify.MiddleCentre)
  GUI.pr_gfd_star = Sp_CreateStar(nil, nil, nil, false, true)
  UIButtons.SetParent(GUI.pr_gfd_star[1], SCUI.name_to_id.GoldenFanDemand_Root, UIEnums.Justify.MiddleCentre)
  UIButtons.SetParent(GUI.pr_gfd_star[2], SCUI.name_to_id.GoldenFanDemand_Root, UIEnums.Justify.MiddleCentre)
  UIButtons.ChangeTexture({
    filename = GameData.GetEvent(SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).eventId).route_tag
  }, 1, SCUI.name_to_id.VP_Image)
  Sp_UpdateEventPreview(SCUI.name_to_id.VP_Root, SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]), GameData.GetEvent(SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).eventId), UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent])
  if SP_ChangeRestrictionText(SCUI.name_to_id.Restriction_Title, SCUI.name_to_id.Restriction_Text, (SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]))) ~= true then
    UIButtons.ChangeSize(SCUI.name_to_id.VP_RacesFrame, UIButtons.GetSize(SCUI.name_to_id.VP_RacesFrame))
    UIButtons.ChangeSize(SCUI.name_to_id.VP_BoxInner, UIButtons.GetSize(SCUI.name_to_id.VP_RacesFrame))
  end
  UpdateRival(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent])
  GUI.city_tag = GameData.GetEvent(SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).eventId).city_tag
  GUI.route_tag = GameData.GetEvent(SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).eventId).route_tag
  if SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).kind == "boss" == true then
    UIButtons.SetActive(SCUI.name_to_id.BossStars, true)
    UIButtons.SetActive(SCUI.name_to_id.RegularStars, false)
    UIButtons.ChangeText(SCUI.name_to_id.BossInfo, "SPL_EVENT_" .. UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent] .. "_PRIMARY_GOAL")
    for _FORV_11_ = 1, SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).maxStars do
      if _FORV_11_ <= SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).totalStars then
        Sp_ActivateStar(GUI.pr_boss_stars[_FORV_11_], true)
        SpSetStarTexture(GUI.pr_boss_stars[_FORV_11_][1], true, SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).state, false, false)
      else
        Sp_ActivateStar(GUI.pr_boss_stars[_FORV_11_], false)
        SpSetStarTexture(GUI.pr_boss_stars[_FORV_11_][2], false, nil, false, false)
      end
    end
  else
    UIButtons.ChangeText(SCUI.name_to_id.PrimaryInfo, "SPL_EVENT_" .. UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent] .. "_PRIMARY_GOAL_" .. Sp_EventStateToNumber(Sp_EventStateToNextState(SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).state)))
    UIButtons.ChangeText(SCUI.name_to_id.SecondaryInfo, "SPL_EVENT_" .. UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent] .. "_SECONDARY_GOAL")
    UIButtons.SetActive(SCUI.name_to_id.BossStars, false)
    UIButtons.SetActive(SCUI.name_to_id.RegularStars, true)
    for _FORV_11_ = 1, 5 do
      if Sp_EventStateToStars(SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).state) >= _FORV_11_ then
        Sp_ActivateStar(GUI.pr_primary_stars[_FORV_11_], true)
        SpSetStarTexture(GUI.pr_primary_stars[_FORV_11_][1], true, SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).state, false, false)
      else
        Sp_ActivateStar(GUI.pr_primary_stars[_FORV_11_], false)
        SpSetStarTexture(GUI.pr_primary_stars[_FORV_11_][2], false, nil, false, false)
      end
    end
  end
  if SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).kind == "boss" == false and Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false or UIEnums.CurrentPlatform == UIEnums.Platform.PS3 and LSP.IsConnected() == false then
    UIButtons.SetActive(SCUI.name_to_id.OfflineBestBranch, true)
    UIButtons.ChangeText(SCUI.name_to_id.BestPrimaryInfo, "SPL_EVENT_" .. UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent] .. "_PRIMARY_BEST")
    UIButtons.ChangeText(SCUI.name_to_id.BestSecondaryInfo, "SPL_EVENT_" .. UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent] .. "_SECONDARY_BEST")
  end
  Sp_ActivateStar(GUI.pr_secondary_star, SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).fanParComplete)
  Sp_ActivateStar(GUI.pr_gfd_star, SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).fanRunComplete)
  GUI.leaderboard_initialised = SpMiniLeaderboard_PostInit(SCUI.name_to_id.LeaderboardBranch, true)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    if UIGlobals.SpSelectMode == UIGlobals.SpSelectMode_PreRace then
      PlaySfxNext()
      PushScreen("Shared\\Garage.lua")
      UIGlobals.SpSelectMode = UIGlobals.SpSelectMode_Garage
      Amax.SetSPEvent(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent])
      UIButtons.TimeLineActive("Hide_PreRace", true)
      Amax.LoadTextureClone(GUI.route_tag, 0)
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    if UIGlobals.SpSelectMode == UIGlobals.SpSelectMode_PreRace then
      PlaySfxBack()
      UISystem.PlaySound(UIEnums.SoundEffect.GraphicBackward)
      SpPopToEventSelect()
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonX or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonX then
    if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false or UIEnums.CurrentPlatform == UIEnums.Platform.PS3 and LSP.IsConnected() == false then
      return
    end
    if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true and GUI.scoreboard_has_read == true then
      UISystem.PlaySound(UIEnums.SoundEffect.Filter)
      PlaySfxGraphicBack()
      PushScreen("SinglePlayer\\SpShowLeaderboard.lua")
    end
  elseif _ARG_0_ == UIEnums.MiscMessage.FriendsUpdated then
    UIGlobals.UpdateEventOwnersPreRace = true
  end
end
function StartLoop(_ARG_0_)
  DeferCam_Update(_ARG_0_)
end
function FrameUpdate(_ARG_0_)
  DeferCam_Update(_ARG_0_)
  if GUI.leaderboard_initialised == true then
    SpMiniLeaderboard_FrameUpdate(_ARG_0_, false)
  end
  if UIGlobals.SpViewingLeaderboard ~= true and UIGlobals.SpViewingGarage ~= true and UIGlobals.OnMovieScreenInEventSelect ~= true and UIGlobals.ViewingFriendsList ~= true then
    if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false or UIEnums.CurrentPlatform == UIEnums.Platform.PS3 and LSP.IsConnected() == false or GUI.leaderboard_initialised == false then
      SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
    else
      SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, UIText.INFO_X_EXPAND_LEADERBOARD)
    end
  end
  if UIGlobals.UpdateEventOwnersPreRace == true then
    UIGlobals.UpdateEventOwnersPreRace = false
    UpdateRival(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent])
  end
end
function Render()
end
function EnterEnd()
  RestoreInfoLine()
  UIButtons.TimeLineActive("Hide_EventSelect", false)
end
function EndLoop(_ARG_0_)
end
function End()
  net_LockoutFriendsOverlay(false)
end
function UpdateRival(_ARG_0_)
  if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false or UIEnums.CurrentPlatform == UIEnums.Platform.PS3 and LSP.IsConnected() == false then
    UIButtons.SetActive(SCUI.name_to_id._background_box, false)
    UIButtons.SetActive(SCUI.name_to_id._text_title_rival, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Help, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_AvatarFrame, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Gamertag, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Score, false)
    return
  end
  if Amax.HasSinglePlayerRival() == true then
    if SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).new == true then
      UIButtons.SetActive(SCUI.name_to_id.Owner_Help, true)
      UIButtons.ChangeText(SCUI.name_to_id.Owner_Help, UIText.CMN_RIVAL_EVENT_NEW)
      UIButtons.SetActive(SCUI.name_to_id.Owner_AvatarFrame, false)
      UIButtons.SetActive(SCUI.name_to_id.Owner_Gamertag, false)
      UIButtons.SetActive(SCUI.name_to_id.Owner_Score, false)
    else
      UIButtons.SetActive(SCUI.name_to_id.Owner_Help, false)
      UIButtons.SetActive(SCUI.name_to_id.Owner_AvatarFrame, true)
      UIButtons.SetActive(SCUI.name_to_id.Owner_Gamertag, true)
      UIButtons.SetActive(SCUI.name_to_id.Owner_Score, true)
      if Profile.GetRemoteGamerPictureMap()[0] ~= nil then
        UIButtons.ChangeTexture({
          filename = "REMOTE_GAMERPIC_" .. Profile.GetRemoteGamerPictureMap()[0]
        }, 1, SCUI.name_to_id.Owner_AvatarFrame)
      end
      UIButtons.ChangeText(SCUI.name_to_id.Owner_Gamertag, "SPL_EVENT_" .. _ARG_0_ .. "_RIVAL_NAME")
      UIButtons.ChangeText(SCUI.name_to_id.Owner_Score, "SPL_EVENT_" .. _ARG_0_ .. "_RIVAL_SCORE")
    end
  else
    UIButtons.SetActive(SCUI.name_to_id.Owner_Help, true)
    UIButtons.ChangeText(SCUI.name_to_id.Owner_Help, UIText.CMN_NO_RIVAL_SET)
    UIButtons.SetActive(SCUI.name_to_id.Owner_AvatarFrame, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Gamertag, false)
    UIButtons.SetActive(SCUI.name_to_id.Owner_Score, false)
  end
end
