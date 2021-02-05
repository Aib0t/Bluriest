DebugItem = {
  ID = -1,
  Gadget = {
    layer = UIEnums.Layer.LAYER_1,
    type = UIEnums.ButtonTypes.SPINNER_BUTTON,
    pos = {x = 70, y = 24},
    size = {x = 320, y = 20},
    colour_style = "!255 255 255 255",
    style_selected = {
      name = "MenuSelected"
    },
    style_deselected = {
      name = "MenuDeselected"
    },
    style_selected_unselectable = {
      name = "MenuSelectedUnselectable"
    },
    style_deselected_unselectable = {
      name = "MenuDeselectedUnselectable"
    },
    loop_list = true,
    text = UIText.IDS_NOWT,
    justify = UIEnums.Justify.JUSTIFY_LEFT
  },
  ObjectName = ""
}
function DebugItem.New(_ARG_0_, _ARG_1_)
  _ARG_1_ = _ARG_1_ or {}
  setmetatable(_ARG_1_, _ARG_0_)
  _ARG_0_.__index = _ARG_0_
  return _ARG_1_
end
function DebugItem.AddButton(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  _ARG_0_.Gadget.pos.x = _ARG_2_
  _ARG_0_.Gadget.pos.y = _ARG_3_
  _ARG_0_.Gadget.text = _ARG_1_
  _ARG_0_.ID = UIButtons.AddButton(_ARG_0_.Gadget)
  _ARG_0_.ObjectName = _ARG_4_
  _ARG_0_:Activate(false)
  return _ARG_3_ + 20
end
function DebugItem.MoveButton(_ARG_0_, _ARG_1_, _ARG_2_)
  UIButtons.ChangePosition(_ARG_0_.ID, _ARG_1_, _ARG_2_)
  return _ARG_2_ + 20
end
function DebugItem.AddData(_ARG_0_)
end
function DebugItem.Update(_ARG_0_)
end
function DebugItem.SetSelection(_ARG_0_, _ARG_1_)
  if IsNumber(_ARG_1_[_ARG_0_.ObjectName]) == true then
    UIButtons.SetSelection(_ARG_0_.ID, _ARG_1_[_ARG_0_.ObjectName])
  end
end
function DebugItem.Activate(_ARG_0_, _ARG_1_)
  UIButtons.SetSelected(_ARG_0_.ID, _ARG_1_)
end
function DebugItem.WriteToStructure(_ARG_0_, _ARG_1_)
  _ARG_1_[_ARG_0_.ObjectName] = UIButtons.GetSelection(_ARG_0_.ID)
end
function DebugItem.GetID(_ARG_0_)
  return _ARG_0_.ID
end
YesNoGadgetBase = DebugItem:New()
function YesNoGadgetBase.AddData(_ARG_0_)
  UIButtons.AddItem(_ARG_0_.ID, 0, UIText.CMN_NO, false)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.CMN_YES, false)
end
OnOffGadgetBase = DebugItem:New()
function OnOffGadgetBase.AddData(_ARG_0_)
  UIButtons.AddItem(_ARG_0_.ID, 0, UIText.CMN_OFF, false)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.CMN_ON, false)
end
