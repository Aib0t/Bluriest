GUI = {
  finished = false,
  prep_time = 0,
  waiting_for_ctx = 0
}
function Init()
  UIScreen.SetScreenTimers(0, 0)
  net_LockoutFriendsOverlay(true)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.finished == false and UserKickBackActive() == false and UIScreen.IsContextActive(UIEnums.Context.CarouselApp) == false and SubScreenActive() == false and UIScreen.IsContextActive(UIEnums.Context.LoadSave) == false then
    GUI.all_ok = true
    GoScreen(GetStoredScreen(UIEnums.ScreenStorage.FE_GAME_LOADING))
    StoreScreen(UIEnums.ScreenStorage.FE_GAME_LOADING, nil)
    return
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  if GUI.all_ok ~= true then
    return
  end
  Camera_UseInGame()
  if Amax.IsGameModeSplitScreen() == true then
    Multiplayer.SetupLevelState(UIGlobals.Splitscreen)
  elseif Amax.IsGameModeMultiplayer() == true then
    Multiplayer.SetupLevelState()
  elseif UIGlobals.DebugEvent ~= nil then
    Amax.SetupDebugRace(UIGlobals.DebugEvent)
  else
    Amax.SetupRace()
  end
  print("[Sync boot assets]")
  Amax.SendMessage(UIEnums.GameFlowMessage.SyncBootAssets)
  if UIGlobals.IsQuickRestart == false then
    Amax.DestroyUiResources()
  else
    Amax.SetLoadingScreen(true)
  end
  ClearGlobals()
end
