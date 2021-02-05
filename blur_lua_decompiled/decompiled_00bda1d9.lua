UISystem.LoadLuaScript("Screens\\Debug\\DebugItemBase.lua")
GUI = {stringNo = 0, finished = false}
PositionSelectGadget = DebugItem:New()
function PositionSelectGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 1, "GAME_STR_GOLD", false)
  UIButtons.AddItem(_ARG_0_.ID, 2, "GAME_STR_SILVER", false)
  UIButtons.AddItem(_ARG_0_.ID, 3, "GAME_STR_BRONZE", false)
  UIButtons.AddItem(_ARG_0_.ID, 4, "GAME_STR_FAIL", false)
end
OntrackXPGadget = DebugItem:New()
function OntrackXPGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 100, "GAME_NUM_100", false)
  UIButtons.AddItem(_ARG_0_.ID, 200, "GAME_NUM_200", false)
  UIButtons.AddItem(_ARG_0_.ID, 300, "GAME_NUM_300", false)
  UIButtons.AddItem(_ARG_0_.ID, 400, "GAME_NUM_400", false)
  UIButtons.AddItem(_ARG_0_.ID, 500, "GAME_NUM_500", false)
  UIButtons.AddItem(_ARG_0_.ID, 600, "GAME_NUM_600", false)
  UIButtons.AddItem(_ARG_0_.ID, 700, "GAME_NUM_700", false)
  UIButtons.AddItem(_ARG_0_.ID, 800, "GAME_NUM_800", false)
  UIButtons.AddItem(_ARG_0_.ID, 900, "GAME_NUM_900", false)
  UIButtons.AddItem(_ARG_0_.ID, 1000, "GAME_NUM_1000", false)
  UIButtons.AddItem(_ARG_0_.ID, 1100, "GAME_NUM_1100", false)
  UIButtons.AddItem(_ARG_0_.ID, 1200, "GAME_NUM_1200", false)
  UIButtons.AddItem(_ARG_0_.ID, 1300, "GAME_NUM_1300", false)
  UIButtons.AddItem(_ARG_0_.ID, 1400, "GAME_NUM_1400", false)
  UIButtons.AddItem(_ARG_0_.ID, 1500, "GAME_NUM_1500", false)
  UIButtons.AddItem(_ARG_0_.ID, 1600, "GAME_NUM_1600", false)
  UIButtons.AddItem(_ARG_0_.ID, 1700, "GAME_NUM_1700", false)
  UIButtons.AddItem(_ARG_0_.ID, 1800, "GAME_NUM_1800", false)
  UIButtons.AddItem(_ARG_0_.ID, 1900, "GAME_NUM_1900", false)
  UIButtons.AddItem(_ARG_0_.ID, 2000, "GAME_NUM_2000", false)
  UIButtons.AddItem(_ARG_0_.ID, 2100, "GAME_NUM_2100", false)
  UIButtons.AddItem(_ARG_0_.ID, 2200, "GAME_NUM_2200", false)
  UIButtons.AddItem(_ARG_0_.ID, 2300, "GAME_NUM_2300", false)
  UIButtons.AddItem(_ARG_0_.ID, 2400, "GAME_NUM_2400", false)
  UIButtons.AddItem(_ARG_0_.ID, 2500, "GAME_NUM_2500", false)
  UIButtons.AddItem(_ARG_0_.ID, 2600, "GAME_NUM_2600", false)
  UIButtons.AddItem(_ARG_0_.ID, 2700, "GAME_NUM_2700", false)
  UIButtons.AddItem(_ARG_0_.ID, 2800, "GAME_NUM_2800", false)
  UIButtons.AddItem(_ARG_0_.ID, 2900, "GAME_NUM_2900", false)
  UIButtons.AddItem(_ARG_0_.ID, 3000, "GAME_NUM_3000", false)
end
GoldFanDemandFansGadget = DebugItem:New()
function GoldFanDemandFansGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 10, "GAME_NUM_10", false)
  UIButtons.AddItem(_ARG_0_.ID, 20, "GAME_NUM_20", false)
  UIButtons.AddItem(_ARG_0_.ID, 30, "GAME_NUM_30", false)
  UIButtons.AddItem(_ARG_0_.ID, 40, "GAME_NUM_40", false)
  UIButtons.AddItem(_ARG_0_.ID, 50, "GAME_NUM_50", false)
  UIButtons.AddItem(_ARG_0_.ID, 60, "GAME_NUM_60", false)
  UIButtons.AddItem(_ARG_0_.ID, 70, "GAME_NUM_70", false)
  UIButtons.AddItem(_ARG_0_.ID, 80, "GAME_NUM_80", false)
  UIButtons.AddItem(_ARG_0_.ID, 90, "GAME_NUM_90", false)
  UIButtons.AddItem(_ARG_0_.ID, 100, "GAME_NUM_100", false)
  UIButtons.AddItem(_ARG_0_.ID, 110, "GAME_NUM_110", false)
  UIButtons.AddItem(_ARG_0_.ID, 120, "GAME_NUM_120", false)
  UIButtons.AddItem(_ARG_0_.ID, 130, "GAME_NUM_130", false)
  UIButtons.AddItem(_ARG_0_.ID, 140, "GAME_NUM_140", false)
  UIButtons.AddItem(_ARG_0_.ID, 150, "GAME_NUM_150", false)
  UIButtons.AddItem(_ARG_0_.ID, 160, "GAME_NUM_160", false)
  UIButtons.AddItem(_ARG_0_.ID, 170, "GAME_NUM_170", false)
  UIButtons.AddItem(_ARG_0_.ID, 180, "GAME_NUM_180", false)
  UIButtons.AddItem(_ARG_0_.ID, 190, "GAME_NUM_190", false)
  UIButtons.AddItem(_ARG_0_.ID, 200, "GAME_NUM_200", false)
  UIButtons.AddItem(_ARG_0_.ID, 210, "GAME_NUM_210", false)
  UIButtons.AddItem(_ARG_0_.ID, 220, "GAME_NUM_220", false)
  UIButtons.AddItem(_ARG_0_.ID, 230, "GAME_NUM_230", false)
  UIButtons.AddItem(_ARG_0_.ID, 240, "GAME_NUM_240", false)
  UIButtons.AddItem(_ARG_0_.ID, 250, "GAME_NUM_250", false)
  UIButtons.AddItem(_ARG_0_.ID, 260, "GAME_NUM_260", false)
  UIButtons.AddItem(_ARG_0_.ID, 270, "GAME_NUM_270", false)
  UIButtons.AddItem(_ARG_0_.ID, 280, "GAME_NUM_280", false)
  UIButtons.AddItem(_ARG_0_.ID, 290, "GAME_NUM_290", false)
  UIButtons.AddItem(_ARG_0_.ID, 300, "GAME_NUM_300", false)
end
GoldFanDemandGadget = DebugItem:New()
function GoldFanDemandGadget.AddData(_ARG_0_)
  UIButtons.ClearItems(_ARG_0_.ID)
  UIButtons.AddItem(_ARG_0_.ID, 1, "GAME_STR_PASSED", false)
  UIButtons.AddItem(_ARG_0_.ID, 2, "GAME_STR_FAILED", false)
end
QuitandWinMenu = {
  {
    PositionSelectGadget,
    UIText.DBG_MEDAL,
    "Position"
  },
  {
    OntrackXPGadget,
    UIText.DBG_ONTRACK_XP,
    "XP"
  },
  {
    GoldFanDemandGadget,
    UIText.DBG_GOLDEN_FAN_DEMAND,
    "GoldFanDemand"
  },
  {
    GoldFanDemandFansGadget,
    UIText.DBG_GOLDEN_FAN_DEMAND_FANS,
    "GoldFanDemandFans"
  }
}
QuitandWinNumberOfItems = 0
QuitandWinCurrentItemSelected = 1
function Init()
  AddSCUI_Elements()
  GUI.stringNo = 0
  for _FORV_4_, _FORV_5_ in ipairs(QuitandWinMenu) do
    _FORV_5_[1]:AddData()
    QuitandWinNumberOfItems = QuitandWinNumberOfItems + 1
  end
  MoveQuitandWinMenu(0)
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
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    GoScreen("Ingame\\Paused.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    Amax.SendMessage(UIEnums.GameFlowMessage.UnPause)
    SetupQuitAndWin()
    UIScreen.SetScreenTimers(0, 0)
    GoScreen("SinglePlayer\\Ingame\\SpFinished.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonUp and _ARG_2_ == true then
    MoveQuitandWinMenu(-1)
  elseif _ARG_0_ == UIEnums.Message.ButtonDown and _ARG_2_ == true then
    MoveQuitandWinMenu(1)
  end
end
function FrameUpdate(_ARG_0_)
  for _FORV_4_, _FORV_5_ in ipairs(QuitandWinMenu) do
    _FORV_5_[1]:Update()
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
function MoveQuitandWinMenu(_ARG_0_)
  QuitandWinCurrentItemSelected = QuitandWinCurrentItemSelected + _ARG_0_
  if QuitandWinCurrentItemSelected < 1 then
    QuitandWinCurrentItemSelected = QuitandWinNumberOfItems
  end
  if QuitandWinCurrentItemSelected > QuitandWinNumberOfItems then
    QuitandWinCurrentItemSelected = 1
  end
  for _FORV_4_, _FORV_5_ in ipairs(QuitandWinMenu) do
    _FORV_5_[1]:Activate(false)
  end
  QuitandWinMenu[QuitandWinCurrentItemSelected][1]:Activate(true)
end
function SetupQuitAndWin()
  QuitAndWin = {}
  for _FORV_3_, _FORV_4_ in ipairs(QuitandWinMenu) do
    _FORV_4_[1]:WriteToStructure(QuitAndWin)
  end
  show_table(QuitAndWin, true)
  Amax.SetupResults(QuitAndWin)
end
