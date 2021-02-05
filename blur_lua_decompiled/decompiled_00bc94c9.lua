GUI = {
  finished = false,
  timer = 0.3,
  stage_time = 5,
  pack_stage_time = 3,
  show_skip = false,
  allow_skip = false,
  stage = 0
}
function Init()
  AddSCUI_Elements()
  Amax.SetGlobalFade(1)
  UIScreen.SetScreenTimers(0, 0)
  if IsSplitScreen() == true then
    Amax.SetNumViewports(1)
  end
  Amax.FadeUpIngameAudio()
  Amax.StartAnimatedCamera(UIEnums.AnimatedCameraSequenceType.RouteVista, true)
  GUI.allow_skip = Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer
  if Amax.IsRaceMpDestruction() == true then
    Amax.StartAnimatedCamera(UIEnums.AnimatedCameraSequenceType.RaceStart4, true, -1, 0, true)
  else
    Amax.StartAnimatedCamera(IntroVista_SecondSequence())
  end
  if IsTable((Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista))) == true then
    UIButtons.ChangePosition(SCUI.name_to_id.Vista, XtToScreenSpaceX(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).px), (XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py)))
    UIButtons.ChangePosition(SCUI.name_to_id.WriteFadeCutoutStencil0, SCREEN_LEFT, (XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py)))
    UIButtons.ChangePosition(SCUI.name_to_id.TopSetStencil128, SCREEN_LEFT, (XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py)))
    UIButtons.ChangeSize(SCUI.name_to_id.WriteFadeCutoutStencil0, 857, XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py) + 2)
    UIButtons.ChangeTexture({
      filename = "LOADING_TEXTURE",
      pos = {
        u = 0,
        v = (XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py) + 2) / 480
      },
      size = {u = 1, v = 1}
    }, 0, SCUI.name_to_id.Bottom)
    {
      filename = "LOADING_TEXTURE",
      pos = {
        u = 0,
        v = (XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py) + 2) / 480
      },
      size = {u = 1, v = 1}
    }.size.v = {
      filename = "LOADING_TEXTURE",
      pos = {
        u = 0,
        v = (XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py) + 2) / 480
      },
      size = {u = 1, v = 1}
    }.pos.v
    {
      filename = "LOADING_TEXTURE",
      pos = {
        u = 0,
        v = (XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py) + 2) / 480
      },
      size = {u = 1, v = 1}
    }.pos.v = 0
    UIButtons.ChangeTexture({
      filename = "LOADING_TEXTURE",
      pos = {
        u = 0,
        v = (XtToScreenSpaceY(Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).py) + 2) / 480
      },
      size = {u = 1, v = 1}
    }, 0, SCUI.name_to_id.WriteFadeCutoutStencil0)
    if 0 < Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).time then
      GUI.stage_time = Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista).time
    end
    GUI.anim_camera = Amax.GetAnimatedCameraParams(UIEnums.AnimatedCameraSequenceType.RouteVista)
  end
  if Amax.IsNetworkRace() == true then
    if IsTable((Multiplayer.GetCurrentRace())) == true then
    end
  elseif Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
  end
end
function PostInit()
  if IsTable(GUI.anim_camera) == true then
    UIButtons.TimeLineActive(GUI.anim_camera.anim, true, true)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and GUI.allow_skip == true and GUI.stage == 1 and GUI.show_skip == true then
    IntroVista_GoSecondSequence()
    UISystem.PlaySound(UIEnums.SoundEffect.SkipVista)
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.timer > 0 then
    GUI.timer = GUI.timer - _ARG_0_
    if GUI.allow_skip == true and GUI.show_skip == false and GUI.stage == 1 and GUI.timer < GUI.stage_time - 0.7 then
      GUI.show_skip = true
      SetupInfoLine(UIText.INFO_SKIP_A)
    end
    if GUI.timer <= 0 then
      if GUI.stage == 0 then
        Amax.StartAnimatedCamera(0, false)
        GUI.timer = GUI.stage_time
        GUI.stage = 1
      elseif GUI.stage == 1 then
        IntroVista_GoSecondSequence()
      else
        GoScreen("Ingame\\IntroRace.lua")
      end
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
function IntroVista_SecondSequence()
  if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer and (Amax.SP_IsBossRace() == true or Amax.SP_IsBossBattleFD() == true) then
    return UIEnums.AnimatedCameraSequenceType.RivalSeq01, 1
  end
  return UIEnums.AnimatedCameraSequenceType.RoutePack, -1
end
function IntroVista_GoSecondSequence()
  GUI.show_skip = false
  SetupInfoLine()
  if Amax.IsNetworkRace() == true then
    Amax.SendMessage(UIEnums.GameFlowMessage.BeginRollingStart)
  else
    UIScreen.AddMessage(UIEnums.CutScene.StartScriptedCamera)
  end
  UIButtons.TimeLineActive("route", true)
  if Amax.IsRaceMpDestruction() == true then
    GoScreen("Ingame\\IntroRace.lua")
  else
    GUI.timer = GUI.pack_stage_time
    GUI.stage = 2
    Amax.StartAnimatedCamera(IntroVista_SecondSequence())
    Amax.StartAnimatedCamera(UIEnums.AnimatedCameraSequenceType.RaceStart4, true, 0, 0, true)
  end
end
