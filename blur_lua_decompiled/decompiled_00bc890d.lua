GUI = {
  finished = false,
  show_rival = false,
  countdown_time = 3,
  countdown_clamp = 3,
  anims = {"scale_x", "scale_y"},
  packshot_stages = {
    {
      cam = UIEnums.AnimatedCameraSequenceType.RoutePack,
      time = 3,
      px = 10,
      py = 0,
      sx = 140,
      sy = 18,
      anim = "scale_y"
    }
  },
  rival_stages = {
    {
      cam = UIEnums.AnimatedCameraSequenceType.RivalSeq01,
      time = 1.5,
      player = 1,
      px = 20,
      py = 24,
      sx = 18,
      sy = 96,
      anim = "scale_y"
    },
    {
      cam = UIEnums.AnimatedCameraSequenceType.RivalSeq02,
      time = 1.5,
      player = 1,
      px = -20,
      py = 24
    }
  },
  countdown_stages = {
    {
      cam = UIEnums.AnimatedCameraSequenceType.RaceStart4,
      time = 1,
      player = true,
      px = 0,
      py = 0,
      sx = 18,
      sy = 48,
      anim = "scale_y"
    },
    {
      cam = UIEnums.AnimatedCameraSequenceType.RaceStart3,
      time = 1,
      player = true,
      px = 40,
      py = 0,
      sx = 160,
      sy = 18,
      anim = "scale_y"
    },
    {
      cam = UIEnums.AnimatedCameraSequenceType.RaceStartGO,
      time = 1,
      player = true,
      px = 0,
      py = 0,
      anim = "scale_y"
    }
  },
  SEQ_PACKSHOT = 0,
  SEQ_RIVAL = 1,
  SEQ_COUNTDOWN = 2,
  SEQ_HUD = 3
}
function Init()
  if IsSplitScreen() == true then
    Amax.SetNumViewports(#UIGlobals.Splitscreen.players)
  end
  Splitscreen_AddSplits()
  GUI.num_players = Amax.GetNumViewports()
  for _FORV_3_ = 1, GUI.num_players do
    Amax.StartAnimatedCamera(UIEnums.AnimatedCameraSequenceType.RaceStartGO, true, _FORV_3_ - 1, _FORV_3_ - 1, true)
  end
  _FOR_()
  Amax.SetGlobalFade(1)
  UIScreen.SetScreenTimers(0, 0)
  GUI.wipe_id = SCUI.name_to_id.Wipe
  UIScreen.AddMessage(UIEnums.UIGameMessage.RaceStartsIn, GUI.countdown_clamp)
  UIScreen.AddMessageNow(UIEnums.GameMessage.SetLocalPlayerIndex, 0)
  GUI.countdown_time = 3
  UISystem.PlaySound(UIEnums.SoundEffect.RaceStartCountdown)
  GUI.timer = 0
  GUI.stage_index = 1
  GUI.seq_index = GUI.SEQ_COUNTDOWN
end
function IntroRace_ResetAnims()
  for _FORV_3_, _FORV_4_ in ipairs(GUI.anims) do
    UIButtons.TimeLineActive(_FORV_4_, true, 10, true)
  end
end
function PostInit()
  GUI.countdown_id = {}
  for _FORV_3_ = 1, GUI.num_players do
    GUI.countdown_id[_FORV_3_] = {}
    for _FORV_9_, _FORV_10_ in ipairs({
      UIButtons.CloneXtGadgetByName("hud_objects", "CountdownNode1"),
      UIButtons.CloneXtGadgetByName("hud_objects", "CountdownNode2"),
      UIButtons.CloneXtGadgetByName("hud_objects", "CountdownNode3")
    }) do
      UIButtons.ChangePanel(UIButtons.FindChildByName(_FORV_10_, "CDText"), UIEnums.Panel._VP0 + (_FORV_3_ - 1))
      GUI.countdown_id[_FORV_3_][_FORV_9_] = UIButtons.FindChildByName(_FORV_10_, "CDText")
    end
    UIScreen.AddMessageNow(UIEnums.GameMessage.SetLocalPlayerIndex, _FORV_3_ - 1)
  end
  if _FOR_.IsRaceMpDestruction() == true then
    GUI.seq_index = GUI.SEQ_COUNTDOWN
    GUI.countdown_time = 3
    UISystem.PlaySound(UIEnums.SoundEffect.RaceStartCountdown)
    UIButtons.TimeLineActive("countdown_intro", true, 3, true)
  end
  IntroRace_InitSequence()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if GUI.countdown_time > 0 then
    GUI.countdown_time = GUI.countdown_time - _ARG_0_
    if GUI.countdown_time < 0 then
      GUI.countdown_time = -1
    end
    if GUI.countdown_time > GUI.countdown_clamp then
    elseif math.ceil(GUI.countdown_time) ~= math.ceil(GUI.countdown_clamp) and 0 <= GUI.countdown_clamp and math.ceil(GUI.countdown_clamp) ~= 0 then
      UISystem.PlaySound(UIEnums.SoundEffect.RaceStartCountdown)
    end
    UIScreen.AddMessage(UIEnums.UIGameMessage.RaceStartsIn, GUI.countdown_time)
  end
  GUI.timer = GUI.timer - _ARG_0_
  if 0 >= GUI.timer then
    GUI.timer = 0
    GUI.stage_index = GUI.stage_index + 1
    if GUI.stage_index > #GUI.stages then
      GUI.stage_index = 1
      GUI.seq_index = GUI.seq_index + 1
      if GUI.seq_index == GUI.SEQ_RIVAL and GUI.show_rival ~= true then
        GUI.seq_index = GUI.seq_index + 1
      end
      if GUI.seq_index == GUI.SEQ_HUD then
        UIGlobals.Ingame.IntroHUD = true
        GoScreen("Ingame\\Hud.lua")
      else
        IntroRace_InitSequence()
      end
    else
      IntroRace_InitStage()
      Amax.ResetViewpointVisibility()
      if GUI.seq_index == GUI.SEQ_COUNTDOWN then
        for _FORV_4_ = 1, GUI.num_players do
          for _FORV_8_, _FORV_9_ in ipairs(GUI.countdown_id[_FORV_4_]) do
            UIButtons.SetActive(_FORV_9_, GUI.stage_index == _FORV_8_)
          end
        end
      end
      if _FOR_.seq_index == GUI.SEQ_COUNTDOWN and GUI.stage_index == #GUI.stages then
        for _FORV_4_ = 1, GUI.num_players do
          Amax.BlendAnimatedCamera(1, _FORV_4_ - 1, _FORV_4_ - 1)
        end
      end
    end
  end
end
function IntroRace_InitStage()
  if IsTable(GUI.stages) == false then
    print("Invalid stage table", GUI.stage_index, GUI.seq_index)
    return
  end
  if IsTable(GUI.stages[GUI.stage_index]) == false then
    print("Invalid cam table", GUI.stage_index, GUI.seq_index)
    return
  end
  IntroRace_ReadAnimTable(GUI.stages[GUI.stage_index])
  GUI.timer = GUI.stages[GUI.stage_index].time
  if IsNumber(GUI.stages[GUI.stage_index].cam) == true then
    if GUI.stages[GUI.stage_index].player == true then
      for _FORV_4_ = 1, GUI.num_players do
        Amax.StartAnimatedCamera(GUI.stages[GUI.stage_index].cam, false, _FORV_4_ - 1, _FORV_4_ - 1)
      end
    else
      Amax.StartAnimatedCamera(GUI.stages[GUI.stage_index].cam, false, GUI.stages[GUI.stage_index].player, GUI.stages[GUI.stage_index].player)
    end
  end
  if IsNumber(GUI.stages[GUI.stage_index].px) == true and IsNumber(GUI.stages[GUI.stage_index].py) == true then
    UIButtons.ChangePosition(GUI.wipe_id, GUI.stages[GUI.stage_index].px, GUI.stages[GUI.stage_index].py)
  end
  if IsNumber(GUI.stages[GUI.stage_index].sx) == true and IsNumber(GUI.stages[GUI.stage_index].sy) == true then
    UIButtons.ChangeSize(GUI.wipe_id, GUI.stages[GUI.stage_index].sx, GUI.stages[GUI.stage_index].sy)
  end
  IntroRace_ResetAnims()
  if GUI.stages[GUI.stage_index].forwards ~= false then
  end
  if IsString(GUI.stages[GUI.stage_index].anim) == true then
    UIButtons.TimeLineActive(GUI.stages[GUI.stage_index].anim, true, 0, true)
  end
end
function IntroRace_ReadAnimTable(_ARG_0_)
  if IsTable(_ARG_0_) == false then
    return
  end
  if IsTable((Amax.GetAnimatedCameraParams(_ARG_0_.cam))) == false then
    return
  end
  if Amax.GetAnimatedCameraParams(_ARG_0_.cam).sx <= 0 and 0 >= Amax.GetAnimatedCameraParams(_ARG_0_.cam).sy then
    return
  end
  _ARG_0_.px = Amax.GetAnimatedCameraParams(_ARG_0_.cam).px / 1.5 + 320
  _ARG_0_.py = Amax.GetAnimatedCameraParams(_ARG_0_.cam).py / 1.5 + 240
  _ARG_0_.sx = Amax.GetAnimatedCameraParams(_ARG_0_.cam).sx / 1.5
  _ARG_0_.sy = Amax.GetAnimatedCameraParams(_ARG_0_.cam).sy / 1.5
  _ARG_0_.anim = Amax.GetAnimatedCameraParams(_ARG_0_.cam).anim
  _ARG_0_.forwards = Amax.GetAnimatedCameraParams(_ARG_0_.cam).forwards
end
function IntroRace_InitSequence()
  if GUI.seq_index == GUI.SEQ_PACKSHOT then
    GUI.stages = GUI.packshot_stages
  end
  if GUI.seq_index == GUI.SEQ_RIVAL then
    GUI.stages = GUI.rival_stages
  end
  if GUI.seq_index == GUI.SEQ_COUNTDOWN then
    GUI.stages = GUI.countdown_stages
  end
  IntroRace_InitStage()
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  UISystem.PlaySound(UIEnums.SoundEffect.RaceStart)
end
