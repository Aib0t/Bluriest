GUI = {
  finished = false,
  carousel_branch = "Races",
  CanExit = function(_ARG_0_)
    if UIGlobals.SpSelectMode == UIGlobals.SpSelectMode_Tier then
      UISystem.PlaySound(UIEnums.SoundEffect.GraphicBackward)
      return true
    end
    return false
  end
}
function Init()
  AddSCUI_Elements()
  DeferCam_Init("Sp_3")
  CarouselApp_SetScreenTimers()
  net_SetRichPresence(UIEnums.RichPresence.Career)
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, UIText.INFO_Y_DIFFICULTY, "GAME_SHARE_BUTTON")
  if Sp_ReturnFromGame() == false then
    UIGlobals.Sp = {}
    UIGlobals.SpSelectMode = UIGlobals.SpSelectMode_Tier
    UIGlobals.Sp.CurrentEvent = nil
  end
  UIGlobals.Sp.GameInfo = SinglePlayer.GameInfo()
  UIGlobals.Sp.TierInfo = SinglePlayer.TierInfo()
  UIGlobals.Sp.BossInfo = SinglePlayer.BossInfo()
  GUI.MenuId = SCUI.name_to_id.menu
  if UIGlobals.FriendDemandAttemptFromMessage == false then
    PlaySPMovieFullScreen(UIEnums.SPVideoConfig.VIDEO_TUTORIAL_1)
  end
end
function PostInit()
  UIButtons.TimeLineActive("Hide_Carousel", true)
  GUI.node_id = {}
  for _FORV_3_, _FORV_4_ in ipairs(UIGlobals.Sp.TierInfo) do
    if _FORV_4_.unlocked then
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SpSCUI", "tier_OnBoss" .. _FORV_3_), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_GreyCity"), UIEnums.Justify.MiddleCentre)
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_Stars"), "SPL_TIER_" .. _FORV_4_.tier - 1 .. "STARSANDMAX")
      if UIGlobals.CurrentLanguage ~= UIEnums.Language.English then
        UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_Subtitle"), true)
        UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_Subtitle"), _FORV_4_.name)
      end
      if _FORV_3_ == #UIGlobals.Sp.TierInfo then
        GUI.b9_c_id = UIButtons.CloneXtGadgetByName("SpSCUI", "tier_OnBoss" .. _FORV_3_)
        if SpTierSelect_RevealEvilShannon() == false then
          UIButtons.SetAlphaIntensity(UIButtons.FindChildByName(GUI.b9_c_id, "b9_c"), nil, 0)
        end
      end
    else
      UIButtons.ChangeTexture({
        filename = "boss" .. _FORV_4_.tier .. "_bg"
      }, 0, UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_GreyCity"))
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_GreyCity"), true)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_LockedIcon"), true)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_Stars"), false, true)
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SpSCUI", "TS_LockedTitle"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_LockedRoot"), UIEnums.Justify.BottomCentre)
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "TS_LockedTitle"), "TS_LockedNumber"), "GAME_NUM_" .. _FORV_4_.starRequirement)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "Silhouette"), true)
      UIButtons.ChangeTexture({
        filename = "boss" .. 1 .. "_cutout"
      }, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "Silhouette")))
    end
    if _FORV_4_.new == true then
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), "TS_NewIcon"), true)
    end
    UIButtons.AddListItem(GUI.MenuId, UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node"), _FORV_3_)
    GUI.node_id[_FORV_3_] = UIButtons.CloneXtGadgetByName("SpSCUI", "Tier_Node")
  end
  if Sp_ReturnFromGame() == true then
    UIButtons.SetSelection(GUI.MenuId, UIGlobals.Sp.CurrentTier)
    if UIGlobals.SpReturnMode == UIGlobals.SpSelectMode_Tier then
      UIGlobals.SpSelectMode = UIGlobals.SpReturnMode
      UIGlobals.SpReturnMode = nil
    else
      SpTierSelect_GoEventSelect()
    end
  end
  GUI.selection = UIButtons.GetSelection(GUI.MenuId)
  UISystem.PauseMovie(GUI.selection, false)
end
function StartLoop(_ARG_0_)
  DeferCam_Update(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if IsControllerLocked() == true then
    return
  end
  if UIScreen.IsPopupActive() == false and _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
    UIButtons.SetCurrentItemByID(GUI.MenuId, (UIButtons.GetParent(_ARG_2_)))
  end
  if UIGlobals.SpSelectMode == UIGlobals.SpSelectMode_Tier and (_ARG_0_ == UIEnums.Message.ButtonY and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonY) then
    UIGlobals.OptionsTable = Amax.Options()
    SetupCustomPopup(UIEnums.CustomPopups.SpChangeDifficulty)
  end
  if UIGlobals.SpSelectMode == UIGlobals.SpSelectMode_Tier then
    if _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonLeftShoulder then
      print("Left Shoulder - ")
      if Amax.CanUseShare() == true then
        UIGlobals.ShareShowTier = UIGlobals.Sp.TierInfo[UIButtons.GetSelection(GUI.MenuId)].unlocked
        SetupCustomPopup(UIEnums.CustomPopups.SpTierSelectSharingOptions)
      end
    elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
      if _ARG_3_ == UIEnums.ShareOptions.Facebook then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FanStatus + UIGlobals.SharingOptionsChosen, 1, GUI.selection)
        StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "SinglePlayer\\SpTierSelect.lua")
        GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
      elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FanStatus + UIGlobals.SharingOptionsChosen, 0, GUI.selection)
        StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "SinglePlayer\\SpTierSelect.lua")
        GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
      elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
        Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.FanStatus + UIGlobals.SharingOptionsChosen, 2, GUI.selection)
      end
    end
  end
  if (_ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or true == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA) and UIGlobals.SpSelectMode == UIGlobals.SpSelectMode_Tier then
    SinglePlayer.MarkNotNew(UIGlobals.Sp.TierInfo[GUI.selection].tierId)
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.node_id[GUI.selection], "TS_NewIcon"), false)
    if UIGlobals.Sp.TierInfo[GUI.selection].unlocked == true then
      UIGlobals.Sp.CurrentTier = GUI.selection
      UIGlobals.Sp.CurrentEvent = nil
      UIGlobals.SpSelectMode = UIGlobals.SpSelectMode_Event
      SpTierSelect_GoEventSelect()
      PlaySfxNext()
      UISystem.PlaySound(UIEnums.SoundEffect.GraphicForward)
    else
      PlaySfxError()
    end
  end
end
function SpTierSelect_GoEventSelect()
  UIButtons.SetSelected(GUI.MenuId, false)
  UISystem.PauseMovie(GUI.selection, true)
  PushScreen("SinglePlayer\\SpEventSelect.lua")
end
function FrameUpdate(_ARG_0_)
  DeferCam_Update(_ARG_0_)
  if UIGlobals.Sp.RevealEvilShannon == true then
    print("Revealing evil shannon")
    UIButtons.SetAlphaIntensity(UIButtons.FindChildByName(GUI.b9_c_id, "b9_c"), nil, 1)
    UIGlobals.Sp.RevealEvilShannon = nil
  end
  if UIGlobals.Sp.EnableTierSelect == true then
    UIButtons.SetSelected(GUI.MenuId, true)
    UIGlobals.Sp.EnableTierSelect = nil
  end
  if GUI.selection ~= UIButtons.GetSelection(GUI.MenuId) then
    UIButtons.PrivateTimeLineActive(GUI.node_id[UIButtons.GetSelection(GUI.MenuId)], "flash", true, 0)
    UISystem.PauseMovie(GUI.selection, true)
    GUI.selection = UIButtons.GetSelection(GUI.MenuId)
    UIButtons.TimeLineActive("TierSelected", true, 0)
    UISystem.PauseMovie(GUI.selection, false)
    if UIGlobals.Sp.TierInfo[UIButtons.GetSelection(GUI.MenuId)].unlocked == true then
      SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, UIText.INFO_Y_DIFFICULTY, "GAME_SHARE_BUTTON")
    else
      SetupInfoLine(UIText.INFO_B_BACK, UIText.INFO_Y_DIFFICULTY, "GAME_SHARE_BUTTON")
    end
  end
end
function Render()
end
function EnterEnd()
  if UIGlobals.SpReturnMode == nil then
    UIGlobals.SpSelectMode = nil
    UIGlobals.Sp = nil
  end
  RestoreInfoLine()
  UIButtons.TimeLineActive("Hide_Carousel", false)
end
function EndLoop(_ARG_0_)
end
function End()
end
function SpTierSelect_RevealEvilShannon()
  for _FORV_3_, _FORV_4_ in ipairs(UIGlobals.Sp.BossInfo[#UIGlobals.Sp.TierInfo].demands) do
    if _FORV_4_.complete == false then
      return false
    end
  end
  return true
end
