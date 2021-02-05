GUI = {finished = false}
function Init()
  Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
  UIScreen.SetScreenTimers(0.3, 0.3)
  UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUpDown")
  Amax.SendMessage(UIEnums.GameFlowMessage.CutsceneVideoStarted)
  RemapMovieTracks()
  SetupMovie(0, "Ui\\Movies\\BlurAttract.bik", nil, nil, false, true)
  UISystem.EnableMovieLooping(0, false)
end
function StartLoop(_ARG_0_)
end
function AttractSplash_GoStartScreen()
  Amax.SetLoadingScreen(false)
  Amax.SendMessage(UIEnums.GameFlowMessage.StartGameRendering)
  GoScreen("Intro\\StartScreen.lua")
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MovieFinished and _ARG_1_ == 0 then
    AttractSplash_GoStartScreen()
  elseif (_ARG_0_ == UIEnums.Message.ButtonStart or _ARG_0_ == UIEnums.Message.MenuNext or _ARG_0_ == UIEnums.Message.MouseClickLeft) and _ARG_2_ == true then
    PlaySfxNext()
    AttractSplash_GoStartScreen()
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
  if NetServices.GameInvitePending() == true then
    AttractSplash_GoStartScreen()
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  AttractSplash_GoStartScreen = nil
  Amax.SendMessage(UIEnums.GameFlowMessage.CutsceneVideoFinished)
  UISystem.DestroyMovie(0)
  UIGlobals.DoFadeUp = true
end
