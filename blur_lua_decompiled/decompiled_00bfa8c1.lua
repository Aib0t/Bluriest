GUI = {
  finished = false,
  stringNo = 0,
  menu_active = 0,
  CanExit = function(_ARG_0_)
    return false
  end,
  node_list_id_location = -1,
  node_list_id_vehicles = -1
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_PHOTO_SEARCH_A, UIText.INFO_B_BACK)
  GUI.node_list_id_location = SCUI.name_to_id.node_list_location
  GUI.node_list_id_vehicles = SCUI.name_to_id.node_list_vehicles
  ActivateMenus()
end
function PostInit()
  LSP.Enable(true)
  LSP.SetUserIndex(Profile.GetPrimaryPad())
  LSP.ClearTags()
  LSP.AddTag(0, 1)
  PhotoSearchAddItem_Location(-1, UIText.CMN_ANY, "style_mixed", "common_icons")
  for _FORV_4_, _FORV_5_ in ipairs((GameData.GetCities())) do
    PhotoSearchAddItem_Location(_FORV_5_.id, _FORV_5_.name, _FORV_5_.icon_name, "location_icons")
  end
  PhotoSearchAddItem_Vehicle(-1, UIText.CMN_ANY, "style_mixed", "common_icons")
  for _FORV_5_, _FORV_6_ in ipairs((GameData.GetVehicles())) do
    PhotoSearchAddItem_Vehicle(_FORV_6_.id, _FORV_6_.name, _FORV_6_.icon_name, "car_icons")
  end
  SetupScreenTitle(UIText.RBU_PHOTO_SEARCH_PAGE_TITLE, SCUI.name_to_id.screen, "search_online", "fe_icons")
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if GUI.finished == true then
    return
  end
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    PlaySfxBack()
    GoScreen("Photos\\Photos.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if UIButtons.GetSelection(GUI.node_list_id_location) ~= -1 then
      LSP.AddTag(1, (UIButtons.GetSelection(GUI.node_list_id_location)))
    end
    if UIButtons.GetSelection(GUI.node_list_id_vehicles) ~= -1 then
      LSP.AddTag(2, (UIButtons.GetSelection(GUI.node_list_id_vehicles)))
    end
    GoScreen("Photos\\PhotoSearch.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonDown and _ARG_2_ == true then
    GUI.menu_active = GUI.menu_active + 1
    if GUI.menu_active == 2 then
      GUI.menu_active = 0
    end
    ActivateMenus()
  elseif _ARG_0_ == UIEnums.Message.ButtonUp and _ARG_2_ == true then
    GUI.menu_active = GUI.menu_active - 1
    if GUI.menu_active == -1 then
      GUI.menu_active = 1
    end
    ActivateMenus()
  end
end
function FrameUpdate(_ARG_0_)
end
function Render()
end
function EnterEnd()
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
end
function ActivateMenus()
  UIButtons.SetSelected(GUI.node_list_id_location, false)
  UIButtons.SetSelected(GUI.node_list_id_vehicles, false)
  if GUI.menu_active == 0 then
    UIButtons.SetSelected(GUI.node_list_id_location, true)
  elseif GUI.menu_active == 1 then
    UIButtons.SetSelected(GUI.node_list_id_vehicles, true)
  end
end
function PhotoSearchAddItem_Location(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  UIButtons.AddListItem(GUI.node_list_id_location, UIButtons.CloneXtGadgetByName("Photos\\PhotoSearchParams.lua", "_node_location"), _ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\PhotoSearchParams.lua", "_node_location"), "_text_location"), _ARG_1_)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\PhotoSearchParams.lua", "_node_location"), "_icon_location"), _ARG_3_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\PhotoSearchParams.lua", "_node_location"), "_icon_location"), _ARG_2_)
end
function PhotoSearchAddItem_Vehicle(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  UIButtons.AddListItem(GUI.node_list_id_vehicles, UIButtons.CloneXtGadgetByName("Photos\\PhotoSearchParams.lua", "_node_vehicle"), _ARG_0_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\PhotoSearchParams.lua", "_node_vehicle"), "_text_vehicle"), _ARG_1_)
  UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\PhotoSearchParams.lua", "_node_vehicle"), "_icon_vehicle"), _ARG_3_)
  UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\PhotoSearchParams.lua", "_node_vehicle"), "_icon_vehicle"), _ARG_2_)
end
