function show_table(_ARG_0_, _ARG_1_)
  show_table_spacing = ""
  my_show_table(_ARG_0_, _ARG_1_)
  show_table_spacing = nil
end
function my_show_table(_ARG_0_, _ARG_1_)
  if _ARG_0_ == nil then
    print("show_table : ERROR - Table == nil")
    return
  end
  print(show_table_spacing .. "{")
  show_table_spacing = show_table_spacing .. "   "
  for _FORV_5_, _FORV_6_ in pairs(_ARG_0_) do
    if type(_FORV_6_) == "table" and _ARG_1_ ~= nil then
      print(show_table_spacing .. "TABLE: " .. _FORV_5_)
      my_show_table(_FORV_6_, _ARG_1_)
    else
      print(show_table_spacing .. _FORV_5_ .. " = ", _FORV_6_)
    end
  end
  show_table_spacing = string.sub(show_table_spacing, 0, -4)
  print(show_table_spacing .. "}")
end
function show_globals(_ARG_0_)
  for _FORV_4_, _FORV_5_ in pairs(_G) do
    if type(_FORV_5_) ~= "function" or _ARG_0_ == true then
      print(_FORV_4_ .. " = ", _FORV_5_)
    end
  end
end
function UISetup(_ARG_0_)
  UISystem.LoadLuaScript("UIGlobals.lua")
  UISystem.LoadLuaScript("UIFontSequences.lua")
  UISystem.LoadLuaScript("Screens\\GUIBank.lua")
  UISystem.LoadLuaScript("Screens\\Commands.lua")
  UISystem.LoadLuaScript("Popups\\CustomPopupData.lua")
  UIGlobals.LaunchMode = _ARG_0_
  UIGlobals.DevMode = UIGlobals.LaunchMode ~= UIEnums.LaunchMode.Master and UIGlobals.LaunchMode ~= UIEnums.LaunchMode.Demo
  if UIGlobals.LaunchMode == UIEnums.LaunchMode.Final then
    print("LaunchMode == Final")
  elseif UIGlobals.LaunchMode == UIEnums.LaunchMode.Debug then
    print("LaunchMode == Debug")
  elseif UIGlobals.LaunchMode == UIEnums.LaunchMode.DebugRb then
    print("LaunchMode == Debug : RaceBook")
  elseif UIGlobals.LaunchMode == UIEnums.LaunchMode.Demo then
    print("LaunchMode == Public Demo")
  elseif UIGlobals.LaunchMode == UIEnums.LaunchMode.Master then
    print("LaunchMode == MASTER")
  elseif UIGlobals.LaunchMode == UIEnums.LaunchMode.Automation then
    print("LaunchMode == Automation")
  else
    print("## WARNING : LaunchMode == Unknown ##", _ARG_0_)
  end
  if UIGlobals.DevMode == true then
    print("- Developer mode")
  end
  if UIGlobals.LaunchMode == UIEnums.LaunchMode.Debug or UIGlobals.LaunchMode == UIEnums.LaunchMode.Automation then
    UIGlobals.ProfilePressedStart = 0
    Profile.Setup(UIGlobals.ProfilePressedStart, true)
    UIGlobals.ProfileState[UIGlobals.ProfilePressedStart] = UIEnums.Profile.Blagged
    Profile.LockToPad(UIGlobals.ProfilePressedStart)
    Profile.SetPrimaryPad(UIGlobals.ProfilePressedStart)
    GameProfile.InitPrimary()
    Profile.AllowProfileChanges(false)
    Profile.ActOnProfileChanges(false)
    Profile.AllowAllPadInput(false)
    Amax.SetGameMode(UIEnums.GameMode.SinglePlayer)
    Amax.SendMessage(UIEnums.GameFlowMessage.EnteredDebugMenu)
    Amax.SetGameMode(UIEnums.GameMode.Debug)
    Amax.CacheGlobalAnimationResources()
    UIScreen.SetInitialScreen("Debug\\DebugScreen.lua")
  else
    UIScreen.SetInitialScreen("Intro\\Legal.lua")
  end
end
