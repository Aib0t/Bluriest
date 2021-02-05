GUI = {finished = false, countdown = 5}
function Init()
  AddSCUI_Elements()
  for _FORV_7_ = 1, #UIGlobals.Splitscreen.players do
    UIButtons.ChangePosition({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], 0, 0, 0)
    UIButtons.SetParent({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], SCUI.name_to_id.centre, UIEnums.Justify.TopLeft)
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "frame"), "locked")
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "name"), "locked")
    UIButtons.ChangeColour({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "locked")
    UIButtons.SetXtVar({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "time_lines.0.time.end", UIButtons.GetXtVar({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "time_lines.0.time.end") + (UIButtons.GetXtVar({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "time_lines.0.time.end") - UIButtons.GetXtVar({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "time_lines.0.time.start") - 0.1) * (_FORV_7_ - 1))
    UIButtons.SetXtVar({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "time_lines.0.time.start", UIButtons.GetXtVar({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "time_lines.0.time.start") + (UIButtons.GetXtVar({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "time_lines.0.time.end") - UIButtons.GetXtVar({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_7_], "time_lines.0.time.start") - 0.1) * (_FORV_7_ - 1))
  end
  for _FORV_9_ = 1, #Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true))) do
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "position"), "GAME_POS_" .. Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].pos)
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "name"), "PROFILE_PAD" .. UIGlobals.Splitscreen.players[Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index].pad .. "_NAME")
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "points"), "MPL_SPLITSCREEN" .. Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index - 1 .. "_POINTS_RACE")
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "frame"), UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index].pad])
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "name"), UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index].pad])
    UIButtons.ChangeColour({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "!255 255 255 255")
    UIButtons.SetAlphaIntensity({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], nil, 1)
    UIButtons.SetAlphaIntensity(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "name"), nil, 1)
    UIButtons.SetAlphaIntensity(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "frame"), nil, 1)
    LocalGamerPicture({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], UIGlobals.Splitscreen.players[Splitscreen_GetSortedScores((_FOR_.GetSplitscreenScores(true)))[_FORV_9_].player_index].pad)
    UIButtons.SetActive(UIButtons.FindChildByName({
      [_FORV_7_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpSplitscreenResults.lua", "gamer_picture")
    }[_FORV_9_], "position"), true)
  end
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.gamer_picture, false, true)
end
function FrameUpdate(_ARG_0_)
  GUI.countdown = GUI.countdown - _ARG_0_
  if GUI.countdown <= 0 then
    GUI.countdown = 0
    GoScreen("Multiplayer\\Ingame\\MpRaceAwards.lua")
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
end
function EnterEnd()
end
function End()
end
