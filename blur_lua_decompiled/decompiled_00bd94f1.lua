GUI = {
  finished = false,
  Pumping = false,
  TaskType = "Nothing"
}
function Init()
  AddSCUI_Elements()
  NetServices.Disconnect()
  NetServices.Connect(true)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.Message.MenuBack and _ARG_2_ == true then
    GoScreen("Intro\\StartScreen.lua")
  end
  if net_RouterAvailable(true) then
    if _ARG_0_ == UIEnums.Message.MenuNext and _ARG_2_ == true then
      GUI.TaskType = "Uploading"
      LSP.SetFileName("Amax1.bin")
      LSP.SetTags(3, 1, 2, 3)
      LSP.SetUserIndex(0)
      GUI.Pumping = LSP.UploadData()
    elseif _ARG_0_ == UIEnums.Message.ButtonX and _ARG_2_ == true then
      GUI.TaskType = "Downloading"
      LSP.SetFileName("Amax.bin")
      LSP.SetUserIndex(0)
      GUI.Pumping = LSP.DownloadData()
    elseif _ARG_0_ == UIEnums.Message.ButtonY and _ARG_2_ == true then
      GUI.TaskType = "Searching"
      LSP.SetUserIndex(0)
      GUI.Pumping = LSP.ListFileByOwner(0, false)
      LSP.SetTags(3, 1, 2, 3)
      GUI.Pumping = LSP.SearchByTags()
    end
  end
end
function FrameUpdate(_ARG_0_)
  if GUI.Pumping == true then
    GUI.Pumping = LSP.PumpCurrentTask()
    if GUI.Pumping == false and LSP.PumpCurrentTask() == false then
      if GUI.TaskType == "Downloading" then
        LSP.Debug_PrintDownloadData()
      elseif GUI.TaskType == "Searching" then
        show_table(LSP.GetSearchResults(), true)
      end
    end
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
end
