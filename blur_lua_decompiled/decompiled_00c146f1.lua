GUI = {
  finished = false,
  carousel_branch = "Options",
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  GUI.MessageListId = SCUI.name_to_id.OptionsList
  StoreInfoLine()
  SetupMenuOptions()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if (_ARG_0_ == UIEnums.Message.MenuBack or _ARG_0_ == UIEnums.Message.MenuNext) and _ARG_2_ == true then
    PlaySfxNext()
    GoScreen("Shared\\Options.lua")
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
