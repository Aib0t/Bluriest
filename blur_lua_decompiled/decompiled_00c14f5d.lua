GUI = {
  finished = false,
  carousel_branch = "Options",
  CanExit = function(_ARG_0_)
    return false
  end,
  nat_data = {
    [UIEnums.NatType.Open] = {
      text = UIText.MP_NAT_TYPE_OPEN,
      colour = "Support_0",
      count = 3
    },
    [UIEnums.NatType.Moderate] = {
      text = UIText.MP_NAT_TYPE_MODERATE,
      colour = "Support_4",
      count = 2
    },
    [UIEnums.NatType.Strict] = {
      text = UIText.MP_NAT_TYPE_STRICT,
      colour = "Support_3",
      count = 1
    }
  },
  region_data = {
    [UIEnums.MatchingRegion.Any] = UIText.MP_REGION_ANY,
    [UIEnums.MatchingRegion.Asia] = UIText.MP_REGION_ASIA,
    [UIEnums.MatchingRegion.Australia] = UIText.MP_REGION_AUSTRALIA,
    [UIEnums.MatchingRegion.Europe] = UIText.MP_REGION_EUROPE,
    [UIEnums.MatchingRegion.NorthAmerica] = UIText.MP_REGION_NORTH_AMERICA,
    [UIEnums.MatchingRegion.SouthAmerica] = UIText.MP_REGION_SOUTH_AMERICA
  }
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupBack()
  GUI.region_mode_id = SCUI.name_to_id.region_rule_slider
  UIButtons.AddItem(GUI.region_mode_id, UIEnums.MatchingRule.Any, UIText.MP_REGION_ANY, false)
  UIButtons.AddItem(GUI.region_mode_id, UIEnums.MatchingRule.Preferred, UIText.MP_REGION_PREFERRED, false)
  UIButtons.AddItem(GUI.region_mode_id, UIEnums.MatchingRule.Enforced, UIText.MP_REGION_REQUIRED, false)
  UIButtons.SetSelection(GUI.region_mode_id, (Amax.GetMultiplayerOptions()))
  SetupInfoLineL(UIText.INFO_B_BACK)
end
function PostInit()
  if net_RouterAvailable(true) == true then
    UIButtons.ChangeText(SCUI.name_to_id.nat_type, GUI.nat_data[NetServices.GetNatType()].text)
    for _FORV_4_ = 1, 3 do
      if _FORV_4_ <= GUI.nat_data[NetServices.GetNatType()].count then
        UIButtons.ChangeColour(SCUI.name_to_id["nat_gfx_" .. _FORV_4_], GUI.nat_data[NetServices.GetNatType()].colour)
      else
        UIButtons.ChangeColour(SCUI.name_to_id["nat_gfx_" .. _FORV_4_], "Main_Black")
      end
    end
    _FOR_.ChangeText(SCUI.name_to_id.region, GUI.region_data[NetServices.GetSystemRegion()])
  else
    UIButtons.SetActive(SCUI.name_to_id.unavailible_msg, true)
    UIButtons.SetActive(SCUI.name_to_id.settings, false)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    PlaySfxBack()
    Amax.SetMultiplayerOptions(UIButtons.GetSelection(GUI.region_mode_id))
    NetServices.SetMatchingRegionInfo()
    GoScreen("Shared\\Options.lua")
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
    UIButtons.SetCurrentItemByID(SCUI.name_to_id.OptionsList, (UIButtons.GetParent(_ARG_2_)))
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
