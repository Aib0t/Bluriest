GUI = {
  finished = false,
  PhotoTaskLeaderboard = 0,
  PhotoTaskLeaderboardFinished = 1,
  PhotoTaskGetMetaData = 2,
  PhotoTaskDownload = 3,
  PhotoTaskFinished = 4,
  PhotoTask = 0,
  doing_photo_task = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  leaderboardIndex = 0,
  ids = {},
  node_list_id = -1,
  num_items = 20
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_OPEN_A, UIText.INFO_B_BACK)
  GUI.node_list_id = SCUI.name_to_id.node_list
end
function PostInit()
  GUI.PhotoTask = GUI.PhotoTaskLeaderboard
  LSP.Enable(true)
  LSP.SetUserIndex(Profile.GetPrimaryPad())
  LSP.GetTop20Leaderboard(1, true)
  GUI.doing_photo_task = true
  for _FORV_3_ = 1, GUI.num_items do
    UIButtons.AddListItem(GUI.node_list_id, UIButtons.CloneXtGadgetByName("Photos\\Top20VotedPhotos.lua", "_node"), _FORV_3_ - 1)
    GUI.ids[#GUI.ids + 1] = {
      node = UIButtons.CloneXtGadgetByName("Photos\\Top20VotedPhotos.lua", "_node"),
      text = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\Top20VotedPhotos.lua", "_node"), "_text")
    }
  end
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if GUI.doing_photo_task == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    PlaySfxBack()
    GoScreen("Photos\\Photos.lua")
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    GUI.leaderboardIndex = UIButtons.GetSelection(GUI.node_list_id)
    GUI.doing_photo_task = true
    LSP.GetMetaDataFromLeaderboardIndex(GUI.leaderboardIndex, true)
    GUI.PhotoTask = GUI.PhotoTaskGetMetaData
  elseif _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true then
    Amax.ViewPhotoTop20GamerCard(Profile.GetPrimaryPad(), UIButtons.GetSelection(GUI.node_list_id), true)
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.doing_photo_task == true then
    still_pumping, error = LSP.PumpCurrentTask()
    if still_pumping == false then
      GUI.PhotoTask = GUI.PhotoTask + 1
      if GUI.PhotoTask == GUI.PhotoTaskLeaderboardFinished then
        GUI.doing_photo_task = false
        if LSP.IsStatsConnected() == false or #LSP.GetReturnedLeaderboardData(true) == 0 then
          SetupCustomPopup(UIEnums.CustomPopups.ContentServerLeaderboardError)
        else
          for _FORV_5_, _FORV_6_ in ipairs((LSP.GetReturnedLeaderboardData(true))) do
            UIButtons.SetNodeItemLocked(GUI.node_list_id, _FORV_5_ - 1, false)
            UIButtons.ChangeText(GUI.ids[_FORV_5_].text, "GAME_PHOTO_LEADERBOARD_VOTE_" .. _FORV_6_.index)
          end
          for _FORV_5_ = #LSP.GetReturnedLeaderboardData(true) + 1, #GUI.ids do
            UIButtons.SetNodeItemLocked(GUI.node_list_id, _FORV_5_ - 1, true)
          end
          if _FOR_.CanViewGamerCard(Profile.GetPrimaryPad()) == true then
            SetupInfoLine(UIText.INFO_X_SHOW_GAMERCARD, UIText.INFO_OPEN_A, UIText.INFO_B_BACK)
          end
        end
      elseif GUI.PhotoTask == GUI.PhotoTaskGetMetaData then
      elseif GUI.PhotoTask == GUI.PhotoTaskDownload then
        if error == 0 then
          SetupCustomPopup(UIEnums.CustomPopups.ContentServerData)
          LSP.DownloadPhoto(0)
        else
          GUI.doing_photo_task = false
          GUI.PhotoTask = GUI.PhotoTaskFinished
          SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
        end
      elseif GUI.PhotoTask == GUI.PhotoTaskFinished then
        GUI.doing_photo_task = false
        UIScreen.CancelPopup()
        if error ~= 0 then
          if error == 2006 then
            PopupSpawn(UIEnums.CustomPopups.ContentServerDownloadBandwidthError)
          else
            PopupSpawn(UIEnums.CustomPopups.ContentServerGeneralError)
          end
        else
          LSP.DecodeDownloadedPhoto()
          GUIBank.photo_viewing_from = GUIBank.PhotoViewFrom.Top20Voted
          GUIBank.photo_viewing_download = true
          GoScreen("Photos\\ViewPhoto.lua")
        end
      end
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
