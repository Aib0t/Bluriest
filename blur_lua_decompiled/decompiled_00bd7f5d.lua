UISystem.LoadLuaScript("Screens\\Debug\\DebugItemBase.lua")
YPos = 0
YNextPos = 0
NumberOfItems = 0
CurrentItemSelected = 1
GUI = {stringNo = 0, finished = false}
RandomCarsGadget = YesNoGadgetBase:New()
NumberOfCarsGadget = DebugItem:New()
function NumberOfCarsGadget.AddData(_ARG_0_)
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
CharacterSelectGadget = DebugItem:New()
function CharacterSelectGadget.AddData(_ARG_0_)
  for _FORV_5_, _FORV_6_ in ipairs((GameData.GetCharacters())) do
    UIButtons.AddItem(_ARG_0_.ID, _FORV_6_.id, _FORV_6_.name, false)
  end
end
ManufacturerSelectGadget = DebugItem:New()
function ManufacturerSelectGadget.AddData(_ARG_0_)
  for _FORV_5_, _FORV_6_ in ipairs((GameData.GetManufacturers())) do
    UIButtons.AddItem(_ARG_0_.ID, _FORV_6_.id, _FORV_6_.name, false)
  end
end
VehicleSelectGadget = DebugItem:New()
function VehicleSelectGadget.AddData(_ARG_0_)
  if type(_ARG_0_.Index) == "nil" then
    _ARG_0_.Index = NumberOfItems + 1
  end
  _ARG_0_.CurrentManufacturer = UIButtons.GetSelection(DebugMenu[_ARG_0_.Index - 1][1]:GetID())
  UIButtons.ClearItems(_ARG_0_.ID)
  for _FORV_5_, _FORV_6_ in ipairs((GameData.GetVehicles(_ARG_0_.CurrentManufacturer))) do
    UIButtons.AddItem(_ARG_0_.ID, _FORV_6_.name, _FORV_6_.name, false)
  end
end
function VehicleSelectGadget.Update(_ARG_0_)
  if _ARG_0_.CurrentManufacturer ~= UIButtons.GetSelection(DebugMenu[_ARG_0_.Index - 1][1]:GetID()) then
    _ARG_0_:AddData()
  end
end
VehicleTypeSelectGadget = DebugItem:New()
function VehicleTypeSelectGadget.AddData(_ARG_0_)
  if type(_ARG_0_.Index) == "nil" then
    _ARG_0_.Index = NumberOfItems + 1
  end
  _ARG_0_.CurrentVehicle = UIButtons.GetSelection(DebugMenu[_ARG_0_.Index - 1][1]:GetID())
  UIButtons.ClearItems(_ARG_0_.ID)
  if GameData.HasVehicleGotStyle(_ARG_0_.CurrentVehicle, 0) == true then
    UIButtons.AddItem(_ARG_0_.ID, 0, UIText.VEH_TYP_STOCK, false)
  end
  if GameData.HasVehicleGotStyle(_ARG_0_.CurrentVehicle, 1) == true then
    UIButtons.AddItem(_ARG_0_.ID, 1, UIText.VEH_TYP_SMOOTH, false)
  end
  if GameData.HasVehicleGotStyle(_ARG_0_.CurrentVehicle, 2) == true then
    UIButtons.AddItem(_ARG_0_.ID, 2, UIText.VEH_TYP_DRIFT, false)
  end
  if GameData.HasVehicleGotStyle(_ARG_0_.CurrentVehicle, 3) == true then
    UIButtons.AddItem(_ARG_0_.ID, 3, UIText.VEH_TYP_TUNER, false)
  end
  if GameData.HasVehicleGotStyle(_ARG_0_.CurrentVehicle, 4) == true then
    UIButtons.AddItem(_ARG_0_.ID, 4, UIText.VEH_TYP_RACE, false)
  end
  if GameData.HasVehicleGotStyle(_ARG_0_.CurrentVehicle, 5) == true then
    UIButtons.AddItem(_ARG_0_.ID, 5, UIText.VEH_TYP_RAT, false)
  end
  if GameData.HasVehicleGotStyle(_ARG_0_.CurrentVehicle, 6) == true then
    UIButtons.AddItem(_ARG_0_.ID, 6, UIText.VEH_TYP_OFFROAD, false)
  end
  if GameData.HasVehicleGotStyle(_ARG_0_.CurrentVehicle, 7) == true then
    UIButtons.AddItem(_ARG_0_.ID, 7, UIText.VEH_TYP_DRAG, false)
  end
end
function VehicleTypeSelectGadget.Update(_ARG_0_)
  if _ARG_0_.CurrentVehicle ~= UIButtons.GetSelection(DebugMenu[_ARG_0_.Index - 1][1]:GetID()) then
    _ARG_0_:AddData()
  end
end
ControlsSelectGadget = DebugItem:New()
function ControlsSelectGadget.AddData(_ARG_0_)
  UIButtons.AddItem(_ARG_0_.ID, 99, UIText.CMN_AI_CONTROLLED, false)
  UIButtons.AddItem(_ARG_0_.ID, 0, UIText.CMN_CONTROLLER_PORT_1, false)
  UIButtons.AddItem(_ARG_0_.ID, 1, UIText.CMN_CONTROLLER_PORT_2, false)
  UIButtons.AddItem(_ARG_0_.ID, 2, UIText.CMN_CONTROLLER_PORT_3, false)
  UIButtons.AddItem(_ARG_0_.ID, 3, UIText.CMN_CONTROLLER_PORT_4, false)
end
CharacterSelectGadget1 = CharacterSelectGadget:New()
ManufacturerSelectGadget1 = ManufacturerSelectGadget:New()
VehicleSelectGadget1 = VehicleSelectGadget:New()
VehicleTypeSelectGadget1 = VehicleTypeSelectGadget:New()
ControlsSelectGadget1 = ControlsSelectGadget:New()
CharacterSelectGadget2 = CharacterSelectGadget:New()
ManufacturerSelectGadget2 = ManufacturerSelectGadget:New()
VehicleSelectGadget2 = VehicleSelectGadget:New()
VehicleTypeSelectGadget2 = VehicleTypeSelectGadget:New()
ControlsSelectGadget2 = ControlsSelectGadget:New()
CharacterSelectGadget3 = CharacterSelectGadget:New()
ManufacturerSelectGadget3 = ManufacturerSelectGadget:New()
VehicleSelectGadget3 = VehicleSelectGadget:New()
VehicleTypeSelectGadget3 = VehicleTypeSelectGadget:New()
ControlsSelectGadget3 = ControlsSelectGadget:New()
CharacterSelectGadget4 = CharacterSelectGadget:New()
ManufacturerSelectGadget4 = ManufacturerSelectGadget:New()
VehicleSelectGadget4 = VehicleSelectGadget:New()
VehicleTypeSelectGadget4 = VehicleTypeSelectGadget:New()
ControlsSelectGadget4 = ControlsSelectGadget:New()
CharacterSelectGadget5 = CharacterSelectGadget:New()
ManufacturerSelectGadget5 = ManufacturerSelectGadget:New()
VehicleSelectGadget5 = VehicleSelectGadget:New()
VehicleTypeSelectGadget5 = VehicleTypeSelectGadget:New()
ControlsSelectGadget5 = ControlsSelectGadget:New()
CharacterSelectGadget6 = CharacterSelectGadget:New()
ManufacturerSelectGadget6 = ManufacturerSelectGadget:New()
VehicleSelectGadget6 = VehicleSelectGadget:New()
VehicleTypeSelectGadget6 = VehicleTypeSelectGadget:New()
ControlsSelectGadget6 = ControlsSelectGadget:New()
CharacterSelectGadget7 = CharacterSelectGadget:New()
ManufacturerSelectGadget7 = ManufacturerSelectGadget:New()
VehicleSelectGadget7 = VehicleSelectGadget:New()
VehicleTypeSelectGadget7 = VehicleTypeSelectGadget:New()
ControlsSelectGadget7 = ControlsSelectGadget:New()
CharacterSelectGadget8 = CharacterSelectGadget:New()
ManufacturerSelectGadget8 = ManufacturerSelectGadget:New()
VehicleSelectGadget8 = VehicleSelectGadget:New()
VehicleTypeSelectGadget8 = VehicleTypeSelectGadget:New()
ControlsSelectGadget8 = ControlsSelectGadget:New()
CharacterSelectGadget9 = CharacterSelectGadget:New()
ManufacturerSelectGadget9 = ManufacturerSelectGadget:New()
VehicleSelectGadget9 = VehicleSelectGadget:New()
VehicleTypeSelectGadget9 = VehicleTypeSelectGadget:New()
ControlsSelectGadget9 = ControlsSelectGadget:New()
CharacterSelectGadget10 = CharacterSelectGadget:New()
ManufacturerSelectGadget10 = ManufacturerSelectGadget:New()
VehicleSelectGadget10 = VehicleSelectGadget:New()
VehicleTypeSelectGadget10 = VehicleTypeSelectGadget:New()
ControlsSelectGadget10 = ControlsSelectGadget:New()
CharacterSelectGadget11 = CharacterSelectGadget:New()
ManufacturerSelectGadget11 = ManufacturerSelectGadget:New()
VehicleSelectGadget11 = VehicleSelectGadget:New()
VehicleTypeSelectGadget11 = VehicleTypeSelectGadget:New()
ControlsSelectGadget11 = ControlsSelectGadget:New()
CharacterSelectGadget12 = CharacterSelectGadget:New()
ManufacturerSelectGadget12 = ManufacturerSelectGadget:New()
VehicleSelectGadget12 = VehicleSelectGadget:New()
VehicleTypeSelectGadget12 = VehicleTypeSelectGadget:New()
ControlsSelectGadget12 = ControlsSelectGadget:New()
CharacterSelectGadget13 = CharacterSelectGadget:New()
ManufacturerSelectGadget13 = ManufacturerSelectGadget:New()
VehicleSelectGadget13 = VehicleSelectGadget:New()
VehicleTypeSelectGadget13 = VehicleTypeSelectGadget:New()
ControlsSelectGadget13 = ControlsSelectGadget:New()
CharacterSelectGadget14 = CharacterSelectGadget:New()
ManufacturerSelectGadget14 = ManufacturerSelectGadget:New()
VehicleSelectGadget14 = VehicleSelectGadget:New()
VehicleTypeSelectGadget14 = VehicleTypeSelectGadget:New()
ControlsSelectGadget14 = ControlsSelectGadget:New()
CharacterSelectGadget15 = CharacterSelectGadget:New()
ManufacturerSelectGadget15 = ManufacturerSelectGadget:New()
VehicleSelectGadget15 = VehicleSelectGadget:New()
VehicleTypeSelectGadget15 = VehicleTypeSelectGadget:New()
ControlsSelectGadget15 = ControlsSelectGadget:New()
CharacterSelectGadget16 = CharacterSelectGadget:New()
ManufacturerSelectGadget16 = ManufacturerSelectGadget:New()
VehicleSelectGadget16 = VehicleSelectGadget:New()
VehicleTypeSelectGadget16 = VehicleTypeSelectGadget:New()
ControlsSelectGadget16 = ControlsSelectGadget:New()
CharacterSelectGadget17 = CharacterSelectGadget:New()
ManufacturerSelectGadget17 = ManufacturerSelectGadget:New()
VehicleSelectGadget17 = VehicleSelectGadget:New()
VehicleTypeSelectGadget17 = VehicleTypeSelectGadget:New()
ControlsSelectGadget17 = ControlsSelectGadget:New()
CharacterSelectGadget18 = CharacterSelectGadget:New()
ManufacturerSelectGadget18 = ManufacturerSelectGadget:New()
VehicleSelectGadget18 = VehicleSelectGadget:New()
VehicleTypeSelectGadget18 = VehicleTypeSelectGadget:New()
ControlsSelectGadget18 = ControlsSelectGadget:New()
CharacterSelectGadget19 = CharacterSelectGadget:New()
ManufacturerSelectGadget19 = ManufacturerSelectGadget:New()
VehicleSelectGadget19 = VehicleSelectGadget:New()
VehicleTypeSelectGadget19 = VehicleTypeSelectGadget:New()
ControlsSelectGadget19 = ControlsSelectGadget:New()
CharacterSelectGadget20 = CharacterSelectGadget:New()
ManufacturerSelectGadget20 = ManufacturerSelectGadget:New()
VehicleSelectGadget20 = VehicleSelectGadget:New()
VehicleTypeSelectGadget20 = VehicleTypeSelectGadget:New()
ControlsSelectGadget20 = ControlsSelectGadget:New()
DebugMenu = {
  {
    RandomCarsGadget,
    UIText.DBG_RANDOM_CARS,
    "RandomCars"
  },
  {
    NumberOfCarsGadget,
    UIText.CMN_NUMBER_OF_CARS,
    "NumberOfCars"
  },
  {
    ManufacturerSelectGadget1,
    UIText.CMN_MANUFACTURER,
    "Manufacturer1"
  },
  {
    VehicleSelectGadget1,
    UIText.CMN_VEHICLE,
    "Vehicle1"
  },
  {
    VehicleTypeSelectGadget1,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType1"
  },
  {
    ControlsSelectGadget1,
    UIText.CMN_CONTROLS,
    "Control1"
  },
  {
    CharacterSelectGadget1,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character1"
  },
  {
    ManufacturerSelectGadget2,
    UIText.CMN_MANUFACTURER,
    "Manufacturer2"
  },
  {
    VehicleSelectGadget2,
    UIText.CMN_VEHICLE,
    "Vehicle2"
  },
  {
    VehicleTypeSelectGadget2,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType2"
  },
  {
    ControlsSelectGadget2,
    UIText.CMN_CONTROLS,
    "Control2"
  },
  {
    CharacterSelectGadget2,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character2"
  },
  {
    ManufacturerSelectGadget3,
    UIText.CMN_MANUFACTURER,
    "Manufacturer3"
  },
  {
    VehicleSelectGadget3,
    UIText.CMN_VEHICLE,
    "Vehicle3"
  },
  {
    VehicleTypeSelectGadget3,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType3"
  },
  {
    ControlsSelectGadget3,
    UIText.CMN_CONTROLS,
    "Control3"
  },
  {
    CharacterSelectGadget3,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character3"
  },
  {
    ManufacturerSelectGadget4,
    UIText.CMN_MANUFACTURER,
    "Manufacturer4"
  },
  {
    VehicleSelectGadget4,
    UIText.CMN_VEHICLE,
    "Vehicle4"
  },
  {
    VehicleTypeSelectGadget4,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType4"
  },
  {
    ControlsSelectGadget4,
    UIText.CMN_CONTROLS,
    "Control4"
  },
  {
    CharacterSelectGadget4,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character4"
  },
  {
    ManufacturerSelectGadget5,
    UIText.CMN_MANUFACTURER,
    "Manufacturer5"
  },
  {
    VehicleSelectGadget5,
    UIText.CMN_VEHICLE,
    "Vehicle5"
  },
  {
    VehicleTypeSelectGadget5,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType5"
  },
  {
    ControlsSelectGadget5,
    UIText.CMN_CONTROLS,
    "Control5"
  },
  {
    CharacterSelectGadget5,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character5"
  },
  {
    ManufacturerSelectGadget6,
    UIText.CMN_MANUFACTURER,
    "Manufacturer6"
  },
  {
    VehicleSelectGadget6,
    UIText.CMN_VEHICLE,
    "Vehicle6"
  },
  {
    VehicleTypeSelectGadget6,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType6"
  },
  {
    ControlsSelectGadget6,
    UIText.CMN_CONTROLS,
    "Control6"
  },
  {
    CharacterSelectGadget6,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character6"
  },
  {
    ManufacturerSelectGadget7,
    UIText.CMN_MANUFACTURER,
    "Manufacturer7"
  },
  {
    VehicleSelectGadget7,
    UIText.CMN_VEHICLE,
    "Vehicle7"
  },
  {
    VehicleTypeSelectGadget7,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType7"
  },
  {
    ControlsSelectGadget7,
    UIText.CMN_CONTROLS,
    "Control7"
  },
  {
    CharacterSelectGadget7,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character7"
  },
  {
    ManufacturerSelectGadget8,
    UIText.CMN_MANUFACTURER,
    "Manufacturer8"
  },
  {
    VehicleSelectGadget8,
    UIText.CMN_VEHICLE,
    "Vehicle8"
  },
  {
    VehicleTypeSelectGadget8,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType8"
  },
  {
    ControlsSelectGadget8,
    UIText.CMN_CONTROLS,
    "Control8"
  },
  {
    CharacterSelectGadget8,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character8"
  },
  {
    ManufacturerSelectGadget9,
    UIText.CMN_MANUFACTURER,
    "Manufacturer9"
  },
  {
    VehicleSelectGadget9,
    UIText.CMN_VEHICLE,
    "Vehicle9"
  },
  {
    VehicleTypeSelectGadget9,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType9"
  },
  {
    ControlsSelectGadget9,
    UIText.CMN_CONTROLS,
    "Control9"
  },
  {
    CharacterSelectGadget9,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character9"
  },
  {
    ManufacturerSelectGadget10,
    UIText.CMN_MANUFACTURER,
    "Manufacturer10"
  },
  {
    VehicleSelectGadget10,
    UIText.CMN_VEHICLE,
    "Vehicle10"
  },
  {
    VehicleTypeSelectGadget10,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType10"
  },
  {
    ControlsSelectGadget10,
    UIText.CMN_CONTROLS,
    "Control10"
  },
  {
    CharacterSelectGadget10,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character10"
  },
  {
    ManufacturerSelectGadget11,
    UIText.CMN_MANUFACTURER,
    "Manufacturer11"
  },
  {
    VehicleSelectGadget11,
    UIText.CMN_VEHICLE,
    "Vehicle11"
  },
  {
    VehicleTypeSelectGadget11,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType11"
  },
  {
    ControlsSelectGadget11,
    UIText.CMN_CONTROLS,
    "Control11"
  },
  {
    CharacterSelectGadget11,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character11"
  },
  {
    ManufacturerSelectGadget12,
    UIText.CMN_MANUFACTURER,
    "Manufacturer12"
  },
  {
    VehicleSelectGadget12,
    UIText.CMN_VEHICLE,
    "Vehicle12"
  },
  {
    VehicleTypeSelectGadget12,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType12"
  },
  {
    ControlsSelectGadget12,
    UIText.CMN_CONTROLS,
    "Control12"
  },
  {
    CharacterSelectGadget12,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character12"
  },
  {
    ManufacturerSelectGadget13,
    UIText.CMN_MANUFACTURER,
    "Manufacturer13"
  },
  {
    VehicleSelectGadget13,
    UIText.CMN_VEHICLE,
    "Vehicle13"
  },
  {
    VehicleTypeSelectGadget13,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType13"
  },
  {
    ControlsSelectGadget13,
    UIText.CMN_CONTROLS,
    "Control13"
  },
  {
    CharacterSelectGadget13,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character13"
  },
  {
    ManufacturerSelectGadget14,
    UIText.CMN_MANUFACTURER,
    "Manufacturer14"
  },
  {
    VehicleSelectGadget14,
    UIText.CMN_VEHICLE,
    "Vehicle14"
  },
  {
    VehicleTypeSelectGadget14,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType14"
  },
  {
    ControlsSelectGadget14,
    UIText.CMN_CONTROLS,
    "Control14"
  },
  {
    CharacterSelectGadget14,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character14"
  },
  {
    ManufacturerSelectGadget15,
    UIText.CMN_MANUFACTURER,
    "Manufacturer15"
  },
  {
    VehicleSelectGadget15,
    UIText.CMN_VEHICLE,
    "Vehicle15"
  },
  {
    VehicleTypeSelectGadget15,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType15"
  },
  {
    ControlsSelectGadget15,
    UIText.CMN_CONTROLS,
    "Control15"
  },
  {
    CharacterSelectGadget15,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character15"
  },
  {
    ManufacturerSelectGadget16,
    UIText.CMN_MANUFACTURER,
    "Manufacturer16"
  },
  {
    VehicleSelectGadget16,
    UIText.CMN_VEHICLE,
    "Vehicle16"
  },
  {
    VehicleTypeSelectGadget16,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType16"
  },
  {
    ControlsSelectGadget16,
    UIText.CMN_CONTROLS,
    "Control16"
  },
  {
    CharacterSelectGadget16,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character16"
  },
  {
    ManufacturerSelectGadget17,
    UIText.CMN_MANUFACTURER,
    "Manufacturer17"
  },
  {
    VehicleSelectGadget17,
    UIText.CMN_VEHICLE,
    "Vehicle17"
  },
  {
    VehicleTypeSelectGadget17,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType17"
  },
  {
    ControlsSelectGadget17,
    UIText.CMN_CONTROLS,
    "Control17"
  },
  {
    CharacterSelectGadget17,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character17"
  },
  {
    ManufacturerSelectGadget18,
    UIText.CMN_MANUFACTURER,
    "Manufacturer18"
  },
  {
    VehicleSelectGadget18,
    UIText.CMN_VEHICLE,
    "Vehicle18"
  },
  {
    VehicleTypeSelectGadget18,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType18"
  },
  {
    ControlsSelectGadget18,
    UIText.CMN_CONTROLS,
    "Control18"
  },
  {
    CharacterSelectGadget18,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character18"
  },
  {
    ManufacturerSelectGadget19,
    UIText.CMN_MANUFACTURER,
    "Manufacturer19"
  },
  {
    VehicleSelectGadget19,
    UIText.CMN_VEHICLE,
    "Vehicle19"
  },
  {
    VehicleTypeSelectGadget19,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType19"
  },
  {
    ControlsSelectGadget19,
    UIText.CMN_CONTROLS,
    "Control19"
  },
  {
    CharacterSelectGadget19,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character19"
  },
  {
    ManufacturerSelectGadget20,
    UIText.CMN_MANUFACTURER,
    "Manufacturer20"
  },
  {
    VehicleSelectGadget20,
    UIText.CMN_VEHICLE,
    "Vehicle20"
  },
  {
    VehicleTypeSelectGadget20,
    UIText.CMN_VEHICLE_TYPE,
    "VehicleType20"
  },
  {
    ControlsSelectGadget20,
    UIText.CMN_CONTROLS,
    "Control20"
  },
  {
    CharacterSelectGadget20,
    UIText.CHARACTER_DEBUG_TITLE,
    "Character20"
  }
}
function Init()
  AddSCUI_Elements()
  GUI.stringNo = 0
  for _FORV_5_, _FORV_6_ in ipairs(DebugMenu) do
    if math.mod(NumberOfItems - 1, 4) == 0 then
      if math.mod(NumberOfItems, 4) == 0 then
      else
      end
    end
    _FORV_6_[1]:AddData()
    NumberOfItems = NumberOfItems + 1
  end
  for _FORV_6_, _FORV_7_ in ipairs(DebugMenu) do
    _FORV_7_[1]:SetSelection((Amax.GetLevelData()))
  end
  ContextTable[UIEnums.Context.Main].FrameUpdate(0)
  for _FORV_7_, _FORV_8_ in ipairs(DebugMenu) do
    _FORV_8_[1]:SetSelection((Amax.GetLevelData()))
  end
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
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    GoScreen("Intro\\StartScreen.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    StoreScreen(UIEnums.ScreenStorage.FE_RETURN)
    SetupRaceTable()
    GoLoadingScreen("Loading\\LoadingGame.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonLeftTrigger and _ARG_2_ == true then
    SetupRaceTable()
    GoScreen("Debug\\DebugScreen.lua")
  elseif _ARG_0_ == UIEnums.Message.ButtonUp and _ARG_2_ == true then
    MoveMenu(-1)
  elseif _ARG_0_ == UIEnums.Message.ButtonDown and _ARG_2_ == true then
    MoveMenu(1)
  elseif (_ARG_0_ == UIEnums.Message.ButtonLeft or _ARG_0_ == UIEnums.Message.ButtonRight) and _ARG_2_ == true then
    if math.mod(CurrentItemSelected - 3, 5) == 0 then
      UIButtons.SetSelectionByIndex(DebugMenu[CurrentItemSelected + 1][1]:GetID(), 0)
      UIButtons.SetSelectionByIndex(DebugMenu[CurrentItemSelected + 2][1]:GetID(), 0)
    end
    if math.mod(CurrentItemSelected - 4, 5) == 0 then
      UIButtons.SetSelectionByIndex(DebugMenu[CurrentItemSelected + 1][1]:GetID(), 0)
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true then
    DuplicateFirstCar()
  end
end
function FrameUpdate(_ARG_0_)
  for _FORV_4_, _FORV_5_ in ipairs(DebugMenu) do
    _FORV_5_[1]:Update()
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
    if math.mod(0 - 2, 5) == 0 then
      if math.mod(0, 5) == 0 then
      else
      end
    end
  end
end
function DuplicateFirstCar()
  for _FORV_7_ = 1, 19 do
    UIButtons.SetSelection(DebugMenu[8 + 0][1]:GetID(), (UIButtons.GetSelection(DebugMenu[3][1]:GetID())))
  end
  ContextTable[UIEnums.Context.Main].FrameUpdate(0)
  for _FORV_8_ = 1, 19 do
    UIButtons.SetSelection(DebugMenu[9 + 0][1]:GetID(), (UIButtons.GetSelection(DebugMenu[4][1]:GetID())))
  end
  ContextTable[UIEnums.Context.Main].FrameUpdate(0)
  for _FORV_9_ = 1, 19 do
    UIButtons.SetSelection(DebugMenu[10 + 0][1]:GetID(), (UIButtons.GetSelection(DebugMenu[5][1]:GetID())))
  end
  ContextTable[UIEnums.Context.Main].FrameUpdate(0)
end
