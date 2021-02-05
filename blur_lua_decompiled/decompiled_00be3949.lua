GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  Amax.ChangeUiCamera("Sp_3", UIGlobals.CameraLerpTime, 0)
  net_SetRichPresence(UIEnums.RichPresence.Leaderboards)
  AddSCUI_Elements()
  StoreInfoLine()
  SetupMenuOptions()
  GUI.MenuId = SCUI.name_to_id.menu
  for _FORV_4_, _FORV_5_ in ipairs({
    {
      value = UIEnums.MpScoreboard.TotalWins,
      text = UIText.MP_SCOREBOARD_NEW_TOTAL_POINTS,
      help_text = UIText.MP_SCOREBOARD_NEW_TOTAL_POINTS_HELP,
      icon_sheet = "common_icons",
      icon_name = "points_target"
    },
    {
      value = UIEnums.MpScoreboard.TotalFans,
      text = UIText.MP_SCOREBOARD_NEW_FANS_TOTAL,
      help_text = UIText.MP_SCOREBOARD_NEW_FANS_TOTAL_HELP,
      icon_sheet = "Common_icons",
      icon_name = "Fan"
    },
    {
      value = UIEnums.MpScoreboard.PerkRatio,
      text = UIText.MP_SCOREBOARD_TOTAL_POWERUPS,
      help_text = UIText.MP_SCOREBOARD_TOTAL_POWERUPS_HELP,
      icon_sheet = "fe_icons",
      icon_name = "perk_hit"
    },
    {
      value = UIEnums.MpScoreboard.Legends,
      text = UIText.MP_SCOREBOARD_NEW_LEGENDS,
      help_text = UIText.MP_SCOREBOARD_NEW_LEGENDS_HELP,
      icon_sheet = "fe_icons",
      icon_name = "Legend"
    }
  }) do
    Mp_SetupMenuItemHelpText(GUI.MenuId, _FORV_5_.value, _FORV_5_.text, _FORV_5_.help_text, _FORV_5_.icon_name, _FORV_5_.icon_sheet, UIEnums.Panel._3DAA_WORLD, true)
  end
end
function PostInit()
  RestoreScreenSelection(GUI, "MenuId")
  SetupScreenTitle(UIText.MP_CHOOSE_SCOREBOARD_TO_VIEW, SCUI.name_to_id.TitleDummy, "leaderboards", "fe_icons")
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and UIScreen.Context() == _ARG_3_ then
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or UIButtons.SetCurrentItemByID(GUI.MenuId, (UIButtons.GetParent(_ARG_2_))) == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    PlaySfxNext()
    Amax.ScoreboardLookAt((UIButtons.GetSelection(GUI.MenuId)))
    UIGlobals.ScoreboardLookingAt = UIButtons.GetSelection(GUI.MenuId)
    GoScreen("Multiplayer\\MpShowLeaderboard.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    net_StopScoreboardRequests()
    PlaySfxBack()
    PlaySfxGraphicBack()
    GoScreen("Multiplayer\\MpOnline.lua")
  end
end
function FrameUpdate(_ARG_0_)
end
function EnterEnd()
  RestoreInfoLine()
end
function End()
  StoreScreenSelection(GUI, "MenuId")
end
