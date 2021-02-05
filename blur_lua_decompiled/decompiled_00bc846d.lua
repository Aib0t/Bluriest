HUD = {
  ViewportId = {
    [1] = -1,
    [2] = -1,
    [3] = -1,
    [4] = -1
  },
  ViewportId3d = {
    [1] = -1,
    [2] = -1,
    [3] = -1,
    [4] = -1
  },
  GetScreenScale = function()
    if GUI.num_players == 2 then
    else
    end
    return 0.7
  end,
  SetupPlayerViewports = function()
    for _FORV_7_ = 1, GUI.num_players do
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }.pos.x = GetScreenBounds(GUI.num_players, _FORV_7_) + (GetScreenBounds(GUI.num_players, _FORV_7_) - GetScreenBounds(GUI.num_players, _FORV_7_)) / 2
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }.pos.y = GetScreenBounds(GUI.num_players, _FORV_7_) + (GetScreenBounds(GUI.num_players, _FORV_7_) - GetScreenBounds(GUI.num_players, _FORV_7_)) / 2
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }.size.x = GetScreenBounds(GUI.num_players, _FORV_7_) - GetScreenBounds(GUI.num_players, _FORV_7_)
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }.size.y = GetScreenBounds(GUI.num_players, _FORV_7_) - GetScreenBounds(GUI.num_players, _FORV_7_)
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }.pos.x = (GetScreenBounds(GUI.num_players, _FORV_7_) + (GetScreenBounds(GUI.num_players, _FORV_7_) - GetScreenBounds(GUI.num_players, _FORV_7_)) / 2 - 320) / 10
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }.pos.y = -(GetScreenBounds(GUI.num_players, _FORV_7_) + (GetScreenBounds(GUI.num_players, _FORV_7_) - GetScreenBounds(GUI.num_players, _FORV_7_)) / 2 - 240) / 10
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }.size.x = (GetScreenBounds(GUI.num_players, _FORV_7_) - GetScreenBounds(GUI.num_players, _FORV_7_)) / 10
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }.size.y = (GetScreenBounds(GUI.num_players, _FORV_7_) - GetScreenBounds(GUI.num_players, _FORV_7_)) / 10
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }.size.x = {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }.size.x * Select(IsSplitScreen(), 1, 1)
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }.size.y = {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }.size.y * 0.875
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }.size.x = {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }.size.x * Select(IsSplitScreen(), 1, 1)
      {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }.size.y = {
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }.size.y * 0.875
      (function(_ARG_0_, _ARG_1_)
        _ARG_0_.size.x = _ARG_0_.size.x * (1 / _ARG_1_)
        _ARG_0_.size.y = _ARG_0_.size.y * (1 / _ARG_1_)
        _ARG_0_.scale.x = _ARG_1_
        _ARG_0_.scale.y = _ARG_1_
      end)({
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      }, (HUD.GetScreenScale()));
      (function(_ARG_0_, _ARG_1_)
        _ARG_0_.size.x = _ARG_0_.size.x * (1 / _ARG_1_)
        _ARG_0_.size.y = _ARG_0_.size.y * (1 / _ARG_1_)
        _ARG_0_.scale.x = _ARG_1_
        _ARG_0_.scale.y = _ARG_1_
      end)({
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      }, (HUD.GetScreenScale()))
      HUD.ViewportId[_FORV_7_] = UIButtons.AddButton({
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!32 128 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        justify = UIEnums.Justify.MiddleCentre
      })
      HUD.ViewportId3d[_FORV_7_] = UIButtons.AddButton({
        type = UIEnums.ButtonTypes.DUMMY,
        pos = {x = -1, y = -1},
        size = {x = -1, y = -1},
        scale = {x = 1, y = 1},
        justify = UIEnums.Justify.TopLeft,
        colour_style = "!64 255 128 128",
        textures = {
          {
            name = UITexture.Textures.null,
            pos = {u = 0, v = 0},
            size = {u = 0, v = 0}
          }
        },
        panel = 7,
        justify = UIEnums.Justify.MiddleCentre
      })
    end
  end
}
