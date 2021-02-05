GUI = {
  finished = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  is_online = false,
  voting = false,
  stars = {},
  rating = 3
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_PHOTO_VOTE_A, UIText.INFO_B_BACK)
  for _FORV_3_ = 1, 5 do
    GUI.stars[_FORV_3_] = SCUI.name_to_id["star_" .. _FORV_3_]
    if _FORV_3_ > GUI.rating then
      UIButtons.ChangeColour(GUI.stars[_FORV_3_], "Main_Black")
    end
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if GUI.voting == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.ButtonLeft then
    if GUI.rating > 0 then
      UIButtons.ChangeColour(GUI.stars[GUI.rating], "Main_Black")
      GUI.rating = GUI.rating - 1
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonRight then
    if GUI.rating < 5 then
      GUI.rating = GUI.rating + 1
      UIButtons.ChangeColour(GUI.stars[GUI.rating], "Support_4")
    end
  elseif _ARG_0_ == UIEnums.Message.MenuBack then
    GoScreen("Photos\\ViewPhoto.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuNext then
    if LSP.Vote(GUI.rating * 2) == true then
      GUI.voting = true
    else
      SetupCustomPopup(UIEnums.CustomPopups.AlreadyVoted)
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.voting == true then
    still_pumping, error = LSP.PumpCurrentTask()
    if still_pumping == false then
      GUI.voting = false
      if error == 0 then
        UIGlobals.FinishedVoting = false
        SetupCustomPopup(UIEnums.CustomPopups.ThankyouForVoting)
      else
        SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
      end
    end
  end
  if UIGlobals.FinishedVoting == true then
    StartAsyncSave()
    UIGlobals.FinishedVoting = false
    if GUIBank.photo_viewing_from == GUIBank.PhotoViewFrom.Top20Voted then
      GoScreen("Photos\\Top20VotedPhotos.lua")
    elseif GUIBank.photo_viewing_from == GUIBank.PhotoViewFrom.Top20Download then
      GoScreen("Photos\\Top20DownloadedPhotos.lua")
    elseif GUIBank.photo_viewing_from == GUIBank.PhotoViewFrom.Search then
      GoScreen("Photos\\PhotoSearch.lua")
    elseif GUIBank.photo_viewing_from == GUIBank.PhotoViewFrom.MyOnline then
      UIGlobals.PhotoDoMyLIst = false
      GoScreen("Photos\\MyOnlinePhotos.lua")
    else
      GoScreen("Photos\\Photos.lua")
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
