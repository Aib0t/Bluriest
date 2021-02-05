GUI = {
  finished = false,
  do_start_load = true,
  ui_audio_loaded = false,
  ui_scene_loaded = false,
  max_wait_time = 15,
  disconnecting = false,
  network_load_flag = false
}
function Init()
  net_LockoutFriendsOverlay(true)
  print("LoadingUI Init()")
  Camera_UseFrontend()
  StopIngameMusic()
  UIScreen.SetScreenTimers(0, 0.3)
  NetRace.EndPlay(true)
  if UIGlobals.Multiplayer.LaunchScreen ~= UIEnums.MpLaunchScreen.MultiplayerLobby then
    Amax.SetLoadStateBackToUI()
  else
    Amax.SetLoadStateBackToLobby()
  end
  if UIGlobals.LoadFromDebug == false then
    Profile.AllowProfileChanges(true)
    Profile.ActOnProfileChanges(false)
    UIGlobals.ActUponFriendChallenges = false
  end
  if UIGlobals.Multiplayer.LaunchScreen ~= UIEnums.MpLaunchScreen.MultiplayerLobby then
    UIGlobals.Ingame = {}
    ClearMultiplayerGlobals()
  end
  GameProfile.ClearRaceDifficulty()
  AddSCUI_Elements()
  if IsSplitScreen() == true then
    Profile.SetPrimaryPad(UIGlobals.Splitscreen.primary_pad)
    Profile.LockToPad(UIGlobals.Splitscreen.primary_pad)
  end
  Amax.SendMessage(UIEnums.GameFlowMessage.UnPause)
end
function PostInit()
  GUI.loadingSegs = AddLoadingSegs()
  if ShouldShowRaceImage() == false then
    UIButtons.SetActive(SCUI.name_to_id.background, false)
    UIButtons.SetActive(SCUI.name_to_id.StencilWriteOn, false)
    UIButtons.SetActive(SCUI.name_to_id.CSB_M, false)
    UIButtons.SetActive(SCUI.name_to_id.StencilWriteOff, false)
    UIButtons.SetActive(SCUI.name_to_id.StencilReadOn, false)
    UIButtons.SetActive(SCUI.name_to_id.LoadingTex, false)
    UIButtons.SetActive(SCUI.name_to_id.LoadingFade, false)
    UIButtons.SetActive(SCUI.name_to_id.Gfx_LoadingBG, true)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.GameFlowMessage.UILoaded and UIGlobals.LoadFromDebug == true then
    UIButtons.SetActive(GUI.loadingSegs, false)
    GUI.finished_load = true
    Amax.ExitNetworkLoad()
  end
  if _ARG_0_ == UIEnums.GameMessage.UIAudioPreLoaded then
    GUI.ui_audio_loaded = true
  elseif _ARG_0_ == UIEnums.GameMessage.UISceneReady then
    GUI.ui_scene_loaded = true
  end
end
function FrameUpdate(_ARG_0_)
  if SubScreenActive() == true then
    return
  end
  if GUI.ui_scene_loaded == true and UIGlobals.ShowingUnlocks == false and UIScreen.IsContextActive(UIEnums.Context.LoadSave) == false then
    Amax.HandleUISceneReady()
    UIButtons.SetActive(GUI.loadingSegs, false)
    if UIGlobals.LoadFromDebug == false then
      Profile.ForceProfileUpdate()
      Profile.ActOnProfileChanges(true)
      UIGlobals.ActUponFriendChallenges = true
    end
  end
  if GUI.ui_audio_loaded == true and GUI.ui_scene_loaded == true then
    GUI.finished_load = true
    if GUI.network_load_flag == false then
      GUI.network_load_flag = true
      Amax.ExitNetworkLoad()
    end
  end
  if GUI.do_start_load == true then
    GUI.do_start_load = false
    Amax.EnterNetworkLoad()
    StartUiLoad()
    if ShouldShowRaceImage() == true then
      PushScreen("Shared\\Unlocks.lua")
    end
  end
  if GUI.finished_load == true and UIScreen.IsContextActive(UIEnums.Context.LoadSave) == false then
    if IsNetworkMultiplayerMode() == true and UserKickBackActive() == false and UIGlobals.FriendDemandAttemptFromMessage == false then
      GoScreen("Multiplayer\\MpMain.lua")
    else
      GoScreen(GetStoredScreen(UIEnums.ScreenStorage.FE_RETURN))
    end
  end
  if IsNetworkMultiplayerMode() == true and UIScreen.IsContextActive(UIEnums.Context.LoadSave) == true then
    GUI.max_wait_time = GUI.max_wait_time - _ARG_0_
    if GUI.disconnecting == false and GUI.max_wait_time <= 0 then
      print("LoadingUI: Save has been interupted for too long. Disconnecting from network game")
      GUI.disconnecting = true
      GUI.max_wait_time = 0
      net_FlushSessionEnumerator()
      net_CloseAllSessions()
      UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.MultiplayerRoot
      UIGlobals.IdlePlayerKicked = true
    end
  end
end
function ShouldShowRaceImage()
  return UserKickBackActive() ~= true and UIGlobals.Sp_PreviousFans ~= nil and IsNetworkMultiplayerMode() == false and IsSplitScreen() == false and Amax.SP_IsFriendDemand() == false and UIGlobals.LoadFromDebug == false
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  UIGlobals.FadeUpLoading = 0
  Amax.CreateUiResources()
  UIGlobals.IsIngame = false
  if UIGlobals.Multiplayer.LaunchScreen ~= UIEnums.MpLaunchScreen.MultiplayerLobby then
    UIGlobals.Multiplayer.InitialLobby = true
  end
  Amax.SetFrontEndLoaded()
  ClearGlobals()
end
