GUI = {finished = false, RollCredits = false}
function Init()
  AddSCUI_Elements()
  UIGlobals.OnMovieScreenInEventSelect = true
  if UIGlobals.ActiveSPMovie[1].Filename == -1 then
    Print("ERROR: ACTIVE SP MOVIE HAS NO FILENAME, LEAVING SP MOVIE SCREEN")
    finished = true
    return
  end
  StoreInfoLine()
  SetupInfoLine()
  UISystem.DestroyMovie(0)
  if UIGlobals.ActiveSPMovie[1].FullScreen == true then
    UIScreen.SetScreenTimers(0.3, 0.3)
    UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUpDown")
  end
  Amax.SendMessage(UIEnums.GameFlowMessage.CutsceneVideoStarted)
  Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
  RemapMovieTracks()
  print(UIGlobals.ActiveSPMovie[1].Filename)
  if UIGlobals.ActiveSPMovie[1].FullScreen == true then
    SetupMovie(0, UIGlobals.ActiveSPMovie[1].Filename, nil, nil, false, true)
  else
    UIButtons.SetActive(SCUI.name_to_id.vid, true)
    UISystem.InitMovie(0, UIGlobals.ActiveSPMovie[1].Filename, false, nil, false, true)
  end
  UISystem.EnableMovieLooping(0, false)
  UIScreen.BlockInputToContext(true)
  if UIGlobals.SPRollCredits == true then
    GUI.RollCredits = true
  end
end
function PostInit()
  UIButtons.TimeLineActive("movie_start", true)
  print("Should Save ", UIGlobals.SpMovieScreenShouldSave)
  if UIGlobals.SpMovieScreenShouldSave == true then
    print("Saving")
    StartAsyncSave()
    SpMovieScreenShouldSave = false
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if GUI.finished == true then
    PopScreen()
    return
  end
  if _ARG_0_ == UIEnums.Message.MovieFinished and _ARG_1_ == 0 then
    if CheckQueuedMovies() == true then
    elseif GUI.RollCredits == true then
      UIGlobals.SPRollCredits = false
      UIGlobals.EndOfGame = true
      GoScreen("Shared\\Options_Credits.lua")
    else
      PopScreen()
    end
  elseif (_ARG_0_ == UIEnums.Message.ButtonStart or _ARG_0_ == UIEnums.Message.MenuNext or _ARG_0_ == UIEnums.Message.MouseClickLeft) and _ARG_2_ == true and (UIGlobals.ActiveSPMovie[1].Skipable == true or UIGlobals.DevMode == true) then
    if CheckQueuedMovies() == true then
      PlaySfxNext()
    else
      PlaySfxNext()
      if GUI.RollCredits == true then
        UIGlobals.SPRollCredits = false
        GoScreen("Shared\\Options_Credits.lua")
      else
        PopScreen()
      end
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == true then
    return
  end
end
function Render()
end
function CheckQueuedMovies()
  UIGlobals.ActiveSPMovie[1].Filename = -1
  UIGlobals.ActiveSPMovie[1].Skipable = -1
  UIGlobals.ActiveSPMovie[1].FullScreen = -1
  for _FORV_3_ = 1, #UIGlobals.ActiveSPMovie do
    if IsTable(UIGlobals.ActiveSPMovie[_FORV_3_]) == true then
      if IsTable(UIGlobals.ActiveSPMovie[_FORV_3_ + 1]) == true then
        UIGlobals.ActiveSPMovie[_FORV_3_].Filename = UIGlobals.ActiveSPMovie[_FORV_3_ + 1].Filename
        UIGlobals.ActiveSPMovie[_FORV_3_].Skipable = UIGlobals.ActiveSPMovie[_FORV_3_ + 1].Skipable
        UIGlobals.ActiveSPMovie[_FORV_3_].FullScreen = UIGlobals.ActiveSPMovie[_FORV_3_ + 1].FullScreen
      else
        UIGlobals.ActiveSPMovie[_FORV_3_].Filename = -1
        UIGlobals.ActiveSPMovie[_FORV_3_].Skipable = -1
        UIGlobals.ActiveSPMovie[_FORV_3_].FullScreen = -1
      end
    end
  end
  if _FOR_.ActiveSPMovie[1].Filename ~= -1 then
    UISystem.DestroyMovie(0)
    if UIGlobals.ActiveSPMovie[1].FullScreen == true then
      UIScreen.SetScreenTimers(0.3, 0.3)
    end
    Amax.SendMessage(UIEnums.GameFlowMessage.CutsceneVideoStarted)
    RemapMovieTracks()
    print(UIGlobals.ActiveSPMovie[1].Filename)
    if UIGlobals.ActiveSPMovie[1].FullScreen == true then
      SetupMovie(0, UIGlobals.ActiveSPMovie[1].Filename, nil, nil, false, true)
    else
      UIButtons.SetActive(SCUI.name_to_id.vid, true)
      UISystem.InitMovie(0, UIGlobals.ActiveSPMovie[1].Filename, false, nil, false, true)
    end
    UISystem.EnableMovieLooping(0, false)
    return true
  else
    return false
  end
end
function EndLoop(_ARG_0_)
end
function EnterEnd()
end
function End()
  SinglePlayer.ClearUnlocks()
  if UserKickBackActive() == false and Sp_ReturnFromGame() == true and GUI.RollCredits == false and UIGlobals.EndOfGame ~= true then
    OpenApp(UIEnums.RwBranch.Races, nil, "SinglePlayer\\SpTierSelect.lua")
  end
  RestoreInfoLine()
  Amax.SendMessage(UIEnums.GameFlowMessage.StartGameRendering)
  Amax.SendMessage(UIEnums.GameFlowMessage.CutsceneVideoFinished)
  UISystem.DestroyMovie(0)
  if UIGlobals.ActiveSPMovie.FullScreen == true then
    UIGlobals.DoFadeUp = true
  end
  UIGlobals.ActiveSPMovie[1].Filename = -1
  UIGlobals.ActiveSPMovie[1].Skipable = -1
  UIGlobals.ActiveSPMovie[1].FullScreen = -1
  UIGlobals.OnMovieScreenInEventSelect = false
end
