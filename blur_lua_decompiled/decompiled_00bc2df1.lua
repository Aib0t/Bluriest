GUI = {finished = false}
function Init()
  AddSCUI_Elements()
end
function PostInit()
  UIButtons.SetActive(SCUI.name_to_id.avatar_parent, false, true)
end
function StartLoop(_ARG_0_)
end
function MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_) == true then
    return
  end
  if GUI.finished == true then
    return
  end
  if _ARG_0_ == UIEnums.GameMessage.Dialogue then
    if _ARG_1_ == nil or _ARG_2_ == nil then
      return
    end
    AvatarTexture(SCUI.name_to_id.avatar_image, _ARG_1_, true)
    Amax.ChangeText(SCUI.name_to_id.avatar_text, _ARG_2_)
    UIButtons.TimeLineActive("avatar_dialogue", true, 0)
  end
end
function FrameUpdate(_ARG_0_)
end
function EndLoop(_ARG_0_)
end
function End()
end
