GUI = {
  finished = false,
  allow_pause = true,
  automation_start = true,
  num_players = 1,
  vertical_split = false,
  item_table = {},
  vp_table = {},
  vp_table_prev = {},
  ai_hud_ids = {},
  safe_2d_ids = {},
  safe_3d_ids = {},
  inter_2d_ids = {},
  inter_3d_ids = {},
  revs_partial_ids = {},
  time_id = -1,
  going_to_pause_pad = -1,
  mp_rivals_ids = {},
  ss_timer_ids = {},
  mp_finished_ids = {},
  mp_eliminated_ids = {},
  mp_wrecked_ids = {},
  fan_msg_ids = {},
  mp_destruction_positions = {},
  mp_destruction_ids = {},
  mp_network_elimination_on = false,
  mp_network_elimination_me = false,
  mp_network_current_fans = -1,
  mp_network_current_rank = -1,
  is_network_race = false,
  mp_ss_finished_ids = {},
  mp_ss_wrecked_ids = {},
  mp_ss_messages = {},
  mp_fan_msg_root = {},
  mp_fan_msg_rb = {},
  mp_rank_up_ids = {},
  mp_challenge_complete_ids = {},
  mp_rank_or_challenge_stack = {},
  mp_fan_msg_activate_in = {},
  sp = {},
  fan_combo_ids = {},
  fan_combo_timer = {},
  fan_combo_sy = -1,
  fan_combo_py = -1,
  fan_combo_tex = {
    filename = "hud_main",
    pos = {u = 0.3125, v = 0.125},
    size = {u = 0.0625, v = 0.125}
  },
  LastGaspPowerupSlotID = nil,
  jump_the_gun_standalone_ID = nil
}
function Init()
  Splitscreen_AddSplits()
  GUI.is_network_race = Amax.IsNetworkRace()
  Amax.SetGlobalFade(1)
  UIScreen.SetScreenTimers(0.3, 0.15)
  net_SetRichPresence(UIEnums.RichPresence.InRace)
  GUI.num_players = Amax.GetNumViewports()
  UISystem.LoadLuaScript("Screens\\Ingame\\HUD_Helpers.lua")
  HUD.SetupPlayerViewports()
  if IsSplitScreen() == true then
    Profile.LockToPad(-1)
    Profile.SetPrimaryPad(UIGlobals.Splitscreen.primary_pad)
  end
  UIScreen.AddMessageNow(UIEnums.GameMessage.SetLocalPlayerIndex, 0)
  if Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false then
    UIGlobals.Ingame.last_gasp_mode_active = Amax.LastGaspModeActive(0)
    UIGlobals.Ingame.can_fire_last_gasp = Amax.LastGaspModeActive(0)
    UIGlobals.Ingame.has_last_gasp = Amax.PlayerHasLastGasp(0)
    UIGlobals.Ingame.has_jump_the_gun = Amax.PlayerHasJumpTheGun(0)
    if UIGlobals.Ingame.last_gasp_timer == nil or 0 >= UIGlobals.Ingame.last_gasp_timer then
      UIGlobals.Ingame.last_gasp_timer = Amax.GetLastGaspTime(0)
    end
  end
end
function EnableIntroItems(_ARG_0_)
end
function PostInit()
  GUI.show_revs = Amax.ShowRevs()
  GUI.show_camera_helpers = Amax.ShowCameraHelpers()
  if IsSplitScreen() == false and Amax.IsRaceMpDestruction() == true then
  end
  for _FORV_3_ = 1, GUI.num_players do
    UIButtons.ReplaceTimeLineLabel({
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Fade"),
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Flash"),
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_FlashGraphic")
    }[1], "HoG_fade", "HoG_fade_" .. _FORV_3_ - 1)
    UIButtons.ReplaceTimeLineLabel({
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Fade"),
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Flash"),
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_FlashGraphic")
    }[2], "Flash_fade", "Flash_fade_" .. _FORV_3_ - 1)
    UIButtons.ReplaceTimeLineLabel({
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Fade"),
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Flash"),
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_FlashGraphic")
    }[3], "FlashGraphic_fade", "FlashGraphic_fade_" .. _FORV_3_ - 1)
    for _FORV_15_, _FORV_16_ in ipairs({
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Fade"),
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Flash"),
      UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_FlashGraphic")
    }) do
      UIButtons.ChangeSize(_FORV_16_, GetScreenBounds(GUI.num_players, _FORV_3_, false) - GetScreenBounds(GUI.num_players, _FORV_3_, false), GetScreenBounds(GUI.num_players, _FORV_3_, false) - GetScreenBounds(GUI.num_players, _FORV_3_, false))
      UIButtons.ChangePosition(_FORV_16_, GetScreenBounds(GUI.num_players, _FORV_3_, false) + (GetScreenBounds(GUI.num_players, _FORV_3_, false) - GetScreenBounds(GUI.num_players, _FORV_3_, false)) / 2, GetScreenBounds(GUI.num_players, _FORV_3_, false) + (GetScreenBounds(GUI.num_players, _FORV_3_, false) - GetScreenBounds(GUI.num_players, _FORV_3_, false)) / 2)
    end
    if 1 < GUI.num_players then
      for _FORV_16_, _FORV_17_ in ipairs({
        UIButtons.CloneXtGadgetByName("hud_objects", "Clip_Push_41"),
        UIButtons.CloneXtGadgetByName("hud_objects", "Clip_Push_14"),
        UIButtons.CloneXtGadgetByName("hud_objects", "Clip_Push_31")
      }) do
        UIButtons.SetXtVar(_FORV_17_, "render_state.clip_pos.vx", GetScreenBounds(GUI.num_players, _FORV_3_, false))
        UIButtons.SetXtVar(_FORV_17_, "render_state.clip_pos.vy", GetScreenBounds(GUI.num_players, _FORV_3_, false))
        UIButtons.SetXtVar(_FORV_17_, "render_state.clip_size.vx", GetScreenBounds(GUI.num_players, _FORV_3_, false) - GetScreenBounds(GUI.num_players, _FORV_3_, false))
        UIButtons.SetXtVar(_FORV_17_, "render_state.clip_size.vy", GetScreenBounds(GUI.num_players, _FORV_3_, false) - GetScreenBounds(GUI.num_players, _FORV_3_, false))
      end
    end
    GUI.safe_2d_ids[_FORV_3_] = UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE")
    GUI.safe_3d_ids[_FORV_3_] = UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE")
    GUI.inter_2d_ids[_FORV_3_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate")
    GUI.inter_3d_ids[_FORV_3_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate")
    UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), UIButtons.GetSize(HUD.ViewportId[_FORV_3_]))
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), HUD.ViewportId[_FORV_3_], UIEnums.Justify.MiddleCentre)
    UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIButtons.GetSize(HUD.ViewportId3d[_FORV_3_]))
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), HUD.ViewportId3d[_FORV_3_], UIEnums.Justify.MiddleCentre)
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "FanMsg_Main_RB"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), UIEnums.Justify.TopCentre)
    GUI.mp_fan_msg_root[_FORV_3_] = UIButtons.CloneXtGadgetByName("hud_objects", "FanMsg_Main_RB")
    GUI.mp_fan_msg_rb[_FORV_3_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "FanMsg_Main_RB"), "bra_FanRoot")
    if Amax.ShowAiNames() == false then
      UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "FanMsg_Main_RB"), "dmy_FanBonus"), UIButtons.GetPosition((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "FanMsg_Main_RB"), "dmy_FanBonus"))))
    end
    GUI.mp_fan_msg_activate_in[_FORV_3_] = -1
    if IsSplitScreen() == true then
      UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), "Perks_MainHUD"), "bender", 0)
      if GUI.num_players == 4 then
        UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), "Perks_MainHUD"), Select(math.mod(_FORV_3_, 2) == 1, -2.2, 2.2), nil, nil, true)
      elseif GUI.num_players > 2 and _FORV_3_ > 1 then
        UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), "Perks_MainHUD"), Select(math.mod(_FORV_3_, 2) == 0, -2.2, 2.2), nil, nil, true)
      end
    else
      UIButtons.CloneXtGadgetByName("hud_objects", "Perks_Dummy")
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "ProgressMessage"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), UIEnums.Justify.BottomLeft)
      if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer and SP_IsFriendDemand() == false then
        AIGamerPicture(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "ProgressMessage"), "ProgressBossPic"), UIGlobals.boss_avatar_ids[SinglePlayer.EventInfo(UIGlobals.Sp.TierInfo[UIGlobals.Sp.CurrentTier].events[UIGlobals.Sp.CurrentEvent]).tier])
      end
    end
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopRight)
    Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), "Map_SpeedNumber"), "HUD_" .. _FORV_3_ - 1 .. "_SPEED_MPH")
    UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad"), UIEnums.Panel._RT0 + (_FORV_3_ - 1))
    UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad_Alt"), UIEnums.Panel._RT0 + (_FORV_3_ - 1))
    UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad"), "name", "shp_MiniMapRoad" .. _FORV_3_ - 1)
    UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad_Alt"), "name", "shp_MiniMapRoad_Alt" .. _FORV_3_ - 1)
    UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "dmy_MiniMapTranslate"), "name", "dmy_MiniMapTranslate" .. _FORV_3_ - 1)
    UIButtons.SetXtVar(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "name", "dmy_MiniMapScale" .. _FORV_3_ - 1)
    UIButtons.ChangeTexture({
      filename = "MINIMAP_RT" .. _FORV_3_ - 1
    }, 5, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), "Map_Main")))
    if GUI.show_revs == true then
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Revs"), UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), UIEnums.Justify.MiddleCentre)
      GUI.revs_partial_ids[_FORV_3_] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Revs"), "Map_RevsPartial")
    end
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Fans_Icon"), UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), UIEnums.Justify.BottomRight)
    Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), "Fans_Number"), "HUD_" .. _FORV_3_ - 1 .. "_FANS")
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Fans_BackingTop"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopRight)
    GUI.fan_combo_ids[#GUI.fan_combo_ids + 1] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Fans_Icon"), "Combo_Icon")
    GUI.fan_combo_timer[#GUI.fan_combo_timer + 1] = -1
    GUI.fan_combo_sy = UIButtons.GetSize((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Fans_Icon"), "Combo_Icon")))
    GUI.fan_combo_py = UIButtons.GetPosition((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Fans_Icon"), "Combo_Icon")))
    Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Fans_Icon"), "Combo_Number"), "HUD_" .. _FORV_3_ - 1 .. "_COMBO")
    if IsSplitScreen() == false then
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Fans_MinorScore"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopRight)
    end
    if Amax.IsRaceMpDestruction() == true then
      if NetRace.IsTeamGame() == true then
        HUD_MpDestructionSetupTeam(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), _FORV_3_ - 1, Multiplayer.GetPlayerTeam(), true)
        HUD_MpDestructionSetupTeam(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), _FORV_3_ - 1, Select(Multiplayer.GetPlayerTeam() == "team_a", "team_b", "team_a"), false)
      else
        UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
        UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
        UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), "Points_Amount"), "HUD_" .. _FORV_3_ - 1 .. "_MP_CURRENT_POINTS")
        UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), "SpDestructionPointsSmall"), false)
        UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
        UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), nil, 3, nil, true)
        UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextMedalTitle"), UIText.HUD_POS)
        UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextMedalInfo"), "HUD_" .. _FORV_3_ - 1 .. "_MP_PLACE")
        UIButtons.SetActive(HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextLightDummy"), 0).off, false)
        UIButtons.SetActive(HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextLightDummy"), 0).on, false)
        UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextArrow"), false)
        GUI.mp_destruction_ids[_FORV_3_] = {
          icon = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextDone"),
          blob = HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextLightDummy"), 0).blob
        }
        UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
        UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), nil, -4, nil, true)
        GUI.mp_rivals_ids[_FORV_3_] = {
          pic = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealthPic"),
          name = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealthName"),
          health = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealth"),
          rival_title = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "MpRivalTitle"),
          rival_time = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "MpRivalTime"),
          blob = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealthBlob")
        }
      end
    elseif Amax.SP_IsCheckpointRace() == true or Amax.SP_IsCheckpointFD() == true then
      HUD_SpCheckpointSetup(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate")))
    elseif Amax.SP_IsDestructionRace() == true or Amax.SP_IsDestructionFD() == true then
      HUD_SpDestructionSetup(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate")))
    elseif Amax.SP_IsFanDemandRace() == true or Amax.SP_IsFanDemandFD() == true then
      HUD_SpFanDemandSetup(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate")))
    else
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
      Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), "Position_Amount"), "HUD_" .. _FORV_3_ - 1 .. "_POS_NUM")
      Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), "Position_AmountOf"), "HUD_" .. _FORV_3_ - 1 .. "_POS_NUM_OF")
      if NetRace.IsTeamGame() == true then
        UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"), UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), UIEnums.Justify.MiddleLeft)
        UIButtons.ChangeTextureUV(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"), 0, UIGlobals.TeamIcons[Multiplayer.GetPlayerTeam()].u, UIGlobals.TeamIcons[Multiplayer.GetPlayerTeam()].v)
        UIButtons.ChangeColour(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"), UIGlobals.TeamColours[Multiplayer.GetPlayerTeam()])
        UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), UIButtons.GetSize((UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"))))
        UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), "Position_Amount"), -UIButtons.GetSize((UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"))), nil, nil, true)
        UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Title"), "Position_AmountOf"), -UIButtons.GetSize((UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"))), nil, nil, true)
        UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Team_ToW"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
      end
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Laps"), UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), UIEnums.Justify.TopRight)
      Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Laps"), "Map_LapsNum"), "HUD_" .. _FORV_3_ - 1 .. "_LAP")
      if Amax.SP_IsStreetRace() == true or Amax.SP_IsStreetRaceFD() == true then
        HUD_SpStreetRaceSetup(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate")))
      elseif Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true then
        HUD_SpBossSetup(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate")))
      end
    end
    if Amax.SP_IsStreetRaceFD() == true or Amax.SP_IsDestructionFD() == true or Amax.SP_IsCheckpointFD() == true or Amax.SP_IsFanDemandFD() == true or Amax.SP_IsBossBattleFD() == true then
      HUD_SpSetupFD(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate")))
    end
    if IsSplitScreen() == true then
      UIButtons.SetActive(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), false)
      UIButtons.SetActive(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), false)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "FanMsg_Main_RB"), "bra_FanDemandRoot"), false)
      UIButtons.SetActive({
        UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Fade"),
        UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_Flash"),
        UIButtons.CloneXtGadgetByName("hud_objects", "FullScreen_FlashGraphic")
      }[3], false)
      UIButtons.ChangeSize(UIButtons.CloneXtGadgetByName("hud_objects", "Ss_RaceLine_Main"), Screen.safe.width, UIButtons.GetSize((UIButtons.CloneXtGadgetByName("hud_objects", "Ss_RaceLine_Main"))))
      UIButtons.SwapColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), "Main_1", UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[_FORV_3_].pad])
      UIButtons.SwapColour(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "Main_1", UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[_FORV_3_].pad])
      UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Map_Root"), "Map_Main"), "colour_you", UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[_FORV_3_].pad])
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "dmy_MiniMapScale"), "shp_MiniMapRoad" .. _FORV_3_ - 1), "Support_4")
      UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "FanMsg_Main_RB"), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("hud_objects", "FanMsg_Main_RB"))))
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root_SS"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), UIEnums.Justify.TopCentre)
      UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root_SS"), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root_SS"))))
      UIButtons.ChangeScale(UIButtons.FindChildByName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), "targeting"), 0.725, 0.725, 1)
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), UIEnums.Justify.MiddleCentre)
      UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"))) - 320, UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"))) - 240, UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"))))
      UIButtons.ChangeLayer(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), 4, true)
      if IsWideScreen() == false and GUI.num_players > 2 then
        UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "Finished"), 375, 80, 0)
      end
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "StencilWrite"), false)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "CSB_T"), false)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "CSB_M"), false)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "CSB_B"), false)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "StencilWriteOff"), false)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "CSB_T_SS"), true)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "CSB_B_SS"), true)
      UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "PosDummy"), UIButtons.GetPosition((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), "PosDummy"))))
      UIButtons.SetActive(UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy"), false)
      GUI.mp_ss_finished_ids[#GUI.mp_ss_finished_ids + 1] = UIButtons.CloneXtGadgetByName("Multiplayer\\Ingame\\MpFinished.lua", "FinishedDummy")
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"), UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), UIEnums.Justify.MiddleCentre)
      UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"))) - 320, UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"))) - 240, UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"))))
      UIButtons.ChangeLayer(UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"), 4, true)
      UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"), "Wrecked_By"), UIButtons.GetPosition((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"), "Wrecked_By"))))
      UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"), "Wrecked_By"), "MPL_WRECKED_BY" .. _FORV_3_ - 1)
      UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"), "Loadout"), false)
      UIButtons.SetActive(UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch"), false)
      GUI.mp_ss_wrecked_ids[#GUI.mp_ss_wrecked_ids + 1] = UIButtons.CloneXtGadgetByName("Ingame\\SpWrecked.lua", "WreckedRenderBranch")
    else
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), UIEnums.Justify.TopCentre)
      if IsWideScreen() == false then
        UIButtons.ChangeScale(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root"), UIButtons.GetScale((UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root"))) * 0.75, UIButtons.GetScale((UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root"))) * 0.75)
        UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root"), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root"))))
      end
      if Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false then
        GUI.LastGaspPowerupSlotID = UIButtons.CloneXtGadgetByName("hud_objects", "LastGaspCountdownNode1")
        UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "LastGaspRenderBranch"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
        SyncLastGaspHudToVars()
      end
      GUI.mirrorID = UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Root")
    end
    if (GUI.is_network_race == true or IsSplitScreen() == true) and IsSplitScreen() == true then
      UIButtons.ChangePosition(HUD_SpCreateTimer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), "HUD_0_MP_TIMEOUT", _FORV_3_), nil, Select(GUI.num_players == 2, 29, 11), nil, true)
      UIButtons.ChangeScale(HUD_SpCreateTimer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), "HUD_0_MP_TIMEOUT", _FORV_3_), 0.625, 0.625, 1)
    end
    if GUI.is_network_race == true and IsSplitScreen() == false then
      UIButtons.CloneXtGadgetByName("hud_objects", "Mp_DataFullScreen")
      if Amax.IsRaceMpDestruction() == false then
        UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_DataMini"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.TopLeft)
        UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_DataMini"), nil, 0 - 2.05, nil, true)
        if Amax.GetNumVehicles() < 5 then
          UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_DataMini"), "MiniData_BackingMiddle"), UIButtons.GetSize((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_DataMini"), "MiniData_BackingMiddle"))))
          UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_DataMini"), "MiniData_BackingMiddleR"), UIButtons.GetSize((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_DataMini"), "MiniData_BackingMiddleR"))))
        end
      end
      UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mp_Speaking"), UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), UIEnums.Justify.BottomLeft)
      GUI.mp_rank_up_ids.root = UIButtons.CloneXtGadgetByName("hud_objects", "mp_rank_up_dummy")
      GUI.mp_rank_up_ids.rank = UIButtons.FindChildByName(GUI.mp_rank_up_ids.root, "mp_rank_up_rank")
      GUI.mp_rank_up_ids.rank_num = UIButtons.FindChildByName(GUI.mp_rank_up_ids.root, "mp_rank_up_rank_num")
      GUI.mp_rank_up_ids.rank_info = UIButtons.FindChildByName(GUI.mp_rank_up_ids.root, "mp_rank_up_rank_info")
      UIButtons.SetParent(GUI.mp_rank_up_ids.root, UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), UIEnums.Justify.TopCentre)
      GUI.mp_challenge_complete_ids.root = UIButtons.CloneXtGadgetByName("hud_objects", "mp_challenge_complete_dummy")
      GUI.mp_challenge_complete_ids.title = UIButtons.FindChildByName(GUI.mp_challenge_complete_ids.root, "mp_challenge_complete_title")
      GUI.mp_challenge_complete_ids.name = UIButtons.FindChildByName(GUI.mp_challenge_complete_ids.root, "mp_challenge_complete_name")
      GUI.mp_challenge_complete_ids.desc = UIButtons.FindChildByName(GUI.mp_challenge_complete_ids.root, "mp_challenge_complete_desc")
      GUI.mp_challenge_complete_ids.fans = UIButtons.FindChildByName(GUI.mp_challenge_complete_ids.root, "mp_challenge_complete_fans")
      GUI.mp_challenge_complete_ids.blob = UIButtons.FindChildByName(GUI.mp_challenge_complete_ids.root, "mp_challenge_complete_fans")
      GUI.mp_challenge_complete_ids.blob_title = UIButtons.FindChildByName(GUI.mp_challenge_complete_ids.root, "mp_challenge_complete_blob_title_c")
      GUI.mp_challenge_complete_ids.blob_info = UIButtons.FindChildByName(GUI.mp_challenge_complete_ids.root, "mp_challenge_complete_blob_info_c")
      UIButtons.SetParent(GUI.mp_challenge_complete_ids.root, UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), UIEnums.Justify.TopCentre)
    end
    if (GUI.is_network_race == true or IsSplitScreen() == true) and UIGlobals.Ingame.has_last_gasp and UIGlobals.Ingame.has_jump_the_gun then
      GUI.jump_the_gun_standalone_ID = UIButtons.CloneXtGadgetByName("hud_objects", "jump_the_gun_icon_standalone")
      UIButtons.SetParent(GUI.jump_the_gun_standalone_ID, UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), UIEnums.Justify.MiddleCentre)
    end
    if NetRace.IsTeamGame() == true then
      UIButtons.SwapColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), "Main_1", UIGlobals.TeamColours[Multiplayer.GetPlayerTeam()])
      UIButtons.SwapColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate"), "Main_1", UIGlobals.TeamColours[Multiplayer.GetPlayerTeam()])
    end
    if GUI.num_players > 1 then
      UIButtons.CloneXtGadgetByName("hud_objects", "Clip_Pop_41")
      UIButtons.CloneXtGadgetByName("hud_objects", "Clip_Pop_14")
      UIButtons.CloneXtGadgetByName("hud_objects", "Clip_Pop_31")
    end
    GUI.ai_hud_ids[_FORV_3_] = {}
    GUI.ai_hud_ids[_FORV_3_].id = UIButtons.FindChildByName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate"), "AIHud_Main")
    for _FORV_34_ = 1, Amax.GetNumVehicles() do
      UIButtons.ReplaceTimeLineLabel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "AIHud_Parent"), "ai_targeting_left"), "targeted", "targeted" .. "_" .. _FORV_3_ - 1 .. "_" .. _FORV_34_ - 1)
      UIButtons.ReplaceTimeLineLabel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "AIHud_Parent"), "ai_targeting_right"), "targeted", "targeted" .. "_" .. _FORV_3_ - 1 .. "_" .. _FORV_34_ - 1)
      GUI.ai_hud_ids[_FORV_3_][#GUI.ai_hud_ids[_FORV_3_] + 1] = UIButtons.CloneXtGadgetByName("hud_objects", "AIHud_Parent")
      if IsSplitScreen() == true and _FORV_34_ <= #UIGlobals.Splitscreen.players then
        UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "AIHud_Parent"), "ai_name"), UIGlobals.Splitscreen.colours[UIGlobals.Splitscreen.players[_FORV_34_].pad])
      end
    end
    if UIGlobals.Ingame.IntroHUD == true then
      UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "GoNode"), "GoText"), UIEnums.Panel._VP0 + (_FORV_3_ - 1))
    end
    UIScreen.AddMessageNow(UIEnums.GameMessage.SetLocalPlayerIndex, _FORV_3_ - 1)
    if GUI.show_camera_helpers == true then
      UIButtons.SetActive(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), false)
      UIButtons.SetActive(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), false)
    end
    UIButtons.RenderBranchScan((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "2D_SAFE"), "2D_Intermediate")))
    UIButtons.RenderBranchScan((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "3D_SAFE"), "3D_Intermediate")))
    if IsSplitScreen() == true then
      GUI.mp_ss_messages[_FORV_3_] = {
        finished = false,
        wrecked = false,
        respawn_timer = 0
      }
    end
  end
  if _FOR_() == false and Amax.IsRaceMpDestruction() == true then
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Copy_State_On"), mirror, UIEnums.Justify.None)
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_ImageL_Copy"), mirror, UIEnums.Justify.TopCentre)
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_ImageR_Copy"), mirror, UIEnums.Justify.TopCentre)
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Mirror_Copy_State_Off"), mirror, UIEnums.Justify.None)
  end
  if IsSplitScreen() == true then
    UIButtons.TimeLineActive("start", true, 0.5, true)
  end
  if GUI.show_camera_helpers == true then
    UIButtons.CloneXtGadgetByName("hud_objects", "Debug_CameraHelpers")
  end
  if UIGlobals.Ingame.IntroHUD == true then
    Amax.SendMessage(UIEnums.GameFlowMessage.RaceStarted)
    UIGlobals.Ingame.IntroHUD = nil
  end
  for _FORV_3_, _FORV_4_ in ipairs(GUI.ai_hud_ids) do
    for _FORV_8_, _FORV_9_ in ipairs(_FORV_4_) do
      Amax.ResolveAiHud(_FORV_4_.id, _FORV_9_)
    end
  end
  HUD_UpdateCombo()
  if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
    HUD_SpUpdate(0)
  end
  if IsSplitScreen() == true then
    HUD_SsCheckStates(0)
  end
  if (GUI.is_network_race == true or IsSplitScreen() == true) and Amax.IsRaceMpDestruction() == true then
    HUD_MpDestructionPositionUpdate()
    HUD_MpDestructionRivalUpdate()
  end
end
function StartLoop(_ARG_0_)
  if IsSplitScreen() == true then
    HUD_SsUpdateTimers(_ARG_0_)
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.KeyboardDisconnected and IsSplitScreen() == true then
    PauseGame(0)
  end
  if _ARG_0_ == UIEnums.Message.ControllerDisconnected then
    if UIEnums.CurrentPlatform ~= UIEnums.Platform.PS3 then
      if IsSplitScreen() == true then
        for _FORV_9_, _FORV_10_ in ipairs(UIGlobals.Splitscreen.players) do
          if _FORV_10_.pad == _ARG_1_ then
            if UIEnums.CurrentPlatform == UIEnums.Platform.PC then
              if _ARG_2_ == true then
                PauseGame(_ARG_1_)
              else
                else
                  PauseGame(_ARG_1_)
                  break
                end
                elseif _ARG_1_ == Profile.GetPrimaryPad() and UIEnums.CurrentPlatform ~= UIEnums.Platform.PC then
                  PauseGame(_ARG_1_)
                end
                elseif (_ARG_0_ == UIEnums.GameMessage.PrimeLastGasp or _ARG_0_ == UIEnums.GameMessage.DisarmLastGasp) and Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false then
                  RefreshLastGaspVars()
                  SyncLastGaspHudToVars()
                  if _ARG_0_ == UIEnums.GameMessage.DisarmLastGasp and UIGlobals.Ingame.has_jump_the_gun == true and UIGlobals.Ingame.has_last_gasp == true then
                    UIButtons.SetActive(GUI.jump_the_gun_standalone_ID, true)
                  end
                elseif _ARG_0_ == UIEnums.GameMessage.DisplayECMWarning and Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false then
                  HUD_ActivateECMWarning(_ARG_1_)
                elseif _ARG_0_ == UIEnums.GameMessage.RemoveECMWarning and Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false then
                  HUD_DeactivateECMWarning(_ARG_1_)
                elseif _ARG_0_ == UIEnums.GameMessage.NewRivalSelected then
                  HUD_MpDestructionRivalChange(_ARG_1_ + 1)
                elseif _ARG_0_ == UIEnums.GameMessage.UsePickup and Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false then
                  if UIGlobals.Ingame.has_last_gasp == true and UIGlobals.Ingame.last_gasp_mode_active == true and UIGlobals.Ingame.can_fire_last_gasp == true then
                    Amax.FireLastGasp(0)
                    RefreshLastGaspVars()
                    SyncLastGaspHudToVars()
                  end
                elseif (_ARG_0_ == UIEnums.Message.ButtonStart or _ARG_0_ == UIEnums.Message.ButtonPause) and _ARG_2_ == true and Amax.IsGamePaused() == false then
                  PlaySfxNext()
                  PauseGame(_ARG_1_)
                elseif _ARG_0_ == UIEnums.GameFlowMessage.RaceFinished or _ARG_0_ == UIEnums.GameFlowMessage.RaceFailed then
                  UIGlobals.Ingame.RaceFinishedMsg = _ARG_0_
                  if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
                    Amax.SetupResults()
                    UIScreen.SetScreenTimers(0, 0)
                    GoScreen("SinglePlayer\\Ingame\\SpFinished.lua")
                  elseif IsSplitScreen() == true then
                    UIScreen.SetScreenTimers(0, 1.5)
                    GoScreen("Multiplayer\\Ingame\\MpWinner.lua")
                  elseif Multiplayer.IsEliminated() then
                    NetRace.ChangeLocalPlayerState(Profile.GetPrimaryPad(), UIEnums.Network.PlayerStates.eNetPlayerStateFinished)
                    if Multiplayer.RaceFinished() == true and NetRace.CanShowWinner() == true then
                      GoScreen("Multiplayer\\Ingame\\MpWinner.lua")
                    else
                      Mp_ResetSpectateVars()
                      GoScreen("Multiplayer\\Ingame\\MpSpectate.lua")
                    end
                  else
                    GoScreen("Multiplayer\\Ingame\\MpFinished.lua")
                  end
                elseif _ARG_0_ == UIEnums.GameFlowMessage.Wrecked then
                  if IsSplitScreen() == true then
                    if 0 < _ARG_1_ + 1 and _ARG_1_ + 1 <= #UIGlobals.Splitscreen.players then
                      UIGlobals.SplitscreenMessages[_ARG_1_ + 1].wrecked = true
                    end
                  elseif _ARG_1_ == 0 then
                    if GUI.is_network_race == true and UIButtons.IsActive(GUI.mp_challenge_complete_ids.root) == true then
                      UIButtons.TimeLineActive("mp_challenge_complete", false)
                      UIButtons.SetActive(GUI.mp_challenge_complete_ids.root, false)
                      GUI.mp_rank_or_challenge_stack = {}
                    end
                    GoScreen("Ingame\\SpWrecked.lua", UIEnums.Context.SpWrecked)
                    GUI.allow_pause = false
                    UIButtons.SetActive(GUI.mp_fan_msg_root[1], false)
                  end
                elseif _ARG_0_ == UIEnums.GameFlowMessage.Respawn then
                  if IsSplitScreen() == true then
                    if 0 < _ARG_1_ + 1 and _ARG_1_ + 1 <= #UIGlobals.Splitscreen.players then
                      UIGlobals.SplitscreenMessages[_ARG_1_ + 1].wrecked = false
                    end
                  elseif _ARG_1_ == 0 then
                    GUI.allow_pause = true
                    GUI.mp_fan_msg_activate_in[_ARG_1_ + 1] = 0.5
                    if UIGlobals.Ingame.has_jump_the_gun == true and UIGlobals.Ingame.has_last_gasp == true then
                      UIButtons.SetActive(GUI.jump_the_gun_standalone_ID, false)
                    end
                  end
                elseif _ARG_0_ == UIEnums.GameMessage.MpRankedUp then
                  HUD_MpRankUp(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
                elseif _ARG_0_ == UIEnums.GameMessage.MpChallengeComplete and UIScreen.IsContextActive(UIEnums.Context.SpWrecked) == false then
                  HUD_MpChallengeComplete(_ARG_1_, _ARG_2_)
                elseif _ARG_0_ == UIEnums.GameFlowMessage.VehicleFinished and IsSplitScreen() == true and 0 < _ARG_1_ + 1 and _ARG_1_ + 1 <= #UIGlobals.Splitscreen.players then
                  UIGlobals.SplitscreenMessages[_ARG_1_ + 1].finished = true
                  UIGlobals.SplitscreenMessages[_ARG_1_ + 1].finished_position = Multiplayer.GetSplitscreenPosition(_ARG_1_ + 1)
                end
              end
          end
        end
    end
  if _ARG_0_ == UIEnums.GameMessage.SpCheckpointPassed then
    HUD_SpCheckpointPassed()
  elseif _ARG_0_ == UIEnums.GameMessage.SpCollectStopwatch then
    HUD_SpCheckpointCollectStopwatch()
  elseif _ARG_0_ == UIEnums.GameMessage.SpDestructionPointsAdded then
    HUD_SpDestructionPointsAdded(_ARG_1_)
  elseif _ARG_0_ == UIEnums.GameMessage.SpDestructionBonusHitStart then
    HUD_SpDestructionBonusHitStart()
  elseif _ARG_0_ == UIEnums.GameMessage.SpDestructionBonusHitAdded then
    HUD_SpDestructionBonusHitAdded()
  elseif _ARG_0_ == UIEnums.GameMessage.SpDestructionBonusHitEnd then
    HUD_SpDestructionBonusHitEnd()
  elseif _ARG_0_ == UIEnums.GameMessage.SpFanDemandFansAdded then
    HUD_SpFanDemandFansAdded()
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true or net_Disconnecting() == true then
    return
  end
  if NetRace.IsPlayerInactive() == true and UIGlobals.IdlePlayerKicked == false and UIGlobals.Multiplayer.LobbyConnectionLost == false then
    print("Idle Player Kicked")
    UIScreen.SetScreenTimers(0, 0)
    UIGlobals.IdlePlayerKicked = true
    net_DisconnectFromRace()
  end
  if UIGlobals.LaunchMode == UIEnums.LaunchMode.Automation and GUI.automation_start == true then
    Amax.EnableAIControl(true)
    GUI.automation_start = false
    UIGlobals.automation_timer = UIGlobals.automation_length
  end
  if IsSplitScreen() == false and UIGlobals.Multiplayer.RaceFinished == false and Multiplayer.RaceFinished() == true then
    UIScreen.SetScreenTimers(0, 0)
    GoScreen("Multiplayer\\Ingame\\MpFinished.lua")
    print("RACE FINISHED")
  end
  if IsSplitScreen() == false and UIGlobals.Multiplayer.PrimaryVehicleFinished == false and Multiplayer.PrimaryVehicleFinished() == true then
    UIGlobals.Multiplayer.PrimaryVehicleFinished = true
    if Multiplayer.IsEliminated() then
      NetRace.ChangeLocalPlayerState(Profile.GetPrimaryPad(), UIEnums.Network.PlayerStates.eNetPlayerStateFinished)
      if Multiplayer.RaceFinished() == true and NetRace.CanShowWinner() == true then
        GoScreen("Multiplayer\\Ingame\\MpWinner.lua")
      else
        Mp_ResetSpectateVars()
        GoScreen("Multiplayer\\Ingame\\MpSpectate.lua")
      end
    else
      GoScreen("Multiplayer\\Ingame\\MpFinished.lua")
    end
    GoScreen("Multiplayer\\Ingame\\MpFinished.lua")
    print("VEHICLE FINISHED")
  end
  if Profile.GuideActive() == true then
    PauseGame(Profile.GetPrimaryPad())
    return
  end
  if GUI.show_revs == true then
    for _FORV_4_ = 1, GUI.num_players do
      UIShape.SetVertexParams(GUI.revs_partial_ids[_FORV_4_], 0, (Amax.GetRevs01(_FORV_4_)))
    end
  end
  for _FORV_4_ = 1, GUI.num_players do
    if 0 < GUI.mp_fan_msg_activate_in[_FORV_4_] then
      GUI.mp_fan_msg_activate_in[_FORV_4_] = GUI.mp_fan_msg_activate_in[_FORV_4_] - _ARG_0_
      if 0 >= GUI.mp_fan_msg_activate_in[_FORV_4_] then
        UIButtons.SetActive(GUI.mp_fan_msg_root[_FORV_4_], true)
      end
    end
  end
  if _FOR_.GetGameMode() == UIEnums.GameMode.SinglePlayer then
    HUD_SpUpdate(_ARG_0_)
  end
  if IsSplitScreen() == true then
    HUD_SsCheckStates(_ARG_0_)
    HUD_SsUpdateTimers(_ARG_0_)
  end
  HUD_UpdateCombo()
  if Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false and UIGlobals.Ingame.has_last_gasp == true and UIGlobals.Ingame.last_gasp_mode_active == true then
    UIGlobals.Ingame.last_gasp_timer = Amax.GetLastGaspTime(0)
    if 0 < UIGlobals.Ingame.last_gasp_timer then
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.LastGaspPowerupSlotID, "time_LastGasp_OnCar"), "MPL_TIMER_GASP_COUNTDOWN" .. UIGlobals.Ingame.last_gasp_timer)
    end
  end
  if GUI.is_network_race == true or IsSplitScreen() == true then
    if Amax.IsRaceMpDestruction() == true then
      if Amax.MP_GetTimeout() <= 30 then
        HUD_SpTimerUpdate((Amax.MP_GetTimeout()))
      end
      HUD_MpDestructionPositionUpdate()
      HUD_MpDestructionRivalUpdate()
    else
      HUD_SpTimerUpdate((Amax.MP_GetTimeout()))
    end
  end
end
function Render()
end
function EnterEnd()
  UIButtons.TimeLineActive("Show_Pickup", false)
end
function EndLoop(_ARG_0_)
  if IsSplitScreen() == true then
    HUD_SsUpdateTimers(_ARG_0_)
  end
end
function End()
  Camera_UseFrontend()
  SetNil(HUD)
  SetNil(HUD_Panels)
  SetNil(HUD_Items)
  if IsSplitScreen() == true and GUI.going_to_pause_pad == -1 then
    Profile.SetPrimaryPad(UIGlobals.Splitscreen.primary_pad)
    Profile.LockToPad(UIGlobals.Splitscreen.primary_pad)
  end
end
function HUD_UpdateCombo()
  for _FORV_3_, _FORV_4_ in ipairs(GUI.fan_combo_ids) do
    if Amax.GetComboTimer(_FORV_3_ - 1) ~= GUI.fan_combo_timer[_FORV_3_] then
      UIButtons.ChangeTexture({
        filename = GUI.fan_combo_tex.filename,
        pos = {
          u = GUI.fan_combo_tex.pos.u,
          v = GUI.fan_combo_tex.pos.v + (1 - Amax.GetComboTimer(_FORV_3_ - 1) / 4) * GUI.fan_combo_tex.size.v
        },
        size = {
          u = GUI.fan_combo_tex.size.u,
          v = GUI.fan_combo_tex.size.v * (Amax.GetComboTimer(_FORV_3_ - 1) / 4)
        }
      }, 0, _FORV_4_)
      UIButtons.ChangeSize(_FORV_4_, GUI.fan_combo_sy, GUI.fan_combo_sy * (Amax.GetComboTimer(_FORV_3_ - 1) / 4), 0)
      UIButtons.ChangePosition(_FORV_4_, UIButtons.GetPosition(_FORV_4_))
      if GUI.fan_combo_timer[_FORV_3_] == 0 then
        UIButtons.PrivateTimeLineActive(_FORV_4_, "combo_pulse", true)
      end
      GUI.fan_combo_timer[_FORV_3_] = Amax.GetComboTimer(_FORV_3_ - 1)
      if GUI.fan_combo_timer[_FORV_3_] == 0 then
        UIButtons.PrivateTimeLineActive(_FORV_4_, "combo_pulse", false)
      end
    end
  end
end
function PauseGame(_ARG_0_)
  if GUI.allow_pause == false then
    return
  end
  GUI.going_to_pause_pad = _ARG_0_
  if IsSplitScreen() == true then
    Profile.SetPrimaryPad(GUI.going_to_pause_pad)
    Profile.LockToPad(GUI.going_to_pause_pad)
  end
  GUI.going_to_pause = true
  Amax.SendMessage(UIEnums.GameFlowMessage.Pause)
  if GUI.num_players == 1 then
    UIButtons.TimeLineActive("start", false)
  end
  GoScreen("Ingame\\Paused.lua")
end
function HUD_MpRankUp(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  GUI.mp_rank_or_challenge_stack[#GUI.mp_rank_or_challenge_stack + 1] = {
    tag = "R",
    rank = _ARG_0_,
    legend = _ARG_1_,
    fans = _ARG_2_,
    fans_next = _ARG_3_
  }
  if #GUI.mp_rank_or_challenge_stack == 1 then
    HUD_MpNextRankOrChallenge()
  end
end
function HUD_MpRankUpFinished()
  UIButtons.SetActive(GUI.mp_rank_up_ids.root, false)
  UIButtons.SetActive(GUI.mp_fan_msg_root[1], true)
  table.remove(GUI.mp_rank_or_challenge_stack, 1)
  HUD_MpNextRankOrChallenge()
end
function HUD_MpChallengeComplete(_ARG_0_, _ARG_1_)
  GUI.mp_rank_or_challenge_stack[#GUI.mp_rank_or_challenge_stack + 1] = {
    tag = "C",
    type = _ARG_0_,
    tier = _ARG_1_
  }
  if #GUI.mp_rank_or_challenge_stack == 1 then
    HUD_MpNextRankOrChallenge()
  end
end
function HUD_MpChallengeCompleteFinished()
  UIButtons.SetActive(GUI.mp_challenge_complete_ids.root, false)
  UIButtons.SetActive(GUI.mp_fan_msg_root[1], true)
  table.remove(GUI.mp_rank_or_challenge_stack, 1)
  HUD_MpNextRankOrChallenge()
end
function HUD_MpNextRankOrChallenge()
  if #GUI.mp_rank_or_challenge_stack == 0 then
    return
  end
  if GUI.mp_rank_or_challenge_stack[1].tag == "R" then
    UIButtons.SetActive(GUI.mp_rank_up_ids.root, true)
    UIButtons.SetActive(GUI.mp_fan_msg_root[1], false)
    Mp_RankIcon(GUI.mp_rank_up_ids.rank, GUI.mp_rank_or_challenge_stack[1].rank - 1, GUI.mp_rank_or_challenge_stack[1].legend)
    UIButtons.ChangeText(GUI.mp_rank_up_ids.rank_num, "HUD_0_MP_RANK_" .. GUI.mp_rank_or_challenge_stack[1].rank)
    if GUI.mp_rank_or_challenge_stack[1].fans_next == -1 then
      UIButtons.ChangeText(GUI.mp_rank_up_ids.rank_info, UIText.CMN_NOWT)
    else
      UIButtons.ChangeText(GUI.mp_rank_up_ids.rank_info, "HUD_0_MP_NEXT_RANK_IN_" .. GUI.mp_rank_or_challenge_stack[1].fans_next - GUI.mp_rank_or_challenge_stack[1].fans .. "_" .. GUI.mp_rank_or_challenge_stack[1].rank + 1)
    end
    UIButtons.TimeLineActive("mp_rank_up", true, 0)
    UISystem.PlaySound(UIEnums.SoundEffect.RankUp)
  elseif GUI.mp_rank_or_challenge_stack[1].tag == "C" then
    UIButtons.SetActive(GUI.mp_challenge_complete_ids.root, true)
    UIButtons.SetActive(GUI.mp_fan_msg_root[1], false)
    UIButtons.ChangeText(GUI.mp_challenge_complete_ids.name, "MPL_CHALLENGE" .. GUI.mp_rank_or_challenge_stack[1].type .. "_" .. GUI.mp_rank_or_challenge_stack[1].tier .. "_NAME")
    UIButtons.ChangeText(GUI.mp_challenge_complete_ids.desc, "MPL_CHALLENGE" .. GUI.mp_rank_or_challenge_stack[1].type .. "_" .. GUI.mp_rank_or_challenge_stack[1].tier .. "_DESC")
    UIButtons.ChangeText(GUI.mp_challenge_complete_ids.fans, "MPL_CHALLENGE" .. GUI.mp_rank_or_challenge_stack[1].type .. "_" .. GUI.mp_rank_or_challenge_stack[1].tier .. "_FANS")
    UIButtons.ChangeSize(GUI.mp_challenge_complete_ids.blob_title, UIButtons.GetStaticTextLength(GUI.mp_challenge_complete_ids.title) + 20, UIButtons.GetSize(GUI.mp_challenge_complete_ids.blob_title))
    UIButtons.ChangeSize(GUI.mp_challenge_complete_ids.blob_info, math.max(UIButtons.GetStaticTextLength(GUI.mp_challenge_complete_ids.name), (UIButtons.GetStaticTextLength(GUI.mp_challenge_complete_ids.desc))) + 20, UIButtons.GetSize(GUI.mp_challenge_complete_ids.blob_info))
    UIButtons.TimeLineActive("mp_challenge_complete", true, 0)
    UISystem.PlaySound(UIEnums.SoundEffect.ChallengeComplete)
  end
end
function HUD_SsCheckStates(_ARG_0_)
  for _FORV_4_ = 1, #UIGlobals.Splitscreen.players do
    if GUI.mp_ss_messages[_FORV_4_].finished == false and UIGlobals.SplitscreenMessages[_FORV_4_].finished == true then
      GUI.mp_ss_messages[_FORV_4_].finished = true
      GUI.mp_ss_messages[_FORV_4_].finished_position = UIGlobals.SplitscreenMessages[_FORV_4_].finished_position
      UIButtons.SetActive(GUI.inter_2d_ids[_FORV_4_], false)
      UIButtons.SetActive(GUI.inter_3d_ids[_FORV_4_], false)
      UIButtons.SetActive(GUI.mp_ss_finished_ids[_FORV_4_], true)
      UIButtons.ChangeText(UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "Pos_Place"), "MPL_SPLITSCREEN_FINISHED_POSITION_" .. GUI.mp_ss_messages[_FORV_4_].finished_position)
      if GUI.mp_ss_messages[_FORV_4_].finished_position <= 3 then
        UIButtons.SetActive(UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "Dummy_" .. GUI.mp_ss_messages[_FORV_4_].finished_position), true)
        if GUI.mp_ss_messages[_FORV_4_].finished_position == 3 then
          UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "Pos_Place"), (GetResultColour(GUI.mp_ss_messages[_FORV_4_].finished_position)))
        elseif GUI.mp_ss_messages[_FORV_4_].finished_position == 2 then
          UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "Pos_Place"), (GetResultColour(GUI.mp_ss_messages[_FORV_4_].finished_position)))
        else
          UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "Pos_Place"), (GetResultColour(GUI.mp_ss_messages[_FORV_4_].finished_position)))
        end
      else
        UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "Pos_Place"), (GetResultColour(GUI.mp_ss_messages[_FORV_4_].finished_position)))
      end
      for _FORV_15_, _FORV_16_ in ipairs({
        UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "CSB_T_SS"),
        UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "CSB_B_SS"),
        UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "Finished")
      }) do
        UIButtons.PrivateTimeLineActive(_FORV_16_, "show_finished", true, UIGlobals.SplitscreenMessages[_FORV_4_].finished_timer, true)
      end
      for _FORV_15_, _FORV_16_ in ipairs({
        UIButtons.FindChildByName(GUI.mp_ss_finished_ids[_FORV_4_], "PosDummy")
      }) do
        UIButtons.PrivateTimeLineActive(_FORV_16_, "show_result", true, UIGlobals.SplitscreenMessages[_FORV_4_].finished_timer, true)
      end
    end
    if GUI.mp_ss_messages[_FORV_4_].wrecked == false and UIGlobals.SplitscreenMessages[_FORV_4_].wrecked == true then
      GUI.mp_ss_messages[_FORV_4_].wrecked = true
      UIButtons.SetActive(GUI.inter_2d_ids[_FORV_4_], false)
      UIButtons.SetActive(GUI.inter_3d_ids[_FORV_4_], false)
      UIButtons.SetActive(GUI.mp_ss_wrecked_ids[_FORV_4_], true)
      for _FORV_11_, _FORV_12_ in ipairs({
        UIButtons.FindChildByName(GUI.mp_ss_wrecked_ids[_FORV_4_], "CSB_Top"),
        UIButtons.FindChildByName(GUI.mp_ss_wrecked_ids[_FORV_4_], "CSB_Bottom"),
        UIButtons.FindChildByName(GUI.mp_ss_wrecked_ids[_FORV_4_], "Wrecked"),
        UIButtons.FindChildByName(GUI.mp_ss_wrecked_ids[_FORV_4_], "Wrecked_By")
      }) do
        UIButtons.PrivateTimeLineActive(_FORV_12_, "show_wrecked", true, UIGlobals.SplitscreenMessages[_FORV_4_].wrecked_timer, true)
      end
    end
    if GUI.mp_ss_messages[_FORV_4_].wrecked == true and UIGlobals.SplitscreenMessages[_FORV_4_].wrecked == false then
      GUI.mp_ss_messages[_FORV_4_].wrecked = false
      GUI.mp_ss_messages[_FORV_4_].respawn_timer = 0.5
    end
    if GUI.mp_ss_messages[_FORV_4_].respawn_timer > 0 then
      GUI.mp_ss_messages[_FORV_4_].respawn_timer = GUI.mp_ss_messages[_FORV_4_].respawn_timer - _ARG_0_
      if GUI.mp_ss_messages[_FORV_4_].respawn_timer < 0 then
        GUI.mp_ss_messages[_FORV_4_].respawn_timer = 0
        UIButtons.SetActive(GUI.mp_ss_wrecked_ids[_FORV_4_], false)
        UIButtons.SetActive(GUI.inter_2d_ids[_FORV_4_], true)
        UIButtons.SetActive(GUI.inter_3d_ids[_FORV_4_], true)
        UIGlobals.SplitscreenMessages[_FORV_4_].wrecked_timer = 0
      end
    end
  end
end
function HUD_SsUpdateTimers(_ARG_0_)
  for _FORV_4_ = 1, #UIGlobals.Splitscreen.players do
    if GUI.mp_ss_messages[_FORV_4_].finished == true then
      UIGlobals.SplitscreenMessages[_FORV_4_].finished_timer = UIGlobals.SplitscreenMessages[_FORV_4_].finished_timer + _ARG_0_
    end
    if GUI.mp_ss_messages[_FORV_4_].wrecked == true then
      UIGlobals.SplitscreenMessages[_FORV_4_].wrecked_timer = UIGlobals.SplitscreenMessages[_FORV_4_].wrecked_timer + _ARG_0_
    end
  end
end
function HUD_SpCreateLight(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_1_ = _ARG_1_ * 1.1
  for _FORV_9_, _FORV_10_ in ipairs(Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)) do
    UIButtons.ChangePanel(_FORV_10_, UIEnums.Panel._3DAA_0, true)
    UIButtons.SetParent(_FORV_10_, _ARG_0_, UIEnums.Justify.MiddleCentre)
  end
  if _ARG_2_ == true then
    UIButtons.ChangePanel({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on, UIEnums.Panel._2DAA, true)
    UIButtons.ChangePanel({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.off, UIEnums.Panel._2DAA, true)
    UIButtons.ChangePanel({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.blob, UIEnums.Panel._2DAA, true)
    UIButtons.ChangeSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on) * 10, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on) * 10, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on))
    UIButtons.ChangeSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.off, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on) * 10, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on) * 10, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on))
    UIButtons.ChangeSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.blob, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on) * 10, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on) * 10, UIButtons.GetSize({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on))
    UIButtons.ChangeJustification({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on, UIEnums.Justify.BottomLeft)
    UIButtons.ChangePosition({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on, UIButtons.GetPosition({
      on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
      off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
      blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
    }.on))
  end
  return {
    on = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[1],
    off = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)[2],
    blob = Sp_CreateStar(false, _ARG_1_ + 1, nil, nil, nil, 0.85, true, true)
  }
end
function HUD_SpCreateLightPanel(_ARG_0_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpLightsBackingTop"), _ARG_0_, UIEnums.Justify.TopLeft)
  GUI.sp.light = {}
  for _FORV_6_ = 1, 5 do
    GUI.sp.light[_FORV_6_] = HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpLightsBackingTop"), "SpLightsDummy"), _FORV_6_ - 1)
  end
end
function HUD_SpCreateNextPanel(_ARG_0_, _ARG_1_, _ARG_2_)
  if Amax.SP_IsStreetRaceFD() == true or Amax.SP_IsDestructionFD() == true or Amax.SP_IsCheckpointFD() == true or Amax.SP_IsFanDemandFD() == true or Amax.SP_IsBossBattleFD() == true then
    return
  end
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), _ARG_0_, UIEnums.Justify.TopLeft)
  GUI.sp.light_next = HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextLightDummy"), 0)
  GUI.sp.light_done = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextDone")
  UIButtons.SetActive(GUI.sp.light_next.off, false)
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextMedalInfo"), _ARG_1_)
  GUI.sp.next_title = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextMedalTitle")
  GUI.sp.next_arrow = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpNextBackingTop"), "SpNextArrow")
  GUI.sp.best_title_text = UIText.HUD_BEST
  if _ARG_2_ ~= nil then
    GUI.sp.best_title_text = _ARG_2_
  end
end
function HUD_SpUpdate(_ARG_0_)
  if GUI.is_street_race == true then
    HUD_SpStreetRaceUpdate(_ARG_0_)
  elseif GUI.is_checkpoint_race == true then
    HUD_SpCheckpointUpdate(_ARG_0_)
  elseif GUI.is_destruction_race == true then
    HUD_SpDestructionUpdate(_ARG_0_)
  elseif GUI.is_fan_demand_race == true then
    HUD_SpFanDemandUpdate(_ARG_0_)
  end
  if GUI.is_race_fd == true then
    HUD_SpUpdateFD(_ARG_0_)
  end
end
function HUD_FanScoreOnOff(_ARG_0_)
  if _ARG_0_ == true then
    MajorScoreOnOff(_ARG_0_)
    GUI.major_fan_on = true
  else
    GUI.major_fan_on = false
    MajorScoreOnOff()
  end
end
function HUD_FanScoreBonusOnOff(_ARG_0_)
  if _ARG_0_ == true then
    MajorScoreOnOff(_ARG_0_)
    GUI.major_bonus_on = true
  else
    GUI.major_bonus_on = false
    MajorScoreOnOff()
  end
end
function HUD_FanDemandStart()
  if GUI.is_checkpoint_race == true then
    UIButtons.SetActive(GUI.sp.cp_rb, false)
  elseif GUI.is_destruction_race == true then
    UIButtons.SetActive(GUI.sp.destruction_rb, false)
    UIButtons.SetActive(GUI.sp.destruction_bonus_rb, false)
  end
  MajorScoreOnOff(true)
  GUI.major_demand_on = true
end
function HUD_FanDemandEnd()
  if GUI.is_checkpoint_race == true then
    UIButtons.SetActive(GUI.sp.cp_rb, true)
  elseif GUI.is_destruction_race == true then
    UIButtons.SetActive(GUI.sp.destruction_rb, true)
    UIButtons.SetActive(GUI.sp.destruction_bonus_rb, true)
  end
  GUI.major_demand_on = false
  MajorScoreOnOff()
end
function MajorScoreOnOff(_ARG_0_)
  if _ARG_0_ == nil then
    _ARG_0_ = false
  end
  if GUI.major_fan_on ~= true and GUI.major_bonus_on ~= true and GUI.major_demand_on ~= true then
    UIButtons.TimeLineActive("fade_hud_data", _ARG_0_)
  end
end
function HUD_SpStateUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_ ~= GUI.sp.state then
    if Sp_EventStateToStars(_ARG_0_) ~= 0 then
      GUI.sp.state_change_active = true
      GUI.sp.state_change_timer = 0
      GUI.sp.state_change_timer_next = 0
      GUI.sp.state_change_current = 1
      GUI.sp.state_change_target = Sp_EventStateToStars(_ARG_0_)
      GUI.sp.state_change_state = _ARG_0_
      GUI.sp.state_change_down = Sp_EventStateToStars(_ARG_0_) < Sp_EventStateToStars(GUI.sp.state)
    else
      GUI.sp.state_change_active = false
    end
    for _FORV_8_ = 1, 5 do
      UIButtons.SetActive(GUI.sp.light[_FORV_8_].on, Select(Sp_EventStateToStars(_ARG_0_) < Sp_EventStateToStars(GUI.sp.state), false, _FORV_8_ <= Sp_EventStateToStars(GUI.sp.state)), true)
      UIButtons.SetActive(GUI.sp.light[_FORV_8_].off, true)
    end
    if _FOR_.is_checkpoint_race == true then
      UIButtons.SetActive(GUI.sp.light_timer.on, _ARG_0_ ~= "none", true)
      UIButtons.SetActive(GUI.sp.light_timer.off, true)
      if _ARG_0_ ~= "none" == true then
        SpSetStarTexture(GUI.sp.light_timer.on, true, _ARG_0_)
        UIButtons.ChangeColour(GUI.sp.light_timer.blob, Sp_EventStateToColour(_ARG_0_))
        UIButtons.PrivateTimeLineActive(GUI.sp.light_timer.on, "light_on", true, 0)
        UIButtons.PrivateTimeLineActive(GUI.sp.light_timer.blob, "light_on", true, 0)
      end
      SpSetStarTexture(GUI.sp.light_timer.off, true, Sp_EventStateToPrevState(_ARG_0_))
    end
    if GUI.sp.light_next ~= nil then
      if _ARG_0_ == "gold" then
        UIButtons.SetActive(GUI.sp.light_done, true)
        UIButtons.SetActive(GUI.sp.light_next.on, false, true)
        UIButtons.ChangeText(GUI.sp.next_title, GUI.sp.best_title_text)
        UIButtons.SetActive(GUI.sp.next_arrow, true)
      else
        UIButtons.SetActive(GUI.sp.light_done, false)
        UIButtons.SetActive(GUI.sp.light_next.on, true, true)
        UIButtons.ChangeText(GUI.sp.next_title, UIText.HUD_NEXT)
        UIButtons.SetActive(GUI.sp.next_arrow, false)
        SpSetStarTexture(GUI.sp.light_next.on, true, (Sp_EventStateToNextState(_ARG_0_)))
        UIButtons.ChangeColour(GUI.sp.light_next.blob, Sp_EventStateToColour((Sp_EventStateToNextState(_ARG_0_))))
      end
      UIButtons.PrivateTimeLineActive(GUI.sp.light_next.on, "light_on", true, 0)
      UIButtons.PrivateTimeLineActive(GUI.sp.light_next.blob, "light_on", true, 0)
    end
    GUI.sp.state = _ARG_0_
    UIButtons.TimeLineActive("medal_state_change", true, 0)
  end
  if GUI.sp.state_change_active == true then
    if GUI.sp.state_change_timer >= GUI.sp.state_change_timer_next then
      if GUI.sp.state_change_down == true then
        UISystem.PlaySound(UIEnums.SoundEffect.MedalDecrease)
      end
      for _FORV_7_ = GUI.sp.state_change_current, Select(GUI.sp.state_change_down, GUI.sp.state_change_target, GUI.sp.state_change_current) do
        UIButtons.SetActive(GUI.sp.light[_FORV_7_].on, true, true)
        SpSetStarTexture(GUI.sp.light[_FORV_7_].on, true, GUI.sp.state_change_state)
        UIButtons.ChangeColour(GUI.sp.light[_FORV_7_].blob, Sp_EventStateToColour(GUI.sp.state_change_state))
        UIButtons.PrivateTimeLineActive(GUI.sp.light[_FORV_7_].on, "light_on", true, 0)
        UIButtons.PrivateTimeLineActive(GUI.sp.light[_FORV_7_].blob, "light_on", true, 0)
        GUI.sp.state_change_timer_next = GUI.sp.state_change_timer_next + 0.125
        GUI.sp.state_change_current = GUI.sp.state_change_current + 1
        if GUI.sp.state_change_down == false then
          UISystem.PlaySound(UIEnums.SoundEffect.MedalIncrease)
        end
      end
      if _FOR_.sp.state_change_current > GUI.sp.state_change_target then
        GUI.sp.state_change_active = false
      end
    end
    GUI.sp.state_change_timer = GUI.sp.state_change_timer + _ARG_1_
  end
  if GUI.sp.next_arrow ~= nil and _ARG_0_ == "gold" and GUI.sp.beating_best ~= _ARG_2_ then
    if _ARG_2_ == true then
      UIButtons.ChangeColour(GUI.sp.next_arrow, "Support_0")
      UIButtons.ChangeOrientation(GUI.sp.next_arrow, 0, 0, 0)
    else
      UIButtons.ChangeColour(GUI.sp.next_arrow, "Support_3")
      UIButtons.ChangeOrientation(GUI.sp.next_arrow, 0, 0, 180)
    end
    GUI.sp.beating_best = _ARG_2_
  end
end
function HUD_SpCheckpointSetup(_ARG_0_, _ARG_1_)
  GUI.is_checkpoint_race = true
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), _ARG_0_, UIEnums.Justify.TopLeft)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Checkpoint_Title"), _ARG_0_, UIEnums.Justify.TopLeft)
  HUD_SpCreateLightPanel(_ARG_0_)
  HUD_SpCreateNextPanel(_ARG_0_, "HUD_SP_RACE_CHECKPOINT_TIME_DIFF_TO_MEDAL", UIText.HUD_BEST_TIME)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpCheckpointTimeAdded"), UIButtons.FindChildByName(HUD_SpCreateTimer(_ARG_1_, "HUD_SP_RACE_CHECKPOINT_TIME_LEFT"), "SpTimerScaleDummy"), UIEnums.Justify.MiddleCentre)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpCpBonusRB"), _ARG_1_, UIEnums.Justify.TopCentre)
  GUI.sp.cp_rb = UIButtons.CloneXtGadgetByName("hud_objects", "SpCpBonusRB")
  GUI.sp.cp_stopwatch_rb = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpCpBonusRB"), "SpCpBonusStopwatchRB")
  GUI.sp.cp_checkpoint_rb = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpCpBonusRB"), "SpCpBonusCheckpointRB")
  UIButtons.ChangeSize(UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpBlobStopwatchC"), 0 + UIButtons.GetSize((UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpStopwatchBonusIcon"))) + UIButtons.GetPosition((UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpStopwatchBonusTitle"))) + UIButtons.GetStaticTextLength((UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpStopwatchBonusTitle"))) + 20, UIButtons.GetSize((UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpBlobStopwatchC"))))
  UIButtons.ChangePosition(UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpStopwatchBonusIcon"), -((0 + UIButtons.GetSize((UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpStopwatchBonusIcon"))) + UIButtons.GetPosition((UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpStopwatchBonusTitle"))) + UIButtons.GetStaticTextLength((UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpStopwatchBonusTitle")))) / 2), UIButtons.GetPosition((UIButtons.FindChildByName(GUI.sp.cp_stopwatch_rb, "SpCpStopwatchBonusIcon"))))
  GUI.sp.cp_checkpoint_text = UIButtons.FindChildByName(GUI.sp.cp_checkpoint_rb, "SpCpCheckpointBonusTitle")
  GUI.sp.cp_checkpoint_blob = UIButtons.FindChildByName(GUI.sp.cp_checkpoint_rb, "SpCpBlobCheckpointC")
  GUI.sp.cp_bronze, GUI.sp.cp_silver, GUI.sp.cp_gold = Amax.SP_CheckpointRaceParams()
end
function HUD_SpCheckpointUpdate(_ARG_0_)
  HUD_SpStateUpdate(Amax.SP_CheckpointRaceState())
  HUD_SpTimerUpdate(Amax.SP_CheckpointRaceState())
  if GUI.sp.checkpoint_time_left == nil then
    GUI.sp.checkpoint_time_left = Amax.SP_CheckpointRaceState()
  else
    if Amax.SP_CheckpointRaceState() > GUI.sp.checkpoint_time_left then
      UIButtons.TimeLineActive("sp_timer_update", true)
    end
    GUI.sp.checkpoint_time_left = Amax.SP_CheckpointRaceState()
  end
end
function HUD_SpCheckpointPassed()
  if UIButtons.IsActive(GUI.mp_fan_msg_rb[1]) == false then
    UIButtons.TimeLineActive("checkpoint_show_bonus", false, 0)
    UIButtons.SetActive(GUI.sp.cp_stopwatch_rb, false)
    UIButtons.SetActive(GUI.sp.cp_checkpoint_rb, false)
  else
    UIButtons.TimeLineActive("checkpoint_show_bonus", true, 0)
    UIButtons.SetActive(GUI.sp.cp_stopwatch_rb, false)
    UIButtons.SetActive(GUI.sp.cp_checkpoint_rb, true)
  end
  UIButtons.ChangeSize(GUI.sp.cp_checkpoint_blob, UIButtons.GetStaticTextLength(GUI.sp.cp_checkpoint_text) + 20, UIButtons.GetSize(GUI.sp.cp_checkpoint_blob))
  UIButtons.TimeLineActive("checkpoint_show_bonus_time", true, 0)
end
function HUD_SpCheckpointCollectStopwatch()
  if UIButtons.IsActive(GUI.mp_fan_msg_rb[1]) == false then
    UIButtons.TimeLineActive("checkpoint_show_bonus", false, 0)
    UIButtons.SetActive(GUI.sp.cp_checkpoint_rb, false)
    UIButtons.SetActive(GUI.sp.cp_stopwatch_rb, false)
  else
    UIButtons.TimeLineActive("checkpoint_show_bonus", true, 0)
    UIButtons.SetActive(GUI.sp.cp_checkpoint_rb, false)
    UIButtons.SetActive(GUI.sp.cp_stopwatch_rb, true)
  end
  UIButtons.TimeLineActive("checkpoint_show_bonus_time", true, 0)
end
function HUD_SpDestructionSetup(_ARG_0_, _ARG_1_)
  GUI.is_destruction_race = true
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), _ARG_0_, UIEnums.Justify.TopLeft)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), _ARG_0_, UIEnums.Justify.TopLeft)
  GUI.sp.destruction_points_amount = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), "Points_Amount")
  UIButtons.GetStaticTextLength(GUI.sp.destruction_points_amount, true)
  HUD_SpCreateLightPanel(_ARG_0_)
  HUD_SpCreateNextPanel(_ARG_0_, "HUD_SP_RACE_DESTRUCTION_DIFF_TO_MEDAL", UIText.HUD_BEST_POINTS)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionTimeAdded"), UIButtons.FindChildByName(HUD_SpCreateTimer(_ARG_1_, "HUD_SP_RACE_DESTRUCTION_TIME_LEFT"), "SpTimerScaleDummy"), UIEnums.Justify.MiddleCentre)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionPointsRB"), _ARG_1_, UIEnums.Justify.TopCentre)
  GUI.sp.destruction_blob = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionPointsRB"), "SpDestructionBlobC")
  GUI.sp.destruction_string = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionPointsRB"), "SpDestructionBlobString")
  GUI.sp.destruction_points = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionPointsRB"), "SpDestructionPoints")
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionBonusPointsRB"), _ARG_1_, UIEnums.Justify.TopCentre)
  GUI.sp.destruction_bonus_blob = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionBonusPointsRB"), "SpDestructionBonusBlobC")
  GUI.sp.destruction_bonus_string = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionBonusPointsRB"), "SpDestructionBonusBlobString")
  GUI.sp.destruction_bonus_points = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionBonusPointsRB"), "SpDestructionBonusPoints")
  GUI.sp.destruction_rb = UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionPointsRB")
  GUI.sp.destruction_bonus_rb = UIButtons.CloneXtGadgetByName("hud_objects", "SpDestructionBonusPointsRB")
end
function HUD_SpDestructionUpdate(_ARG_0_)
  HUD_SpStateUpdate(Amax.SP_DestructionRaceState())
  HUD_SpTimerUpdate(Amax.SP_DestructionRaceState())
  if GUI.sp.destruction_time_left == nil then
    GUI.sp.destruction_time_left = Amax.SP_DestructionRaceState()
  else
    if Amax.SP_DestructionRaceState() > GUI.sp.destruction_time_left then
      UIButtons.TimeLineActive("sp_timer_update", true)
    end
    GUI.sp.destruction_time_left = Amax.SP_DestructionRaceState()
  end
end
function HUD_SpDestructionPointsAdded(_ARG_0_)
  if UIButtons.IsActive(GUI.mp_fan_msg_rb[1]) == false then
    UIButtons.TimeLineActive("show_destruction_points_small", true, 0)
    UIButtons.TimeLineActive("show_destruction_points", false, 0)
  else
    UIButtons.TimeLineActive("show_destruction_points", true, 0)
    UIButtons.TimeLineActive("show_destruction_points_bonus", true, Select(_ARG_0_ == true, 0, 100))
  end
  UIButtons.ChangeSize(GUI.sp.destruction_blob, 0 + UIButtons.GetStaticTextLength(GUI.sp.destruction_string, true) + UIButtons.GetPosition(GUI.sp.destruction_points) + UIButtons.GetStaticTextLength(GUI.sp.destruction_points, true) + 20, UIButtons.GetSize(GUI.sp.destruction_blob))
  UIButtons.ChangePosition(GUI.sp.destruction_string, -((0 + UIButtons.GetStaticTextLength(GUI.sp.destruction_string, true) + UIButtons.GetPosition(GUI.sp.destruction_points) + UIButtons.GetStaticTextLength(GUI.sp.destruction_points, true)) / 2), UIButtons.GetPosition(GUI.sp.destruction_string))
  UIButtons.GetStaticTextLength(GUI.sp.destruction_points_amount, true)
  UIButtons.TimeLineActive("show_destruction_points_time", true, 0)
end
function HUD_SpDestructionBonusHitStart()
  if UIButtons.IsActive(GUI.mp_fan_msg_rb[1]) == false then
    UIButtons.TimeLineActive("show_destruction_bonus_points_start", false, 0)
    UIButtons.TimeLineActive("show_destruction_bonus_points_added", false, 0)
  else
    UIButtons.TimeLineActive("show_destruction_bonus_points_start", true, 0)
    UIButtons.TimeLineActive("show_destruction_bonus_points_added", true, 0)
  end
  UIButtons.ChangeSize(GUI.sp.destruction_bonus_blob, 0 + UIButtons.GetStaticTextLength(GUI.sp.destruction_bonus_string, true) + UIButtons.GetPosition(GUI.sp.destruction_bonus_points) + UIButtons.GetStaticTextLength(GUI.sp.destruction_bonus_points, true) + 20, UIButtons.GetSize(GUI.sp.destruction_bonus_blob))
  UIButtons.ChangePosition(GUI.sp.destruction_bonus_string, -((0 + UIButtons.GetStaticTextLength(GUI.sp.destruction_bonus_string, true) + UIButtons.GetPosition(GUI.sp.destruction_bonus_points) + UIButtons.GetStaticTextLength(GUI.sp.destruction_bonus_points, true)) / 2), UIButtons.GetPosition(GUI.sp.destruction_bonus_string))
  UIButtons.GetStaticTextLength(GUI.sp.destruction_points_amount, true)
end
function HUD_SpDestructionBonusHitAdded()
  UIButtons.TimeLineActive("show_destruction_bonus_points_added", true, 0)
end
function HUD_SpDestructionBonusHitEnd()
  UIButtons.TimeLineActive("show_destruction_bonus_points_start", false)
end
function HUD_SpFanDemandFansAdded()
  UIButtons.TimeLineActive("fan_demand_fans_added", true, 0)
end
function HUD_SpFanDemandSetup(_ARG_0_, _ARG_1_)
  GUI.is_fan_demand_race = true
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), _ARG_0_, UIEnums.Justify.TopLeft)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "FanDemand_Title"), _ARG_0_, UIEnums.Justify.TopLeft)
  HUD_SpCreateLightPanel(_ARG_0_)
  HUD_SpCreateNextPanel(_ARG_0_, "HUD_SP_RACE_FAN_DEMAND_DIFF_TO_MEDAL", UIText.HUD_BEST_FANS)
  HUD_SpCreateTimer(_ARG_1_, "HUD_SP_RACE_FAN_DEMAND_TIME_LEFT")
end
function HUD_SpFanDemandUpdate(_ARG_0_)
  HUD_SpStateUpdate(Amax.SP_FanDemandRaceState())
  HUD_SpTimerUpdate(Amax.SP_FanDemandRaceState())
end
function HUD_SpBossSetup(_ARG_0_, _ARG_1_)
  GUI.is_boss_race = true
  for _FORV_6_ = 1, Amax.GetNumVehicles() - 1 do
    HUD_SpBossSetupCarHealth(0 + 1, _FORV_6_, false, _ARG_0_, _ARG_1_)
  end
  HUD_SpBossSetupCarHealth(0 + 1 + 1, 0, true, _ARG_0_, _ARG_1_)
  UIButtons.TimeLineActive("boss_show", true, 100)
end
function HUD_SpBossSetupCarHealth(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  GUI.sp_boss_offset = 4
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), _ARG_3_, UIEnums.Justify.TopLeft)
  _, GUI.sp.boss_start_y, _ = UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop")))
  UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"))))
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealthName"), Amax.SP_GetCharacterFromVehicle(_ARG_1_).name)
  if _ARG_2_ == true then
    LocalGamerPicture(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealthPic"), Profile.GetPrimaryPad())
  else
    AIGamerPicture(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealthPic"), Amax.SP_GetCharacterFromVehicle(_ARG_1_).avatar)
  end
  UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealth"), "vehicle_index_override", _ARG_1_)
  UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealth"), "boss", true)
  UIButtons.SetXtVar(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpBossHealthBackingTop"), "SpBossHealth"), "always_do_effect", true)
end
function HUD_SpStreetRaceSetup(_ARG_0_, _ARG_1_)
  GUI.is_street_race = true
  HUD_SpCreateLightPanel(_ARG_0_)
  HUD_SpCreateNextPanel(_ARG_0_, "HUD_SP_RACE_STREET_DIFF_TO_MEDAL", UIText.HUD_BEST_FANS)
end
function HUD_SpStreetRaceUpdate(_ARG_0_)
  HUD_SpStateUpdate(Amax.SP_StreetRaceState())
end
function HUD_SpSetupFD(_ARG_0_, _ARG_1_)
  GUI.is_race_fd = true
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), _ARG_0_, UIEnums.Justify.TopLeft)
  if GUI.is_boss_race == true then
    UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"))))
  end
  UIButtons.PrivateTimeLineActive(HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpLightDummyFD"), 0).on, "light_on", true, 0)
  UIButtons.PrivateTimeLineActive(HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpLightDummyFD"), 0).blob, "light_on", true, 0)
  SpSetStarTexture(HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpLightDummyFD"), 0).on, true, FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).state)
  UIButtons.ChangeColour(HUD_SpCreateLight(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpLightDummyFD"), 0).blob, Sp_EventStateToColour(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).state))
  GUI.sp.fd_state = FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).state
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpMedalInfoFD"), "HUD_SP_FD_RACE_MEDAL_TARGET_" .. Sp_EventStateToNumber(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).state))
  GUI.sp.fd_pass = {}
  GUI.sp.fd_pass[1] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpMedalPassFD")
  GUI.sp.fd_fail = {}
  GUI.sp.fd_fail[1] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpMedalFailFD")
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD2"), UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), UIEnums.Justify.TopLeft)
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD2"), "SpTitleFD2"), "GAME_FRIEND_DEMAND_STORE_CRITERIA_TITLE_" .. UIGlobals.FriendDemandAttemptingIndex .. "_0")
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD2"), "SpInfoFD2"), "HUD_SP_FD_RACE_CRITERIA")
  GUI.sp.fd_pass[2] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpMedalPassFD2")
  GUI.sp.fd_fail[2] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpMedalFailFD2")
  UIButtons.ChangeTexture(Fd_GetCriteriaIconInfo(SinglePlayer.EventInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).eventid_sp).kind).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpIconFD2")))
  UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpIconFD2"), Fd_GetCriteriaIconInfo(SinglePlayer.EventInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).eventid_sp).kind).effect)
  if FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).extra_modifier ~= UIEnums.FriendDemandModifer.NotUsed then
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD3"), UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), UIEnums.Justify.TopLeft)
    Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD3"), "SpTitleFD3"), "GAME_FRIEND_DEMAND_STORE_PARAM_TITLE_" .. UIGlobals.FriendDemandAttemptingIndex .. "_0")
    Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD3"), "SpInfoFD3"), "HUD_SP_FD_RACE_PARAM")
    GUI.sp.fd_pass[3] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpMedalPassFD3")
    GUI.sp.fd_fail[3] = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpMedalBackingTopFD"), "SpMedalFailFD3")
    UIButtons.ChangeTexture(Fd_GetParamIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).extra_param).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD3"), "SpIconFD3")))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD3"), "SpIconFD3"), Fd_GetParamIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).extra_param).effect)
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD3"), "SpIconFD3"), Fd_GetParamIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).extra_param).colour)
    UIButtons.ChangeTexture(Fd_GetModifierIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).extra_modifier).tex, 0, (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD3"), "SpIconModifierFD3")))
    UIButtons.ChangeEffectIndex(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "SpDummyFD3"), "SpIconModifierFD3"), Fd_GetModifierIconInfo(FriendDemand.GetInfo(UIGlobals.FriendDemandAttemptingIndex).extra_modifier).effect)
  end
end
function HUD_SpUpdateFD(_ARG_0_)
  if GUI.is_boss_race == true then
    GUI.sp.state = Amax.SP_BossRaceState()
  end
  if Sp_EventStateToStars(GUI.sp.state, GUI.is_boss_race) >= Sp_EventStateToStars(GUI.sp.fd_state, GUI.is_boss_race) ~= GUI.sp.fd_passing_medal then
    UIButtons.SetActive(GUI.sp.fd_pass[1], Sp_EventStateToStars(GUI.sp.state, GUI.is_boss_race) >= Sp_EventStateToStars(GUI.sp.fd_state, GUI.is_boss_race))
    UIButtons.SetActive(GUI.sp.fd_fail[1], not (Sp_EventStateToStars(GUI.sp.state, GUI.is_boss_race) >= Sp_EventStateToStars(GUI.sp.fd_state, GUI.is_boss_race)))
    GUI.sp.fd_passing_medal = Sp_EventStateToStars(GUI.sp.state, GUI.is_boss_race) >= Sp_EventStateToStars(GUI.sp.fd_state, GUI.is_boss_race)
  end
  if Amax.SP_StateFD() ~= GUI.sp.passing_criteria then
    UIButtons.SetActive(GUI.sp.fd_pass[2], Amax.SP_StateFD())
    UIButtons.SetActive(GUI.sp.fd_fail[2], not Amax.SP_StateFD())
    GUI.sp.passing_criteria = Amax.SP_StateFD()
  end
  if Amax.SP_StateFD() ~= GUI.sp.passing_param then
    if GUI.sp.fd_pass[3] ~= nil and GUI.sp.fd_fail[3] ~= nil then
      UIButtons.SetActive(GUI.sp.fd_pass[3], Amax.SP_StateFD())
      UIButtons.SetActive(GUI.sp.fd_fail[3], not Amax.SP_StateFD())
    end
    GUI.sp.passing_param = Amax.SP_StateFD()
  end
end
function RefreshLastGaspVars()
  if Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false then
    UIGlobals.Ingame.last_gasp_mode_active = Amax.LastGaspModeActive(0)
    UIGlobals.Ingame.can_fire_last_gasp = Amax.LastGaspModeActive(0)
    UIGlobals.Ingame.has_last_gasp = Amax.PlayerHasLastGasp(0)
    UIGlobals.Ingame.last_gasp_timer = Amax.GetLastGaspTime(0)
  end
end
function SyncLastGaspHudToVars()
  if Amax.IsGameModeMultiplayer() == true and IsSplitScreen() == false then
    UIButtons.SetActive(UIButtons.FindChildByName(GUI.inter_3d_ids[1], "LastGaspRenderBranch"), UIGlobals.Ingame.last_gasp_mode_active)
    UIButtons.SetActive(GUI.LastGaspPowerupSlotID, UIGlobals.Ingame.last_gasp_mode_active, true)
    if UIGlobals.Ingame.last_gasp_timer <= 0 then
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.LastGaspPowerupSlotID, "time_LastGasp_OnCar"), false, true)
    else
      UIButtons.SetActive(UIButtons.FindChildByName(GUI.LastGaspPowerupSlotID, "time_LastGasp_OnCar"), true, true)
    end
  end
end
function HUD_ActivateECMWarning(_ARG_0_)
  UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.inter_3d_ids[_ARG_0_ + 1], "targeting_bottom"), "Slot3")
end
function HUD_DeactivateECMWarning(_ARG_0_)
  UIButtons.ChangeColour(UIButtons.FindChildByName(GUI.inter_3d_ids[_ARG_0_ + 1], "targeting_bottom"), "Support_3")
end
function HUD_MpDestructionPositionUpdate()
  if NetRace.IsTeamGame() == true then
    return
  end
  for _FORV_3_ = 1, GUI.num_players do
    if GUI.mp_destruction_positions[_FORV_3_] ~= -1 then
      UIButtons.ChangeColour(GUI.mp_destruction_ids[_FORV_3_].icon, (GetResultColour(-1)))
      UIButtons.ChangeColour(GUI.mp_destruction_ids[_FORV_3_].blob, (GetResultColour(-1)))
      UIButtons.PrivateTimeLineActive(GUI.mp_destruction_ids[_FORV_3_].blob, "light_on", true, 0)
      GUI.mp_destruction_positions[_FORV_3_] = -1
    end
  end
end
function HUD_MpDestructionRivalUpdate()
  if NetRace.IsTeamGame() == true then
    return
  end
  if Multiplayer.GetRivalsCountdownDelayActive() == false and GUI.mp_rivals_active == true then
    return
  end
  if Multiplayer.GetRivalsCountdownDelayActive() == false and GUI.mp_rivals_on ~= true then
    UIButtons.TimeLineActive("boss_show", true, 0.25)
    for _FORV_5_ = 1, GUI.num_players do
      UIButtons.SetActive(GUI.mp_rivals_ids[_FORV_5_].pic, false, true)
      UIButtons.SetActive(GUI.mp_rivals_ids[_FORV_5_].rival_title, true)
      UIButtons.SetActive(GUI.mp_rivals_ids[_FORV_5_].rival_time, true)
    end
    _FOR_.mp_rivals_on = true
  end
  if Multiplayer.GetRivalsCountdownDelayActive() == false and GUI.mp_rivals_active ~= true then
    UIButtons.TimeLineActive("boss_show", true, 0)
    for _FORV_5_ = 1, GUI.num_players do
      UIButtons.SetActive(GUI.mp_rivals_ids[_FORV_5_].pic, true, true)
      UIButtons.SetActive(GUI.mp_rivals_ids[_FORV_5_].rival_title, false)
      UIButtons.SetActive(GUI.mp_rivals_ids[_FORV_5_].rival_time, false)
      HUD_MpDestructionRivalChange(_FORV_5_)
    end
    _FOR_.mp_rivals_active = true
  end
end
function HUD_MpDestructionRivalChange(_ARG_0_)
  if NetRace.IsTeamGame() == true then
    return
  end
  UIButtons.ChangeText(GUI.mp_rivals_ids[_ARG_0_].name, "MPL_SPECTATE_NAME" .. Multiplayer.GetRivalIndex(_ARG_0_))
  if IsSplitScreen() == true then
    LocalGamerPicture(GUI.mp_rivals_ids[_ARG_0_].pic, UIGlobals.Splitscreen.players[Multiplayer.GetRivalIndex(_ARG_0_) + 1].pad)
  else
    RemoteGamerPicture(GUI.mp_rivals_ids[_ARG_0_].pic, Profile.GetRemoteGamerPictureMap()[Multiplayer.VehicleIDToJoinID(Multiplayer.GetRivalIndex(_ARG_0_) + 1)])
  end
  UIButtons.SetXtVar(GUI.mp_rivals_ids[_ARG_0_].health, "vehicle_index_override", (Multiplayer.GetRivalIndex(_ARG_0_)))
  UIButtons.SetXtVar(GUI.mp_rivals_ids[_ARG_0_].health, "boss", true)
  UIButtons.SetXtVar(GUI.mp_rivals_ids[_ARG_0_].health, "always_do_effect", true)
  UIButtons.PrivateTimeLineActive(GUI.mp_rivals_ids[_ARG_0_].blob, "rival_changed", true, 0)
end
function HUD_MpDestructionSetupTeam(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), _ARG_0_, UIEnums.Justify.TopLeft)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), UIEnums.Justify.TopLeft)
  UIButtons.ChangeText(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), Select(_ARG_2_ == "team_a", UIText.MP_TEAM_A_NAME, UIText.MP_TEAM_B_NAME))
  UIButtons.ChangeColour(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), UIGlobals.TeamColours[_ARG_2_])
  UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), nil, -0.25, nil, true)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), "Points_Amount"), "HUD_" .. _ARG_1_ .. Select(_ARG_3_, "_MP_TEAM_POINTS_CURRENT", "_MP_TEAM_POINTS_OPPOSITION"))
  UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), "SpDestructionPointsSmall"), false)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"), UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), UIEnums.Justify.MiddleLeft)
  UIButtons.ChangeTextureUV(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"), 0, UIGlobals.TeamIcons[_ARG_2_].u, UIGlobals.TeamIcons[_ARG_2_].v)
  UIButtons.ChangeColour(UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"), UIGlobals.TeamColours[_ARG_2_])
  UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), UIButtons.GetSize((UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"))))
  UIButtons.ChangePosition(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("hud_objects", "Points_Title"), "Points_Amount"), -UIButtons.GetSize((UIButtons.CloneXtGadgetByName("hud_objects", "Position_Team_Icon"))), nil, nil, true)
  if _ARG_3_ == false then
    UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), nil, -5.825, nil, true)
    UIButtons.ChangeScale(UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"), UIButtons.GetScale((UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"))) * 0.825, UIButtons.GetScale((UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"))) * 0.825, UIButtons.GetScale((UIButtons.CloneXtGadgetByName("hud_objects", "Pos_Backing"))))
  end
end
