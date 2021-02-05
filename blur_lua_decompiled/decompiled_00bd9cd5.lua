GUI = {stringNo = 0, finished = false}
function Init()
  AddSCUI_Elements()
  Amax.ParseHDDForReplays()
  UIButtons.ClearItems(SCUI.name_to_id.ReplayMenu)
  for _FORV_4_, _FORV_5_ in ipairs((Amax.GetReplayFilesFromHDD())) do
    print(_FORV_5_.name)
    UIButtons.StoreString(GUI.stringNo, _FORV_5_.name)
    UIButtons.AddItem(SCUI.name_to_id.ReplayMenu, _FORV_5_.id, GUI.stringNo, true)
    GUI.stringNo = GUI.stringNo + 1
  end
end
function StartLoop(_ARG_0_)
end
function DebugLoadReplay()
  if Amax.DebugLoadReplay() == true then
    StoreScreen(UIEnums.ScreenStorage.FE_RETURN)
    GoLoadingScreen("Loading\\LoadingGame.lua")
  end
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.ButtonRightTrigger and _ARG_2_ == true then
    GoScreen("Debug\\DebugEventScreen.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if Amax.SetLoadReplayIndex(UIButtons.GetSelection(SCUI.name_to_id.ReplayMenu)) == true then
      StoreScreen(UIEnums.ScreenStorage.FE_RETURN)
      GoLoadingScreen("Loading\\LoadingGame.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true then
    Amax.SetConvertReplayIndex(UIButtons.GetSelection(SCUI.name_to_id.ReplayMenu))
  end
end
function FrameUpdate(_ARG_0_)
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
