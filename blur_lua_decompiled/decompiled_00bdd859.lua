GUI = {
  finished = false,
  can_leave = false,
  countdown = 5,
  scoreboard_writetime = 0
}
function Init()
  AddSCUI_Elements()
  UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceResults.lua", "MpBgStuff")
  UIScreen.SetScreenTimers(0, 0.3)
  GUI.timeout_id = SCUI.name_to_id.countdown
  GUI.GamerPictures = Profile.GetRemoteGamerPictureMap()
  GUI.race_awards = Multiplayer.GetRaceAwards()
  Multiplayer.PostFlaggedDataEvents()
  y = -4
  for _FORV_5_, _FORV_6_ in ipairs(GUI.race_awards) do
    UIButtons.ChangePosition(Awards_SetupAward(_FORV_6_, _FORV_5_), -(35 * ((#GUI.race_awards - 1) / 2)), y, 0)
    UIButtons.SetXtVar(Awards_SetupAward(_FORV_6_, _FORV_5_), "time_lines.0.time.end", UIButtons.GetXtVar(Awards_SetupAward(_FORV_6_, _FORV_5_), "time_lines.0.time.end") + (UIButtons.GetXtVar(Awards_SetupAward(_FORV_6_, _FORV_5_), "time_lines.0.time.end") - UIButtons.GetXtVar(Awards_SetupAward(_FORV_6_, _FORV_5_), "time_lines.0.time.start") - 0.15) * (_FORV_5_ - 1))
    UIButtons.SetXtVar(Awards_SetupAward(_FORV_6_, _FORV_5_), "time_lines.0.time.start", UIButtons.GetXtVar(Awards_SetupAward(_FORV_6_, _FORV_5_), "time_lines.0.time.start") + (UIButtons.GetXtVar(Awards_SetupAward(_FORV_6_, _FORV_5_), "time_lines.0.time.end") - UIButtons.GetXtVar(Awards_SetupAward(_FORV_6_, _FORV_5_), "time_lines.0.time.start") - 0.15) * (_FORV_5_ - 1))
  end
  if Amax.GetGameMode() ~= UIEnums.GameMode.SplitScreen then
    net_EnableGlobalUpdate(false)
    Amax.StartScoreboardWrite()
    print("Writing to scoreboard")
  end
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.award_node, false)
  if IsSplitScreen() == true then
    UIButtons.SetActive(SCUI.name_to_id.countdown, false)
  else
    SetupInfoLine(UIText.INFO_QUIT_RACE)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and IsSplitScreen() == false then
    SetupCustomPopup(UIEnums.CustomPopups.ExitRace)
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if IsSplitScreen() == true then
    GUI.countdown = GUI.countdown - _ARG_0_
    if GUI.countdown <= 0 then
      GUI.countdown = 0
      StopIngameMusic()
      GoScreen("Loading\\LoadingUI.lua")
    end
  end
  if Amax.GetGameMode() ~= UIEnums.GameMode.SplitScreen then
    if GUI.can_leave == false then
      GUI.scoreboard_writetime = GUI.scoreboard_writetime + _ARG_0_
      if Amax.ScoreboardWriteComplete() == true or GUI.scoreboard_writetime > 15 then
        print("Scoreboard write finished. Time : ", GUI.scoreboard_writetime)
        EnableLeave()
      end
    elseif NetRace.CanStartResultsCountdown() == true then
      GUI.countdown = GUI.countdown - _ARG_0_
      if math.ceil(GUI.countdown) ~= math.ceil(GUI.countdown) and 0 < math.ceil(GUI.countdown) then
        if math.ceil(GUI.countdown) <= 3 then
          UISystem.PlaySound(UIEnums.SoundEffect.CountDown03)
        elseif math.ceil(GUI.countdown) <= 10 then
          UISystem.PlaySound(UIEnums.SoundEffect.CountDown)
        end
      end
      if GUI.countdown <= 0 then
        GUI.countdown = 0
        if net_Disconnecting() == false then
          StopIngameMusic()
          GoScreen("Loading\\LoadingUI.lua")
          StartAsyncSave()
        end
      end
      UIButtons.ChangeText(GUI.timeout_id, "MPL_RETURN_TO_LOBBY" .. math.ceil(GUI.countdown))
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  UIScreen.CancelPopup()
end
function Awards_SetupAward(_ARG_0_, _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "name"), _ARG_0_.name)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "desc"), _ARG_0_.description)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "amount"), "MPL_AWARDS_AMOUNT" .. _ARG_1_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "gamertag"), "MPL_AWARDS_OWNER" .. _ARG_1_)
  if _ARG_0_.tied == true then
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "tied_notification"), true)
  end
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "icon"), _ARG_0_.icon_name)
  if IsSplitScreen() == true then
    LocalGamerPicture(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "gamerpic"), _ARG_0_.pad_index)
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "gamertag"), UIGlobals.Splitscreen.colours[_ARG_0_.pad_index])
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "frame"), UIGlobals.Splitscreen.colours[_ARG_0_.pad_index])
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "name"), UIGlobals.Splitscreen.colours[_ARG_0_.pad_index])
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "icon"), UIGlobals.Splitscreen.colours[_ARG_0_.pad_index])
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "rank"), false, true)
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "tied_notification"), false)
  else
    if _ARG_0_.local_player == true then
      LocalGamerPicture(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "gamerpic"), Profile.GetPrimaryPad())
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "gamertag"), "Support_4")
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "frame"), "Support_4")
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "name"), "Support_4")
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "icon"), "Support_4")
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "tied_notification"), "Support_4")
    else
      RemoteGamerPicture(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "gamerpic"), GUI.GamerPictures[_ARG_0_.join_ref])
    end
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "rank"), "MPL_AWARDS_RANK" .. _ARG_1_)
    Mp_RankIcon(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "rank_icon"), _ARG_0_.rank, _ARG_0_.legend)
  end
  if _ARG_1_ % 2 == 1 then
    UIButtons.SetAlphaIntensity(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"), "backing"), nil, 0.45)
  end
  return (UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceAwards.lua", "award_node"))
end
function EnableLeave()
  if GUI.can_leave == false then
    NetRace.EnterResultsIdle()
    net_EnableGlobalUpdate(true)
    GUI.can_leave = true
  end
end
