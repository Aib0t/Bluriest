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
  SetupScreenTitle(UIText.CMN_HELP_SHARING_TITLE, SCUI.name_to_id._CarouselDummy, "message", "common_icons")
  SetupBottomHelpBar(UIText.CMN_HLP_OPT_SHARING)
  UISystem.PlaySound(UIEnums.SoundEffect.Cascade)
end
function PostInit()
  if Amax.GetGameMode() ~= UIEnums.GameMode.SinglePlayer then
    UIButtons.SetActive(SCUI.name_to_id.gfx_bullet_4, false, true)
  end
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
