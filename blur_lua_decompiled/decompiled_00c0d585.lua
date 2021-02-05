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
  SetupScreenTitle(UIText.CMN_HELP_MP_GAME_MODES_TITLE, SCUI.name_to_id._CarouselDummy, "Powered_up_Racing")
  SetupBottomHelpBar(UIText.CMN_HELP_MP_GAME_MODES_BOTTOM)
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
  if _ARG_0_ == UIEnums.Message.MenuBack then
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
