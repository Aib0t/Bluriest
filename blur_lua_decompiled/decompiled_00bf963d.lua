GUI = {
  finished = false,
  carousel_branch = "Photos",
  unhide_carousel = true,
  CanExit = function(_ARG_0_)
    return true
  end
}
function Init()
  AddSCUI_Elements()
  Amax.ChangeUiCamera("Sp_2", UIGlobals.CameraLerpTime, 0)
  CarouselApp_SetScreenTimers()
  StoreInfoLine()
  SetupMenuOptions()
  LSP.SetInPhotoUI(true)
  LSP.Enable(true)
  GUI.MenuId = SCUI.name_to_id.node_list
  if CanSave(Profile.GetPrimaryPad(), true) == false then
    table.remove({
      {
        value = 0,
        text = UIText.RBU_PHOTO_LOCAL_PHOTOS,
        icon_name = "Local_Photos",
        help_text = UIText.SP_PHOTO_LOCAL_PHOTOS_HELP
      },
      {
        value = 1,
        text = UIText.RBU_PHOTO_MY_ONLINE_PHOTOS,
        icon_name = "Online_Photos",
        help_text = UIText.SP_PHOTO_ONLINE_PHOTOS_HELP
      },
      {
        value = 4,
        text = UIText.RBU_PHOTO_SEARCH,
        icon_name = "Search_Online",
        help_text = UIText.SP_PHOTO_SEARCH_ONLINE_PHOTOS_HELP
      }
    }, 1)
  end
  for _FORV_4_, _FORV_5_ in ipairs({
    {
      value = 0,
      text = UIText.RBU_PHOTO_LOCAL_PHOTOS,
      icon_name = "Local_Photos",
      help_text = UIText.SP_PHOTO_LOCAL_PHOTOS_HELP
    },
    {
      value = 1,
      text = UIText.RBU_PHOTO_MY_ONLINE_PHOTOS,
      icon_name = "Online_Photos",
      help_text = UIText.SP_PHOTO_ONLINE_PHOTOS_HELP
    },
    {
      value = 4,
      text = UIText.RBU_PHOTO_SEARCH,
      icon_name = "Search_Online",
      help_text = UIText.SP_PHOTO_SEARCH_ONLINE_PHOTOS_HELP
    }
  }) do
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\Photos.lua", "_node"), "_icon"), _FORV_5_.icon_name)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\Photos.lua", "_node"), "_text"), _FORV_5_.text)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("Photos\\Photos.lua", "_node"), "_help_text"), _FORV_5_.help_text)
    UIButtons.AddListItem(GUI.MenuId, UIButtons.CloneXtGadgetByName("Photos\\Photos.lua", "_node"), _FORV_5_.value)
  end
  SetupScreenTitle(UIText.RBU_PHOTOS, SCUI.name_to_id.screen, "photo")
end
function PostInit()
  UIButtons.TimeLineActive("Hide_Carousel", true)
  GUI.bottom_text_id = SetupBottomHelpBar(UIText.HLP_PHOTO, SCUI.name_to_id.screen)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if GUI.finished == true then
    return
  end
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
  mouse_overide = false
  if _ARG_0_ == UIEnums.Message.MouseClickInBox and _ARG_3_ == UIScreen.Context() then
    UIButtons.SetCurrentItemByID(GUI.MenuId, (UIButtons.GetParent((UIButtons.GetParent(_ARG_2_)))))
    mouse_overide = true
  end
  if _ARG_0_ == UIEnums.Message.MenuBack then
    GUI.unhide_carousel = true
  elseif _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true or mouse_overide == true or getMouseButton(_ARG_0_, 0, _ARG_1_, _ARG_3_) == UIEnums.Message.ButtonA then
    PlaySfxNext()
    GUI.unhide_carousel = false
    GUIBank.photo_viewing_from = -1
    if UIButtons.GetSelection(GUI.MenuId) == 0 then
      StartAsyncLoadPhotos()
    elseif UIButtons.GetSelection(GUI.MenuId) == 1 then
      if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
        SetupCustomPopup(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
      elseif LSP.IsConnected() == false then
        SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
      else
        UIGlobals.PhotoDoMyLIst = true
        GoScreen("Photos\\MyOnlinePhotos.lua")
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == 2 then
      if LSP.IsConnected() == false then
        SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
      else
        GoScreen("Photos\\Top20VotedPhotos.lua")
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == 3 then
      if LSP.IsConnected() == false then
        SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
      else
        GoScreen("Photos\\Top20DownloadedPhotos.lua")
      end
    elseif UIButtons.GetSelection(GUI.MenuId) == 4 then
      if Profile.PadProfileOnline(Profile.GetPrimaryPad()) == false then
        SetupCustomPopup(UIEnums.CustomPopups.MultiplayerOnlineConnectionLost)
      elseif LSP.IsConnected() == false then
        SetupCustomPopup(UIEnums.CustomPopups.ContentServerGeneralError)
      else
        GoScreen("Photos\\PhotoSearchParams.lua")
      end
    end
  end
end
function FrameUpdate(_ARG_0_)
end
function Render()
end
function EnterEnd()
  if GUI.unhide_carousel == true then
    UIButtons.TimeLineActive("Hide_Carousel", false)
  end
  RestoreInfoLine()
end
function EndLoop(_ARG_0_)
end
function End()
end
