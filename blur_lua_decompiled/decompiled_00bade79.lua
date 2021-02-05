GUI = {}
function Run(_ARG_0_, _ARG_1_)
  print("Func:", _ARG_0_, "Arg:", _ARG_1_)
  if UIScreen.Context() ~= 0 then
    return
  end
  if ContextTable[UIEnums.Context.Main].GUI == nil or ContextTable[UIEnums.Context.Main].SCUI == nil then
    print("Command.lua Run() has no context[0].GUI / .SCUI table")
    return
  end
  if ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context] ~= nil then
  end
  if _ARG_0_ == "open_app" then
    OpenApp(UIButtons.GetSelection(ContextTable[UIEnums.Context.Main].GUI.carousel_id, 2))
  elseif _ARG_0_ == "pan_in" then
    UIButtons.TimeLineActive("start_load", false)
  elseif _ARG_0_ == "pan_out" then
    UIButtons.TimeLineActive("start_load", true)
  elseif _ARG_0_ == "close_app" then
    CloseApp(UIButtons.GetSelection(ContextTable[UIEnums.Context.Main].GUI.carousel_id, 2))
  elseif _ARG_0_ == "lock_controller" then
    LockController()
    UIButtons.SetSelected(ContextTable[UIEnums.Context.Main].GUI.carousel_id, false)
  elseif _ARG_0_ == "unlock_controller" then
    UnlockController()
  elseif _ARG_0_ == "select" then
    UIButtons.SetSelection(ContextTable[UIEnums.Context.Main].GUI.carousel_id, _ARG_1_)
  end
  if _ARG_0_ == "select_group" then
    UIButtons.SetSelected(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.GroupListId, true)
    UIButtons.SetSelection(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.GroupListId, UIGlobals.JumpGroupId)
  end
  if _ARG_0_ == "profile_update_start" then
  elseif _ARG_0_ == "profile_update_show_icon" then
    UIButtons.TimeLineActive("show_fan_icon", true)
    UIButtons.TimeLineActive("hide_fan_icon", false)
  elseif _ARG_0_ == "profile_update_hide_icon" then
    UIButtons.TimeLineActive("hide_fan_icon", true)
    UIButtons.TimeLineActive("show_fan_icon", false)
  elseif _ARG_0_ == "profile_update_show_fans" then
    UIButtons.TimeLineActive("show_fans_earned", true)
  elseif _ARG_0_ == "profile_update_hide_fans" then
    UIButtons.TimeLineActive("show_fans_earned", false)
  elseif _ARG_0_ == "profile_update_show_cash" then
    UIButtons.TimeLineActive("show_cash_earned", true)
  elseif _ARG_0_ == "profile_update_hide_cash" then
    UIButtons.TimeLineActive("show_cash_earned", false)
  elseif _ARG_0_ == "profile_update_fans_start" then
    ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.UpdateFans = true
  elseif _ARG_0_ == "profile_update_fans_end" then
    ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.UpdateFans = false
  elseif _ARG_0_ == "profile_update_cash_start" then
    ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.UpdateCash = true
  elseif _ARG_0_ == "profile_update_cash_end" then
    ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.UpdateCash = false
  elseif _ARG_0_ == "profile_update_end" then
    UIButtons.SetActive(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].SCUI.name_to_id.FanBody, false, true)
    UIButtons.SetActive(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.FriendsListId, true)
    UIButtons.SetActive(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].SCUI.name_to_id.Friends, true)
    SetupInfoLine(UIText.INFO_VEW_DETAILS, UIText.INFO_B_BACK, UIText.INFO_TOGGLE_PERKS, UIText.INFO_EDIT_MEDIA)
  elseif _ARG_0_ == "open_game_options" then
    if IsNumber(ContextTable[UIEnums.Context.Main].GUI.active_context) == true then
      GoScreen("Shared\\Options_DrivingAssists.lua", ContextTable[UIEnums.Context.Main].GUI.active_context)
    end
  elseif _ARG_0_ == "open_options_gamma" and IsNumber(ContextTable[UIEnums.Context.Main].GUI.active_context) == true then
    GoScreen("Shared\\Options_ImageAdjust.lua", ContextTable[UIEnums.Context.Main].GUI.active_context)
  end
  if _ARG_0_ == "mp_raceresults_start" then
    UIButtons.TimeLineActive("show_finished", true)
    UIButtons.SetActive(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.icon, true, true)
  elseif _ARG_0_ == "mp_raceresults_hide_finished" then
    UIButtons.TimeLineActive("hide_finished", true)
  elseif _ARG_0_ == "mp_raceresults_update_fans" then
    UIButtons.TimeLineActive("show_fan_icon", true)
    UIButtons.SetActive(ContextTable[UIEnums.Context.Main].SCUI.name_to_id.fan_icon, true, true)
    ContextTable[UIEnums.Context.Main].GUI.UpdatingFans = true
    SetupInfoLine(UIText.INFO_SKIP_A)
  end
  if ContextTable[UIEnums.Context.Main].GUI.do_tutorial == false then
    return
  end
  if _ARG_0_ == "avatar_on" then
    UIButtons.TimeLineActive("avatar_scale", true)
  elseif _ARG_0_ == "avatar_off" then
    UIButtons.TimeLineActive("avatar_scale", false)
    UIButtons.SetActive(ContextTable[UIEnums.Context.Main].GUI.tutorial_text_id, false)
  elseif _ARG_0_ == "next_text" then
    UIButtons.SetActive(ContextTable[UIEnums.Context.Main].GUI.tutorial_text_id, true)
    UIButtons.ResetTextPrint(ContextTable[UIEnums.Context.Main].GUI.tutorial_text_id)
    UIButtons.ChangeText(ContextTable[UIEnums.Context.Main].GUI.tutorial_text_id, ContextTable[UIEnums.Context.Main].GUI.tutorial_step_text[ContextTable[UIEnums.Context.Main].GUI.tutorial_text_index])
    UISystem.PlaySound(ContextTable[UIEnums.Context.Main].GUI.tutorial_step_vo[ContextTable[UIEnums.Context.Main].GUI.tutorial_text_index])
    ContextTable[UIEnums.Context.Main].GUI.tutorial_text_index = ContextTable[UIEnums.Context.Main].GUI.tutorial_text_index + 1
  elseif _ARG_0_ == "init_app" then
    UIButtons.TimeLineActive("fade_" .. ContextTable[UIEnums.Context.Main].GUI.branch_name[UIButtons.GetSelection(ContextTable[UIEnums.Context.Main].GUI.carousel_id, 2)], true)
  elseif _ARG_0_ == "enable" then
    EndTutorial()
  end
end
