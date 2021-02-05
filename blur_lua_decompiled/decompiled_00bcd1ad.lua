GUI = {
  finished = false,
  StartGame = function()
    GoScreen("Intro\\BizarreSplash.lua")
  end
}
function Init()
  print("PS3 : Install attract movie")
  UIGlobals.Ps3InstallState = UIEnums.Ps3InstallState.COPY_ATTRACT
  Amax.Ps3PrimeInstaller(false)
  Profile.AllowProfileChanges(true)
  Profile.ActOnProfileChanges(false)
  Profile.AllowAllPadInput(true)
  AddSCUI_Elements()
  UIScreen.SetScreenTimers(0.3, 0.3)
  UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUpDown")
  SetupMovie(0, "Ui\\Movies\\atvi.bik", nil, nil, false, true)
  UISystem.EnableMovieLooping(0, false)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MovieFinished and _ARG_1_ == 0 then
    GUI.StartGame()
  elseif (_ARG_0_ == UIEnums.Message.ButtonStart or _ARG_0_ == UIEnums.Message.MenuNext) and UIGlobals.Ps3InstallState == UIEnums.Ps3InstallState.NONE then
    PlaySfxNext()
    GUI.StartGame()
  end
end
function FrameUpdate(_ARG_0_)
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  UISystem.DestroyMovie(0)
end
