GUI = {finished = false, ui_audio_loaded = false}
function Init()
  UIScreen.SetScreenTimers(0, 0)
  PS3_CheckForInstallingMessage()
  Profile.AllowProfileChanges(true)
  Profile.ActOnProfileChanges(false)
  Profile.AllowAllPadInput(true)
  if UIGlobals.Ps3Installing ~= true then
    Amax.SetLoadingScreen(true)
  end
end
function PostInit()
  if Amax.IsBootPreCachingComplete() == false or UIGlobals.Ps3Installing == true or Amax.BootUiSceneReady() == false then
    GUI.loadingSegs = AddLoadingSegs()
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_ == UIEnums.GameMessage.UIAudioPreLoaded then
    GUI.ui_audio_loaded = true
  end
end
function FrameUpdate(_ARG_0_)
  PS3_CheckForInstallingMessage()
  if Amax.IsBootPreCachingComplete() == false then
    return
  end
  if UIGlobals.Ps3Installing == true then
    if Amax.IsInstallerScreenEnabled() == true then
      GoScreen("Intro\\Ps3Installer.lua")
    end
  elseif Amax.BootUiSceneReady() == true then
    Amax.SetLoadingScreen(false)
    Amax.BootFinished()
    Amax.SendMessage(UIEnums.GameFlowMessage.StartGameRendering)
    Amax.InstallTrophies()
    GoScreen("Intro\\StartScreen.lua")
  end
end
function End()
  print("[Storing Globals Table]")
  _Globals = {}
  for _FORV_3_, _FORV_4_ in pairs(_G) do
    _Globals[_FORV_3_] = _FORV_4_
  end
end
