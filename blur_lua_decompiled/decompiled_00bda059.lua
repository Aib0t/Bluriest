GUI = {finished = false}
function Init()
  AddSCUI_Elements()
  SetupBack()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    GoScreen("Debug\\DebugScreen.lua")
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
