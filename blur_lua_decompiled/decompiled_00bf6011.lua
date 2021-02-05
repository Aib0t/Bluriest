function CustomRace_SetupSpinner(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), "spinner"), _ARG_2_)
  if _ARG_3_ ~= nil and _ARG_4_ ~= nil then
    UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), "icon"), _ARG_4_)
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), "icon"), _ARG_3_)
  end
  UIButtons.AddTableRow(_ARG_0_, UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), _ARG_1_)
  return (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "spinner_node"), "spinner"))
end
function CustomRace_SetupItem(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "item_node"), "name"), _ARG_2_)
  if _ARG_3_ ~= nil and _ARG_4_ ~= nil then
    UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "item_node"), "icon"), _ARG_4_)
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "item_node"), "icon"), _ARG_3_)
  end
  UIButtons.AddTableRow(_ARG_0_, UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "item_node"), _ARG_1_)
end
function CustomRace_SetupToggle(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Amax.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "toggle_node"), "toggle"), _ARG_2_)
  if _ARG_3_ ~= nil and _ARG_4_ ~= nil then
    UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "toggle_node"), "icon"), _ARG_4_)
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "toggle_node"), "icon"), _ARG_3_)
  end
  UIButtons.AddTableRow(_ARG_0_, UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "toggle_node"), _ARG_1_)
  return (UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Multiplayer\\Shared\\MpCustomRace.lua", "toggle_node"), "toggle"))
end
function CustomRace_SetupPowerupIcon(_ARG_0_, _ARG_1_)
  UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_, "icon"), _ARG_1_)
  UIButtons.ChangeSize(UIButtons.FindChildByName(_ARG_0_, "icon"), 4.5, 4.5, 0)
end
