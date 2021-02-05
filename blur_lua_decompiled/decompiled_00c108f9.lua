GUI = {
  finished = false,
  carousel_branch = "Options",
  initial_timer = 0.25,
  timer = 0.25,
  can_play_activision_credits = false,
  CanExit = function(_ARG_0_)
    return false
  end
}
function Init()
  AddSCUI_Elements()
  GUI.MessageListId = SCUI.name_to_id.OptionsList
  StoreInfoLine()
  PlaySPMovieFullScreen(UIEnums.SPVideoConfig.VIDEO_END_OF_GAME, true)
end
function PostInit()
  GUI.can_play_activision_credits = true
  if UIGlobals.EndOfGame == true then
    Amax.ChangeUiCamera("Op_1", 0.6, 0)
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonB then
    if UIGlobals.EndOfGame == true then
      UIGlobals.EndOfGame = nil
      ReturnToStartScreen(UIEnums.UserKickBackMode.EndOfGame)
    else
      PlaySfxBack()
      GoScreen("Shared\\Options.lua")
    end
  end
  if _ARG_0_ == UIEnums.Message.CreditsFinished then
    if UIGlobals.EndOfGame == true then
      UIGlobals.EndOfGame = nil
      ReturnToStartScreen(UIEnums.UserKickBackMode.EndOfGame)
    else
      GoScreen("Shared\\Options.lua")
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.initial_timer > 0 then
    GUI.initial_timer = GUI.initial_timer - _ARG_0_
  elseif UIGlobals.OnMovieScreenInEventSelect == false and GUI.can_play_activision_credits == true then
    UIButtons.SetActive(SCUI.name_to_id.Txt_Credits, true)
    UIButtons.SetActive(SCUI.name_to_id.Shp_Credits, true)
    GUI.timer = GUI.timer - _ARG_0_
    if 0 >= GUI.timer then
      SetupInfoLine(UIText.INFO_B_BACK)
      UIButtons.SetActive(SCUI.name_to_id.credits, true)
      GUI.can_play_activision_credits = false
    end
  end
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
