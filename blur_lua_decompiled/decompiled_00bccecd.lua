GUI = {finished = false, timeout = 0}
function Init()
  Splitscreen_AddSplits()
  AddSCUI_Elements()
end
function PostInit()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.GameFlowMessage.RaceFinished then
    UIGlobals.Ingame.RaceFinishedMsg = _ARG_0_
  end
end
function FrameUpdate(_ARG_0_)
  GUI.timeout = GUI.timeout + _ARG_0_
  if GUI.timeout > 3 then
    if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
      print("##### SinglePlayer. Nowhere to go ####")
      print("##### SinglePlayer. Please fix-up ####")
    elseif Amax.GetGameMode() == UIEnums.GameMode.Online then
      GoScreen("Multiplayer\\Ingame\\MpWinner.lua")
      Amax.EndWreckedEffect(0)
    elseif IsSplitScreen() == true then
      Amax.SetupResults()
      GoScreen("Multiplayer\\Ingame\\MpSplitscreenResults.lua")
    else
      GoScreen("Loading\\LoadingUI.lua")
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
