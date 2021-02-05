ScoringEvent_Debug = 0
function AddScoringEvent(_ARG_0_)
  if _ARG_0_ == UIEnums.TrackScoring.ScoringType.UsedPerk then
    if ScoringEvent_Debug == 1 and AmaxScoringEvent.VehicleIndex == 0 then
      print("-- ", GetScoringEventName(_ARG_0_))
      print("Vehicle Index", AmaxScoringEvent.VehicleIndex)
      print("Perk Used", GetPerkName(AmaxScoringEvent.PerkUsed))
      print("Level", AmaxScoringEvent.Level)
      print("Hit Index", AmaxScoringEvent.VehicleHitIndex)
      print("Unique ID", AmaxScoringEvent.UniqueID)
      print("--")
      print("")
    end
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.ShieldedPerk then
    if ScoringEvent_Debug == 1 and AmaxScoringEvent.VehicleIndex == 0 then
      print("-- ", GetScoringEventName(_ARG_0_))
      print("Vehicle Index", AmaxScoringEvent.VehicleIndex)
      print("DefendedFromVehicleIndex", AmaxScoringEvent.DefendedFromVehicleIndex)
      print("--")
      print("")
    end
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.Overtake then
    if ScoringEvent_Debug == 1 and AmaxScoringEvent.VehicleIndex == 0 then
      print("-- ", GetScoringEventName(_ARG_0_))
      print("Vehicle Index", AmaxScoringEvent.VehicleIndex)
      print("NewRacePosition", AmaxScoringEvent.NewRacePosition)
      print("OvertakenVehicleIndex", AmaxScoringEvent.OvertakenVehicleIndex)
      print("--")
      print("")
    end
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.FatallyDamagedVehicle then
    if ScoringEvent_Debug == 1 then
      print("-- ", GetScoringEventName(_ARG_0_))
      print("Vehicle Index", AmaxScoringEvent.VehicleIndex)
      print("--")
      print("")
    end
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.Collision then
    if ScoringEvent_Debug == 1 and AmaxScoringEvent.VehicleIndex == 0 then
      print("-- ", GetScoringEventName(_ARG_0_))
      print("Vehicle Index", AmaxScoringEvent.VehicleIndex)
      print("Damage", AmaxScoringEvent.Damage)
      print("AgressorVehicleIndex", AmaxScoringEvent.AgressorVehicleIndex)
      print("OtherVehicleIndex", AmaxScoringEvent.OtherVehicleIndex)
      print("--")
      print("")
    end
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.None then
  end
end
function UpdateScoringLogic(_ARG_0_)
end
function GetScoringEventName(_ARG_0_)
  if _ARG_0_ == UIEnums.TrackScoring.ScoringType.None then
    return "None"
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.UsedPerk then
    return "UsedPerk"
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.ShieldedPerk then
    return "ShieldedPerk"
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.Overtake then
    return "Overtake"
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.FatallyDamagedVehicle then
    return "FatallyDamagedVehicle"
  elseif _ARG_0_ == UIEnums.TrackScoring.ScoringType.Collision then
    return "Collision"
  end
  return "Unknown"
end
function GetPerkName(_ARG_0_)
  if _ARG_0_ == UIEnums.TrackScoring.PickupType.None then
    return "None"
  elseif _ARG_0_ == UIEnums.TrackScoring.PickupType.Nitrous then
    return "Nitrous"
  elseif _ARG_0_ == UIEnums.TrackScoring.PickupType.Shock then
    return "Shock"
  elseif _ARG_0_ == UIEnums.TrackScoring.PickupType.Shunt then
    return "Shunt"
  elseif _ARG_0_ == UIEnums.TrackScoring.PickupType.Shield then
    return "Shield"
  elseif _ARG_0_ == UIEnums.TrackScoring.PickupType.Repair then
    return "Repair"
  elseif _ARG_0_ == UIEnums.TrackScoring.PickupType.XP then
    return "XP"
  elseif _ARG_0_ == UIEnums.TrackScoring.PickupType.Mine then
    return "Mine"
  elseif _ARG_0_ == UIEnums.TrackScoring.PickupType.Barge then
    return "Barge"
  end
  return "Unknown"
end
