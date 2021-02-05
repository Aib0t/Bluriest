GUI = {
  finished = false,
  timeout = 5.75,
  friend_demand = false
}
function Init()
  UIScreen.SetScreenTimers(1, UIGlobals.screen_time.default_end)
  net_LockoutFriendsOverlay(true)
  AddSCUI_Elements()
  Amax.StartAnimatedCamera(UIEnums.AnimatedCameraSequenceType.MpWinner, false, 0, 0)
  UIGlobals.FriendDemandSent = false
  if UIScreen.IsContextActive(UIEnums.Context.SpWrecked) == true then
    UIScreen.SetScreenTimers(0, 0, UIEnums.Context.SpWrecked)
    EndScreen(UIEnums.Context.SpWrecked)
  end
end
function PostInit()
  if IsTable((Amax.SP_GetLevelResult())) ~= true then
    return
  end
  if Amax.SP_IsStreetRaceFD() == true or Amax.SP_IsDestructionFD() == true or Amax.SP_IsCheckpointFD() == true or Amax.SP_IsFanDemandFD() == true or Amax.SP_IsBossBattleFD() == true then
    GUI.friend_demand = true
  end
  UIButtons.ChangeColour(SCUI.name_to_id.Pos_Place, GetResultColour(Amax.SP_GetLevelResult().state))
  if (Amax.SP_IsCheckpointRace() == true or Amax.SP_IsCheckpointFD() == true) and Amax.SP_GetLevelResult().state == "none" then
  else
    UIButtons.ChangeText(SCUI.name_to_id.Pos_Place, "HUD_SP_RACE_RESULT")
  end
  if GUI.friend_demand == false then
    UIButtons.ChangeText(SCUI.name_to_id.medal_result_text, "SPL_EVENT_" .. UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent] .. "_PRIMARY_GOAL_" .. Sp_EventStateToNumber(Amax.SP_GetLevelResult().state))
  else
    UIButtons.ChangeText(SCUI.name_to_id.medal_result_text, "SPL_EVENT_" .. FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).eventid_sp .. "_PRIMARY_GOAL_" .. Sp_EventStateToNumber(Amax.SP_GetLevelResult().state) .. "_" .. FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex, false, true).difficulty)
  end
  if GUI.friend_demand == true then
    if FriendDemand.IsComplete() == 0 then
      UIButtons.ChangeText(SCUI.name_to_id.Finished, UIText.FDE_FAILED)
    elseif FriendDemand.IsComplete() == 1 then
      UIButtons.ChangeText(SCUI.name_to_id.Finished, UIText.FDE_PASSED)
      Amax.CheckStickerProgress(UIEnums.StickerType.BeatFriendDemand)
    elseif FriendDemand.IsComplete() == 2 then
      UIButtons.ChangeText(SCUI.name_to_id.Finished, UIText.FDE_KO)
      Amax.CheckStickerProgress(UIEnums.StickerType.BeatFriendDemand)
    end
  else
    UIButtons.ChangeText(SCUI.name_to_id.Finished, Select(Amax.SP_GetLevelResult().state == "none", UIText.FDE_FAILED, UIText.FDE_PASSED))
  end
  UIButtons.SetActive(SCUI.name_to_id["swirl_" .. Amax.SP_GetLevelResult().state], true)
  SpFinished_CreatePrimaryLights(SCUI.name_to_id.light_dummy, Amax.SP_GetLevelResult().state)
  UIButtons.TimeLineActive("show_result", true)
  UIButtons.TimeLineActive("show_finished", true, 0)
  if Amax.SP_IsDestructionRace() == true or Amax.SP_IsDestructionFD() == true then
    UISystem.PlaySound(Select(Amax.SP_GetLevelResult().state == "none", UIEnums.SoundEffect.DestructionFail, UIEnums.SoundEffect.DestructionPass))
  elseif Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true then
    UISystem.PlaySound(Select(Amax.SP_GetLevelResult().state == "none", UIEnums.SoundEffect.BossRaceLose, UIEnums.SoundEffect.BossRaceWin))
  else
    UISystem.PlaySound(Select(Amax.SP_GetLevelResult().state == "none", UIEnums.SoundEffect.RaceTargetFailed, UIEnums.SoundEffect.RaceTargetPass))
  end
  if Amax.SP_GetLevelResult().state ~= "none" then
    UISystem.PlaySound(UIEnums.SoundEffect.PostRacePassedLightTrail)
  end
  UIGlobals.DoResults = true
end
function SpFinished_CreatePrimaryLights(_ARG_0_, _ARG_1_)
  for _FORV_9_ = 1, SP_MaxStars(Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true) do
    UIButtons.SetParent(Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12), _ARG_0_, UIEnums.Justify.TopRight)
    UIButtons.ChangePanel(Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12), UIEnums.Panel._2DAA, true)
    UIButtons.ChangeJustification(Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12), UIEnums.Justify.MiddleCentre)
    UIButtons.ChangeScale(Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12), 12, 12)
    if _FORV_9_ == 1 then
      _, _ = UIButtons.GetSize((Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12)))
    end
    UIButtons.ChangePosition(Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12), UIButtons.GetPosition((Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12))) - (SP_MaxStars(Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true) - 1) * UIButtons.GetSize((Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12))) * 13 * 0.5, UIButtons.GetPosition((Sp_CreateStar(_FORV_9_ <= Sp_EventStateToStars(_ARG_1_, Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true), _FORV_9_, _ARG_1_, nil, nil, 12))))
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext then
    SpFinished_End()
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  GUI.timeout = GUI.timeout - _ARG_0_
  if GUI.timeout <= 0 then
    SpFinished_End()
  end
end
function SpFinished_End()
  if GUI.friend_demand == true then
    GoScreen("SinglePlayer\\Ingame\\SpFriendDemand.lua")
  else
    GoScreen("SinglePlayer\\Ingame\\SpRaceAwards.lua")
  end
end
function EnterEnd()
end
function EndLoop(_ARG_0_)
end
function End()
end
