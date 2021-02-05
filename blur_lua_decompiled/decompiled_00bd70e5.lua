UISystem.LoadLuaScript("Screens\\Debug\\DebugItemBase.lua")
GUI = {
  stringNo = 0,
  finished = false,
  leaving_debug_menu = false,
  city_table = GameData.GetCities(true)
}
CitySelectGadget = DebugItem:New()
function CitySelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.city_table) do
    UIButtons.AddItem(_ARG_0_.ID, _FORV_5_.id, _FORV_5_.name, false)
  end
end
RouteSelectGadget = DebugItem:New()
function RouteSelectGadget.AddData(_ARG_0_)
  CurrentCity = UIButtons.GetSelection(DebugMenu[1][1]:GetID())
  GUI.stringNo = 0
  UIButtons.ClearItems(_ARG_0_.ID)
  for _FORV_5_, _FORV_6_ in ipairs((GameData.GetRoutes(CurrentCity))) do
    UIButtons.StoreString(GUI.stringNo, _FORV_6_.debug_tag)
    UIButtons.AddItem(_ARG_0_.ID, _FORV_6_.id, GUI.stringNo, true)
    GUI.stringNo = GUI.stringNo + 1
  end
  CurrentRoute = UIButtons.GetSelection(DebugMenu[2][1]:GetID())
end
function RouteSelectGadget.Update(_ARG_0_)
  if CurrentCity ~= UIButtons.GetSelection(DebugMenu[1][1]:GetID()) then
    _ARG_0_:AddData()
    UpdateRouteShapes("Shp_Route", 4, CurrentCity, CurrentRoute, "Shp_StartLine")
  end
  if CurrentRoute ~= UIButtons.GetSelection(DebugMenu[2][1]:GetID()) then
    CurrentRoute = UIButtons.GetSelection(DebugMenu[2][1]:GetID())
    UpdateRouteShapes("Shp_Route", 4, CurrentCity, CurrentRoute, "Shp_StartLine")
  end
end
LapSelectGadget = DebugItem:New()
function LapSelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 0, UIText.CMN_NONE, false)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.CMN_1, false)
  UIButtons.AddItem(_ARG_0_.ID, 2, UIText.CMN_2, false)
  UIButtons.AddItem(_ARG_0_.ID, 3, UIText.CMN_3, false)
  UIButtons.AddItem(_ARG_0_.ID, 4, UIText.CMN_4, false)
  UIButtons.AddItem(_ARG_0_.ID, 5, UIText.CMN_5, false)
  UIButtons.AddItem(_ARG_0_.ID, 6, UIText.CMN_6, false)
  UIButtons.AddItem(_ARG_0_.ID, 7, UIText.CMN_7, false)
  UIButtons.AddItem(_ARG_0_.ID, 8, UIText.CMN_8, false)
  UIButtons.AddItem(_ARG_0_.ID, 9, UIText.CMN_9, false)
  UIButtons.AddItem(_ARG_0_.ID, 10, UIText.CMN_10, false)
  UIButtons.AddItem(_ARG_0_.ID, 11, UIText.CMN_11, false)
  UIButtons.AddItem(_ARG_0_.ID, 12, UIText.CMN_12, false)
  UIButtons.AddItem(_ARG_0_.ID, 13, UIText.CMN_13, false)
  UIButtons.AddItem(_ARG_0_.ID, 14, UIText.CMN_14, false)
  UIButtons.AddItem(_ARG_0_.ID, 15, UIText.CMN_15, false)
  UIButtons.AddItem(_ARG_0_.ID, 16, UIText.CMN_16, false)
  UIButtons.AddItem(_ARG_0_.ID, 17, UIText.CMN_17, false)
  UIButtons.AddItem(_ARG_0_.ID, 18, UIText.CMN_18, false)
  UIButtons.AddItem(_ARG_0_.ID, 19, UIText.CMN_19, false)
  UIButtons.AddItem(_ARG_0_.ID, 20, UIText.CMN_20, false)
end
EnvironmentSelectGadget = DebugItem:New()
function EnvironmentSelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 0, UIText.CMN_NO, false)
  for _FORV_4_, _FORV_5_ in ipairs(GUI.city_table) do
    UIButtons.AddItem(_ARG_0_.ID, _FORV_5_.id, _FORV_5_.name, false)
  end
end
PartyModeGadget = DebugItem:New()
function PartyModeGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 0, UIText.CMN_NO, false)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.CMN_YES, false)
end
ViewPortSelectGadget = DebugItem:New()
function ViewPortSelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.CMN_1, false)
  UIButtons.AddItem(_ARG_0_.ID, 2, UIText.CMN_2, false)
  UIButtons.AddItem(_ARG_0_.ID, 3, UIText.CMN_3, false)
  UIButtons.AddItem(_ARG_0_.ID, 4, UIText.CMN_4, false)
end
SplitscreenRaceModeSelectGadget = DebugItem:New()
function SplitscreenRaceModeSelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  for _FORV_5_, _FORV_6_ in ipairs((GameData.GetSplitScreenEvents())) do
    UIButtons.AddItem(_ARG_0_.ID, _FORV_6_.id, _FORV_6_.name, false)
  end
end
DebugMenu = {
  {
    CitySelectGadget,
    UIText.CMN_CITY,
    "City"
  },
  {
    RouteSelectGadget,
    UIText.CMN_ROUTE,
    "Route"
  },
  {
    LapSelectGadget,
    UIText.CMN_LAPS,
    "Laps"
  },
  {
    EnvironmentSelectGadget,
    UIText.CMN_ENVIRONMENT_OVERIDE,
    "Environment"
  },
  {
    PartyModeGadget,
    UIText.CMN_PARTY_MODE,
    "PartyMode"
  },
  {
    ViewPortSelectGadget,
    UIText.CMN_VIEWPORTS,
    "Viewports"
  },
  {
    SplitscreenRaceModeSelectGadget,
    UIText.CMN_SPLIT_SCREEN_RACEMODE,
    "SplitScreenRaceMode"
  }
}
NumberOfItems = 0
CurrentItemSelected = 1
function Init()
  AddSCUI_Elements()
  UIGlobals.LoadFromDebug = true
  UIGlobals.Sp = nil
  GUI.stringNo = 0
  for _FORV_4_, _FORV_5_ in ipairs(DebugMenu) do
    _FORV_5_[1]:AddData()
    NumberOfItems = NumberOfItems + 1
  end
  for _FORV_5_, _FORV_6_ in ipairs(DebugMenu) do
    _FORV_6_[1]:AddData()
    _FORV_6_[1]:SetSelection((Amax.GetLevelData()))
  end
  MoveMenu(0)
end
function PostInit()
  UpdateRouteShapes("Shp_Route", 4, CurrentCity, CurrentRoute, "Shp_StartLine")
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if GUI.leaving_debug_menu == true then
    if _ARG_0_ == UIEnums.GameFlowMessage.StartGameRendering then
      GUI.leaving_debug_menu = false
      GoScreen("Intro\\StartScreen.lua")
    else
      return
    end
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    GUI.leaving_debug_menu = true
    Amax.SetGameMode(UIEnums.GameMode.Nothing)
    Amax.SetDebugEvent(false)
    Amax.SetUICarToMultiplayer(false)
    Amax.SendMessage(UIEnums.GameFlowMessage.LoadUIScene)
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    LaunchGame()
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftShoulder and _ARG_2_ == true then
    GoScreen("Debug\\DebugUI.lua")
  elseif _ARG_0_ == UIEnums.Message.AutomationLoadGame then
    UIGlobals.Splitscreen.players = {
      {pad = 0},
      {pad = 1},
      {pad = 2},
      {pad = 3}
    }
    Splitscreen_ClearMessages()
    StoreScreen(UIEnums.ScreenStorage.FE_RETURN)
    GoLoadingScreen("Loading\\LoadingGame.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftTrigger and _ARG_2_ == true then
    GoScreen("Debug\\DebugEventScreen.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonRightTrigger and _ARG_2_ == true then
    SetupRaceTable()
    GoScreen("Debug\\DebugCarScreen.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonUp and _ARG_2_ == true then
    MoveMenu(-1)
  elseif _ARG_0_ == UIEnums.Message.ButtonDown and _ARG_2_ == true then
    MoveMenu(1)
  elseif (_ARG_0_ == UIEnums.Message.ButtonLeft or _ARG_0_ == UIEnums.Message.ButtonRight) and _ARG_2_ == true and CurrentItemSelected == 1 then
    UIButtons.SetSelectionByIndex(DebugMenu[CurrentItemSelected + 1][1]:GetID(), 0)
  end
end
function LaunchGame()
  StoreScreen(UIEnums.ScreenStorage.FE_RETURN)
  SetupRaceTable()
  Amax.LoadTextureClone(GUI.route_texture_name)
  GoLoadingScreen("Loading\\LoadingGame.lua")
end
function FrameUpdate(_ARG_0_)
  for _FORV_4_, _FORV_5_ in ipairs(DebugMenu) do
    _FORV_5_[1]:Update()
  end
  if GUI.leaving_debug_menu == true then
    return
  end
  if GUI.finished == false and UIGlobals.LaunchMode == UIEnums.LaunchMode.Automation then
    print("GOGO Automation")
    Profile.Setup(arg1, true)
    Profile.LockToPad(arg1)
    Profile.SetPrimaryPad(arg1)
    GameProfile.InitPrimary()
    Profile.AllowProfileChanges(false)
    Profile.ActOnProfileChanges(false)
    Profile.AllowAllPadInput(false)
    Amax.SendMessage(UIEnums.GameFlowMessage.EnteredDebugMenu)
    Amax.SetGameMode(UIEnums.GameMode.SinglePlayer)
    UIButtons.TimeLineActive("exit", true)
    UIButtons.TimeLineActive("start_fade", false)
    UIScreen.SetScreenTimers(0, 0.7)
    StoreScreen(UIEnums.ScreenStorage.FE_RETURN)
    UIGlobals.AlreadySetupRace = true
    UIGlobals.LoadFromDebug = true
    if UIGlobals.automation_event_id == 0 then
    elseif UIGlobals.automation_event_id == 1 then
    elseif UIGlobals.automation_event_id == 2 then
    elseif UIGlobals.automation_event_id == 3 then
    end
    UIGlobals.automation_event_id = UIGlobals.automation_event_id + 1
    if 3 < UIGlobals.automation_event_id then
      UIGlobals.automation_event_id = 0
    end
    Amax.LoadTextureClone("usa_amboy_3")
    show_table({
      Difficulty = 1,
      PickupSlots = 3,
      HealthSlots = 5,
      Vehicle = 5392512,
      ShieldSlots = 6,
      EventID = 4597671,
      EventID = -319285474,
      EventID = -1433716086,
      EventID = 4597671
    })
    UIGlobals.DebugEvent = {
      Difficulty = 1,
      PickupSlots = 3,
      HealthSlots = 5,
      Vehicle = 5392512,
      ShieldSlots = 6,
      EventID = 4597671,
      EventID = -319285474,
      EventID = -1433716086,
      EventID = 4597671
    }
    Amax.SetupDebugRace({
      Difficulty = 1,
      PickupSlots = 3,
      HealthSlots = 5,
      Vehicle = 5392512,
      ShieldSlots = 6,
      EventID = 4597671,
      EventID = -319285474,
      EventID = -1433716086,
      EventID = 4597671
    })
    GoLoadingScreen("Loading\\LoadingGame.lua")
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
function MoveMenu(_ARG_0_)
  CurrentItemSelected = CurrentItemSelected + _ARG_0_
  if CurrentItemSelected < 1 then
    CurrentItemSelected = NumberOfItems
  end
  if CurrentItemSelected > NumberOfItems then
    CurrentItemSelected = 1
  end
  for _FORV_4_, _FORV_5_ in ipairs(DebugMenu) do
    _FORV_5_[1]:Activate(false)
  end
  DebugMenu[CurrentItemSelected][1]:Activate(true)
end
function SetupRaceTable()
  DebugRace = {}
  for _FORV_3_, _FORV_4_ in ipairs(DebugMenu) do
    _FORV_4_[1]:WriteToStructure(DebugRace)
  end
  Amax.SetupRace(DebugRace)
end
