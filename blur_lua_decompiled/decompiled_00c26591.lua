GUI = {
  finished = false,
  carousel_branch = "Leaderboards",
  tier_info = {},
  tier_select = {},
  event_select = {},
  event_nodes = {},
  selection = {},
  current_selection = 0,
  current_tier_select_index = 1,
  current_event_select_index = 1,
  change_leaderboard = false,
  cool_off_timer = 0,
  cool_down_time = 1.5,
  slider = {},
  tier_selected = true,
  Displaying_Lost_Connection = false,
  CanExit = function(_ARG_0_)
    PlaySfxGraphicBack()
    return true
  end
}
function Init()
  AddSCUI_Elements()
  CarouselApp_SetScreenTimers()
  StoreInfoLine()
  GUI.tier_info = SinglePlayer.TierInfo()
  GUI.silder = SCUI.name_to_id.Tiers
  GUI.tier_select = SCUI.name_to_id.Options
  GUI.selection = SCUI.name_to_id.selected
  SpCarouselLeaderboard_SetupTierSelectSlider(GUI.silder)
end
function PostInit()
  UIButtons.TimeLineActive("Hide_Carousel", true)
  UIButtons.SetActive(SCUI.name_to_id._EventSelect, false, true)
  SetUpLeaderboardScreen()
  UIGlobals.SpLeaderboardCarouselFocusOnMenu = true
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if IsControllerLocked() == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    PopScreen()
    CloseApp(UIEnums.RwBranch.Leaderboards)
    Amax.ChangeUiCamera(UIGlobals.CameraNames.SpCarousel, UIGlobals.CameraLerpTime, 0)
  elseif _ARG_0_ == UIEnums.Message.ButtonUp then
    if UIGlobals.SpLeaderboardCarouselFocusOnMenu == true then
      MoveSelectionUp()
      for _FORV_8_ = 1, #GUI.event_nodes do
        UIButtons.SetSelected(GUI.event_nodes[_FORV_8_].event_slider, false)
      end
      _FOR_.tier_selected = true
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonDown then
    if UIGlobals.SpLeaderboardCarouselFocusOnMenu == true then
      MoveSelectionDown()
      for _FORV_8_ = 1, #GUI.event_nodes do
        UIButtons.SetSelected(GUI.event_nodes[_FORV_8_].event_slider, false)
      end
      _FOR_.SetSelected(GUI.event_nodes[GUI.current_tier_select_index].event_slider, true)
      GUI.tier_selected = false
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonY then
    if UIGlobals.SpLeaderboardCarouselFocusOnMenu == true then
      UIGlobals.SpLeaderboardCarouselFocusOnMenu = false
    else
      UIGlobals.SpLeaderboardCarouselFocusOnMenu = true
    end
    SetNewFocus()
  elseif _ARG_0_ == UIEnums.Message.PopupNext and _ARG_2_ == UIEnums.CustomPopups.MultiplayerOnlineConnectionLost then
    PopScreen()
    CloseApp(UIEnums.RwBranch.Leaderboards)
    Amax.ChangeUiCamera(UIGlobals.CameraNames.SpCarousel, UIGlobals.CameraLerpTime, 0)
  end
end
function FrameUpdate(_ARG_0_)
  if change_leaderboard == true then
    GUI.cool_off_timer = GUI.cool_off_timer - _ARG_0_
  end
  if GUI.current_tier_select_index ~= UIButtons.GetSelectionIndex(GUI.silder) + 1 then
    GUI.current_tier_select_index = UIButtons.GetSelectionIndex(GUI.silder) + 1
    for _FORV_5_ = 1, #GUI.event_nodes do
      UIButtons.SetActive(GUI.event_nodes[_FORV_5_].node, false, true)
    end
    _FOR_.SetActive(GUI.event_nodes[GUI.current_tier_select_index].node, true, true)
    GUI.current_event_select_index = -1
  end
  if GUI.current_event_select_index ~= UIButtons.GetSelectionIndex(GUI.event_nodes[GUI.current_tier_select_index].event_slider) + 1 then
    GUI.current_event_select_index = UIButtons.GetSelectionIndex(GUI.event_nodes[GUI.current_tier_select_index].event_slider) + 1
    GUI.cool_off_timer = GUI.cool_down_time
    change_leaderboard = true
  end
  if change_leaderboard == true and GUI.cool_off_timer <= 0 then
    change_leaderboard = false
    PopScreen()
    ReLoadLeaderboardScreen()
  end
end
function EnterEnd()
  UIButtons.TimeLineActive("Hide_Carousel", false)
  UIGlobals.SpLeaderboardInCarousel = false
  RestoreInfoLine()
end
function End()
end
function SpCarouselLeaderboard_SetupTierSelectSlider(_ARG_0_)
  if _ARG_0_ == nil then
    print("ERROR - SpCarouselLeaderboard_SetupTierSelectSlider( slider ) : slider is not valid!!")
    return
  elseif GUI.tier_info == nil then
    print("ERROR - SpCarouselLeaderboard_SetupTierSelectSlider( slider ) : GUI.tier_info is not valid!!")
    return
  end
  for _FORV_4_, _FORV_5_ in ipairs(GUI.tier_info) do
    UIButtons.AddItem(_ARG_0_, _FORV_5_.tierId, _FORV_5_.name, false)
    GUI.event_nodes[_FORV_4_] = {
      node = UIButtons.CloneXtGadgetByName("SinglePlayer\\SpCarouselLeaderboard.lua", "_EventSelect"),
      event_slider = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpCarouselLeaderboard.lua", "_EventSelect"), "_Event")
    }
    UIButtons.SetActive(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpCarouselLeaderboard.lua", "_EventSelect"), false, true)
    for _FORV_11_, _FORV_12_ in ipairs(_FORV_5_.events) do
      UIButtons.AddItem(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpCarouselLeaderboard.lua", "_EventSelect"), "_Event"), _FORV_11_, "SPL_LEADERBOARD_EVENT_SELECT_NAME" .. SinglePlayer.EventInfo(_FORV_12_).kind .. _FORV_11_, false)
    end
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SinglePlayer\\SpCarouselLeaderboard.lua", "_EventSelect"), SCUI.name_to_id.Options, UIEnums.Justify.MiddleCentre)
  end
  UIButtons.SetActive(GUI.event_nodes[UIButtons.GetSelectionIndex(GUI.silder) + 1].node, true, true)
  GUI.current_tier_select_index = UIButtons.GetSelectionIndex(GUI.silder) + 1
  for _FORV_4_ = 1, #GUI.event_nodes do
    UIButtons.SetSelected(GUI.event_nodes[_FORV_4_].event_slider, false)
  end
  _FOR_.SetSelected(GUI.silder, true)
end
function SetUpLeaderboardScreen()
  UIGlobals.SpLeaderboardInCarousel = true
  Amax.SetCurrentEvent(SinglePlayer.EventInfo(GUI.tier_info[GUI.current_tier_select_index].events[UIButtons.GetSelection(GUI.event_nodes[1].event_slider)]).eventId)
  PushScreen("SinglePlayer\\SpShowLeaderboard.lua")
end
function ReLoadLeaderboardScreen()
  Amax.SetCurrentEvent(SinglePlayer.EventInfo(GUI.tier_info[GUI.current_tier_select_index].events[UIButtons.GetSelection(GUI.event_nodes[GUI.current_tier_select_index].event_slider)]).eventId)
  PushScreen("SinglePlayer\\SpShowLeaderboard.lua")
end
function MoveSelectionUp()
  GUI.current_selection = GUI.current_selection - 1
  if GUI.current_selection < 0 then
    GUI.current_selection = 0
  end
  SetSelectedItem()
end
function MoveSelectionDown()
  GUI.current_selection = GUI.current_selection + 1
  if GUI.current_selection > 1 then
    GUI.current_selection = 1
  end
  SetSelectedItem()
end
function SetSelectedItem()
  UIButtons.ChangePosition(GUI.selection, UIButtons.GetPosition(GUI.tier_select))
end
function SetNewFocus()
  if UIGlobals.SpLeaderboardCarouselFocusOnMenu == true then
    UIButtons.SetActive(GUI.selection, true, true)
    UIButtons.SetSelected(GUI.tier_select, true)
  else
    UIButtons.SetActive(GUI.selection, false, true)
    UIButtons.SetSelected(GUI.tier_select, false)
  end
end
