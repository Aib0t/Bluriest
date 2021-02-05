GUI = {
  finished = false,
  CurrentPack = -1,
  CurrentChallenge = -1,
  CurrentClass = -1,
  CurrentCar = -1,
  ProgressSize = 0,
  Challenges = {},
  Cars = {},
  PackDummys = {},
  ChallengeNodes = {},
  CarClassNodes = {},
  CarChallengeNodes = {},
  RewardNodes = {},
  WinnerRewardNodes = {},
  RepeatRewardNodes = {},
  State = {
    Packs = 1,
    Challenges = 2,
    CarClass = 3,
    CarChallenges = 4
  },
  CurrentState = 1,
  Classes = {
    [1] = UIEnums.MpVehicleClass.ClassA,
    [2] = UIEnums.MpVehicleClass.ClassB,
    [3] = UIEnums.MpVehicleClass.ClassC,
    [4] = UIEnums.MpVehicleClass.ClassD
  },
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  if UIGlobals.Multiplayer.InLobby == true then
    PlaySfxGraphicBack()
  else
    PlaySfxGraphicNext()
  end
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_3", UIGlobals.CameraLerpTime, 0)
  StoreInfoLine()
  SetupInfoLine()
  if UIGlobals.Multiplayer.InLobby == false then
    net_SetRichPresence(UIEnums.RichPresence.Challenges)
  end
  GUI.ChallengeMenuID = SCUI.name_to_id.challenges
  GUI.CarClassMenuID = SCUI.name_to_id.car_classes
  GUI.CarChallengesMenuID = SCUI.name_to_id.car_challenges
  GUI.ChallengeNameID = SCUI.name_to_id.challenge_name
  GUI.ChallengeDescID = SCUI.name_to_id.challenge_desc
  GUI.ChallengeProgressID = SCUI.name_to_id.challenge_amount
  GUI.ProgressSize = UIButtons.GetSize(SCUI.name_to_id.backing)
  GUI.CarRewards = Multiplayer.GetCarChallengeRewards()
  GUI.PacksMenuID = SCUI.name_to_id.packs
  GUI.Packs = Multiplayer.GetChallengePacks()
  for _FORV_4_, _FORV_5_ in ipairs(GUI.Packs) do
    UIButtons.AddListItem(GUI.PacksMenuID, UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), _FORV_5_.category, _FORV_5_.locked)
    if _FORV_5_.locked then
      UIButtons.LockNode((UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item")))
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "text"), "locked")
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "icon"), "locked")
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "pack_frame"), "locked")
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "backing"), "locked")
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "progress"), "locked")
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "text"), "MPL_ABILITY_LOCKED" .. _FORV_5_.level + 1)
      UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "icon"), "style_mixed")
    else
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "text"), _FORV_5_.name)
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "helptext"), _FORV_5_.desc)
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "pack_counter"), "MPL_CHALLENGE_PACK" .. _FORV_4_ .. "_PROGRESS")
      UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), "icon"), _FORV_5_.icon_name)
      SetupProgressBar(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item"), _FORV_5_.progress)
      if Multiplayer.GetNewChallengePacksMap()[_FORV_4_] == true then
        Mp_ShowItemNew(GUI.PacksMenuID, _FORV_4_ - 1)
      end
    end
    GUI.PackDummys[_FORV_4_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_item")
  end
  for _FORV_4_ = 1, 16 do
    GUI.ChallengeNodes[_FORV_4_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_challenge")
    UIButtons.AddListItem(GUI.ChallengeMenuID, GUI.ChallengeNodes[_FORV_4_], _FORV_4_)
  end
  for _FORV_5_, _FORV_6_ in ipairs(GUI.Classes) do
    GUI.CarClassNodes[_FORV_5_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_car_class")
    UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.CarClassNodes[_FORV_5_], "class_icon"), UIGlobals.ClassIcons[_FORV_6_])
    UIButtons.ChangeText(UIButtons.FindChildByName(GUI.CarClassNodes[_FORV_5_], "name"), "MPL_CHALLENGE_CLASS_PROGRESS" .. _FORV_6_)
    UIButtons.AddListItem(GUI.CarClassMenuID, GUI.CarClassNodes[_FORV_5_], _FORV_5_)
    SetupProgressBar(GUI.CarClassNodes[_FORV_5_], _FOR_.GetCarChallengeClasses()[_FORV_5_])
  end
  for _FORV_5_ = 1, 15 do
    GUI.CarChallengeNodes[_FORV_5_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_car_challenge")
    UIButtons.AddListItem(GUI.CarChallengesMenuID, GUI.CarChallengeNodes[_FORV_5_], _FORV_5_)
  end
  for _FORV_7_ = 1, 3 do
    GUI.RewardNodes[_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "fan_node")
    UIShape.ChangeSceneName(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_7_], "icon"), "common_icons")
    UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_7_], "icon"), "fan")
    UIButtons.ChangePosition(GUI.RewardNodes[_FORV_7_], 0.5, -7, 0)
    UIButtons.SetParent(GUI.RewardNodes[_FORV_7_], SCUI.name_to_id.challenge_frame, UIEnums.Justify.BottomLeft)
  end
  for _FORV_8_ = 1, 3 do
    GUI.RepeatRewardNodes[_FORV_8_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "reward_node")
    UIButtons.SetParent(GUI.RepeatRewardNodes[_FORV_8_], SCUI.name_to_id.repeat_offender_frame, UIEnums.Justify.BottomLeft)
    UIButtons.ChangeText(UIButtons.FindChildByName(GUI.RepeatRewardNodes[_FORV_8_], "name"), "MPL_CAR_UPGRADE_TYPE" .. UIEnums.MpUpgradeChallenges.Races .. "_" .. _FORV_8_ - 1)
    UIButtons.ChangePosition(GUI.RepeatRewardNodes[_FORV_8_], 0.5, -4.75, 0)
    UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.RepeatRewardNodes[_FORV_8_], "icon"), UIGlobals.CarUpgradeIcons[GUI.CarRewards.repeat_offender[_FORV_8_]])
    GUI.WinnerRewardNodes[_FORV_8_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "reward_node")
    UIButtons.SetParent(GUI.WinnerRewardNodes[_FORV_8_], SCUI.name_to_id.winner_frame, UIEnums.Justify.BottomLeft)
    UIButtons.ChangeText(UIButtons.FindChildByName(GUI.WinnerRewardNodes[_FORV_8_], "name"), "MPL_CAR_UPGRADE_TYPE" .. UIEnums.MpUpgradeChallenges.Winner .. "_" .. _FORV_8_ - 1)
    UIButtons.ChangePosition(GUI.WinnerRewardNodes[_FORV_8_], 0.5, -4.75, 0)
    UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.WinnerRewardNodes[_FORV_8_], "icon"), UIGlobals.CarUpgradeIcons[GUI.CarRewards.winner[_FORV_8_]])
  end
  if _FOR_.Multiplayer.InLobby == true or Amax.CanUseShare() == false then
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
  else
    SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
  end
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.pack_frame, false, true)
  UIButtons.SetActive(SCUI.name_to_id.fan_reward_node, false)
  UIButtons.SetActive(SCUI.name_to_id.reward_node, false)
  UIButtons.SetActive(SCUI.name_to_id.node_challenge, false)
  UIButtons.SetActive(SCUI.name_to_id.node_car_challenge, false)
  UIButtons.SetActive(SCUI.name_to_id.node_car_class, false)
  UIButtons.ChangePanel(SetupScreenTitle(UIText.MP_CHALLENGES, SCUI.name_to_id.centre, "challenge", "fe_icons"), UIEnums.Panel._3DAA_WORLD, true)
  UIButtons.SetActive(SCUI.name_to_id.darken, UIGlobals.Multiplayer.InLobby)
  UIButtons.SetActive(SCUI.name_to_id.countdown, UIGlobals.Multiplayer.InLobby)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and _ARG_3_ == UIScreen.Context() then
    if GUI.CurrentState == GUI.State.Packs then
      if UIButtons.GetType(_ARG_2_) == UIEnums.ButtonTypes.BOX then
        UIButtons.SetCurrentItemByID(GUI.PacksMenuID, (UIButtons.GetParent((UIButtons.GetParent((UIButtons.GetParent(_ARG_2_)))))))
        if UIButtons.GetSelection(GUI.PacksMenuID) == UIButtons.GetSelection(GUI.PacksMenuID) then
          PlaySfxNext()
          SelectPack(true)
          if GUI.CurrentPack == UIEnums.MpChallengePack.Car then
            GUI.CurrentState = GUI.State.CarClass
          else
            GUI.CurrentState = GUI.State.Challenges
            SetupInfoLine(UIText.INFO_B_BACK)
          end
        end
      end
    elseif GUI.CurrentState == GUI.State.Challenges then
      UIButtons.SetCurrentItemByID(GUI.ChallengeMenuID, (UIButtons.GetParent((UIButtons.GetParent((UIButtons.GetParent((UIButtons.GetParent((UIButtons.GetParent(_ARG_2_)))))))))))
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    if GUI.CurrentState == GUI.State.Packs then
      PlaySfxNext()
      SelectPack(true)
      if GUI.CurrentPack == UIEnums.MpChallengePack.Car then
        GUI.CurrentState = GUI.State.CarClass
        UIButtons.TimeLineActive("change_class", true, 0)
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
      else
        GUI.CurrentState = GUI.State.Challenges
        SetupInfoLine(UIText.INFO_B_BACK)
      end
    elseif GUI.CurrentState == GUI.State.CarClass then
      GUI.CurrentState = GUI.State.CarChallenges
      PlaySfxNext()
      SelectClass(true)
      SetupInfoLine(UIText.INFO_B_BACK)
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    PlaySfxBack()
    if GUI.CurrentState == GUI.State.Packs then
      if UIGlobals.Multiplayer.InLobby == true then
        PopScreen()
      else
        GoScreen("Multiplayer\\MpOnline.lua")
      end
    elseif GUI.CurrentState == GUI.State.Challenges then
      GUI.CurrentState = GUI.State.Packs
      SelectPack(false)
      if UIGlobals.Multiplayer.InLobby == true then
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
      else
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
      end
    elseif GUI.CurrentState == GUI.State.CarClass then
      GUI.CurrentState = GUI.State.Packs
      SelectPack(false)
      if UIGlobals.Multiplayer.InLobby == true then
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
      else
        SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK, "GAME_SHARE_BUTTON")
      end
    elseif GUI.CurrentState == GUI.State.CarChallenges then
      GUI.CurrentState = GUI.State.CarClass
      SelectClass(false)
      SetupInfoLine(UIText.INFO_A_SELECT, UIText.INFO_B_BACK)
    end
  end
  if _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
    if Amax.CanUseShare() == true and UIGlobals.Multiplayer.InLobby == false and GUI.CurrentState == GUI.State.Packs then
      UIGlobals.ShareFromWhatPopup = -1
      SetupCustomPopup(UIEnums.CustomPopups.SharingOptions)
    end
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.SharingOptions then
    StoreScreen(UIEnums.ScreenStorage.FE_SOCIAL_NETWORK, "Multiplayer\\Challenges\\MpChallenges.lua")
    if _ARG_3_ == UIEnums.ShareOptions.Facebook then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPChallengePackComplete, 1, (UIButtons.GetSelectionIndex(GUI.PacksMenuID)))
      GoScreen("Shared\\Facebook.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Twitter then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPChallengePackComplete, 0, (UIButtons.GetSelectionIndex(GUI.PacksMenuID)))
      GoScreen("Shared\\Twitter.lua", UIEnums.Context.Blurb)
    elseif _ARG_3_ == UIEnums.ShareOptions.Blurb then
      Amax.CreateBlurb(UIEnums.SocialNetworkingItemType.MPChallengePackComplete, 2, (UIButtons.GetSelectionIndex(GUI.PacksMenuID)))
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.CurrentState == GUI.State.Packs then
    if GUI.CurrentPack ~= UIButtons.GetSelection(GUI.PacksMenuID) then
      GUI.CurrentPack = UIButtons.GetSelection(GUI.PacksMenuID)
      ChangePack((UIButtons.GetSelection(GUI.PacksMenuID)))
    end
  elseif GUI.CurrentState == GUI.State.Challenges then
    if GUI.CurrentChallenge ~= UIButtons.GetSelection(GUI.ChallengeMenuID) then
      GUI.CurrentChallenge = UIButtons.GetSelection(GUI.ChallengeMenuID)
      if GUI.CurrentPack == UIEnums.MpChallengePack.Car then
      else
        RefreshChallenge((UIButtons.GetSelection(GUI.ChallengeMenuID)))
      end
    end
  elseif GUI.CurrentState == GUI.State.CarClass then
    if GUI.CurrentClass ~= UIButtons.GetSelection(GUI.CarClassMenuID) then
      GUI.CurrentClass = UIButtons.GetSelection(GUI.CarClassMenuID)
      RefreshCarChallengeList((UIButtons.GetSelection(GUI.CarClassMenuID)))
    end
  elseif GUI.CurrentState == GUI.State.CarChallenges and GUI.CurrentCar ~= UIButtons.GetSelection(GUI.CarChallengesMenuID) then
    GUI.CurrentCar = UIButtons.GetSelection(GUI.CarChallengesMenuID)
    RefreshCarChallenge((UIButtons.GetSelection(GUI.CarChallengesMenuID)))
  end
end
function EnterEnd()
  RestoreInfoLine()
  if UIGlobals.Multiplayer.InLobby == true then
    PlaySfxGraphicNext()
  else
    PlaySfxGraphicBack()
  end
end
function End()
  if UIGlobals.Multiplayer.InLobby == true then
    Amax.ChangeUiCamera(UIGlobals.CameraNames.MpLobby, UIGlobals.CameraLerpTime, 0)
  end
end
function ChangePack(_ARG_0_)
  if GUI.CurrentPack == UIEnums.MpChallengePack.Car then
    UIButtons.SetActive(GUI.CarClassMenuID, true)
    UIButtons.SetActive(GUI.ChallengeMenuID, false)
    RefreshCarChallengeList(_ARG_0_)
  else
    UIButtons.SetActive(GUI.CarClassMenuID, false)
    UIButtons.SetActive(GUI.ChallengeMenuID, true)
    RefreshChallengeList(_ARG_0_)
  end
end
function SelectPack(_ARG_0_)
  GUI.CurrentChallenge = -1
  UIButtons.TimeLineActive("select_pack", _ARG_0_)
  UIButtons.SetSelected(GUI.PacksMenuID, not _ARG_0_)
  for _FORV_5_, _FORV_6_ in ipairs(GUI.Packs) do
    if _FORV_5_ == UIButtons.GetSelectionIndex(GUI.PacksMenuID) + 1 then
      UIButtons.PrivateTimeLineActive(GUI.PackDummys[_FORV_5_], "move_up_" .. _FORV_5_, _ARG_0_)
    else
      UIButtons.PrivateTimeLineActive(GUI.PackDummys[_FORV_5_], "slide_out", _ARG_0_)
    end
  end
  if GUI.CurrentPack == UIEnums.MpChallengePack.Car then
    UIButtons.SetSelected(GUI.CarClassMenuID, _ARG_0_)
    UIButtons.TimeLineActive("show_classes", _ARG_0_)
    if _ARG_0_ == true then
      UIButtons.SetSelection(GUI.ChallengeMenuID, 1)
    end
  else
    UIButtons.SetSelected(GUI.ChallengeMenuID, _ARG_0_)
    UIButtons.TimeLineActive("show_challenges", _ARG_0_)
    if _ARG_0_ == true then
      UIButtons.SetSelection(GUI.ChallengeMenuID, 1)
    end
  end
  Multiplayer.ChallengePackViewed(UIButtons.GetSelectionIndex(GUI.PacksMenuID) + 1 - 1)
  Mp_HideItemNew(GUI.PacksMenuID, UIButtons.GetSelectionIndex(GUI.PacksMenuID) + 1 - 1)
end
function SelectClass(_ARG_0_, _ARG_1_)
  UIButtons.TimeLineActive("select_class", _ARG_0_)
  UIButtons.TimeLineActive("show_car_challenge", _ARG_0_)
  for _FORV_6_, _FORV_7_ in ipairs(GUI.Classes) do
    if _FORV_6_ == UIButtons.GetSelectionIndex(GUI.CarClassMenuID) + 1 then
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(GUI.CarClassNodes[_FORV_6_], "frame"), "move_up_" .. _FORV_6_, _ARG_0_)
    else
      UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(GUI.CarClassNodes[_FORV_6_], "frame"), "slide_out", _ARG_0_)
    end
  end
  UIButtons.PrivateTimeLineActive(GUI.PackDummys[UIButtons.GetSelectionIndex(GUI.PacksMenuID) + 1], "slide_out", _ARG_0_)
  UIButtons.SetSelected(GUI.CarClassMenuID, not _ARG_0_)
  UIButtons.SetSelected(GUI.CarChallengesMenuID, _ARG_0_)
  if _ARG_0_ == true then
    UIButtons.SetSelection(GUI.CarChallengesMenuID, 1)
    RefreshCarChallenge(1)
  end
end
function RefreshChallenge(_ARG_0_)
  UIButtons.ChangeText(GUI.ChallengeNameID, "MPL_CHALLENGE" .. GUI.Challenges[_ARG_0_].type .. "_NAME")
  UIButtons.ChangeText(GUI.ChallengeDescID, "MPL_CHALLENGE" .. GUI.Challenges[_ARG_0_].type .. "_DESC")
  UIButtons.ChangeText(GUI.ChallengeProgressID, "MPL_CHALLENGE" .. GUI.Challenges[_ARG_0_].type .. "_PROGRESS")
  SetupProgressBar(SCUI.name_to_id.challenge_frame, GUI.Challenges[_ARG_0_].progress)
  RefreshChallengeRewards(GUI.Challenges[_ARG_0_], _ARG_0_)
end
function RefreshChallengeList(_ARG_0_)
  GUI.Challenges = Multiplayer.GetChallenges(_ARG_0_)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.ChallengeNodes) do
    UIButtons.SetActive(_FORV_5_, false)
  end
  for _FORV_4_, _FORV_5_ in ipairs(GUI.Challenges) do
    UIButtons.SetActive(GUI.ChallengeNodes[_FORV_4_], true)
    UIButtons.ChangeText(UIButtons.FindChildByName(GUI.ChallengeNodes[_FORV_4_], "challenge_name"), "MPL_CHALLENGE" .. _FORV_5_.type .. "_NAME")
    SetupProgressBar(GUI.ChallengeNodes[_FORV_4_], _FORV_5_.progress)
    RefreshChallengeTiers(GUI.ChallengeNodes[_FORV_4_], _FORV_5_)
  end
end
function RefreshCarChallengeList(_ARG_0_)
  GUI.Cars = Multiplayer.GetCarChallenges(_ARG_0_, false)
  for _FORV_5_, _FORV_6_ in ipairs(GUI.CarChallengeNodes) do
    UIButtons.SetActive(_FORV_6_, false)
  end
  for _FORV_5_, _FORV_6_ in ipairs(GUI.Cars) do
    UIButtons.SetActive(GUI.CarChallengeNodes[_FORV_5_], true)
    if _FORV_6_.unlocked == true then
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "car_icon"), true, true)
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "locked_icon"), false)
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "rank_text"), false)
      UIShape.ChangeSceneName(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "car_icon"), _FORV_6_.sheet)
      UIShape.ChangeObjectName(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "car_icon"), _FORV_6_.icon)
      UIButtons.SetNodeItemLocked(GUI.CarChallengesMenuID, _FORV_5_ - 1, false)
      for _FORV_13_, _FORV_14_ in ipairs({
        [1] = "winner",
        [2] = "repeat_offender"
      }) do
        for _FORV_18_ = 1, _FORV_6_[_FORV_14_].tiers do
          if _FORV_18_ < _FORV_6_[_FORV_14_].tier or _FORV_6_[_FORV_14_].complete == true then
            UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], _FORV_14_ .. _FORV_18_), "Support_0")
          elseif _FORV_18_ == _FORV_6_[_FORV_14_].tier then
            UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], _FORV_14_ .. _FORV_18_), "Support_4")
          else
            UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], _FORV_14_ .. _FORV_18_), "Locked")
          end
        end
      end
    else
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "car_icon"), false, true)
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "locked_icon"), true)
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "rank_text"), true)
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.CarChallengeNodes[_FORV_5_], "rank_text"), "MPL_UNLOCK_RANK" .. _FORV_6_.rank_needed)
      UIButtons.SetNodeItemLocked(GUI.CarChallengesMenuID, _FORV_5_ - 1, true)
    end
  end
end
function RefreshCarChallenge(_ARG_0_)
  UIButtons.ChangeText(SCUI.name_to_id.car_name, GUI.Cars[_ARG_0_].name)
  if GUI.Cars[_ARG_0_].texture_square == true then
    UIButtons.SetActive(SCUI.name_to_id.manufacturer_logo_square, true)
    UIButtons.SetActive(SCUI.name_to_id.manufacturer_logo_rect, false)
    UIButtons.ChangeTexture({
      filename = GUI.Cars[_ARG_0_].texture
    }, 0, SCUI.name_to_id.manufacturer_logo_square)
  else
    UIButtons.SetActive(SCUI.name_to_id.manufacturer_logo_square, false)
    UIButtons.SetActive(SCUI.name_to_id.manufacturer_logo_rect, true)
    UIButtons.ChangeTexture({
      filename = GUI.Cars[_ARG_0_].texture
    }, 0, SCUI.name_to_id.manufacturer_logo_rect)
  end
  for _FORV_9_, _FORV_10_ in ipairs({
    [1] = "repeat_offender",
    [2] = "winner"
  }) do
    UIButtons.ChangeText(SCUI.name_to_id[_FORV_10_ .. "_name"], "MPL_CAR_CHALLENGE" .. GUI.Cars[_ARG_0_].id .. "_" .. GUI.Cars[_ARG_0_][_FORV_10_].type .. "_NAME")
    UIButtons.ChangeText(SCUI.name_to_id[_FORV_10_ .. "_desc"], "MPL_CAR_CHALLENGE" .. GUI.Cars[_ARG_0_].id .. "_" .. GUI.Cars[_ARG_0_][_FORV_10_].type .. "_DESC")
    UIButtons.ChangeText(SCUI.name_to_id[_FORV_10_ .. "_amount"], "MPL_CAR_CHALLENGE" .. GUI.Cars[_ARG_0_].id .. "_" .. GUI.Cars[_ARG_0_][_FORV_10_].type .. "_PROGRESS")
    SetupProgressBar(SCUI.name_to_id[_FORV_10_ .. "_frame"], GUI.Cars[_ARG_0_][_FORV_10_].progress)
    for _FORV_14_ = 1, 3 do
      if _FORV_10_ == "winner" then
        if GUI.Cars[_ARG_0_].can_respray == true then
          UIButtons.ChangeText(UIButtons.FindChildByName({
            [1] = GUI.RepeatRewardNodes,
            [2] = GUI.WinnerRewardNodes
          }[_FORV_9_][_FORV_14_], "name"), "MPL_CAR_UPGRADE_TYPE" .. UIEnums.MpUpgradeChallenges.Winner .. "_" .. _FORV_14_ - 1)
          UIShape.ChangeSceneName(UIButtons.FindChildByName({
            [1] = GUI.RepeatRewardNodes,
            [2] = GUI.WinnerRewardNodes
          }[_FORV_9_][_FORV_14_], "icon"), "fe_icons")
          UIShape.ChangeObjectName(UIButtons.FindChildByName({
            [1] = GUI.RepeatRewardNodes,
            [2] = GUI.WinnerRewardNodes
          }[_FORV_9_][_FORV_14_], "icon"), UIGlobals.CarUpgradeIcons[GUI.CarRewards.winner[_FORV_14_]])
        else
          UIButtons.ChangeText(UIButtons.FindChildByName({
            [1] = GUI.RepeatRewardNodes,
            [2] = GUI.WinnerRewardNodes
          }[_FORV_9_][_FORV_14_], "name"), "MPL_CHALLENGE" .. UIEnums.MpUpgradeChallenges.Winner .. "_" .. _FORV_14_ - 1 .. Select(_FORV_14_ == GUI.Cars[_ARG_0_][_FORV_10_].tier, "_FAN_REWARD", "_FANS"))
          UIShape.ChangeSceneName(UIButtons.FindChildByName({
            [1] = GUI.RepeatRewardNodes,
            [2] = GUI.WinnerRewardNodes
          }[_FORV_9_][_FORV_14_], "icon"), "common_icons")
          UIShape.ChangeObjectName(UIButtons.FindChildByName({
            [1] = GUI.RepeatRewardNodes,
            [2] = GUI.WinnerRewardNodes
          }[_FORV_9_][_FORV_14_], "icon"), "fan")
        end
      end
      RefreshCarChallengeRewards({
        [1] = GUI.RepeatRewardNodes,
        [2] = GUI.WinnerRewardNodes
      }[_FORV_9_][_FORV_14_], GUI.Cars[_ARG_0_][_FORV_10_], _FORV_14_)
    end
  end
  Multiplayer.CarChallengeViewed(GUI.Cars[_ARG_0_].id)
end
function RefreshChallengeRewards(_ARG_0_, _ARG_1_)
  for _FORV_5_ = 1, 3 do
    if _FORV_5_ > _ARG_0_.tiers then
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "fans"), UIText.CMN_NOWT)
      UIButtons.SetActive(GUI.RewardNodes[_FORV_5_], false)
    else
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "fans"), "MPL_CHALLENGE" .. _ARG_0_.type .. "_" .. _FORV_5_ - 1 .. "_FANS")
      UIButtons.SetActive(GUI.RewardNodes[_FORV_5_], true)
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "tick"), false)
      if _FORV_5_ < _ARG_0_.tier or _ARG_0_.complete == true then
        UIButtons.SetActive(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "tick"), true)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "icon"), "Support_0", true)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "fans"), "Support_0", true)
      elseif _FORV_5_ == _ARG_0_.tier then
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "icon"), "Support_4", true)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "fans"), "Support_4", true)
        UIButtons.ChangeText(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "fans"), "MPL_CHALLENGE" .. _ARG_0_.type .. "_" .. _FORV_5_ - 1 .. "_FAN_REWARD")
      else
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "icon"), "Locked", true)
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.RewardNodes[_FORV_5_], "fans"), "Locked", true)
      end
    end
  end
end
function RefreshCarChallengeRewards(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ > _ARG_1_.tiers then
    UIButtons.SetActive(_ARG_0_, false)
  else
    UIButtons.SetActive(_ARG_0_, true)
    UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "tick"), false)
    if _ARG_2_ < _ARG_1_.tier or _ARG_1_.complete == true then
      UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "tick"), true)
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "icon"), "Support_0", true)
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "name"), "Support_0", true)
    elseif _ARG_2_ == _ARG_1_.tier then
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "icon"), "Support_4", true)
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "name"), "Support_4", true)
    else
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "icon"), "Locked", true)
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "name"), "Locked", true)
    end
  end
end
function RefreshChallengeTiers(_ARG_0_, _ARG_1_)
  for _FORV_5_ = 1, 3 do
    if _FORV_5_ > _ARG_1_.tiers then
      UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "part_" .. _FORV_5_), false)
    elseif _FORV_5_ < _ARG_1_.tier or _ARG_1_.complete == true then
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "part_" .. _FORV_5_), "Support_0")
      UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "part_" .. _FORV_5_), true)
    elseif _FORV_5_ == _ARG_1_.tier then
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "part_" .. _FORV_5_), "Support_4")
      UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "part_" .. _FORV_5_), true)
    else
      UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "part_" .. _FORV_5_), "Locked")
      UIButtons.SetActive(UIButtons.FindChildByName(_ARG_0_, "part_" .. _FORV_5_), true)
    end
  end
end
function SetupChallenge(_ARG_0_, _ARG_1_, _ARG_2_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_challenge"), "challenge_name"), _ARG_1_)
  UIButtons.AddListItem(GUI.ChallengeMenuID, UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_challenge"), _ARG_0_, not _ARG_2_)
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\Challenges\\MpChallenges.lua", "node_challenge"))
end
function SetupProgressBar(_ARG_0_, _ARG_1_)
  UIButtons.ChangeSize(UIButtons.FindChildByName(_ARG_0_, "progress"), UIButtons.GetSize((UIButtons.FindChildByName(_ARG_0_, "backing"))) * _ARG_1_, UIButtons.GetSize((UIButtons.FindChildByName(_ARG_0_, "progress"))))
end
