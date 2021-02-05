UISystem.LoadLuaScript("Screens\\Debug\\DebugItemBase.lua")
YPos = 0
YNextPos = 0
NumberOfItems = 0
CurrentItemSelected = 1
GUI = {
  stringNo = 0,
  finished = false,
  leaving_debug_menu = false
}
EventsGadget = DebugItem:New()
function EventsGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  for _FORV_5_, _FORV_6_ in ipairs((GameData.GetEvents())) do
    UIButtons.StoreString(GUI.stringNo, _FORV_6_.event_tag)
    UIButtons.AddItem(_ARG_0_.ID, _FORV_6_.event_id, GUI.stringNo, true)
    GUI.stringNo = GUI.stringNo + 1
  end
end
VehicleSelectGadget = DebugItem:New()
function VehicleSelectGadget.AddData(_ARG_0_)
  for _FORV_5_, _FORV_6_ in ipairs((GameData.GetVehicles())) do
    UIButtons.StoreString(GUI.stringNo, _FORV_6_.name)
    UIButtons.AddItem(_ARG_0_.ID, _FORV_6_.id, _FORV_6_.name, false)
    GUI.stringNo = GUI.stringNo + 1
  end
end
VehicleSelectGadget1 = VehicleSelectGadget:New()
DifficultySelectGadget = DebugItem:New()
function DifficultySelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 0, UIText.RBC_DIFFICULTY_VERY_EASY, false)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.RBC_DIFFICULTY_EASY, false)
  UIButtons.AddItem(_ARG_0_.ID, 2, UIText.RBC_DIFFICULTY_MEDIUM, false)
  UIButtons.AddItem(_ARG_0_.ID, 3, UIText.RBC_DIFFICULTY_HARD, false)
  UIButtons.AddItem(_ARG_0_.ID, 4, UIText.RBC_DIFFICULTY_EXPERT, false)
end
PickupSlotSelectGadget = DebugItem:New()
function PickupSlotSelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.CMN_1, false)
  UIButtons.AddItem(_ARG_0_.ID, 2, UIText.CMN_2, false)
  UIButtons.AddItem(_ARG_0_.ID, 3, UIText.CMN_3, false)
  UIButtons.AddItem(_ARG_0_.ID, 4, UIText.CMN_4, false)
  UIButtons.AddItem(_ARG_0_.ID, 5, UIText.CMN_5, false)
  UIButtons.AddItem(_ARG_0_.ID, 6, UIText.CMN_6, false)
end
ShieldSlotSelectGadget = DebugItem:New()
function ShieldSlotSelectGadget.AddData(_ARG_0_)
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
end
HealthSlotSelectGadget = DebugItem:New()
function HealthSlotSelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 0, UIText.CMN_NONE, false)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.CMN_1, false)
  UIButtons.AddItem(_ARG_0_.ID, 2, UIText.CMN_2, false)
  UIButtons.AddItem(_ARG_0_.ID, 3, UIText.CMN_3, false)
  UIButtons.AddItem(_ARG_0_.ID, 4, UIText.CMN_4, false)
  UIButtons.AddItem(_ARG_0_.ID, 5, UIText.CMN_5, false)
end
DebugMenu = {
  {
    EventsGadget,
    UIText.DBG_Event,
    "EventID"
  },
  {
    VehicleSelectGadget1,
    UIText.CMN_VEHICLE,
    "Vehicle"
  },
  {
    DifficultySelectGadget,
    UIText.CMN_DIFFICULTY,
    "Difficulty"
  },
  {
    PickupSlotSelectGadget,
    UIText.CMN_PICKUP_SLOTS,
    "PickupSlots"
  },
  {
    ShieldSlotSelectGadget,
    UIText.CMN_SHIELD_SLOTS,
    "ShieldSlots"
  },
  {
    HealthSlotSelectGadget,
    UIText.CMN_HEALTH_SLOTS,
    "HealthSlots"
  }
}
function Init()
  AddSCUI_Elements()
  GUI.stringNo = 0
  for _FORV_5_, _FORV_6_ in ipairs(DebugMenu) do
    _FORV_6_[1]:AddData()
    NumberOfItems = NumberOfItems + 1
  end
  eventID, vehicleID, diffID, pickup_slots, shield_slots, health_slots = Amax.GetCurrentDebugEventID()
  print(eventID, vehicleID, diffID, pickup_slots, shield_slots, health_slots)
  UIButtons.SetSelection(DebugMenu[1][1]:GetID(), eventID)
  UIButtons.SetSelection(DebugMenu[2][1]:GetID(), vehicleID)
  UIButtons.SetSelection(DebugMenu[3][1]:GetID(), diffID)
  UIButtons.SetSelection(DebugMenu[4][1]:GetID(), pickup_slots)
  UIButtons.SetSelection(DebugMenu[5][1]:GetID(), shield_slots)
  UIButtons.SetSelection(DebugMenu[6][1]:GetID(), health_slots)
  MoveMenu(0)
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
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    Amax.SetGameMode(UIEnums.GameMode.SinglePlayer)
    StoreScreen(UIEnums.ScreenStorage.FE_RETURN)
    SetupDebugEventTable()
    print(UIButtons.GetSelection(DebugMenu[1][1]:GetID()), UIButtons.GetSelection(DebugMenu[2][1]:GetID()), UIButtons.GetSelection(DebugMenu[3][1]:GetID()), UIButtons.GetSelection(DebugMenu[4][1]:GetID()), UIButtons.GetSelection(DebugMenu[5][1]:GetID()), UIButtons.GetSelection(DebugMenu[6][1]:GetID()))
    Amax.SetCurrentDebugEventID(UIButtons.GetSelection(DebugMenu[1][1]:GetID()), UIButtons.GetSelection(DebugMenu[2][1]:GetID()), UIButtons.GetSelection(DebugMenu[3][1]:GetID()), UIButtons.GetSelection(DebugMenu[4][1]:GetID()), UIButtons.GetSelection(DebugMenu[5][1]:GetID()), UIButtons.GetSelection(DebugMenu[6][1]:GetID()))
    Sp_NewGame()
    UIGlobals.Sp = {
      TierInfo = SinglePlayer.TierInfo(),
      CurrentTier = -1,
      CurrentEvent = -1
    }
    for _FORV_6_, _FORV_7_ in ipairs(UIGlobals.Sp.TierInfo) do
      for _FORV_11_, _FORV_12_ in ipairs(_FORV_7_.events) do
        if SinglePlayer.EventInfo(_FORV_12_).eventId == UIGlobals.DebugEvent.EventID then
          UIGlobals.Sp.CurrentTier = _FORV_6_
          UIGlobals.Sp.CurrentEvent = _FORV_11_
          break
        end
      end
    end
    if UIGlobals.Sp.CurrentTier == -1 or UIGlobals.Sp.CurrentEvent == -1 then
      print("*** WARNING - couldn't find sp event - defaulting Lua to T0E0 ***")
      UIGlobals.Sp.CurrentTier = 1
      UIGlobals.Sp.CurrentEvent = 1
    end
    Amax.LoadTextureClone("usa_amboy_3")
    GoLoadingScreen("Loading\\LoadingGame.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true then
    print(UIButtons.GetSelection(DebugMenu[1][1]:GetID()), UIButtons.GetSelection(DebugMenu[2][1]:GetID()), UIButtons.GetSelection(DebugMenu[3][1]:GetID()), UIButtons.GetSelection(DebugMenu[4][1]:GetID()), UIButtons.GetSelection(DebugMenu[5][1]:GetID()), UIButtons.GetSelection(DebugMenu[6][1]:GetID()))
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    GUI.leaving_debug_menu = true
    Amax.SetGameMode(UIEnums.GameMode.Nothing)
    Amax.SetDebugEvent(false)
    Amax.SetUICarToMultiplayer(false)
    Amax.SendMessage(UIEnums.GameFlowMessage.LoadUIScene)
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftTrigger and _ARG_2_ == true then
    GoScreen("Debug\\DebugLoadReplays.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonRightTrigger and _ARG_2_ == true then
    Amax.SendMessage(UIEnums.GameFlowMessage.EnteredDebugMenu)
    Amax.SetGameMode(UIEnums.GameMode.Debug)
    GoScreen("Debug\\DebugScreen.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonUp and _ARG_2_ == true then
    MoveMenu(-1)
  elseif _ARG_0_ == UIEnums.Message.ButtonDown and _ARG_2_ == true then
    MoveMenu(1)
  end
end
function FrameUpdate(_ARG_0_)
  for _FORV_4_, _FORV_5_ in ipairs(DebugMenu) do
    _FORV_5_[1]:Update()
  end
  if GUI.leaving_debug_menu == true then
    return
  end
  YNextPos = 152 - (CurrentItemSelected - 1) * 20
  YPos = YPos + (YNextPos - YPos) * (_ARG_0_ * 4)
  MoveMenu(0)
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
  for _FORV_7_, _FORV_8_ in ipairs(DebugMenu) do
  end
end
function SetupDebugEventTable()
  UIGlobals.DebugEvent = {}
  for _FORV_3_, _FORV_4_ in ipairs(DebugMenu) do
    _FORV_4_[1]:WriteToStructure(UIGlobals.DebugEvent)
  end
  show_table(UIGlobals.DebugEvent, true)
  Amax.SetupDebugRace(UIGlobals.DebugEvent)
  UIGlobals.AlreadySetupRace = true
end
