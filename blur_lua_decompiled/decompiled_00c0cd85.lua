GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupBack()
  SetupScreenTitle(UIText.CMN_HELP_SP_PROGRESSION_TITLE, SCUI.name_to_id._CarouselDummy, "bio")
  SetupBottomHelpBar(UIText.CMN_HLP_OPT_SP_PROGRESSION)
  UISystem.PlaySound(UIEnums.SoundEffect.Cascade)
end
function PostInit()
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    PlaySfxBack()
    GoScreen("Shared\\Help.lua")
  end
end
function FrameUpdate(_ARG_0_)
end
function EnterEnd()
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
end
