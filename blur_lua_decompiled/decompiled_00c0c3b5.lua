GUI = {
  finished = false,
  carousel_branch = "Help",
  CanExit = function(_ARG_0_)
    UISystem.PlaySound(UIEnums.SoundEffect.GraphicBackward)
    return true
  end,
  node_ids = {}
}
function Init()
  if UIGlobals.IsIngame == false then
    Amax.ChangeUiCamera("Op_1", 0.6, 0)
    net_SetRichPresence(UIEnums.RichPresence.Help)
  end
  AddSCUI_Elements()
  CarouselApp_SetScreenTimers()
  GUI.MenuId = SCUI.name_to_id.menu
  GUI.node_ids[1] = Mp_SetupMenuItemHelpText(GUI.MenuId, 0, UIText.CMN_OPT_POWERUPS_HELP, UIText.CMN_HLP_OPT_POWERUPS, "perk_question", "common_icons")
  if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
    GUI.node_ids[2] = Mp_SetupMenuItemHelpText(GUI.MenuId, 1, UIText.CMN_OPT_SHARING_HELP, UIText.CMN_HLP_OPT_SHARING, "message", "common_icons")
    GUI.node_ids[3] = Mp_SetupMenuItemHelpText(GUI.MenuId, 2, UIText.CMN_OPT_SP_PROGRESSION_HELP, UIText.CMN_HLP_OPT_SP_PROGRESSION, "bio", "common_icons")
    GUI.node_ids[4] = Mp_SetupMenuItemHelpText(GUI.MenuId, 3, UIText.CMN_OPT_SP_GAME_MODES_HELP, UIText.CMN_HLP_OPT_SP_GAME_MODES, "style_racing", "common_icons")
    if UIGlobals.IsIngame == false then
      GUI.node_ids[5] = Mp_SetupMenuItemHelpText(GUI.MenuId, 4, UIText.CMN_OPT_VIDEO_HELP, UIText.CMN_HLP_OPT_VIDEOS, "video", "common_icons")
    end
  else
    GUI.node_ids[2] = Mp_SetupMenuItemHelpText(GUI.MenuId, 1, UIText.CMN_OPT_MP_PROGRESSION_HELP, UIText.CMN_HLP_OPT_MP_PROGRESSION, "groups", "common_icons")
    GUI.node_ids[3] = Mp_SetupMenuItemHelpText(GUI.MenuId, 2, UIText.CMN_OPT_MP_GAME_MODES_HELP, UIText.CMN_HLP_OPT_MP_GAME_MODES, "Powered_up_Racing", "common_icons")
  end
  StoreInfoLine()
  SetupMenuOptions()
  SetupScreenTitle(UIText.CMN_HELP_TITLE, SCUI.name_to_id._CarouselDummy, "help")
  SetupBottomHelpBar(UIText.CMN_HLP_SCREEN_HELP)
end
function PostInit()
  UIButtons.SetSelection(GUI.MenuId, 0)
  if IsNumber(GetScreenOtions().selection) == true then
    UIButtons.SetSelection(GUI.MenuId, GetScreenOtions().selection)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if IsControllerLocked() == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or UIButtons.SetCurrentItemByID(GUI.MenuId, (UIButtons.GetParent(_ARG_2_))) == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    PlaySfxNext()
    if UIButtons.GetSelection(GUI.MenuId) == 0 then
      GoScreen("Shared\\Help_Powerups.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 1 then
      if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
        GoScreen("Shared\\Help_Sharing.lua")
      else
        GoScreen("Shared\\Help_MP_Progression.lua")
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == 2 then
      if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
        GoScreen("Shared\\Help_SP_Progression.lua")
      else
        GoScreen("Shared\\Help_MP_GameModes.lua")
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == 3 then
      GoScreen("Shared\\Help_SP_GameModes.lua")
    elseif UIButtons.GetSelection(GUI.MenuId) == 4 then
      GoScreen("Shared\\Help_Video.lua")
    else
      print("whaatisit?", (UIButtons.GetSelection(GUI.MenuId)))
    end
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
  GetScreenOtions().selection = UIButtons.GetSelection(GUI.MenuId)
end
