GUI = {finished = false}
function Ps3Installer_ChangePicture(_ARG_0_)
  print(Ps3Installer_Images[Ps3Installer_ImageIndex])
  UIButtons.ChangeTexture({
    filename = Ps3Installer_Images[Ps3Installer_ImageIndex]
  }, 0, _ARG_0_)
  Ps3Installer_ImageIndex = Ps3Installer_ImageIndex + 1
  if Ps3Installer_ImageIndex == #Ps3Installer_Images then
    Ps3Installer_ImageIndex = 1
  end
end
function Init()
  AddSCUI_Elements()
  Ps3Installer_ImageIndex = 1
  Ps3Installer_Images = {
    "install_00",
    "install_01",
    "install_02",
    "install_03",
    "install_04",
    "install_05",
    "install_06",
    "install_07",
    "install_08",
    "install_09",
    "install_10",
    "install_11",
    "install_12",
    "install_13"
  }
  StopFrontendMusic()
  UIScreen.SetScreenTimers(0.3, 0.3)
  UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUpDown")
  GUI.progress_bar_bra_id = UIButtons.CloneXtGadgetByName("SCUIBank", "Bra_Installer")
  GUI.progress_bar_id = UIButtons.FindChildByName(GUI.progress_bar_bra_id, "Gfx_ProgressBar")
  UIButtons.ChangeScale(UIButtons.FindChildByName(GUI.progress_bar_bra_id, "MessageBarMid"), 1, UIButtons.GetStaticTextHeight((UIButtons.FindChildByName(GUI.progress_bar_bra_id, "SavingContentMessage"))) / UIButtons.GetSize((UIButtons.FindChildByName(GUI.progress_bar_bra_id, "SavingContentMessage"))))
  UIButtons.ChangeScale(GUI.progress_bar_id, 0, 1)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_) == true then
    return
  end
end
function FrameUpdate(_ARG_0_)
  PS3_CheckForInstallingMessage()
  UIButtons.ChangeScale(GUI.progress_bar_id, Amax.Ps3InstallerProgress(), 1)
  if UIGlobals.Ps3Installing ~= true then
    UIButtons.SetActive(GUI.progress_bar_id, false, true)
    Amax.InstallTrophies()
    Amax.SendMessage(UIEnums.GameFlowMessage.LoadUIScene)
    GoScreen("Intro\\Legal.lua")
  end
end
function Render()
end
function EndLoop(_ARG_0_)
end
function End()
  Ps3Installer_ImageIndex = nil
  Ps3Installer_Images = nil
  Ps3Installer_ChangePicture = nil
end
