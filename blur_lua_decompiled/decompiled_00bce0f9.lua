GUI = {finished = false}
function Init()
  Amax.SendMessage(UIEnums.GameFlowMessage.CutsceneVideoStarted)
  RemapMovieTracks()
  SetupMovie(0, "Ui\\Movies\\BlurAttract.bik", nil, nil, false, true)
  UISystem.EnableMovieLooping(0, false)
  UIScreen.SetScreenTimers(0.3, 0.3)
  UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUpDown")
  SetupInfoLine()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MovieFinished and _ARG_1_ == 0 then
    GoScreen("SinglePlayer\\SpMain.lua")
  elseif (_ARG_0_ == UIEnums.Message.ButtonStart or _ARG_0_ == UIEnums.Message.MenuNext) and _ARG_2_ == true then
    PlaySfxNext()
    GoScreen("SinglePlayer\\SpMain.lua")
  end
end
function FrameUpdate(_ARG_0_)
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  Amax.SendMessage(UIEnums.GameFlowMessage.CutsceneVideoFinished)
  UISystem.DestroyMovie(0)
  Amax.SetUICarToMultiplayer(false)
  print("IntroMove finished, calling LoadSPProfileCar")
  Amax.SendMessage(UIEnums.GameFlowMessage.LoadSPProfileCar)
end
