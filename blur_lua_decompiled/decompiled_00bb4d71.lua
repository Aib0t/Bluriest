function IsSplitScreen()
  return Amax.GetGameMode() == UIEnums.GameMode.SplitScreen and Amax.IsGameModeSplitScreen() == true
end
function AreAllSplitScreenHumanPlayersWrecked()
  return (Amax.AreAllSplitScreenHumanPlayersWrecked())
end
function AreAllSplitScreenHumanPlayersEliminated()
  return (Amax.AreAllSplitScreenHumanPlayersEliminated())
end
function Splitscreen_GetSortedScores(_ARG_0_)
  if #_ARG_0_ < #UIGlobals.Splitscreen.players then
    print("we don't have enough scores for the players - wtf - should never happen!")
    return {
      [_FORV_5_] = {
        player_index = _FORV_5_,
        score = _ARG_0_[_FORV_5_].score,
        pos = _ARG_0_[_FORV_5_].pos
      }
    }
  end
  for _FORV_5_, _FORV_6_ in ipairs(UIGlobals.Splitscreen.players) do
  end
  table.sort({
    [_FORV_5_] = {
      player_index = _FORV_5_,
      score = _ARG_0_[_FORV_5_].score,
      pos = _ARG_0_[_FORV_5_].pos
    }
  }, function(_ARG_0_, _ARG_1_)
    if _ARG_0_.score == _ARG_1_.score then
      return _ARG_0_.player_index < _ARG_1_.player_index
    else
      return _ARG_0_.score > _ARG_1_.score
    end
  end)
  return {
    [_FORV_5_] = {
      player_index = _FORV_5_,
      score = _ARG_0_[_FORV_5_].score,
      pos = _ARG_0_[_FORV_5_].pos
    }
  }
end
function Splitscreen_Clear()
  UIGlobals.Splitscreen.primary_pad = -1
  UIGlobals.Splitscreen.players = {}
  UIGlobals.Splitscreen.pad_to_player = {}
  for _FORV_3_ = 0, 3 do
    if UIGlobals.ProfileState[_FORV_3_] == UIEnums.Profile.GamerProfile and _FORV_3_ ~= UIGlobals.splitscreen_primary_pad_original then
      UIGlobals.ProfileState[_FORV_3_] = UIEnums.Profile.PreLoad
    end
  end
end
function Splitscreen_ClearMessages()
  UIGlobals.SplitscreenMessages = {}
  for _FORV_3_, _FORV_4_ in ipairs(UIGlobals.Splitscreen.players) do
    UIGlobals.SplitscreenMessages[#UIGlobals.SplitscreenMessages + 1] = {
      finished = false,
      finished_position = -1,
      finished_timer = 0,
      wrecked = false,
      wrecked_timer = 0
    }
  end
end
function Splitscreen_GetDummyId(_ARG_0_)
  if #UIGlobals.Splitscreen.players == 2 then
    if _ARG_0_ == 1 then
    else
    end
  elseif #UIGlobals.Splitscreen.players == 3 then
    if _ARG_0_ == 1 then
    elseif _ARG_0_ == 2 then
    else
    end
  end
  if SCUI.name_to_id.dummy_4 == nil then
  end
  return SCUI.name_to_id["dummy_" .. _ARG_0_]
end
function Splitscreen_GetDummyName(_ARG_0_)
  if #UIGlobals.Splitscreen.players == 2 then
    if _ARG_0_ == 1 then
      return "top"
    else
      return "bottom"
    end
  elseif #UIGlobals.Splitscreen.players == 3 then
    if _ARG_0_ == 1 then
      return "top"
    elseif _ARG_0_ == 2 then
      return "3"
    else
      return "4"
    end
  end
  return "" .. _ARG_0_
end
function Splitscreen_SetFrontendSplits()
  if #UIGlobals.Splitscreen.players == 2 then
    UIButtons.SetActive(SCUI.name_to_id.split_x_top, false)
    UIButtons.SetActive(SCUI.name_to_id.split_x_bottom, false)
  elseif #UIGlobals.Splitscreen.players == 3 then
    UIButtons.SetActive(SCUI.name_to_id.split_x_top, false)
  end
end
function GetScreenBounds(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ == nil then
    _ARG_2_ = true
  end
  if _ARG_2_ == false then
  end
  if _ARG_2_ == false then
  end
  if _ARG_0_ == 2 then
    if _ARG_1_ == 1 then
    else
    end
  elseif _ARG_0_ == 3 then
    if _ARG_1_ == 1 then
    elseif _ARG_1_ == 2 then
    else
    end
  elseif _ARG_1_ == 3 and _ARG_0_ == 4 then
    if _ARG_1_ == 1 then
    elseif _ARG_1_ == 2 then
    elseif _ARG_1_ == 3 then
    elseif _ARG_1_ == 4 then
    end
  end
  return 320 + 0, 320 - 0, 240 + 0, 240 - 0
end
function Splitscreen_AddSplits()
  if Amax.GetNumViewports() == 1 then
    return
  end
  if Amax.GetNumViewports() == 3 or Amax.GetNumViewports() == 4 or Amax.GetNumViewports() == 2 then
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.pos.x = 320
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.pos.y = 240
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.size.x = Screen.width + 2
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.size.y = 8
    UIButtons.AddButton({
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    })
  end
  if Amax.GetNumViewports() == 4 then
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.pos.x = 320
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.pos.y = 240
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.size.x = 4
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.size.y = Screen.height + 2
    UIButtons.AddButton({
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    })
  end
  if Amax.GetNumViewports() == 3 then
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.size.x = 4
    {
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    }.size.y = Screen.height / 2 + 2
    UIButtons.AddButton({
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.MiddleCentre,
      justify = UIEnums.Justify.TopCentre
    })
    {
      name = "black_square",
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.BottomRight,
      justify = UIEnums.Justify.BottomLeft
    }.pos.x = GetScreenBounds(Amax.GetNumViewports(), 1, false)
    {
      name = "black_square",
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.BottomRight,
      justify = UIEnums.Justify.BottomLeft
    }.pos.y = 240
    {
      name = "black_square",
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.BottomRight,
      justify = UIEnums.Justify.BottomLeft
    }.size.x = GetScreenBounds(Amax.GetNumViewports(), 1, false) - Screen.left + 2
    {
      name = "black_square",
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.BottomRight,
      justify = UIEnums.Justify.BottomLeft
    }.size.y = Screen.height / 2 + 2
    UIButtons.AddButton({
      name = "black_square",
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.BottomRight,
      justify = UIEnums.Justify.BottomLeft
    })
    {
      name = "black_square",
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.BottomRight,
      justify = UIEnums.Justify.BottomLeft
    }.pos.x = GetScreenBounds(Amax.GetNumViewports(), 1, false)
    UIButtons.AddButton({
      name = "black_square",
      panel = 4,
      type = UIEnums.ButtonTypes.GRAPHIC,
      pos = {x = -1, y = -1},
      size = {x = -1, y = -1},
      scale = {x = 1, y = 1},
      justify = UIEnums.Justify.TopLeft,
      colour_style = "!255 0 0 0",
      textures = {
        {
          name = UITexture.Textures.null,
          pos = {u = 0, v = 0},
          size = {u = 0, v = 0}
        }
      },
      justify = UIEnums.Justify.BottomRight,
      justify = UIEnums.Justify.BottomLeft
    })
  end
end
