GUI = {
  finished = false,
  DisableLoading = false,
  RaceLoaded = false,
  DelayLoadTimer = 0,
  DelayLoadTime = 0.5,
  LoadStarted = false,
  MessageTextIDs = {},
  MessageSettings = {
    StartTime = -2,
    EndTime = 2,
    MinTime = 2.5,
    MaxTime = 6,
    Delta = 0.16,
    TimeLimit = 0,
    Timer = 0,
    CurrentPost = 1,
    NumberPosts = 0
  },
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  if UIGlobals.LoadFromDebug == false then
    Profile.AllowProfileChanges(true)
    Profile.ActOnProfileChanges(false)
  end
  UIScreen.SetScreenTimers(0, 0)
  UIGlobals.Ingame = {}
  ClearMultiplayerGlobals()
  AddSCUI_Elements()
  SetupInfoLine()
  show_table(UIEnums.GameMode)
  print("Current Game Mode", Amax.GetGameMode())
  GUI.RacerList = SCUI.name_to_id.racers_list
  GUI.MessageList = SCUI.name_to_id.messages_list
  Amax.SetLoadStateIntoRace()
  if Amax.GetGameMode() == UIEnums.GameMode.Online then
  elseif Amax.GetGameMode() == UIEnums.GameMode.Debug then
    UIButtons.SetActive(SCUI.name_to_id.target, false)
    UIButtons.SetActive(SCUI.name_to_id.racers, false)
    for _FORV_6_ = 1, 3 do
      UIButtons.SetActive(SCUI.name_to_id["objective_" .. _FORV_6_], false)
    end
  end
  if _FOR_.AmaxWorldLayerExists() == true then
    print("LoadingGame : Waiting to dump amax world layer")
    Amax.SendMessage(UIEnums.GameFlowMessage.DumpLevel)
    GUI.LevelDumped = false
  else
    GUI.LevelDumped = true
  end
  if UIGlobals.LaunchMode == UIEnums.LaunchMode.Demo then
    for _FORV_7_, _FORV_8_ in ipairs({
      "racers",
      "target",
      "objective_1",
      "objective_2",
      "objective_3"
    }) do
      UIButtons.SetActive(SCUI.name_to_id[_FORV_8_], false)
    end
  end
end
function PostInit()
  AddTransmitter(Screen.safe.left + 32, 424, 32, 32, UIEnums.Panel._2DAA)
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
  if _ARG_0_ == UIEnums.GameFlowMessage.LevelDumped then
    print("LoadingGame : World layer dumped")
    GUI.LevelDumped = true
  elseif _ARG_0_ == UIEnums.GameFlowMessage.RaceLoaded then
    print("LoadingGame : Race loaded")
    Amax.FillStreamer()
    GUI.RaceLoaded = true
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.LevelDumped == true and GUI.LoadStarted == false then
    GUI.DelayLoadTimer = GUI.DelayLoadTimer + _ARG_0_
    if GUI.DelayLoadTimer >= GUI.DelayLoadTime then
      GUI.LoadStarted = true
      StartLoad()
    end
  end
  if GUI.RaceLoaded == true and Amax.WaitForStreamer() == false then
    GUI.RaceLoaded = false
    if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
    elseif Amax.GetGameMode() == UIEnums.GameMode.Online then
    elseif Amax.GetGameMode() == UIEnums.GameMode.Debug then
      Amax.SendMessage(UIEnums.GameFlowMessage.RaceStarted)
    end
    if GUI.DisableLoading == false then
      UIGlobals.IsLoading = false
      UIGlobals.IsIngame = true
      Amax.SendMessage(UIEnums.GameFlowMessage.StartGameRendering)
      StartIngameMusic()
    end
    GoScreen("Ingame\\HUD.lua", 0)
  end
  if 0 < GUI.MessageSettings.NumberPosts and GUI.MessageSettings.CurrentPost <= GUI.MessageSettings.NumberPosts then
    GUI.MessageSettings.Timer = GUI.MessageSettings.Timer + _ARG_0_
    if GUI.MessageSettings.Timer > GUI.MessageSettings.TimeLimit then
      GUI.MessageSettings.Timer = 0
      GUI.MessageSettings.TimeLimit = Clamp(GUI.MessageSettings.Delta * UIButtons.GetStaticTextLength(GUI.MessageTextIDs[GUI.MessageSettings.CurrentPost]), GUI.MessageSettings.MinTime, GUI.MessageSettings.MaxTime)
      GUI.MessageSettings.CurrentPost = GUI.MessageSettings.CurrentPost + 1
      UIButtons.SetSelectionByIndex(GUI.MessageList, GUI.MessageSettings.CurrentPost - 1)
      print("next post", GUI.MessageSettings.CurrentPost - 1)
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  if UIGlobals.SuccessfullyCreatedNetworkSession == true then
    Amax.StartPlayStatsOnlyMatchingSession()
    UIGlobals.NetworkSessionStarted = true
    print("Started The Network Session")
  end
  if UIGlobals.LoadFromDebug == false then
    Profile.ForceProfileUpdate()
    Profile.ActOnProfileChanges(true)
  end
end
