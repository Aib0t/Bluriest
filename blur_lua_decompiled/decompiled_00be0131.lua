GUI = {
  finished = false,
  countdown = 10,
  team_names = {
    team_a = UIText.MP_TEAM_A_NAME,
    team_b = UIText.MP_TEAM_B_NAME
  },
  team_results = {
    team_a = "MPL_TEAM_A_RESULT",
    team_b = "MPL_TEAM_B_RESULT"
  }
}
function Init()
  AddSCUI_Elements()
  UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpRaceResults.lua", "MpBgStuff")
  SetupInfoLine(UIText.INFO_QUIT_RACE)
  GUI.results = Multiplayer.GetTeamResults()
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "table_dummy"), SCUI.name_to_id.top_dummy, UIEnums.Justify.MiddleCentre)
  MpTeamResults_SetupTeamResults(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "table_dummy"), GUI.results.winner, GUI.results[GUI.results.winner])
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "table_dummy"), SCUI.name_to_id.bottom_dummy, UIEnums.Justify.MiddleCentre)
  MpTeamResults_SetupTeamResults(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "table_dummy"), GUI.results.loser, GUI.results[GUI.results.loser])
  UISystem.PlaySound(UIEnums.SoundEffect.Toggle)
end
function StartLoop(_ARG_0_)
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.table_dummy, false, true)
  UIButtons.SetActive(SCUI.name_to_id.player_node, false, true)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack then
    SetupCustomPopup(UIEnums.CustomPopups.ExitRace)
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  GUI.countdown = GUI.countdown - _ARG_0_
  if GUI.countdown <= 0 then
    GUI.countdown = 0
    if net_Disconnecting() == false then
      if Amax.IsGameModeRanked() == true then
        GoScreen("Multiplayer\\Ingame\\MpProgression.lua")
      else
        GoScreen("Multiplayer\\Ingame\\MpRaceAwards.lua")
      end
    end
  end
end
function MpTeamResults_SetupTeamResults(_ARG_0_, _ARG_1_, _ARG_2_)
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "title"), GUI.team_names[_ARG_1_])
  UIButtons.ChangeText(UIButtons.FindChildByName(_ARG_0_, "result"), GUI.team_results[_ARG_1_])
  UIButtons.ChangeTextureUV(UIButtons.FindChildByName(_ARG_0_, "icon"), 0, UIGlobals.TeamIcons[_ARG_1_].u, UIGlobals.TeamIcons[_ARG_1_].v)
  UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "icon"), UIGlobals.TeamColours[_ARG_1_])
  UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "title"), UIGlobals.TeamColours[_ARG_1_])
  for _FORV_11_ = 1, 10 do
    UIButtons.SetActive(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "backing"), _FORV_11_ % 2 == 0)
    UIButtons.AddListItem(UIButtons.FindChildByName(_ARG_0_, "players"), {
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_])
  end
  for _FORV_11_, _FORV_12_ in ipairs(_ARG_2_) do
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "position"), "MPL_RESULT_POSITION" .. _FORV_12_.index)
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "name"), "MPL_RESULT_NAME" .. _FORV_12_.index)
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "rank"), "MPL_RESULT_RANK" .. _FORV_12_.index)
    UIButtons.ChangeText(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "result"), "MPL_RESULT_SCORE" .. _FORV_12_.index)
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "position"), UIGlobals.TeamColours[_ARG_1_])
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "name"), UIGlobals.TeamColours[_ARG_1_])
    UIButtons.ChangeColour(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "result"), UIGlobals.TeamColours[_ARG_1_])
    UIButtons.SetActive(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "rank"), true, true)
    Mp_RankIcon(UIButtons.FindChildByName({
      [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
    }[_FORV_11_], "rank_icon"), _FORV_12_.rank, _FORV_12_.legend)
    if _FORV_12_.player then
      UIButtons.ChangeColour(UIButtons.FindChildByName({
        [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
      }[_FORV_11_], "position"), "Support_4")
      UIButtons.ChangeColour(UIButtons.FindChildByName({
        [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
      }[_FORV_11_], "name"), "Support_4")
      UIButtons.ChangeColour(UIButtons.FindChildByName({
        [_FORV_11_] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpTeamResults.lua", "player_node")
      }[_FORV_11_], "result"), "Support_4")
    end
  end
end
