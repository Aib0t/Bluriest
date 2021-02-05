GUI = {
  finished = false,
  safety_timer = UIGlobals.ResetTimerAfterWrecked - 0.3 - 0.3,
  wreck_screen_enabled = false,
  has_jump_the_gun = false
}
function Init()
  AddSCUI_Elements()
  SetupCorrectWreckedSequence()
  UIScreen.SetScreenTimers(0.3, 0.3)
  UIButtons.TimeLineActive("start", false, 0)
  UIButtons.ChangeText(SCUI.name_to_id.Wrecked_By, "MPL_WRECKED_BY" .. 0)
  UIButtons.ChangeText(SCUI.name_to_id.Wrecked_By_accell, "MPL_WRECKED_BY" .. 0)
  SetupWreckedScreenInfoline()
  UISystem.PlaySound(UIEnums.SoundEffect.WreckedActionIn)
end
function PostInit()
  if Amax.IsNetworkRace() == true then
    if Amax.GetWreckerModLoadout(0) ~= nil then
      for _FORV_5_, _FORV_6_ in ipairs(Amax.GetWreckerModLoadout(0).mods) do
        UIButtons.ChangeTextureUV(SCUI.name_to_id["Wrecker_LoadOut" .. _FORV_5_], 0, 0.03125 * _FORV_6_.type, 1)
        UIButtons.ChangeColour(SCUI.name_to_id["Wrecker_LoadOut" .. _FORV_5_], UIGlobals.CategoryColour[_FORV_6_.category])
        UIButtons.ChangeTextureUV(SCUI.name_to_id["Wrecker_LoadOut_accell" .. _FORV_5_], 0, 0.03125 * _FORV_6_.type, 1)
        UIButtons.ChangeColour(SCUI.name_to_id["Wrecker_LoadOut_accell" .. _FORV_5_], UIGlobals.CategoryColour[_FORV_6_.category])
      end
    end
    if true == true and Amax.IsRaceMpDestruction() == true and NetRace.IsTeamGame() == false then
      UIButtons.ChangeText(SCUI.name_to_id.WreckerMods, UIText.MP_RIVAL_MODS)
      UIButtons.ChangeText(SCUI.name_to_id.WreckerMods_accell, UIText.MP_RIVAL_MODS)
    end
  end
  if true == false then
    UIButtons.SetActive(SCUI.name_to_id.Loadout, false)
    UIButtons.SetActive(SCUI.name_to_id.Loadout_accell, false)
  end
  UIButtons.TimeLineActive("show_wrecked", true, 0)
  UIScreen.AddMessageNow(UIEnums.GameMessage.SetLocalPlayerIndex, 0)
  if Multiplayer.IsElimination() then
    print("Is Elimination")
    UIButtons.ChangeText(SCUI.name_to_id.Wrecked, UIText.MP_ELIMINATED)
    UIButtons.ChangeText(SCUI.name_to_id.Wrecked_accell, UIText.MP_ELIMINATED)
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
  if _ARG_0_ == UIEnums.GameFlowMessage.Respawn and _ARG_1_ == 0 and IsSplitScreen() == false then
    GUI.finished = true
    EndScreen()
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  GUI.safety_timer = GUI.safety_timer - _ARG_0_
  if GUI.safety_timer <= 0 then
    GUI.finished = true
    EndScreen()
  end
end
function SetupWreckedScreenInfoline()
  if Amax.IsNetworkRace() == true then
    SetupInfoLine(UIText.INFO_BACK_SHOW_SCORES)
  else
    SetupInfoLine()
  end
end
function EndLoop(_ARG_0_)
end
function End()
  if Amax.IsNetworkRace() == true then
    SetupInfoLine()
  end
  UIButtons.TimeLineActive("start", true)
end
function SetupCorrectWreckedSequence()
  safety_timer = Amax.GetWreckedSequenceDuration(0) - 0.3 - 0.3
  GUI.has_jump_the_gun = Amax.PlayerHasJumpTheGun(0)
  if GUI.has_jump_the_gun == true then
    if Amax.PlayerHasLastGasp(0) == false then
      print("but player does NOT have Last gasp mod")
      UIButtons.SetActive(SCUI.name_to_id.WreckedRenderBranch, false)
      UIButtons.SetActive(SCUI.name_to_id.WreckedRenderBranch_Accellerated, true)
      if GUI.has_jump_the_gun == true then
        UIButtons.SetActive(SCUI.name_to_id.jump_the_gun_icon_accell, true)
      end
    else
      UIButtons.SetActive(SCUI.name_to_id.WreckedRenderBranch, false)
      UIButtons.SetActive(SCUI.name_to_id.WreckedRenderBranch_Accellerated, false)
    end
  end
end
