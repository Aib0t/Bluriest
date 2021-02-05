GUI = {
  finished = false,
  PhotoTaskSearch = 0,
  PhotoTaskUpload = 1,
  PhotoTaskFinished = 2,
  PhotoTask = 0,
  doing_photo_task = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  slot_empty = {},
  overwriting = false,
  ids = {},
  node_list_id = -1,
  num_items = 10
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupMenuOptions()
  GUI.node_list_id = SCUI.name_to_id.node_list
  UIGlobals.PhotoSlotContext = UIScreen.Context()
end
function PostInit()
  GUI.PhotoTask = GUI.PhotoTaskSearch
  LSP.Enable(true)
  LSP.SetUserIndex(Profile.GetPrimaryPad())
  LSP.ListFilesByOwner()
  GUI.doing_photo_task = true
  for _FORV_3_ = 1, GUI.num_items do
    UIButtons.AddListItem(GUI.node_list_id, UIButtons.CloneXtGadgetByName("SpSCUI", "_slot_selection_node"), _FORV_3_)
    GUI.ids[#GUI.ids + 1] = {
      node = UIButtons.CloneXtGadgetByName("SpSCUI", "_slot_selection_node"),
      slot = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "_slot_selection_node"), "_text_slot"),
      text = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "_slot_selection_node"), "_text")
    }
  end
  _FOR_.BlockInputToContext(true)
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
    PopScreen()
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == true then
    end
    if not NetServices.UserHasAgeRestriction() == true then
      if GUI.slot_empty[UIButtons.GetSelection(GUI.node_list_id)] == true then
        GUI.overwriting = false
        DoUpload(UIButtons.GetSelection(GUI.node_list_id), GUI)
      else
        GUI.overwriting = true
        SetupCustomPopup(UIEnums.CustomPopups.OverwritePhotoServerSlot)
      end
    else
      SetupCustomPopup(UIEnums.CustomPopups.FailedAgeCheck)
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.doing_photo_task == true then
    still_pumping, error = LSP.PumpCurrentTask()
    if still_pumping == false then
      GUI.PhotoTask = GUI.PhotoTask + 1
      if GUI.PhotoTask == GUI.PhotoTaskUpload then
        GUI.doing_photo_task = false
        for _FORV_5_, _FORV_6_ in ipairs((LSP.GetReturnedSlotData())) do
          UIButtons.SetNodeItemLocked(GUI.node_list_id, _FORV_5_ - 1, false)
          UIButtons.ChangeText(GUI.ids[_FORV_5_].slot, "GAME_PHOTO_SLOT_NAME_" .. _FORV_6_.index - 1)
          UIButtons.ChangeText(GUI.ids[_FORV_5_].text, "GAME_PHOTO_SLOT_INFO_" .. _FORV_6_.index)
          GUI.slot_empty[_FORV_5_] = _FORV_6_.empty
        end
        for _FORV_5_ = #LSP.GetReturnedSlotData() + 1, #GUI.ids do
          UIButtons.SetNodeItemLocked(GUI.node_list_id, _FORV_5_ - 1, true)
        end
      elseif GUI.PhotoTask == GUI.PhotoTaskFinished then
        GUI.doing_photo_task = false
        if error ~= 0 then
          if error == 2003 then
            PopupSpawn(UIEnums.CustomPopups.ContentServerUploadBandwidthError)
          elseif Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
            if net_CanReconnectToDemonware() == false then
              SetupCustomPopup(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
            else
              net_StartServiceConnection(true, nil, false)
            end
          else
            PopupSpawn(UIEnums.CustomPopups.ContentServerGeneralError)
          end
        else
          UIScreen.CancelPopup()
          PopScreen()
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
function DoUpload(_ARG_0_, _ARG_1_)
  _ARG_1_.doing_photo_task = true
  LSP.Enable(true)
  LSP.SetFileName("Photo.jpg")
  LSP.SetFileSlot(_ARG_0_)
  LSP.SetUserIndex(Profile.GetPrimaryPad())
  if LSP.UploadCurrentPhoto() == true then
    if _ARG_1_.overwriting == true then
      PopupSpawn(UIEnums.CustomPopups.ContentServerData)
    else
      SetupCustomPopup(UIEnums.CustomPopups.ContentServerData)
    end
    _ARG_1_.PhotoTask = _ARG_1_.PhotoTaskUpload
  else
    if _ARG_1_.overwriting == true then
      PopupSpawn(UIEnums.CustomPopups.ContentServerCantUpload)
    else
      SetupCustomPopup(UIEnums.CustomPopups.ContentServerCantUpload)
    end
    _ARG_1_.doing_photo_task = false
    _ARG_1_.PhotoTask = _ARG_1_.PhotoTaskFinished
  end
end
