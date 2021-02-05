GUI = {
  finished = false,
  PhotoTaskSearch = 0,
  PhotoTaskGetMetaData = 1,
  PhotoTaskDownload = 2,
  PhotoTaskFinished = 3,
  PhotoTask = 0,
  doing_photo_task = false,
  CanExit = function(_ARG_0_)
    return false
  end,
  ids = {},
  node_list_id = -1,
  num_items = 10,
  preview = {},
  photo_select = 1,
  photo_preview = 2,
  current_view = 1,
  timeout = 0,
  min_time = 0
}
function Init()
  AddSCUI_Elements()
  StoreInfoLine()
  SetupInfoLine(UIText.INFO_OPEN_A, UIText.INFO_B_BACK)
  GUI.node_list_id = SCUI.name_to_id.node_list
end
function PostInit()
  GUI.PhotoTask = GUI.PhotoTaskSearch
  LSP.SearchPhotos()
  SetupCustomPopup(UIEnums.CustomPopups.ContentServerSearching)
  GUI.doing_photo_task = true
  for _FORV_3_ = 1, GUI.num_items do
    UIButtons.AddListItem(GUI.node_list_id, UIButtons.CloneXtGadgetByName("SpSCUI", "_slot_selection_node"), _FORV_3_ - 1)
    GUI.ids[#GUI.ids + 1] = {
      node = UIButtons.CloneXtGadgetByName("SpSCUI", "_slot_selection_node"),
      slot = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "_slot_selection_node"), "_text_slot"),
      text = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "_slot_selection_node"), "_text")
    }
  end
  SetupScreenTitle(UIText.RBU_PHOTO_SEARCH_PAGE_TITLE, SCUI.name_to_id.screen, "search_online", "fe_icons")
  SetupPreview()
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
    if GUI.current_view == GUI.photo_preview then
      HidePreview()
    elseif GUI.current_view == GUI.photo_select then
      PlaySfxBack()
      GoScreen("Photos\\PhotoSearchParams.lua")
    end
  elseif _ARG_0_ == UIEnums.Message.ButtonY and _ARG_2_ == true then
    Amax.ViewPhotoSearchGamerCard(Profile.GetPrimaryPad(), (UIButtons.GetSelection(GUI.node_list_id)))
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
    if GUI.current_view == GUI.photo_preview then
      PushScreen("Photos\\ViewPhoto.lua")
    elseif GUI.current_view == GUI.photo_select then
      GUI.doing_photo_task = true
      SetupCustomPopup(UIEnums.CustomPopups.ContentServerData)
      LSP.DownloadPhoto((UIButtons.GetSelection(GUI.node_list_id)))
      GUI.PhotoTask = GUI.PhotoTaskDownload
      GUI.timeout = 0
      GUI.min_time = 2
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.doing_photo_task == true then
    still_pumping, error = LSP.PumpCurrentTask()
    GUI.min_time = GUI.min_time + _ARG_0_
    if still_pumping == false and GUI.min_time > 2 then
      GUI.PhotoTask = GUI.PhotoTask + 1
      if GUI.PhotoTask == GUI.PhotoTaskGetMetaData then
        LSP.GetMetaDataFromSearch()
      elseif GUI.PhotoTask == GUI.PhotoTaskDownload then
        GUI.doing_photo_task = false
        GUI.min_time = 0
        UIScreen.CancelPopup()
        if LSP.GetNumSearchResults() == 0 then
          if LSP.IsConnected() == true then
            SetupCustomPopup(UIEnums.CustomPopups.ContentServerNoResultsFromSearch)
          else
            SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
          end
        else
          for _FORV_5_, _FORV_6_ in ipairs((LSP.GetReturnedSearchData())) do
            UIButtons.SetNodeItemLocked(GUI.node_list_id, _FORV_5_ - 1, false)
            UIButtons.ChangeText(GUI.ids[_FORV_5_].slot, "GAME_PHOTO_SEARCH_NAME_" .. _FORV_6_.index)
            UIButtons.ChangeText(GUI.ids[_FORV_5_].text, "GAME_PHOTO_SEARCH_INFO_" .. _FORV_6_.index)
          end
          for _FORV_5_ = #LSP.GetReturnedSearchData() + 1, #GUI.ids do
            UIButtons.SetNodeItemLocked(GUI.node_list_id, _FORV_5_ - 1, true)
          end
          print("Should Show Gamercard")
          if NetServices.CanViewGamerCard(Profile.GetPrimaryPad()) == true then
            SetupInfoLine(UIText.INFO_OPEN_A, UIText.INFO_B_BACK, UIText.INFO_Y_VIEW_GAMER_CARD)
          end
        end
      elseif GUI.PhotoTask == GUI.PhotoTaskFinished then
        GUI.doing_photo_task = false
        GUI.min_time = 0
        UIScreen.CancelPopup()
        if error ~= 0 then
          if error == 2006 then
            PopupSpawn(UIEnums.CustomPopups.ContentServerDownloadBandwidthError)
          else
            PopupSpawn(UIEnums.CustomPopups.ContentServerGeneralError)
          end
        else
          LSP.DecodeDownloadedPhoto()
          ShowPreview()
          GUIBank.photo_viewing_from = GUIBank.PhotoViewFrom.Search
          GUIBank.photo_viewing_download = true
          UIButtons.TimeLineActive("Photo_Loaded", true, 0)
        end
      end
    else
      GUI.timeout = GUI.timeout + _ARG_0_
      if GUI.timeout > 30 then
        GUI.PhotoTask = GUI.PhotoTaskFinished
        GUI.doing_photo_task = false
        GUI.min_time = 0
        UIScreen.CancelPopup()
        PopupSpawn(UIEnums.CustomPopups.ContentServerGeneralError)
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
function SetupPreview()
  GUI.preview = CreatePhotoPreviewPage(SCUI.name_to_id.screen)
  UIButtons.SetActive(GUI.preview.node, false, true)
  if GUI.preview.background ~= nil then
    UIButtons.SetParent(SCUI.name_to_id.preview, GUI.preview.background, UIEnums.Justify.MiddleCentre)
  end
end
function ShowPreview()
  GUI.current_view = GUI.photo_preview
  if GUI.preview.node ~= nil then
    UIButtons.SetActive(GUI.preview.node, true, true)
  end
  UIButtons.SetActive(SCUI.name_to_id.node_list, false, true)
  UIButtons.ChangeText(GUI.preview.bottom_text, "GAME_PHOTO_SEARCH_NAME_" .. UIButtons.GetSelectionIndex(SCUI.name_to_id.node_list))
  UIButtons.ChangeText(GUI.preview.top_text, "GAME_PHOTO_SEARCH_PREVIEW_TITLE_" .. UIButtons.GetSelectionIndex(SCUI.name_to_id.node_list))
end
function HidePreview()
  GUI.current_view = GUI.photo_select
  if GUI.preview.node ~= nil then
    UIButtons.SetActive(GUI.preview.node, false, true)
  end
  UIButtons.TimeLineActive("Photo_Loaded", false, 0)
  UIButtons.SetActive(SCUI.name_to_id.node_list, true, true)
end
