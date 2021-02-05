GUI = {finished = false, wait_for_copy = false}
function Init()
  AddSCUI_Elements()
  UIScreen.SetScreenTimers(0.3, 0.3)
  UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUpDown")
  SetupMovie(0, "Ui\\Movies\\BizarreSplash.bik", nil, nil, false, true)
  UISystem.EnableMovieLooping(0, false)
  StoreScreen(UIEnums.ScreenStorage.LOAD_NEXT, "Intro\\Legal.lua")
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MovieFinished and _ARG_1_ == 0 then
    print("State", UIGlobals.Ps3InstallState)
    if UIGlobals.Ps3InstallState == UIEnums.Ps3InstallState.NONE then
      GoScreen("Intro\\Legal.lua")
    elseif UIGlobals.Ps3InstallState == UIEnums.Ps3InstallState.COPY_DATA then
      GoScreen("Intro\\AttractSplash.lua")
    elseif UIGlobals.Ps3InstallState == UIEnums.Ps3InstallState.COPY_ATTRACT then
      AddTransmitter(Screen.safe.right - 32, 424, 32, 32, UIEnums.Panel._2D)
      GUI.wait_for_copy = true
    end
  elseif (_ARG_0_ == UIEnums.Message.MenuNext or _ARG_0_ == UIEnums.Message.ButtonStart or _ARG_0_ == UIEnums.Message.ButtonA) and UIGlobals.Ps3InstallState == UIEnums.Ps3InstallState.NONE then
    GoScreen("Intro\\Legal.lua")
    PlaySfxNext()
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.wait_for_copy == true and UIGlobals.Ps3InstallState == UIEnums.Ps3InstallState.COPY_DATA then
    GUI.wait_for_copy = false
    GoScreen("Intro\\AttractSplash.lua")
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  UISystem.DestroyMovie(0)
  UIScreen.SetScreenTimers(0, 0)
end
