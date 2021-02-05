GUITable = {}
GUIBank = {
  major_avatar_usize = 1 / UIGlobals.NumMajorAvatarIcons,
  major_avatar_marker = 100,
  major_avatar_image = {
    filename = "member_icons",
    pos = {u = 0, v = 0},
    size = {
      u = 1 / UIGlobals.NumMajorAvatarIcons,
      v = 1
    }
  },
  minor_avatar_usize = 1 / UIGlobals.NumMinorAvatarIcons,
  minor_avatar_image = {
    filename = "npc_avatars",
    pos = {u = 0, v = 0},
    size = {
      u = 1 / UIGlobals.NumMinorAvatarIcons,
      v = 1
    }
  },
  blur_avatar_marker = 900,
  blur_avatar_image = {
    filename = "raceworld_logo",
    pos = {u = 0, v = 0},
    size = {u = 1, v = 1}
  },
  CurrentContext = UIEnums.Context.Subscreen0,
  MessageQueue = {},
  MessageStart = 1,
  MessageEnd = 1,
  SelectedMessageIndex = -1,
  loading = false,
  load_timer = 0,
  load_next_text_change_at = 0,
  load_text_index = 0,
  load_start_delay = 2,
  load_start_delay_timer = 0,
  load_message_sent = false,
  load_finished = false,
  load_end_delay = 2,
  load_end_delay_timer = 0,
  end_effects_started = false,
  load_added_objectives = false,
  stay_on_current_screen = false,
  ready_sent = false,
  photo_viewing_download = false,
  PhotoViewFrom = {
    Top20Voted = 0,
    Top20Download = 1,
    Search = 2,
    MyOnline = 3
  },
  photo_viewing_from = -1,
  EventFilters = {
    [UIEnums.MpEventFilter.QuickRace] = {
      UIText.MP_QUICK_RACE,
      UIText.MP_QUICK_RACE_DESC,
      "quick_race",
      "common_icons"
    },
    [UIEnums.MpEventFilter.UserCreated] = {
      UIText.MP_MY_EVENTS,
      UIText.MP_MY_EVENTS_DESC,
      "My_Groups",
      "fe_icons"
    },
    [UIEnums.MpEventFilter.Favourties] = {
      UIText.MP_FAVOURITE_EVENTS,
      UIText.MP_FAVOURITE_EVENTS_DESC,
      "favourite_groups",
      "fe_icons"
    },
    [UIEnums.MpEventFilter.RecentlyPlayed] = {
      UIText.MP_RECENTLY_PLAYED,
      UIText.MP_RECENTLY_PLAYED_DESC,
      "recent_Groups",
      "fe_icons"
    },
    [UIEnums.MpEventFilter.HighestRated] = {
      UIText.MP_HIGHEST_RATED,
      UIText.MP_HIGHEST_RATED_DESC,
      "rated_groups",
      "fe_icons"
    },
    [UIEnums.MpEventFilter.Newest] = {
      UIText.MP_NEWEST_EVENTS,
      UIText.MP_NEWEST_EVENTS_DESC,
      "new_groups",
      "fe_icons"
    }
  },
  IconOverides = {
    [UIEnums.IconOverideType.Message] = {"fe_icons", "message"},
    [UIEnums.IconOverideType.Audio] = {
      "common_icons",
      "mic"
    },
    [UIEnums.IconOverideType.Photo] = {
      "common_icons",
      "photo"
    },
    [UIEnums.IconOverideType.Video] = {
      "common_icons",
      "video"
    },
    [UIEnums.IconOverideType.PriorityPhoto] = {
      "common_icons",
      "photo"
    },
    [UIEnums.IconOverideType.PriorityVideo] = {
      "common_icons",
      "video"
    },
    [UIEnums.IconOverideType.LinkToGarage] = {
      "fe_icons",
      "garage_link"
    },
    [UIEnums.IconOverideType.LinkToOptions] = {
      "fe_icons",
      "options_link"
    },
    [UIEnums.IconOverideType.LinkToShop] = {
      "fe_icons",
      "upgrades_link"
    },
    [UIEnums.IconOverideType.GiftCar] = {
      "common_icons",
      "car"
    },
    [UIEnums.IconOverideType.GiftCash] = {"fe_icons", "rewards"},
    [UIEnums.IconOverideType.GiftFans] = {
      "common_icons",
      "fan"
    },
    [UIEnums.IconOverideType.Event] = {
      "common_icons",
      "events"
    },
    [UIEnums.IconOverideType.CarChallenge] = {
      "fe_icons",
      "car_challenges"
    }
  }
}
UISystem.LoadLuaScript("Screens\\NetworkBank.lua")
UISystem.LoadLuaScript("Screens\\SpGUIBank.lua")
UISystem.LoadLuaScript("Screens\\SsGUIBank.lua")
UISystem.LoadLuaScript("Screens\\MpGUIBank.lua")
UISystem.LoadLuaScript("Screens\\InfoLines.lua")
function ShowGlobals()
  for _FORV_4_, _FORV_5_ in pairs(_G) do
    if type(_FORV_5_) ~= "function" then
      print(_FORV_4_ .. " = ", _FORV_5_)
    else
    end
  end
  print("## function count", 0 + 1)
end
function SetupFadeToBlack(_ARG_0_, _ARG_1_)
  if _ARG_0_ == true and _ARG_1_ == true then
    return UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUpDown")
  elseif _ARG_0_ == true then
    return UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeUp")
  elseif _ARG_1_ == true then
    return UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_FadeDown")
  end
end
function ClearMultiplayerGlobals()
  UIGlobals.Multiplayer.PublicGame = true
  UIGlobals.Multiplayer.SelectPlayerJoinRef = -1
  UIGlobals.Multiplayer.ChallengePackViewing = -1
  UIGlobals.Multiplayer.NotEnoughPlayersKick = false
  UIGlobals.Multiplayer.InitialLobby = false
  UIGlobals.Multiplayer.LobbyState = UIEnums.MpLobbyState.FindingPlayers
  UIGlobals.Multiplayer.LobbyTimer = 0
  UIGlobals.Multiplayer.LobbyUpdateLoadout = false
  UIGlobals.Multiplayer.LobbyUpdateCar = false
  UIGlobals.Multiplayer.VotingFinished = false
  UIGlobals.Multiplayer.CountdownStarted = false
  UIGlobals.Multiplayer.DisconnectRaceAsPartyHost = false
  UIGlobals.Multiplayer.ViewingResults = false
  UIGlobals.Multiplayer.RaceFinished = false
  UIGlobals.Multiplayer.PrimaryVehicleFinished = false
end
function RemapMovieTracks()
  if UIGlobals.CurrentLanguage == UIEnums.Language.French then
  elseif UIGlobals.CurrentLanguage == UIEnums.Language.German then
  elseif UIGlobals.CurrentLanguage == UIEnums.Language.Italian then
  elseif UIGlobals.CurrentLanguage == UIEnums.Language.Spanish then
  elseif UIGlobals.CurrentLanguage == UIEnums.Language.Japanese then
  elseif UIGlobals.CurrentLanguage == UIEnums.Language.Russian then
  elseif UIGlobals.CurrentLanguage == UIEnums.Language.Polish then
  end
  UISystem.RemapMovieTracks(0, 0, 1, 2, 3, 11, 19)
end
function UpdateRouteShapes(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if IsNumber(SCUI.name_to_id[_ARG_4_]) == true then
    UIButtons.SetActive(SCUI.name_to_id[_ARG_4_], false)
  end
  for _FORV_9_ = 1, _ARG_1_ do
    if IsNumber(SCUI.name_to_id[_ARG_0_ .. _FORV_9_]) == true then
      UIButtons.SetActive(SCUI.name_to_id[_ARG_0_ .. _FORV_9_], false)
    end
  end
  if IsNumber(_ARG_2_) == false or IsNumber(_ARG_3_) == false then
    print("id wrong", _ARG_2_, _ARG_3_)
    return
  end
  for _FORV_11_, _FORV_12_ in ipairs((GameData.GetCities())) do
    if _FORV_12_.id == _ARG_2_ then
      break
    end
  end
  if IsTable(_FORV_12_) == false then
    print("City not found")
    return
  end
  if IsTable((GameData.GetRoutes(_ARG_2_))) == false then
    print("route wrong")
    return
  end
  for _FORV_13_, _FORV_14_ in ipairs((GameData.GetRoutes(_ARG_2_))) do
    if _FORV_14_.id == _ARG_3_ then
      break
    end
  end
  if IsTable(_FORV_14_) == false then
    print("Route not found")
    return
  end
  if IsNumber(SCUI.name_to_id.Thumbnail) == true then
    UIButtons.ChangeTexture({
      filename = _FORV_14_.debug_tag
    }, 0, SCUI.name_to_id.Thumbnail)
    GUI.route_texture_name = _FORV_14_.debug_tag
  end
  if IsNumber(SCUI.name_to_id.Gfx_LoadingBG) == true then
    UIButtons.ChangeTexture({
      filename = _FORV_14_.debug_tag
    }, 0, SCUI.name_to_id.Gfx_LoadingBG)
    GUI.route_texture_name = _FORV_14_.debug_tag
  end
  for _FORV_13_ = 1, _ARG_1_ do
    if IsNumber(SCUI.name_to_id[_ARG_0_ .. _FORV_13_]) == true then
      if UIShape.ChangeSceneName(SCUI.name_to_id[_ARG_0_ .. _FORV_13_], _FORV_12_.debug_tag .. "_ui") == false then
        return
      end
      if UIShape.ChangeObjectName(SCUI.name_to_id[_ARG_0_ .. _FORV_13_], _FORV_14_.debug_tag .. "_ui") == false and UIShape.ChangeObjectName(SCUI.name_to_id[_ARG_0_ .. _FORV_13_], _FORV_14_.debug_tag) == false then
        return
      end
      UIButtons.SetActive(SCUI.name_to_id[_ARG_0_ .. _FORV_13_], true)
    end
  end
  if IsNumber(SCUI.name_to_id[_ARG_4_]) == true and UIShape.ChangeSceneName(SCUI.name_to_id[_ARG_4_], _FORV_12_.debug_tag .. "_ui") == true and UIShape.ChangeObjectName(SCUI.name_to_id[_ARG_4_], _FORV_14_.debug_tag .. "_start_line") == true then
    UIButtons.SetActive(SCUI.name_to_id[_ARG_4_], true)
  end
  UIButtons.TimeLineActive("show_map", true, 0, true)
end
function HandleCommand(_ARG_0_)
  if IsTable(ContextTable[UIScreen.Context()]) == false then
    return
  end
  GUI = ContextTable[UIScreen.Context()].GUI
  SCUI = ContextTable[UIScreen.Context()].SCUI
  ProtectedLoadRunString(_ARG_0_)
  SCUI, GUI = SCUI, GUI
end
function GetScreenOtions()
  if UIGlobals.ScreenOptions[UIScreen.GetCurrentScreen(-1)] == nil then
    UIGlobals.ScreenOptions[UIScreen.GetCurrentScreen(-1)] = {}
  end
  return UIGlobals.ScreenOptions[UIScreen.GetCurrentScreen(-1)]
end
function RestoreScreenSelection(_ARG_0_, _ARG_1_, _ARG_2_)
  if IsTable((GetScreenOtions())) == false or IsTable(_ARG_0_) == false or IsString(_ARG_1_) == false then
    print("Type error")
    return
  end
  if IsNumber(_ARG_0_[_ARG_1_]) == false then
    print("Gadget doesn't exist in GUI")
    return
  end
  if IsNumber(GetScreenOtions()[_ARG_1_]) == false then
    return
  end
  if _ARG_2_ == true then
    UIButtons.SetSelectionByIndex(_ARG_0_[_ARG_1_], GetScreenOtions()[_ARG_1_])
  else
    UIButtons.SetSelection(_ARG_0_[_ARG_1_], GetScreenOtions()[_ARG_1_])
  end
end
function StoreScreenSelection(_ARG_0_, _ARG_1_, _ARG_2_)
  if IsTable((GetScreenOtions())) == false or IsTable(_ARG_0_) == false or IsString(_ARG_1_) == false then
    print("Type error")
    return
  end
  if IsNumber(_ARG_0_[_ARG_1_]) == false then
    print("Gadget doesn't exist in GUI")
    return
  end
  if _ARG_2_ == true then
    GetScreenOtions()[_ARG_1_] = UIButtons.GetSelectionIndex(_ARG_0_[_ARG_1_])
  else
    GetScreenOtions()[_ARG_1_] = UIButtons.GetSelection(_ARG_0_[_ARG_1_])
  end
end
function Select(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_ == nil and _ARG_3_ ~= nil then
    return _ARG_3_
  end
  if _ARG_0_ == true then
    return _ARG_1_
  end
  return _ARG_2_
end
function Clamp(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_ < _ARG_1_ then
    _ARG_0_ = _ARG_1_
  elseif _ARG_2_ < _ARG_0_ then
    _ARG_0_ = _ARG_2_
  end
  return _ARG_0_
end
function SmoothStep(_ARG_0_)
  return 3 * (_ARG_0_ * _ARG_0_) - 2 * (_ARG_0_ * _ARG_0_ * _ARG_0_)
end
function ReloadCommandScript()
  UISystem.LoadLuaScript("Screens\\Commands.lua")
end
function PlaySfxBack()
  UISystem.PlaySound(UIEnums.SoundEffect.Backward)
end
function PlaySfxNext()
  UISystem.PlaySound(UIEnums.SoundEffect.Forward)
end
function PlaySfxGraphicBack()
  UISystem.PlaySound(UIEnums.SoundEffect.GraphicBackward)
end
function PlaySfxGraphicNext()
  UISystem.PlaySound(UIEnums.SoundEffect.GraphicForward)
end
function PlaySfxToggle()
  UISystem.PlaySound(UIEnums.SoundEffect.Toggle)
end
function PlaySfxError()
  UISystem.PlaySound(UIEnums.SoundEffect.Error)
end
function PlaySfxUp()
  UISystem.PlaySound(UIEnums.SoundEffect.Up)
end
function PlaySfxDown()
  UISystem.PlaySound(UIEnums.SoundEffect.Down)
end
function PlaySfxLeft()
  UISystem.PlaySound(UIEnums.SoundEffect.Left)
end
function PlaySfxRight()
  UISystem.PlaySound(UIEnums.SoundEffect.Right)
end
function CanSave(_ARG_0_, _ARG_1_)
  if UIScreen.IsContextActive(UIEnums.Context.LoadSave) == true then
    print("CanSave() - already saving - bailing")
    return false
  end
  if _ARG_1_ ~= true and UIGlobals.DoNotSave[_ARG_0_] == true then
    return false
  end
  if UIGlobals.ProfileState[_ARG_0_] ~= UIEnums.Profile.GamerProfile then
    return false
  end
  if IsSplitScreen() == true and _ARG_0_ ~= UIGlobals.splitscreen_primary_pad_original then
    return false
  end
  UIGlobals.ProfileSaveIndex = _ARG_0_
  return true
end
function AddListNode(_ARG_0_, _ARG_1_)
  if _ARG_0_ == nil then
    _ARG_0_ = false
  end
  if _ARG_1_ == nil then
    _ARG_1_ = -1
  end
  return UIButtons.AddButton({
    layer = UIEnums.Layer.LAYER_1,
    type = UIEnums.ButtonTypes.NODE,
    pos = {x = 0, y = 0},
    size = {x = 1, y = 1},
    justify = UIEnums.Justify.TopLeft,
    locked = _ARG_0_,
    value = _ARG_1_
  })
end
function AddListItem(_ARG_0_, _ARG_1_)
  UIButtons.SetParent(_ARG_1_, _ARG_0_, UIEnums.Justify.TopLeft)
end
function ScreenInit()
  for _FORV_4_ = 0, 3 do
    {
      layer = UIEnums.Layer.TOP,
      type = UIEnums.ButtonTypes.TEXT,
      pos = {
        x = GUIBank.ScreenLeftEdge,
        y = GUIBank.ScreenTopEdge
      },
      size = {x = 0, y = 20},
      justify = UIEnums.Justify.TopLeft,
      text_string = "",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_NAME",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_STATUS"
    }.pos.y = {
      layer = UIEnums.Layer.TOP,
      type = UIEnums.ButtonTypes.TEXT,
      pos = {
        x = GUIBank.ScreenLeftEdge,
        y = GUIBank.ScreenTopEdge
      },
      size = {x = 0, y = 20},
      justify = UIEnums.Justify.TopLeft,
      text_string = "",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_NAME",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_STATUS"
    }.pos.y + {
      layer = UIEnums.Layer.TOP,
      type = UIEnums.ButtonTypes.TEXT,
      pos = {
        x = GUIBank.ScreenLeftEdge,
        y = GUIBank.ScreenTopEdge
      },
      size = {x = 0, y = 20},
      justify = UIEnums.Justify.TopLeft,
      text_string = "",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_NAME",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_STATUS"
    }.size.y
  end
  {
    layer = UIEnums.Layer.TOP,
    type = UIEnums.ButtonTypes.TEXT,
    pos = {
      x = GUIBank.ScreenLeftEdge,
      y = GUIBank.ScreenTopEdge
    },
    size = {x = 0, y = 20},
    justify = UIEnums.Justify.TopLeft,
    text_string = "",
    text_string = "PROFILE_PAD" .. _FORV_4_ .. "_NAME",
    text_string = "PROFILE_PAD" .. _FORV_4_ .. "_STATUS"
  }.pos.y = GUIBank.ScreenTopEdge
  {
    layer = UIEnums.Layer.TOP,
    type = UIEnums.ButtonTypes.TEXT,
    pos = {
      x = GUIBank.ScreenLeftEdge,
      y = GUIBank.ScreenTopEdge
    },
    size = {x = 0, y = 20},
    justify = UIEnums.Justify.TopLeft,
    text_string = "",
    text_string = "PROFILE_PAD" .. _FORV_4_ .. "_NAME",
    text_string = "PROFILE_PAD" .. _FORV_4_ .. "_STATUS"
  }.pos.x = GUIBank.ScreenLeftEdge + 150
  for _FORV_4_ = 0, 3 do
    {
      layer = UIEnums.Layer.TOP,
      type = UIEnums.ButtonTypes.TEXT,
      pos = {
        x = GUIBank.ScreenLeftEdge,
        y = GUIBank.ScreenTopEdge
      },
      size = {x = 0, y = 20},
      justify = UIEnums.Justify.TopLeft,
      text_string = "",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_NAME",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_STATUS"
    }.pos.y = {
      layer = UIEnums.Layer.TOP,
      type = UIEnums.ButtonTypes.TEXT,
      pos = {
        x = GUIBank.ScreenLeftEdge,
        y = GUIBank.ScreenTopEdge
      },
      size = {x = 0, y = 20},
      justify = UIEnums.Justify.TopLeft,
      text_string = "",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_NAME",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_STATUS"
    }.pos.y + {
      layer = UIEnums.Layer.TOP,
      type = UIEnums.ButtonTypes.TEXT,
      pos = {
        x = GUIBank.ScreenLeftEdge,
        y = GUIBank.ScreenTopEdge
      },
      size = {x = 0, y = 20},
      justify = UIEnums.Justify.TopLeft,
      text_string = "",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_NAME",
      text_string = "PROFILE_PAD" .. _FORV_4_ .. "_STATUS"
    }.size.y
  end
  _FOR_()
end
function SetupFadedBackground(_ARG_0_)
  if _ARG_0_ == nil then
    _ARG_0_ = UIEnums.Layer.LAYER_1
    print("no layer was specified. Using layer 1")
  end
  UIButtons.AddButton({
    layer = _ARG_0_,
    type = UIEnums.ButtonTypes.GRAPHIC,
    pos = {x = 320, y = 240},
    size = {
      x = SCREEN_WIDTH + 2,
      y = 482
    },
    justify = UIEnums.Justify.MiddleCentre,
    colour_style = "!175 0 0 0",
    textures = {
      {
        name = UITexture.Textures.null,
        pos = {u = 0, v = 0},
        size = {u = 1, v = 1}
      }
    }
  })
end
function IsString(_ARG_0_)
  return type(_ARG_0_) == "string"
end
function IsFunction(_ARG_0_)
  return type(_ARG_0_) == "function"
end
function IsTable(_ARG_0_)
  return type(_ARG_0_) == "table"
end
function IsNumber(_ARG_0_)
  return type(_ARG_0_) == "number"
end
function IsBoolean(_ARG_0_)
  return type(_ARG_0_) == "boolean"
end
function ProtectedLoadRunString(_ARG_0_)
  if loadstring(_ARG_0_) == nil then
    print("ProtectedLoadRunString: ERROR: loadstring() failed", _ARG_0_)
  else
    if pcall((loadstring(_ARG_0_))) == false then
      print("ProtectedLoadRunString: ERROR:", pcall((loadstring(_ARG_0_))))
    end
    return pcall((loadstring(_ARG_0_)))
  end
  return false
end
function SCUI_MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if IsTable(GUI) == true and GUI.finished == true then
    return true
  end
  if IsTable(_ARG_5_) then
  end
  if IsTable(_ARG_5_) == false then
    return false
  end
  if (_ARG_0_ == UIEnums.Message.MenuNext or _ARG_0_ == UIEnums.Message.MenuBack or _ARG_0_ == UIEnums.Message.ButtonX or _ARG_0_ == UIEnums.Message.ButtonY) and _ARG_4_ ~= nil then
    UIGlobals.LastInputDevice = _ARG_4_
  end
  if _ARG_0_ == UIEnums.Message.MenuNext and IsString(_ARG_5_.on_next) then
    return ProtectedLoadRunString(_ARG_5_.on_next)
  elseif _ARG_0_ == UIEnums.Message.MenuBack and IsString(_ARG_5_.on_back) then
    return ProtectedLoadRunString(_ARG_5_.on_back)
  end
  return false
end
function Lerp(_ARG_0_, _ARG_1_, _ARG_2_)
  return _ARG_0_ + (_ARG_1_ - _ARG_0_) * _ARG_2_
end
function SetNil(_ARG_0_)
  if _ARG_0_ == nil then
    return
  end
  if IsTable(_ARG_0_) then
    for _FORV_4_, _FORV_5_ in pairs(_ARG_0_) do
      if IsTable(_ARG_0_[_FORV_4_]) then
        SetNil(_ARG_0_[_FORV_4_])
      end
      _ARG_0_[_FORV_4_] = nil
    end
  end
  _ARG_0_ = nil
end
function CloneTable(_ARG_0_, _ARG_1_)
  if _ARG_1_ == nil then
    _ARG_1_ = {}
  end
  if IsTable(_ARG_0_) then
    for _FORV_5_, _FORV_6_ in pairs(_ARG_0_) do
      if IsTable(_ARG_0_[_FORV_5_]) then
        _ARG_1_[_FORV_5_] = CloneTable(_ARG_0_[_FORV_5_], _ARG_1_[_FORV_5_])
      else
        _ARG_1_[_FORV_5_] = _FORV_6_
      end
    end
  end
  return _ARG_1_
end
function ResolveFontHeight(_ARG_0_)
  if _ARG_0_.type ~= UIEnums.ButtonTypes.TEXT and _ARG_0_.type ~= UIEnums.ButtonTypes.VERTICAL_MENU and _ARG_0_.type ~= UIEnums.ButtonTypes.HORIZONTAL_MENU and _ARG_0_.type ~= UIEnums.ButtonTypes.SPINNER_BUTTON and _ARG_0_.type ~= UIEnums.ButtonTypes.HUD_MESSAGES then
    return
  end
  if _ARG_0_.size.y > -1 then
    return
  end
  if _ARG_0_.size.y * -1 > #UIGlobals.FontSize then
    return
  end
  if math.floor(_ARG_0_.size.y * -1) == #UIGlobals.FontSize then
  else
    _ARG_0_.size.y = Lerp(UIGlobals.FontSize[math.floor(_ARG_0_.size.y * -1)], UIGlobals.FontSize[math.floor(_ARG_0_.size.y * -1) + 1], UIGlobals.FontSize[math.floor(_ARG_0_.size.y * -1)] - math.floor(_ARG_0_.size.y * -1))
  end
  if (_ARG_0_.type == UIEnums.ButtonTypes.VERTICAL_MENU or _ARG_0_.type == UIEnums.ButtonTypes.HORIZONTAL_MENU) and _ARG_0_.size.x == 0 then
    _ARG_0_.size.x = _ARG_0_.size.y
  end
end
function AddSCUI_Elements(_ARG_0_)
  if IsTable(_ARG_0_) then
  end
  if IsTable(_ARG_0_) == false or IsTable(_ARG_0_.elements) == false then
    print("SCUI table fail")
    return
  end
  if IsTable(_ARG_0_.name_to_id) == false then
    _ARG_0_.name_to_id = {}
  end
  if IsTable(_ARG_0_.name_to_index) == false then
    _ARG_0_.name_to_index = {}
  end
  for _FORV_5_, _FORV_6_ in pairs(_ARG_0_.elements) do
    ResolveFontHeight(_FORV_6_)
    if false == true then
      _FORV_6_.ID = UIButtons.AddButton(_FORV_6_)
      _ARG_0_.name_to_id[_FORV_6_.name] = _FORV_6_.ID
    end
    if IsString(_FORV_6_.name) then
      _ARG_0_.name_to_index[_FORV_6_.name] = _FORV_5_
    end
  end
end
function GoLoadingScreen(_ARG_0_)
  if IsString(_ARG_0_) ~= true then
    print("GoLoadingScreen : invalid screen")
    return
  end
  StoreScreen(UIEnums.ScreenStorage.FE_GAME_LOADING, _ARG_0_)
  GoScreen("Loading\\PrepLoading.lua", UIEnums.Context.Main)
end
function GoScreen(_ARG_0_, _ARG_1_)
  if _ARG_0_ == nil then
    return
  end
  if _ARG_1_ == nil then
    _ARG_1_ = UIScreen.Context()
    if _ARG_1_ == 1 then
      _ARG_1_ = 0
    end
  end
  if IsTable(ContextTable[_ARG_1_]) ~= true or UIScreen.IsContextActive(_ARG_1_) == false then
    if _ARG_0_ == "EndScreen" then
      print("Trying to end a screen that's not been started on ctx", _ARG_1_)
    else
      UIScreen.SetNextScreen(_ARG_0_, _ARG_1_)
    end
    return
  end
  if IsTable(ContextTable[_ARG_1_].GUI) == false then
    print("waaah - no local GUI for context", _ARG_1_)
    return
  end
  if ContextTable[_ARG_1_].GUI.finished == nil then
    print("Warning : Using GoScreen() without a 'finished' var in LocalGUI")
  end
  if ContextTable[_ARG_1_].GUI.finished == true then
    print("trying to change a screen that's already finished")
    return
  end
  if UIScreen.Context() == _ARG_1_ then
    ContextTable[_ARG_1_].GUI.finished = true
  end
  if _ARG_0_ == "EndScreen" then
    EndScreen(_ARG_1_)
  else
    UIScreen.SetNextScreen(_ARG_0_, _ARG_1_)
  end
end
function GoSubScreen(_ARG_0_)
  if _ARG_0_ == nil then
    return
  end
  if IsTable(ContextTable[UIEnums.Context.Main].GUI) == true then
    GoScreen(_ARG_0_, ContextTable[UIEnums.Context.Main].GUI.active_context)
  end
end
function CloseCurrentApp(_ARG_0_)
  if IsTable(ContextTable[UIEnums.Context.Main].GUI) == false then
    return
  end
  if IsNumber(ContextTable[UIEnums.Context.Main].GUI.active_context) == false then
    print("active_context ~= NUMBER")
    return
  end
  if ContextTable[UIEnums.Context.Main].GUI.active_context == -1 then
    print("No active context")
  end
  CloseApp(ContextTable[UIEnums.Context.Main].GUI.active_selection, true, nil, _ARG_0_)
end
function CloseApp(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if UIScreen.GetScreenActive(ContextTable[UIEnums.Context.Main].GUI.active_context) == false then
    return false
  end
  if IsNumber(ContextTable[UIEnums.Context.Main].GUI.active_context) == true and IsTable(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context]) == true then
    if IsTable(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI) and IsFunction(ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.CanExit) and _ARG_1_ ~= true then
    end
    if ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI:CanExit(_ARG_2_) == true then
      ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI.finished = true
    end
  end
  if ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI:CanExit(_ARG_2_) == true then
    EndActive()
    UIButtons.TimeLineActive("HelpFade", true, 0)
    if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
      CarouselSetApp(ContextTable[UIEnums.Context.Main].GUI, ContextTable[UIEnums.Context.Main].SCUI, _ARG_0_, true)
    elseif UIGlobals.IsIngame == false then
      LeaveMultiplayerMode()
    end
    if _ARG_3_ ~= true then
      PlaySfxBack()
    end
  end
  if ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI:CanExit(_ARG_2_) == true and IsTable(ContextTable[UIEnums.Context.Main].GUI.node_id) == true then
    UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.node_id[_ARG_0_], "Open", false, 2)
    UIButtons.PrivateTimeLineActive(ContextTable[UIEnums.Context.Main].GUI.bottom_help_id, "Hide_BottomHelp", false)
  end
  return (ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context].GUI:CanExit(_ARG_2_))
end
function EndActive()
  if UIScreen.GetScreenActive(ContextTable[UIEnums.Context.Main].GUI.active_context) == true then
    UIButtons.TimeLineActive("Outro", true, nil, nil, ContextTable[UIEnums.Context.Main].GUI.active_context)
    ContextTable[UIEnums.Context.Main].GUI.inactive_context = ContextTable[UIEnums.Context.Main].GUI.active_context
  else
    EndScreen(ContextTable[UIEnums.Context.Main].GUI.active_context)
  end
  if ContextTable[UIEnums.Context.Main].GUI.do_tutorial ~= true and IsControllerLocked() == false then
    UIButtons.SetActive(ContextTable[UIEnums.Context.Main].GUI.carousel_id, true)
    UIButtons.SetSelected(ContextTable[UIEnums.Context.Main].GUI.carousel_id, true)
  end
  UIButtons.TimeLineActive("CarouselSetback", false)
  ContextTable[UIEnums.Context.Main].GUI.active_selection = -1
end
function EndInactive()
  if UIScreen.Context() ~= 0 then
    return
  end
  if IsNumber(ContextTable[UIEnums.Context.Main].GUI.inactive_context) == true then
    EndScreen(ContextTable[UIEnums.Context.Main].GUI.inactive_context)
    ContextTable[UIEnums.Context.Main].GUI.inactive_context = nil
  end
end
function CarouselApp_SetScreenTimers()
  UIScreen.SetScreenTimers(0.3, 0.15)
end
function EndScreen(_ARG_0_)
  if _ARG_0_ == nil then
    _ARG_0_ = UIScreen.Context()
  end
  if IsTable(ContextTable[_ARG_0_]) == true and IsTable(ContextTable[_ARG_0_].GUI) then
    ContextTable[_ARG_0_].GUI.finished = true
  end
  UIScreen.EndScreen(_ARG_0_)
end
function PushScreen(_ARG_0_)
  if _ARG_0_ == nil then
    return
  end
  if GUI.finished == nil then
    print("Warning : Using PushScreen() without a 'finished' var in LocalGUI")
  end
  if GUI.finished == true then
    return
  end
  if GUIBank.CurrentContext > UIEnums.Context.Subscreen2 then
    print("PushScreen : Trying to push but there's nowhere to go")
    return
  end
  UIScreen.SetNextScreen(_ARG_0_, GUIBank.CurrentContext)
  GUIBank.CurrentContext = GUIBank.CurrentContext + 1
end
function PopScreen()
  if GUIBank.CurrentContext <= UIEnums.Context.Subscreen0 then
    print("PopScreen : Trying to pop but you should stop")
    return
  end
  GUIBank.CurrentContext = GUIBank.CurrentContext - 1
  EndScreen(GUIBank.CurrentContext)
  if IsTable(ContextTable[GUIBank.CurrentContext]) == true then
    ContextTable[GUIBank.CurrentContext].GUI.finished = true
  end
end
function FlushSubscreens()
  EndScreen(UIEnums.Context.Subscreen0)
  EndScreen(UIEnums.Context.Subscreen1)
  EndScreen(UIEnums.Context.Subscreen2)
  EndScreen(UIEnums.Context.Blurb)
  GUIBank.CurrentContext = UIEnums.Context.Subscreen0
end
function SubScreenActive()
  return UIScreen.IsContextActive(UIEnums.Context.Subscreen0) == true or UIScreen.IsContextActive(UIEnums.Context.Subscreen1) == true or UIScreen.IsContextActive(UIEnums.Context.Subscreen2) == true
end
function StoreScreen(_ARG_0_, _ARG_1_)
  if _ARG_1_ == nil then
    _ARG_1_ = UIScreen.GetCurrentScreen()
  end
  if IsNumber(_ARG_0_) == false or IsString(_ARG_1_) == false then
    print("Invalid params : StoreScreen( number, string ) : ", type(_ARG_0_), type(_ARG_1_))
    return
  end
  UIGlobals.ScreenStore[_ARG_0_] = _ARG_1_
end
function GetStoredScreen(_ARG_0_)
  if IsNumber(_ARG_0_) == false then
    print("Invalid params : GetStoredScreen( number, string ) : ", type(_ARG_0_))
    return "INVALID_SCREEN"
  end
  if IsString(UIGlobals.ScreenStore[_ARG_0_]) == false then
    print("Invalid index", _ARG_0_)
    return "INVALID_SCREEN"
  end
  return UIGlobals.ScreenStore[_ARG_0_]
end
function SetupMovie(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_)
  UIButtons.AddButton({
    layer = UIEnums.Layer.LAYER_1,
    type = UIEnums.ButtonTypes.GRAPHIC,
    pos = {x = 320, y = 240},
    size = {
      x = SCREEN_WIDTH + 2,
      y = 482
    },
    justify = UIEnums.Justify.MiddleCentre,
    colour_style = "!255 0 0 0",
    textures = {
      {
        name = UITexture.Textures.null,
        pos = {u = 0, v = 0},
        size = {u = 1, v = 1}
      }
    }
  })
  if _ARG_2_ == nil then
    _ARG_2_ = false
  end
  UISystem.InitMovie(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, (Amax.GetMovieVolume()))
  UIButtons.AddButton({
    layer = UIEnums.Layer.LAYER_1,
    type = UIEnums.ButtonTypes.GRAPHIC,
    pos = {x = 0, y = 0},
    size = {
      x = SCREEN_WIDTH + 2,
      y = (SCREEN_WIDTH + 2) * 9 / 16
    },
    colour_style = "!255 255 255 255",
    justify = UIEnums.Justify.MiddleCentre,
    parent_attach = UIEnums.Justify.MiddleCentre,
    textures = {
      {
        name = UIEnums.TextureType.MOVIE0,
        pos = {u = 0, v = 0},
        size = {u = 1, v = 1}
      }
    },
    blend_mode = UIEnums.BlendMode.Solid,
    effect_index = UIEnums.EffectIndex.Movie
  })
end
function LocalGUI(_ARG_0_)
  print("Deprecated")
  return GUI
end
function LocalGUIName(_ARG_0_)
  print("Deprecated")
end
function LocalSCUI(_ARG_0_)
  print("Deprecated")
  return SCUI
end
function AddInternalUseMessage()
  UIButtons.AddButton({
    type = UIEnums.ButtonTypes.TEXT,
    layer = UIEnums.Layer.TOP,
    justify = UIEnums.Justify.BottomCentre,
    parent_attach = UIEnums.Justify.BottomCentre,
    pos = {
      x = 0,
      y = -20,
      z = 0
    },
    size = {
      x = 0,
      y = 14,
      z = 0
    },
    colour_style = "!96 255 255 255",
    text = UIText.CMN_INTERNAL_USE
  })
end
function ClearScreenTemps()
  Init = nil
  PostInit = nil
  StartLoop = nil
  FrameUpdate = nil
  MessageUpdate = nil
  EnterEnd = nil
  EndLoop = nil
  End = nil
  GUI = nil
  SCUI = nil
end
ContextTable = {}
function PreLoadCallFile()
  ContextTable[UIScreen.Context()] = {}
  ClearScreenTemps()
end
function PostLoadCallFile()
  ContextTable[UIScreen.Context()].GUI = GUI
  ContextTable[UIScreen.Context()].Init = Init
  ContextTable[UIScreen.Context()].PostInit = PostInit
  ContextTable[UIScreen.Context()].StartLoop = StartLoop
  ContextTable[UIScreen.Context()].FrameUpdate = FrameUpdate
  ContextTable[UIScreen.Context()].MessageUpdate = MessageUpdate
  ContextTable[UIScreen.Context()].EnterEnd = EnterEnd
  ContextTable[UIScreen.Context()].EndLoop = EndLoop
  ContextTable[UIScreen.Context()].End = End
  ClearScreenTemps()
end
function SetContextTable(_ARG_0_)
  if IsTable(ContextTable[_ARG_0_]) == false then
    return nil
  end
  ContextTable_BackupGUI = GUI
  ContextTable_BackupSCUI = SCUI
  GUI = ContextTable[_ARG_0_].GUI
  SCUI = ContextTable[_ARG_0_].SCUI
  return ContextTable[_ARG_0_]
end
function ResetContextTable()
  GUI = ContextTable_BackupGUI
  SCUI = ContextTable_BackupSCUI
  ContextTable_BackupSCUI = nil
  ContextTable_BackupGUI = nil
end
function Init_Wrapper()
  if IsTable(ContextTable[UIScreen.Context()]) == false then
    return
  end
  if UIScreen.Context() == InfoLineContext then
    InfoLineClearCommands()
  end
  GUIBank.render_buffer_id = nil
  ContextTable[UIScreen.Context()].SCUI = SCUI
  GUI = ContextTable[UIScreen.Context()].GUI
  _G["GUI" .. UIScreen.Context()] = GUI
  _G["SCUI" .. UIScreen.Context()] = SCUI
  if IsFunction(ContextTable[UIScreen.Context()].Init) then
    ContextTable[UIScreen.Context()].Init()
  end
  if UIScreen.Context() == 0 and IsTable(SCUIBank) == false then
    print("SCUIBank doesnt exists")
    ResetContextTable()
    return
  end
  if UIScreen.Context() == InfoLineContext then
    Friends_CheckForEnable()
  end
  ResetContextTable()
end
function PostInit_Wrapper()
  if IsTable((SetContextTable(UIScreen.Context()))) == false then
    return
  end
  if IsFunction(SetContextTable(UIScreen.Context()).PostInit) then
    SetContextTable(UIScreen.Context()).PostInit()
  end
  if UIScreen.Context() == 0 then
    AddAspectRatioBars()
  end
  if (UIScreen.IsPopupActive() == true or UIGlobals.AsyncSave_FailMessageActive == true) and UIScreen.Context() ~= UIEnums.Context.LoadSave then
    UIButtons.TimeLineActive("Popup_Active", true)
  end
  ResetContextTable()
end
function StartLoop_Wrapper(_ARG_0_)
  if IsTable((SetContextTable(UIScreen.Context()))) == false then
    return
  end
  if IsFunction(SetContextTable(UIScreen.Context()).StartLoop) then
    SetContextTable(UIScreen.Context()).StartLoop(_ARG_0_)
  end
  ResetContextTable()
end
function FrameUpdate_Wrapper(_ARG_0_)
  if UIScreen.Context() == 0 then
    FrameUpdateLoading(_ARG_0_)
  end
  if IsTable((SetContextTable(UIScreen.Context()))) == false then
    return
  end
  if GUI.finished ~= true and IsFunction(SetContextTable(UIScreen.Context()).FrameUpdate) then
    SetContextTable(UIScreen.Context()).FrameUpdate(_ARG_0_)
  end
  if UIScreen.Context() == 0 and UIGlobals.LaunchMode == UIEnums.LaunchMode.Automation and GUI.automation_start == false then
    if Amax.IsGamePaused() == true then
      UIGlobals.automation_timer = UIGlobals.automation_length
    else
      UIGlobals.automation_timer = UIGlobals.automation_timer - _ARG_0_
      if 0 > UIGlobals.automation_timer then
        Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
        GoScreen("Loading\\LoadingUi.lua")
      end
    end
  end
  if UIScreen.Context() == InfoLineContext then
    Friends_CheckForEnable()
    InfoLineFrameUpdate()
  end
  ResetContextTable()
end
function MessageUpdate_Wrapper(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if UIScreen.Context() == 0 then
    MessageUpdateLoading(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  end
  if IsTable((SetContextTable(UIScreen.Context()))) == false then
    return
  end
  if UIScreen.Context() == 0 then
    if _ARG_0_ == UIEnums.GameFlowMessage.UILoaded then
      if UIGlobals.IsLoading == true then
        print("Ui Loaded")
        if UIGlobals.IsQuickRestart == false then
          UIGlobals.IsLoading = false
        end
      else
        print("Error - got UILoaded message when we're not flagged as loading")
      end
    end
    if UIGlobals.MpModShopKeyboardCheck ~= -1 then
      if _ARG_0_ == UIEnums.Message.KeyboardFinished then
        Multiplayer.SetNameOfLoadOut(UIGlobals.MpModShopKeyboardCheck)
        UIGlobals.MpModShopKeyboardCheck = -1
      elseif _ARG_0_ == UIEnums.Message.KeyboardCancelled then
        UIGlobals.MpModShopKeyboardCheck = -1
      end
    end
  end
  if GUI.finished ~= true and IsFunction(SetContextTable(UIScreen.Context()).MessageUpdate) then
    SetContextTable(UIScreen.Context()).MessageUpdate(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  end
  ResetContextTable()
end
function EnterEnd_Wrapper()
  if IsTable((SetContextTable(UIScreen.Context()))) == false then
    return
  end
  if IsFunction(SetContextTable(UIScreen.Context()).EnterEnd) then
    SetContextTable(UIScreen.Context()).EnterEnd()
  end
  if UIScreen.Context() == InfoLineContext then
    SetupInfoLine()
  end
  ResetContextTable()
end
function EndLoop_Wrapper(_ARG_0_)
  if IsTable((SetContextTable(UIScreen.Context()))) == false then
    return
  end
  if IsFunction(SetContextTable(UIScreen.Context()).EndLoop) then
    SetContextTable(UIScreen.Context()).EndLoop(_ARG_0_)
  end
  ResetContextTable()
end
function End_Wrapper()
  if IsTable((SetContextTable(UIScreen.Context()))) == false then
    return
  end
  if IsFunction(SetContextTable(UIScreen.Context()).End) then
    SetContextTable(UIScreen.Context()).End()
  end
  SetNil(_G["GUI" .. UIScreen.Context()])
  SetNil(_G["SCUI" .. UIScreen.Context()])
  SetNil(ContextTable[UIScreen.Context()])
  if UIScreen.Context() == 0 then
    GUIBank.FourThreeBars_BottomId = nil
    GUIBank.FourThreeBars_TopId = nil
  end
  ResetContextTable()
end
function CarouselAddLockedShapes()
  if IsTable(GUI.locked_table) == false then
    return
  end
  if IsTable(SCUI.elements[SCUI.name_to_index._Lock]) == false then
    print("No locked item found")
    return
  end
  if IsTable(GUI) == false or IsTable(GUI.branch_name) == false then
    print("No branch table")
    return
  end
  for _FORV_4_, _FORV_5_ in ipairs(GUI.locked_table) do
    UIButtons.SetParent(UIButtons.AddButton(SCUI.elements[SCUI.name_to_index._Lock]), SCUI.name_to_id[GUI.branch_name[_FORV_5_] .. "Dummy"], UIEnums.Justify.BottomRight)
  end
end
function CarouselIsAppLocked(_ARG_0_)
  if IsTable(GUI.locked_table) == false then
    return false
  end
  for _FORV_4_, _FORV_5_ in ipairs(GUI.locked_table) do
    if _ARG_0_ == _FORV_5_ then
      return true
    end
  end
  return false
end
function CarouselSetApp(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_2_ < 0 then
    return
  end
  if IsTable(_ARG_0_) == false or IsTable(_ARG_1_) == false then
    return
  end
  if IsString(_ARG_0_.branch_name[_ARG_2_]) == false then
    return
  end
  if IsTable(_ARG_0_.node_id) == true then
  end
  if CarouselIsAppLocked(_ARG_2_) == false then
    if _ARG_3_ == true then
    end
  else
  end
  if UIGlobals.IsIngame == true or UIGlobals.IsIngame == false and _ARG_2_ ~= UIEnums.RwBranch.Facebook then
    UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_.node_id[_ARG_2_], "Frame"), "Main_Black")
    UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_.node_id[_ARG_2_], "Title"), "Main_Black")
    UIButtons.ChangeColour(UIButtons.FindChildByName(_ARG_0_.node_id[_ARG_2_], "Shape"), "Main_Black")
  end
end
function StartProfileNew(_ARG_0_)
  UIGlobals.ProfilePressedStart = _ARG_0_
  Profile.SetPrimaryPad(UIGlobals.ProfilePressedStart)
  Profile.LockToPad(_ARG_0_)
  GameProfile.InitPrimary()
  Amax.SetGameMode(UIEnums.GameMode.SinglePlayer)
end
function GetActiveContext()
  if IsTable(ContextTable[UIEnums.Context.Main].GUI) == false then
    print("GUI (0) == nil")
    return
  end
  return ContextTable[ContextTable[UIEnums.Context.Main].GUI.active_context]
end
function GetActiveGUI()
  if IsTable((GetActiveContext())) == false then
    return
  end
  return GetActiveContext().GUI
end
function GetActiveSCUI()
  if IsTable((GetActiveContext())) == false then
    return
  end
  return GetActiveContext().SCUI
end
function CarouselLoadGame(_ARG_0_)
  print("##### SinglePlayer. Nowhere to go ####")
  print("##### SinglePlayer. Please fix-up ####")
end
function StartTimelineActive(_ARG_0_, _ARG_1_)
  for _FORV_5_, _FORV_6_ in pairs(SCUI.elements) do
    if IsTable(_FORV_6_) == true and IsTable(_FORV_6_.time_lines) == true then
      for _FORV_10_, _FORV_11_ in pairs(_FORV_6_.time_lines) do
        if _FORV_11_.label == _ARG_0_ then
          _FORV_11_.start_active = _ARG_1_
        end
      end
    end
  end
end
function StartPrivateTimelineActive(_ARG_0_, _ARG_1_, _ARG_2_)
  if SCUI.name_to_index[_ARG_0_] == nil then
    return
  end
  if IsTable(SCUI.elements[SCUI.name_to_index[_ARG_0_]]) == true and IsTable(SCUI.elements[SCUI.name_to_index[_ARG_0_]].time_lines) == true then
    for _FORV_8_, _FORV_9_ in pairs(SCUI.elements[SCUI.name_to_index[_ARG_0_]].time_lines) do
      if _FORV_9_.label == _ARG_1_ then
        _FORV_9_.start_active = _ARG_2_
      end
    end
  end
end
function SetTimelineStartEnd(_ARG_0_, _ARG_1_, _ARG_2_)
  for _FORV_6_, _FORV_7_ in pairs(SCUI.elements) do
    if IsTable(_FORV_7_) == true and IsTable(_FORV_7_.time_lines) == true then
      for _FORV_11_, _FORV_12_ in pairs(_FORV_7_.time_lines) do
        if _FORV_12_.label == _ARG_0_ then
          if IsNumber(_ARG_2_) == true then
            _FORV_12_.time.start = _ARG_1_
            _FORV_12_.time["end"] = _ARG_2_
          else
            _FORV_12_.time["end"] = _ARG_1_ + (_FORV_12_.time["end"] - _FORV_12_.time.start)
            _FORV_12_.time.start = _ARG_1_
          end
        end
      end
    end
  end
end
function CheckRenderBuffer()
  if IsNumber(GUIBank.render_buffer_id) == false then
    return
  end
  if UISystem.TextureValid("RENDER_BUFFER") == true then
    UIButtons.ChangeTexture({
      name = "RENDER_BUFFER",
      pos = {u = 0, v = 0},
      size = {u = 1, v = 1}
    }, 0, GUIBank.render_buffer_id)
  end
  UIButtons.SetActive(GUIBank.render_buffer_id, (UISystem.TextureValid("RENDER_BUFFER")))
end
function LockController()
  UIGlobals.ControllerLocked = true
end
function UnlockController()
  UIGlobals.ControllerLocked = false
end
function IsControllerLocked()
  return UIGlobals.ControllerLocked
end
function IsGarageMiniMultiplayer()
  return Amax.GetGameMode() == UIEnums.GameMode.Online or Amax.GetGameMode() == UIEnums.GameMode.SystemLink
end
function IsMultiplayerMode()
  return Amax.IsGameModeMultiplayer()
end
function IsNetworkMultiplayerMode()
  return Amax.IsGameModeNetworked()
end
function StartUiLoad()
  if UIGlobals.IsLoading == true then
    print("Warning - StartUiLoad : Already loaded")
    return
  end
  print("StartUiLoad")
  Debug.IncrementMemoryTag("ui")
  Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
  Amax.SendMessage(UIEnums.GameFlowMessage.StartUILoad)
  if UIGlobals.ReturnMode ~= UIEnums.ReturnMode.QuitSpGame and UIGlobals.ReturnMode ~= UIEnums.ReturnMode.QuitMpGame then
    if Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
      Amax.SetUICarToMultiplayer(false)
    else
      Amax.SetUICarToMultiplayer(true)
    end
    Amax.SendMessage(UIEnums.GameFlowMessage.LoadUIScene)
  end
  UIGlobals.IsLoading = true
  net_LockoutFriendsOverlay(true)
end
function StartGameLoad(_ARG_0_, _ARG_1_)
  if _ARG_1_ == nil then
    _ARG_1_ = false
  end
  GUIBank.stay_on_current_screen = _ARG_1_
  print("StartGameLoad")
  UIGlobals.IsLoading = true
  net_LockoutFriendsOverlay(true)
  GUIBank.loading = true
  GUIBank.load_timer = 0
  GUIBank.load_next_text_change_at = 0
  GUIBank.load_text_index = 0
  GUIBank.load_start_delay_timer = 0
  GUIBank.load_message_sent = false
  GUIBank.load_finished = false
  GUIBank.load_end_delay_timer = 0
  GUIBank.ready_sent = false
  if _ARG_0_ == true then
    GUIBank.load_first_time = true
  else
    GUIBank.load_first_time = false
  end
  GUIBank.end_effects_started = false
  if GUIBank.stay_on_current_screen == false then
    UIButtons.TimeLineActive("start_load", true)
  end
  StopFrontendMusic()
  GUIBank.load_added_objectives = false
end
function FrameUpdateLoading(_ARG_0_)
  if GUIBank.loading == false then
    return
  end
  if GUIBank.load_message_sent == false then
    GUIBank.load_start_delay_timer = GUIBank.load_start_delay_timer + _ARG_0_
    if GUIBank.load_start_delay_timer > GUIBank.load_start_delay then
      GUIBank.load_message_sent = true
      print("FrameUpdateLoading : StartGameLoad")
      Debug.IncrementMemoryTag("game")
      if UIGlobals.IsQuickRestart == false then
        Amax.SendMessage(UIEnums.GameFlowMessage.StartRaceLoad)
      else
        Amax.SendMessage(UIEnums.GameFlowMessage.UnPause)
        Amax.SendMessage(UIEnums.GameFlowMessage.RestartRace)
        Amax.SendMessage(UIEnums.GameFlowMessage.RestartLevel)
      end
    end
  end
  if GUIBank.load_finished == true and Amax.WaitForStreamer() == false then
    if NetServices.GameInvitePending() == true then
      UIGlobals.IsIngame = true
      UIGlobals.IsLoading = false
      GUIBank.loading = false
      return
    end
    if Amax.IsGameModeNetworked() == true then
      if GUIBank.ready_sent == false then
        NetRace.EnterSyncAfterRaceLoad()
        GUIBank.ready_sent = true
      else
      end
    end
    if false == false then
      return
    end
    if GUIBank.end_effects_started == false then
      if GUIBank.stay_on_current_screen == false then
        UIButtons.TimeLineActive("end_load", true)
      end
      GUIBank.end_effects_started = true
      if GUIBank.stay_on_current_screen == true then
        EndScreen(UIEnums.Context.CarouselApp)
      end
    end
    GUIBank.load_end_delay_timer = GUIBank.load_end_delay_timer + _ARG_0_
    if GUIBank.load_end_delay_timer > GUIBank.load_end_delay then
      if Amax.HasStartCutScene() == true and Amax.HasStartCutScene() == false then
        print("SendMessage : VideoPresent")
        UIGlobals.VideoPresent = true
        Amax.SendMessage(UIEnums.GameFlowMessage.VideoPresent)
      else
        UIGlobals.VideoPresent = nil
      end
      Amax.SendMessage(UIEnums.GameFlowMessage.StartGameRendering)
      StartIngameMusic()
      if GUIBank.stay_on_current_screen == false and GUIBank.load_first_time == false then
        UIButtons.TimeLineActive("end_load_fade", true)
      end
      GUIBank.loading = false
      UIGlobals.IsLoading = false
      UIGlobals.IsIngame = true
      UIGlobals.IsQuickRestart = false
      if Amax.IsGameModeNetworked() == true then
        NetRace.StartPlay()
        GoScreen("Multiplayer\\Ingame\\MpRollingStart.lua")
      elseif Amax.GetGameMode() == UIEnums.GameMode.SinglePlayer then
        GoScreen("Ingame\\IntroVista.lua")
      else
        Amax.SendMessage(UIEnums.GameFlowMessage.RaceStarted)
        if IsSplitScreen() == true then
          Amax.SendMessage(UIEnums.GameFlowMessage.RaceLoaded)
          GoScreen("Multiplayer\\Ingame\\MpRollingStart.lua")
        else
          GoScreen("Ingame\\HUD.lua")
        end
      end
    end
  end
end
function MessageUpdateLoading(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if GUIBank.loading == false then
    return
  end
  if _ARG_0_ == UIEnums.GameFlowMessage.RaceLoaded and UIScreen.Context() == 0 then
    Amax.SetGlobalFade(1)
    Amax.FillStreamer()
    GUIBank.load_finished = true
  end
end
function GlobalUpdate()
  if UIGlobals.UserKickBackActive == true and UIGlobals.IsIngame == false and UIGlobals.UserKickBackMode ~= UIEnums.UserKickBackMode.None and UIScreen.IsPopupActive() == false and SubScreenActive() == false and UIScreen.IsContextActive(UIEnums.Context.LoadSave) == false and UIScreen.IsContextActive(UIEnums.Context.CarouselApp) == false then
    Amax.ChangeEnvironmentSettings(false)
    GoScreen(UIGlobals.UserKickBackScreen, 0)
    UIGlobals.UserKickBackActive = false
  end
  if UIGlobals.ActUponFriendChallenges == true and UIGlobals.PendingFriendChallengeInfo.Pending == true and UIGlobals.IsLoading == false and UIScreen.GetCurrentScreen() ~= "loading\\loadingui.lua" then
    ActUponPendingFriendChallenge()
    if UIScreen.IsPopupActive() == false and UIScreen.IsContextActive(UIEnums.Context.LoadSave) == false and SubScreenActive() == false then
      Amax.ChangeEnvironmentSettings(false)
      ReturnToSpMain()
      UIGlobals.PendingFriendChallengeInfo = {}
    end
  end
  net_CheckFriendsAvailability()
  if net_GlobalUpdate() == false then
    return false
  end
  return true
end
function RemoveBlaggedProfiles()
  for _FORV_3_ = 0, 3 do
    UIGlobals.ProfileDevice[_FORV_3_] = -1
    if UIGlobals.ProfileState[_FORV_3_] == UIEnums.Profile.Blagged and Profile.GetPrimaryPad() ~= _FORV_3_ then
      Profile.ClearProfile(_FORV_3_)
      GameProfile.ClearGameProfile(_FORV_3_, true)
      UIGlobals.ProfileState[_FORV_3_] = UIEnums.Profile.None
      UIGlobals.LoadProfile[_FORV_3_] = false
    end
  end
end
function AddCutSceneBars(_ARG_0_)
  if _ARG_0_ == nil then
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "TopCutSceneBar"), "move", true, 1)
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "BotCutSceneBar"), "move", true, 1)
  elseif _ARG_0_ == 0 then
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "TopCutSceneBar"), "move", false, 1)
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "BotCutSceneBar"), "move", false, 1)
  elseif _ARG_0_ == 1 then
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "TopCutSceneBar"), "move", true, 0)
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "BotCutSceneBar"), "move", true, 0)
  end
end
function DarkenScreen(_ARG_0_)
  if _ARG_0_ == nil then
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_Darken"), "fade", true, 1)
  elseif _ARG_0_ == 0 then
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_Darken"), "fade", false, 1)
  elseif _ARG_0_ == 1 then
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_Darken"), "fade", true, 0)
  end
end
function LocalGamerPicture(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
  else
  end
  UIButtons.ChangeTexture({
    filename = "default_gamerpic",
    name = "default_gamerpic",
    pos = {u = 0, v = 0},
    size = {u = 1, v = 1}
  }, 1, _ARG_0_)
end
function RemoteGamerPicture(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
  else
  end
  UIButtons.ChangeTexture({
    filename = "default_gamerpic",
    name = "default_gamerpic",
    pos = {u = 0, v = 0},
    size = {u = 1, v = 1}
  }, 1, _ARG_0_)
end
function AIGamerPicture(_ARG_0_, _ARG_1_)
  UIButtons.ChangeTexture({
    filename = "member_icons",
    pos = {
      u = 1 / UIGlobals.NumMajorAvatarIcons * _ARG_1_,
      v = 0
    },
    size = {
      u = 1 / UIGlobals.NumMajorAvatarIcons,
      v = 1
    }
  }, 1, _ARG_0_)
end
function AddLoadingSegs(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  _ARG_0_ = _ARG_0_ or Screen.safe.right - 15
  _ARG_1_ = _ARG_1_ or Screen.safe.bottom - 15
  _ARG_2_ = _ARG_2_ or 30
  _ARG_3_ = _ARG_3_ or 30
  _ARG_4_ = _ARG_4_ or UIEnums.Panel._2DAA
  if IsNumber(_ARG_2_) == true and IsNumber(_ARG_3_) == true then
    UIButtons.ChangeScale(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_LoadingSegs"), _ARG_2_ * 0.5, _ARG_3_ * 0.5)
  end
  UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_LoadingSegs"), _ARG_0_, _ARG_1_)
  if IsNumber(_ARG_4_) == true then
    UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_LoadingSegs"), _ARG_4_)
    for _FORV_10_ = 1, 8 do
      UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_LoadingSegs"), "Gfx_Seg" .. _FORV_10_), _ARG_4_)
      if true == true then
        UIButtons.ChangeOrientation(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_LoadingSegs"), "Gfx_Seg" .. _FORV_10_), 0, 0, 180)
      end
    end
  end
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_LoadingSegs"))
end
function AddTransmitter(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_, _ARG_8_, _ARG_9_)
  if _ARG_9_ == nil then
    _ARG_9_ = 0
  end
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Mast"), _ARG_2_, _ARG_3_)
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "One"), _ARG_2_, _ARG_3_)
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Two"), _ARG_2_, _ARG_3_)
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Three"), _ARG_2_, _ARG_3_)
  UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "BleepBleepText"), _ARG_9_, _ARG_3_)
  UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), _ARG_0_, _ARG_1_)
  if _ARG_4_ ~= nil then
    UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), _ARG_4_)
    UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Mast"), _ARG_4_)
    UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "One"), _ARG_4_)
    UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Two"), _ARG_4_)
    UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Three"), _ARG_4_)
    UIButtons.ChangePanel(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "BleepBleepText"), _ARG_4_)
  end
  if _ARG_5_ ~= nil then
    UIButtons.ChangeLayer(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), _ARG_5_)
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Mast"), _ARG_5_)
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "One"), _ARG_5_)
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Two"), _ARG_5_)
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "Three"), _ARG_5_)
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "BleepBleepText"), _ARG_5_)
  end
  if _ARG_8_ ~= nil then
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "BleepBleepText"), true)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), "BleepBleepText"), _ARG_8_)
  end
  if _ARG_6_ ~= false then
    TransmitterOn((UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep")))
  end
  if _ARG_7_ == true then
    UIButtons.SetActive(UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"), false, true)
  end
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "Gfx_BleepBleep"))
end
function TransmitterOn(_ARG_0_)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_ARG_0_, "Mast"), "bleep_bleep", true, 0)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_ARG_0_, "One"), "bleep_bleep", true, 0)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_ARG_0_, "Two"), "bleep_bleep", true, 0)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_ARG_0_, "Three"), "bleep_bleep", true, 0)
end
function TransmitterOff(_ARG_0_)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_ARG_0_, "Mast"), "bleep_bleep", false)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_ARG_0_, "One"), "bleep_bleep", false)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_ARG_0_, "Two"), "bleep_bleep", false)
  UIButtons.PrivateTimeLineActive(UIButtons.FindChildByName(_ARG_0_, "Three"), "bleep_bleep", false)
end
function InitMpGlobals()
  MpGlobals = {
    group_id = 0,
    user_created_group = false,
    number_of_drivers = 20,
    teams = 0,
    number_of_teams = 2,
    number_of_races = 1,
    current_race_index = 1,
    each_race_the_same = 0,
    public_game = 1,
    race_setup = {}
  }
end
function StartAsyncLoad()
  UIGlobals.FileParams = {
    SetInterface = GameProfile.SetSaveInfoInterfaceProfile,
    FinishedMessage = UIEnums.GameFlowMessage.SaveGameLoaded
  }
  StoreScreen(UIEnums.ScreenStorage.LOAD_NEXT, "EndScreen")
  UIScreen.SetNextScreen("Profile\\AsyncLoad.lua", UIEnums.Context.LoadSave)
  return true
end
function StartAsyncSave()
  if CanSave(Profile.GetPrimaryPad()) == false then
    return false
  end
  UIGlobals.FileParams = {
    SetInterface = GameProfile.SetSaveInfoInterfaceProfile
  }
  StoreScreen(UIEnums.ScreenStorage.SAVE_NEXT, "EndScreen")
  UIScreen.SetNextScreen("Profile\\AsyncSave.lua", UIEnums.Context.LoadSave)
  return true
end
function StartAsyncLoadPhotos()
  if CanSave(Profile.GetPrimaryPad(), true) == false then
    return false
  end
  UIGlobals.FileParams = {
    SetInterface = GameProfile.SetSaveInfoInterfacePhotos,
    FinishedSuccess = false
  }
  UIGlobals.ProfileEnumerateIndex = Profile.GetPrimaryPad()
  GUIBank.photo_viewing_download = false
  StoreScreen(UIEnums.ScreenStorage.SAVE_NEXT, "Photos\\ViewPhoto.lua")
  return true
end
function StartAsyncSavePhotos()
  if CanSave(Profile.GetPrimaryPad(), true) == false then
    return false
  end
  UIGlobals.FileParams = {
    SetInterface = GameProfile.SetSaveInfoInterfacePhotos
  }
  StoreScreen(UIEnums.ScreenStorage.SAVE_NEXT, "EndScreen")
  UIScreen.SetNextScreen("Profile\\AsyncSave.lua", UIEnums.Context.LoadSave)
  return true
end
UIScreen.AddXtRecord("SCUIBank", false)
if IsTable(SCUIBank) == true then
  SCUIBank.name_to_index = {}
  for _FORV_3_, _FORV_4_ in pairs(SCUIBank.elements) do
    if IsString(_FORV_4_.name) then
      SCUIBank.name_to_index[_FORV_4_.name] = _FORV_3_
    end
  end
end
function AddSCUIBankElement(_ARG_0_)
  return UIButtons.CloneXtGadgetByName("SCUIBank", _ARG_0_)
end
function CreateGroupOverview(_ARG_0_, _ARG_1_)
  if _ARG_0_ ~= nil then
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "name"), "MPL_GROUP_NAME" .. _ARG_1_)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "desc"), "MPL_GROUP_DESC" .. _ARG_1_)
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "owner"), "MPL_GROUP_OWNER" .. _ARG_1_)
    for _FORV_10_ = 1, 1 do
      UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "rating_" .. _FORV_10_), "Support_4")
      UIButtons.ChangeAlpha(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "rating_" .. _FORV_10_), 1)
    end
  else
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "owner"), false)
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "name"), "Main_Black")
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "desc"), "Main_Black")
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "owner"), "Main_Black")
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "rating"), "Main_Black")
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"), "frame"), "Main_Black")
  end
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "node_group"))
end
function ForceCloseScreens()
  EndScreen(UIEnums.Context.LoadSave)
  UIScreen.SetScreenTimers(0, 0, UIEnums.Context.CarouselApp)
  UIScreen.SetScreenTimers(0, 0, UIEnums.Context.Subscreen0)
  UIScreen.SetScreenTimers(0, 0, UIEnums.Context.Subscreen1)
  UIScreen.SetScreenTimers(0, 0, UIEnums.Context.Subscreen2)
  EndScreen(UIEnums.Context.CarouselApp)
  FlushSubscreens()
end
function ReturnToStartScreen(_ARG_0_)
  if UserKickBackActive() == false and UIGlobals.UserKickBackMode == UIEnums.UserKickBackMode.None then
    if UIGlobals.IsIngame == true and UIScreen.GetCurrentScreen() ~= "loading\\loadingui.lua" then
      Amax.SendMessage(UIEnums.GameFlowMessage.UnPause)
      Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
      StoreScreen(UIEnums.ScreenStorage.FE_RETURN, UIGlobals.UserKickBackScreen)
      GoScreen("Loading\\LoadingUi.lua", UIEnums.Context.Main)
    end
    UIScreen.CancelPopup()
    ForceCloseScreens()
    if IsTable(PopupGUI) == true then
      PopupGUI.spawn_next = nil
    end
    net_FlushEverything()
  end
  UIGlobals.ReturnMode = UIEnums.ReturnMode.None
  UIGlobals.UserKickBackMode = _ARG_0_
  UIGlobals.UserKickBackActive = true
  print("Returning to start screen because of ", _ARG_0_)
  show_table(UIEnums.UserKickBackMode, 1)
end
function UserKickBackActive()
  if UIGlobals.UserKickBackMode ~= UIEnums.UserKickBackMode.None then
    return true
  end
  return false
end
function ReturnToSpMain()
  if UserKickBackActive() == true then
    return
  end
  if UIGlobals.IsIngame == true and UIScreen.GetCurrentScreen() ~= "loading\\loadingui.lua" then
    Amax.SendMessage(UIEnums.GameFlowMessage.UnPause)
    Amax.SendMessage(UIEnums.GameFlowMessage.QuitRace)
    StoreScreen(UIEnums.ScreenStorage.FE_RETURN, "SinglePlayer\\SpMain.lua")
    GoScreen("Loading\\LoadingUi.lua")
  elseif UIGlobals.IsIngame == false then
    GoScreen("SinglePlayer\\SpMain.lua")
  end
  UIScreen.CancelPopup()
  PopupGUI.spawn_next = nil
  net_FlushSessionEnumerator()
  net_CloseAllSessions()
end
function ProfileSignedInOut(_ARG_0_, _ARG_1_)
  if _ARG_0_ == true then
    print("ProfileSignedIn", _ARG_1_)
  else
    print("ProfileSignedOut", _ARG_1_)
  end
  if IsSplitScreen() == true then
  elseif Amax.IsGameModeNetworked() == true then
  else
  end
  if _ARG_1_ == Profile.GetPrimaryPad() == false then
    if _ARG_0_ == true then
      Profile.Setup(_ARG_1_)
      UIGlobals.ProfilesFound = UIGlobals.ProfilesFound + 1
      UIGlobals.DoNotSave[_ARG_1_] = false
      UIGlobals.ProfileState[_ARG_1_] = UIEnums.Profile.PreLoad
    else
      UIGlobals.ProfileState[_ARG_1_] = UIEnums.Profile.None
      Profile.ClearProfile(_ARG_1_)
      UIGlobals.ProfilesFound = UIGlobals.ProfilesFound - 1
    end
  else
    print("kicking you ... BYE!")
    Amax.KickedOutOfGame()
    ReturnToStartScreen(UIEnums.UserKickBackMode.UserChanged)
  end
end
function StartLoad()
  if GUI.DisableLoading ~= true then
    Debug.IncrementMemoryTag("game")
    net_LockoutFriendsOverlay(true)
    print("LoadingGame : StartGameLoad")
    UIGlobals.IsLoading = true
    Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
    Amax.SendMessage(UIEnums.GameFlowMessage.StartRaceLoad)
  end
end
function StartLobbyNetworkLoad()
  if UIScreen.IsPopupActive() == true then
    UIScreen.CancelPopup()
  end
  print("StartLobbyNetworkLoad")
  Debug.IncrementMemoryTag("game")
  NetRace.EnterRaceLoad()
  UIGlobals.Multiplayer.LaunchScreen = UIEnums.MpLaunchScreen.MultiplayerLobby
  UIGlobals.IsLoading = true
  UIGlobals.IsQuickRestart = false
  Amax.SendMessage(UIEnums.GameFlowMessage.StopGameRendering)
  StopFrontendMusic()
  GoLoadingScreen("Loading\\LoadingMpGame.lua", 0)
end
function UpdateSpStatusBar()
  if IsTable(GUIBank.SpStatusBar) == false then
    return
  end
  UIButtons.SetActive(GUIBank.SpStatusBar.branch_id, true)
  UIButtons.ChangeScale(GUIBank.SpStatusBar.progress_id, SinglePlayer.GameInfo().rankProgress, 1, 1)
end
function UpdateMpStatusBar()
  if IsTable(GUIBank.MpStatusBar) == false then
    return
  end
  UIButtons.SetActive(GUIBank.MpStatusBar.branch_id, true)
  UIButtons.SetActive(GUIBank.MpStatusBar.branch_online_id, (Amax.IsGameModeOnline()))
  if Amax.IsGameModeOnline() == true and IsTable((Multiplayer.ProfileProgression())) == true then
    Mp_RankIcon(GUIBank.MpStatusBar.level_icon_id, Multiplayer.ProfileProgression().level - 1, Multiplayer.ProfileProgression().legend)
    UIButtons.ChangeText(GUIBank.MpStatusBar.level_text_id, "GAME_NUM_" .. Multiplayer.ProfileProgression().level)
    Mp_SetupPlayerProgressBar(GUIBank.MpStatusBar.branch_online_id)
  end
end
function AddStatusBar(_ARG_0_)
  GUIBank.SpStatusBar = nil
  GUIBank.MpStatusBar = nil
  if _ARG_0_ ~= nil then
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "Shp_DlgLogo"), "groups")
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "Shp_DlgLogo"), "Support_1")
    UIButtons.ChangeColour(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "Gfx_StatusBar"), "Support_1")
    GUIBank.MpStatusBar = {
      branch_id = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "Bra_MpStatusBar"),
      branch_online_id = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "Bra_MpOnlineBar"),
      level_text_id = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "Txt_MpLevel"),
      level_icon_id = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "Gfx_MpLevel")
    }
    UpdateMpStatusBar()
  else
    GUIBank.SpStatusBar = {
      branch_id = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "Bra_SpStatusBar"),
      progress_id = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"), "progress")
    }
    UpdateSpStatusBar()
  end
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "Dmy_StatusBar"))
end
function FindRemotePictureIndex(_ARG_0_, _ARG_1_)
  for _FORV_6_, _FORV_7_ in ipairs(_ARG_1_) do
    if _ARG_0_ == _FORV_7_.join_ref then
      break
    end
  end
  return _FORV_6_ - 1
end
function DialogueBox_Resize(_ARG_0_, _ARG_1_)
  if IsTable(SCUIBank.elements[SCUIBank.name_to_index.Txt_DlgBoxMessage]) == false then
    return
  end
  if 4 + SCUIBank.elements[SCUIBank.name_to_index.Txt_DlgBoxMessage].size.y * UISystem.GetNumStringLines(_ARG_1_, SCUIBank.elements[SCUIBank.name_to_index.Txt_DlgBoxMessage].size.y, SCUIBank.elements[SCUIBank.name_to_index.Txt_DlgBoxMessage].size.x, SCUIBank.elements[SCUIBank.name_to_index.Txt_DlgBoxMessage].styles) > UIButtons.GetSize(UIButtons.FindChildByName(_ARG_0_, "Box_DlgBox")) then
    UIButtons.ChangeSize(UIButtons.FindChildByName(_ARG_0_, "Box_DlgBox"), UIButtons.GetSize(UIButtons.FindChildByName(_ARG_0_, "Box_DlgBox")))
  end
end
function StopFrontendMusic()
  print("[StopFrontendMusic]")
  Amax.SendMessage(UIEnums.GameFlowMessage.StopFrontendAudio)
end
function StartIngameMusic()
  print("[StartIngameMusic]")
  Amax.SendMessage(UIEnums.GameFlowMessage.StartIngameAudio)
end
function StopIngameMusic()
  print("[StopIngameMusic]")
  Amax.SendMessage(UIEnums.GameFlowMessage.StopIngameAudio)
end
function GarageCheat_Reload()
  UIGlobals.GarageCheatReload = true
end
function Friends_CheckForEnable()
  if UIEnums.CurrentPlatform ~= UIEnums.Platform.PS3 and UIEnums.CurrentPlatform ~= UIEnums.Platform.PC then
    return
  end
  if Profile.IsFriendsEnabled() == true and Profile.IsFriendsDisplayed() == false then
    if GUI.friends_enable_id == nil then
      GUI.friends_enable_id = UIButtons.CloneXtGadgetByName("SCUIBank", "_info_lineR", InfoLineContext)
      UIButtons.ChangeText(GUI.friends_enable_id, UIText.INFO_BK_FRIENDS)
      UIButtons.ChangeJustification(GUI.friends_enable_id, UIEnums.Justify.BottomRight)
      UIButtons.ChangePosition(GUI.friends_enable_id, Screen.safe.right, Screen.safe.bottom)
      UIButtons.ReplaceTimeLineLabel(GUI.friends_enable_id, "SetupInfoLineR", "FriendsActive")
    elseif GUI.friends_active ~= true then
      UIButtons.SetActive(GUI.friends_enable_id, true)
      UIButtons.TimeLineActive("FriendsActive", true, 0)
      GUI.friends_active = true
    end
  elseif GUI.friends_enable_id ~= nil then
    UIButtons.SetActive(GUI.friends_enable_id, false)
    GUI.friends_active = false
  end
end
function XtToScreenSpaceX(_ARG_0_, _ARG_1_)
  _ARG_0_ = _ARG_0_ / 1.5
  if _ARG_1_ == true then
    _ARG_0_ = _ARG_0_ - 320
  end
  _ARG_0_ = _ARG_0_ + -106.66666666666663
  if _ARG_1_ == true then
    _ARG_0_ = _ARG_0_ * 0.1
  end
  return _ARG_0_
end
function XtToScreenSpaceY(_ARG_0_, _ARG_1_)
  _ARG_0_ = _ARG_0_ / 1.5
  if _ARG_1_ == true then
    _ARG_0_ = _ARG_0_ - 240
  end
  if _ARG_1_ == true then
    _ARG_0_ = _ARG_0_ * -0.1
  end
  return _ARG_0_
end
function AddAspectRatioBars()
  GUIBank.FourThreeBars_TopId = UIButtons.AddButton({
    layer = UIEnums.Layer.BACKGROUND,
    panel = UIEnums.Panel._2DAA,
    type = UIEnums.ButtonTypes.GRAPHIC,
    pos = {x = SCREEN_LEFT, y = 0},
    size = {
      x = SCREEN_WIDTH + 2,
      y = 0
    },
    colour_style = "!255 0 0 0",
    textures = {
      {
        pos = {u = 0, v = 0},
        size = {u = 1, v = 1}
      }
    },
    effect_index = UIEnums.EffectIndex.OneColour,
    justify = UIEnums.Justify.BottomLeft
  })
  {
    layer = UIEnums.Layer.BACKGROUND,
    panel = UIEnums.Panel._2DAA,
    type = UIEnums.ButtonTypes.GRAPHIC,
    pos = {x = SCREEN_LEFT, y = 0},
    size = {
      x = SCREEN_WIDTH + 2,
      y = 0
    },
    colour_style = "!255 0 0 0",
    textures = {
      {
        pos = {u = 0, v = 0},
        size = {u = 1, v = 1}
      }
    },
    effect_index = UIEnums.EffectIndex.OneColour,
    justify = UIEnums.Justify.BottomLeft
  }.pos.y = 481
  GUIBank.FourThreeBars_BottomId = UIButtons.AddButton({
    layer = UIEnums.Layer.BACKGROUND,
    panel = UIEnums.Panel._2DAA,
    type = UIEnums.ButtonTypes.GRAPHIC,
    pos = {x = SCREEN_LEFT, y = 0},
    size = {
      x = SCREEN_WIDTH + 2,
      y = 0
    },
    colour_style = "!255 0 0 0",
    textures = {
      {
        pos = {u = 0, v = 0},
        size = {u = 1, v = 1}
      }
    },
    effect_index = UIEnums.EffectIndex.OneColour,
    justify = UIEnums.Justify.BottomLeft
  })
  UpdateAspectBars()
end
function UpdateAspectBars()
  if IsNumber(GUIBank.FourThreeBars_TopId) ~= true or IsNumber(GUIBank.FourThreeBars_BottomId) ~= true then
    return
  end
  UIButtons.SetActive(GUIBank.FourThreeBars_TopId, UIGlobals.resolution_aspect / 1.7777777777777777 ~= 1)
  UIButtons.SetActive(GUIBank.FourThreeBars_BottomId, UIGlobals.resolution_aspect / 1.7777777777777777 ~= 1)
  if UIGlobals.resolution_aspect / 1.7777777777777777 ~= 1 == false then
    return
  end
  if 1.7777777777777777 > 1 then
    UIButtons.ChangePosition(GUIBank.FourThreeBars_TopId, SCREEN_LEFT, 0)
    UIButtons.ChangePosition(GUIBank.FourThreeBars_BottomId, SCREEN_LEFT, 482)
    UIButtons.ChangeSize(GUIBank.FourThreeBars_TopId, SCREEN_WIDTH, (480 - SCREEN_WIDTH * 9 / 16) / 2)
    UIButtons.ChangeSize(GUIBank.FourThreeBars_BottomId, SCREEN_WIDTH, (480 - SCREEN_WIDTH * 9 / 16) / 2)
  end
end
function IsWideScreen()
  return UIGlobals.resolution_aspect >= 1.7777777777777777
end
function CalcScreenBounds()
  Screen = {
    top = 0,
    bottom = 480,
    left = SCREEN_LEFT,
    right = SCREEN_RIGHT,
    width = SCREEN_WIDTH,
    height = 480,
    safe = {
      top = 36,
      bottom = 444,
      left = SCREEN_LEFT + SCREEN_WIDTH * 0.075,
      right = SCREEN_RIGHT - SCREEN_WIDTH * 0.075,
      width = SCREEN_WIDTH * 0.85,
      height = 408
    }
  }
end
function ChangeResolution(_ARG_0_, _ARG_1_)
  if IsNumber(_ARG_0_) ~= true or IsNumber(_ARG_1_) ~= true then
    print("ChangeResolution : Invalid number")
    return
  end
  if _ARG_0_ <= 0 or _ARG_1_ <= 0 then
    print("ChangeResolution : Invalid dimension", _ARG_0_, _ARG_1_)
    return
  end
  UIGlobals.resolution_width = _ARG_0_
  UIGlobals.resolution_height = _ARG_1_
  UIGlobals.resolution_aspect = _ARG_0_ / _ARG_1_
  SCREEN_WIDTH = _ARG_0_ * (480 / _ARG_1_)
  SCREEN_LEFT = (640 - SCREEN_WIDTH) / 2 - 0.25
  SCREEN_RIGHT = SCREEN_LEFT + SCREEN_WIDTH
  CalcScreenBounds()
  Camera_UseFrontend()
  UpdateAspectBars()
end
function Camera_UseFrontend()
  UIGlobals.UseAspectRatioBars = true
  UpdateAspectBars()
  UISystem.SetCameraScale(true, 0, UIGlobals.resolution_aspect / 1.7777777777777777)
end
function Camera_UseInGame()
  UISystem.SetCameraScale(true, 0, 1)
  UIGlobals.UseAspectRatioBars = false
end
function PS3_CheckForInstallingMessage()
  if UIGlobals.Ps3Installing == true and Amax.Ps3PollInstaller() == true then
    print("PS3 : Finished install")
    UIGlobals.Ps3Installing = nil
    Amax.CleanPS3Install()
  end
end
function PlaySPMovieFullScreen(_ARG_0_, _ARG_1_)
  if _ARG_1_ == nil then
    _ARG_1_ = false
  end
  if Amax.CanPlayGameModeVideo(_ARG_0_) == true or _ARG_1_ == true then
    if _ARG_1_ == false then
      UIGlobals.SpMovieScreenShouldSave = true
    end
    for _FORV_5_, _FORV_6_ in ipairs(UIGlobals.ActiveSPMovie) do
      if _FORV_6_.Filename == -1 then
        print("Adding Item to array in position %d", _FORV_5_)
        _FORV_6_.Filename, _FORV_6_.Skipable, _FORV_6_.FullScreen = Amax.GetGameModeVideoFile(_ARG_0_)
        print(_FORV_6_.Filename)
        print(_FORV_6_.Skipable)
        print(_FORV_6_.FullScreen)
        if _ARG_1_ == true then
          _FORV_6_.FullScreen = true
          _FORV_6_.Skipable = true
        else
          Amax.SetVideoPlayedBitInProfile(_ARG_0_)
        end
        if _FORV_5_ == 1 then
          PushScreen("SinglePlayer\\SpMovieScreen.lua")
        end
        break
      end
    end
    return true
  else
    return false
  end
end
function PlaySPUnlockMovieFullScreen(_ARG_0_, _ARG_1_)
  UIGlobals.SpMovieScreenShouldSave = true
  for _FORV_5_, _FORV_6_ in ipairs(UIGlobals.ActiveSPMovie) do
    if _FORV_6_.Filename == -1 then
      print("Adding Item to array in position %d", _FORV_5_)
      _FORV_6_.Filename, _FORV_6_.Skipable, _FORV_6_.FullScreen = Amax.GetUnlocksVideoFile(_ARG_0_, _ARG_1_)
      print(_FORV_6_.Filename)
      print(_FORV_6_.Skipable)
      print(_FORV_6_.FullScreen)
      if _FORV_5_ == 1 then
        PushScreen("SinglePlayer\\SpMovieScreen.lua")
      end
      break
    end
  end
  return true
end
function SetupScreenTitle(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_, _ARG_8_, _ARG_9_, _ARG_10_)
  UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "title"), _ARG_0_)
  UIButtons.ChangeSizeX(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), UIButtons.GetStaticTextLength((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "title"))) + UIButtons.GetSize((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "BoxFrame_Title"))))
  UIButtons.ChangeSizeX(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "BoxFrame_Title"), UIButtons.GetStaticTextLength((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "title"))) + UIButtons.GetSize((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "BoxFrame_Title"))))
  UIButtons.ChangeSizeX(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "BoxInner_Title"), UIButtons.GetStaticTextLength((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "title"))) + UIButtons.GetSize((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "BoxFrame_Title"))))
  if _ARG_2_ == nil then
    UIButtons.SetActive(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "icon"), false)
  else
    if _ARG_3_ ~= nil then
      UIShape.ChangeSceneName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "icon"), _ARG_3_)
    end
    UIShape.ChangeObjectName(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "icon"), _ARG_2_)
  end
  if _ARG_8_ ~= nil then
    UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), _ARG_8_, true)
  end
  if _ARG_4_ ~= nil then
    UIButtons.ChangeLayer(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), _ARG_4_, true)
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "title"), _ARG_4_ + 1, true)
  end
  if _ARG_5_ ~= nil then
    UIButtons.ChangeJustification(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), _ARG_5_)
  end
  if _ARG_6_ == true then
    UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"))))
  end
  if _ARG_7_ ~= nil then
    UIButtons.SetAlphaIntensity(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "box_dummy"), _ARG_7_, nil)
  end
  if Amax.GetGameMode() ~= UIEnums.GameMode.SinglePlayer then
    UIButtons.SwapColour(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "Main_2", "Support_1")
    UIButtons.SwapColour(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), "Main_1", "Support_1")
  end
  if _ARG_10_ ~= nil then
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), _ARG_1_, _ARG_10_)
  else
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"), _ARG_1_, UIEnums.Justify.MiddleCentre)
  end
  return (UIButtons.CloneXtGadgetByName("SCUIBank", "ScreenTitle_Dummy"))
end
function SetupBottomHelpBar(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
  if IsNumber(_ARG_0_) == true then
    UIButtons.ChangeText(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_help_text"), _ARG_0_)
  end
  if IsNumber(_ARG_2_) then
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_mid"), _ARG_2_ - 1, true)
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_help_text"), _ARG_2_)
  end
  if IsNumber(_ARG_5_) == true then
    UIButtons.ChangeScale(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_mid"), 1, _ARG_5_)
  elseif IsNumber(_ARG_0_) == true and IsNumber(UIButtons.GetSize((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_help_text")))) == true then
    UIButtons.ChangeScale(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_mid"), 1, UIButtons.GetStaticTextHeight((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_help_text"))) / UIButtons.GetSize((UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_help_text"))))
  end
  if IsNumber(_ARG_4_) == true then
    UIButtons.SetAlphaIntensity(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_mid"), _ARG_4_, nil)
  end
  if Amax.GetGameMode() ~= UIEnums.GameMode.SinglePlayer then
    UIButtons.SwapColour(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "Main_2", "Support_1")
    UIButtons.SwapColour(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "Main_1", "Support_1")
  end
  if IsNumber(_ARG_1_) == true then
    UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), _ARG_1_, UIEnums.Justify.BottomCentre)
  end
  return UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"), "bottom_bar_help_text"), (UIButtons.CloneXtGadgetByName("SCUIBank", "bottom_bar_help_dummy"))
end
function BoolToNumber(_ARG_0_)
  if _ARG_0_ == true then
    return 1
  else
    return 0
  end
end
function NumberToBool(_ARG_0_)
  if _ARG_0_ == 1 then
    return true
  else
    return false
  end
end
function CreatePhotoPreviewPage(_ARG_0_)
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SpSCUI", "photo_preview_dummy"), _ARG_0_, UIEnums.Justify.MiddleCentre)
  return {
    node = UIButtons.CloneXtGadgetByName("SpSCUI", "photo_preview_dummy"),
    background = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "photo_preview_dummy"), "background"),
    bottom_text = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "photo_preview_dummy"), "bottom_bar_text"),
    top_text = UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SpSCUI", "photo_preview_dummy"), "top_bar_text")
  }
end
function CustomActionButtonPressed(_ARG_0_, _ARG_1_, _ARG_2_)
  UIGlobals.PendingFriendChallengeInfo.Pending = true
  UIGlobals.PendingFriendChallengeInfo.Pad = _ARG_0_
  UIGlobals.PendingFriendChallengeInfo.Action = _ARG_1_
  UIGlobals.PendingFriendChallengeInfo.FriendIndex = _ARG_2_
  UIGlobals.PendingFriendChallengeInfo.Act = true
end
function ActUponPendingFriendChallenge()
  if UIGlobals.ActUponFriendChallenges == false or UIGlobals.PendingFriendChallengeInfo.Pending ~= true then
    return
  end
  if Profile.GetPrimaryPad() ~= UIGlobals.PendingFriendChallengeInfo.Pad then
    SetupCustomPopup(UIEnums.CustomPopups.FriendDemandCustomAttemptPadError)
    UIGlobals.PendingFriendChallengeInfo = {}
  elseif UIGlobals.PendingFriendChallengeInfo.Act == true then
    UIGlobals.FriendDemandFilterFriend = UIGlobals.PendingFriendChallengeInfo.FriendIndex
    UIGlobals.FriendDemandAttemptFromMessage = true
    ForceCloseScreens()
    UIGlobals.PendingFriendChallengeInfo.Act = nil
  end
end
function EnterSpRaceBook(_ARG_0_)
  Amax.StartCreateStatsOnlyMatchingSession()
  UIGlobals.NetworkSessionStarted = false
  Amax.SetUICarToMultiplayer(false)
  Amax.SendMessage(UIEnums.GameFlowMessage.LoadSPProfileCar)
  if _ARG_0_ == true then
    GoScreen("SinglePlayer\\SpMain.lua")
    FriendDemand.RetrieveFromServer(true)
  end
  Amax.SetLoadStateIntoUI()
  LSP.GetLinkCode()
  Profile.FlushRemotePictures()
end
function SetupSelectionBox(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_, _ARG_6_, _ARG_7_, _ARG_8_)
  if _ARG_0_ == nil then
    return
  end
  _ARG_6_ = _ARG_6_ or UIEnums.Justify.MiddleCentre
  _ARG_5_ = _ARG_5_ or UIEnums.Justify.MiddleCentre
  text_parent_justify = _ARG_6_
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), _ARG_0_, _ARG_5_)
  if _ARG_4_ ~= nil then
    UIButtons.ChangeJustification(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), _ARG_4_)
  end
  UIButtons.SetParent(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")), UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), text_parent_justify)
  if _ARG_1_ ~= nil then
    UIButtons.ChangeText(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")), _ARG_1_)
  end
  if _ARG_6_ ~= nil then
    UIButtons.ChangeJustification(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")), _ARG_6_)
    if _ARG_6_ == UIEnums.Justify.TopLeft or _ARG_6_ == UIEnums.Justify.MiddleLeft or _ARG_6_ == UIEnums.Justify.BottomLeft then
    elseif _ARG_6_ == UIEnums.Justify.TopRight or _ARG_6_ == UIEnums.Justify.MiddleRight or _ARG_6_ == UIEnums.Justify.BottomRight then
    end
    if offset ~= 0 then
      UIButtons.ChangePosition(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")), UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")))) + -UIButtons.GetSize((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")))) * 0.8, UIButtons.GetPosition((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")))))
    end
  end
  if _ARG_2_ ~= nil then
    UIButtons.ChangeLayer(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), _ARG_2_, true)
    UIButtons.ChangeLayer(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), "selection_box_inner"), math.max(_ARG_2_ - 1, 0))
  end
  if _ARG_3_ ~= nil then
    UIButtons.ChangeLayer(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), _ARG_3_, true)
  end
  if _ARG_7_ == true then
    UIButtons.ChangeSize(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), UIButtons.GetSize(_ARG_0_))
    UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), "selection_box_inner"), UIButtons.GetSize(_ARG_0_))
    UIButtons.ChangeSize(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")), UIButtons.GetSize(_ARG_0_) - UIButtons.GetSize((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")))) * 0.8 * 2, UIButtons.GetSize((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")))))
  elseif UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")) ~= nil then
    UIButtons.ChangeSize(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), UIButtons.GetStaticTextLength((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")))) + 9, UIButtons.GetSize((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")))))
    UIButtons.ChangeSize(UIButtons.FindChildByName(UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), "selection_box_inner"), UIButtons.GetStaticTextLength((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")))) + 9, UIButtons.GetSize((UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")))))
  end
  return UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_no_highlight", "selection_box")), (UIButtons.CloneXtGadgetByName("SCUIBank", Select(_ARG_8_ == true, "selection_box_text_no_highlight", "selection_box_text")))
end
function GetResultColour(_ARG_0_)
  if IsString(_ARG_0_) == true then
    if _ARG_0_ == "gold" then
      return "Pos_First"
    elseif _ARG_0_ == "silver" then
      return "Pos_Second"
    elseif _ARG_0_ == "bronze" then
      return "Pos_Third"
    end
  elseif IsNumber(_ARG_0_) == true then
    if _ARG_0_ == 1 then
      return "Pos_First"
    elseif _ARG_0_ == 2 then
      return "Pos_Second"
    elseif _ARG_0_ == 3 then
      return "Pos_Third"
    end
  end
  return "Pos_None"
end
function DeferCam_Init(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if IsNumber(_ARG_1_) == false then
    _ARG_1_ = 0.1
  end
  if IsNumber(_ARG_2_) == false then
    _ARG_2_ = 0.3
  end
  if IsNumber(_ARG_3_) == false then
    _ARG_3_ = 0
  end
  GUI.camera = {
    type = _ARG_0_,
    timer = _ARG_1_,
    lerp_time = _ARG_2_,
    viewport = _ARG_3_
  }
end
function DeferCam_Update(_ARG_0_)
  if IsTable(GUI.camera) == false then
    return false
  end
  GUI.camera.timer = GUI.camera.timer - _ARG_0_
  if GUI.camera.timer <= 0 then
    if IsString(GUI.camera.type) == true then
      Amax.ChangeUiCamera(GUI.camera.type, GUI.camera.lerp_time, GUI.camera.viewport)
    elseif GUI.camera.type == UIEnums.ExtendedCameraType.IntoGarage then
      Amax.ChangeUiSplineCamera(GUI.camera.lerp_time, GUI.camera.viewport, nil, "_ShowRoomCamera", nil, nil, nil, 2)
    else
      print("Unknown camera type", GUI.camera.type)
    end
    GUI.camera = nil
    return true
  end
  return false
end
function UiPanelBloom(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if IsNumber(_ARG_0_) == false then
    return
  end
  if _ARG_2_ ~= false then
    _ARG_2_ = true
  end
  UIButtons.ChangePanel(_ARG_0_, Select(_ARG_1_, Select(_ARG_3_ == true, UIEnums.Panel._3DAA_LIGHT, UIEnums.Panel._3DAA_0), UIEnums.Panel._3D), _ARG_2_)
  UIButtons.SetAlphaIntensity(_ARG_0_, nil, Select(_ARG_1_, 0.4, 1))
end
function WorldPanelBloom(_ARG_0_, _ARG_1_, _ARG_2_)
  if IsNumber(_ARG_0_) == false then
    return
  end
  if _ARG_2_ ~= false then
    _ARG_2_ = true
  end
  UIButtons.ChangePanel(_ARG_0_, Select(_ARG_1_, UIEnums.Panel._3DAA_WORLD, UIEnums.Panel._3D_WORLD), _ARG_2_)
  UIButtons.SetAlphaIntensity(_ARG_0_, nil, Select(_ARG_1_, 0.4, 1))
end
function Presence_IsPlayingSplitscreen(_ARG_0_)
  return UIGlobals.ProfileState[_ARG_0_] == UIEnums.Profile.GamerProfile
end
function FadeUpLoading()
  if IsNumber(UIGlobals.FadeUpLoading) ~= true then
    return
  end
  if UIGlobals.FadeUpLoading == 0 then
    UIButtons.CloneXtGadgetByName("SCUIBank", "FadeUpLoading")
  elseif UIGlobals.FadeUpLoading == 1 then
    UIButtons.PrivateTimeLineActive(UIButtons.CloneXtGadgetByName("Loading\\LoadingUi.lua", "SpBgStuff"), "fade_bg", true)
    UIButtons.ChangePanel(UIButtons.CloneXtGadgetByName("Loading\\LoadingUi.lua", "SpBgStuff"), UIEnums.Panel._2D, true)
  else
    print("Invalid fade up mode", UIGlobals.FadeUpLoading)
  end
  UIGlobals.FadeUpLoading = nil
end
function ClearGlobals()
  if IsTable(_Globals) ~= true then
    return
  end
  print("[Clear]")
  for _FORV_3_, _FORV_4_ in pairs(_G) do
    if _Globals[_FORV_3_] == nil then
      _G[_FORV_3_] = nil
    end
  end
  print("[Done]")
  collectgarbage()
  print("[GC]")
end
function getMouseButton(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  return _ARG_2_
end
function LaunchPopupKeyboard(_ARG_0_, _ARG_1_)
  UIGlobals.KeyboardPopup.Title = _ARG_0_
  UIGlobals.KeyboardPopup.TextLimit = _ARG_1_
  SetupCustomPopup(UIEnums.CustomPopups.Keyboard)
end
SCREEN_WIDTH = 640
SCREEN_LEFT = 0
SCREEN_RIGHT = SCREEN_WIDTH
CalcScreenBounds()
ChangeResolution(Amax.GetScreenResolution())
