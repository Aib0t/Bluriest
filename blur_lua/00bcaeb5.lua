LuaQ                3   
  	���E  F@� F�� 	@��	���	�@�	���	�@�	���	�@�J   	@��	�@�J� I@D�I@D�I@ĉI@D�I@ĊI@D�I@ċ	@��	@F�   $   � $@  � $�    $�  @ $  � $@ � $�   $� @ $  � $@ � $�  	 $� @	  � &      GUI 	   finished     current_mode    UIEnums 
   PhotoMode    Camera 
   do_camera    do_effects    do_controls 	   do_photo 
   do_colour 	   can_save    inactive_slider_ids    colour_option_selected    values    brightness         	   contrast    saturation    hint_amount    shutter_angle    idepth 	   aperture    enable_render_in       �   Init 	   PostInit 
   StartLoop    MessageUpdate    FrameUpdate    Render    EndLoop    End    PhotoMode_UpdateMode    PhotoMode_GetValue    PhotoMode_UpdateFilters    PhotoMode_OnAutoFocus            U      m      @� @  �@ E�  F � F@� @ @  �A @� �  B B   @ @ E�  F�� F � 	@ �@ J ��� ��C��@ ƀ��� �� ŉ��Ŋ� Ƌ��ƌʀ ��F�A G� �� ŉ�@Ǌɀǋɀƌ
� 	�G�EA F�	A�	ŉ	AȊ	�ȋ	�ƌJ� I�H��A �II��IŉIAɊI�ɋI�Ɍ�A �J��A �A�����ŉ�AɊ��ȋ�A ɁJ�B �J���ŉ�AɊɁȋ
�  	K�EB FB�	B�b@�	@���  �K E�  F�� F � @  ��@ �L E� F � F@� �� @�� E@ F � �� � M�@N��  E�  F��F��� @� � =      AddSCUI_Elements    Amax    SendMessage    UIEnums    GameFlowMessage    Pause    StartPhotoCam    LSP    SetInPhotoUI    GUI    current_mode 
   PhotoMode    Camera    options    icon    Brightness    text    UIText    HUD_PHOTO_EFFECT_BRIGHTNESS    num       &@   min       п   max       �?   default       @	   Contrast    HUD_PHOTO_EFFECT_CONTRAST       �      �?   Saturation    HUD_PHOTO_EFFECT_SATURATION       �      �?   Shutter Angle    HUD_PHOTO_EFFECT_SHUTTER_ANGLE               $@       @	   Aperture    HUD_PHOTO_EFFECT_APERTURE    Hint_Amount    HUD_PHOTO_EFFECT_HINT_AMOUNT    Hint_Colour    HUD_PHOTO_EFFECT_HINT_COLOUR    CurrentPlatform 	   Platform    PS3    UIShape    ChangeObjectName    SCUI    name_to_id    controls_icon    ps3_controller_options    SetupScreenTitle    HUD_PHOTO_TITLE    screen_tile    photo    Panel    _2DAA                     W   �      �      @� @  E�  F�� T � �@   @� C�����EA F��F��W@�@�� �AB�� � ���@ � ��B��  E FB�F���A � ��C�A Ɓ���  �A���� �A� �A� ܁� BD@��� ��E FB�� ł  �������\B�E F����ł  ����Ƃ�\B�E�  F��FF��W ���E�  F��FF��@�� �AB  ��  ��@�� ��E�B  `��E F��� �C@� GB  \C�_��@�E�  FB���  �BG� �B@IE F��� \ �G@�� ��� �@ � � �C�E�  F��FF�W ���E FB�� ł  ������\B�E�  F��FI� �� @�  � $      PhotoMode_UpdateMode       �?   GUI    options    AddListNode    SCUI    name_to_id    icon 
   UIButtons    CloneXtGadgetByName    Ingame\PhotoMode.lua 
   SetParent    UIEnums    Justify    MiddleCentre    AddListItem    effects_node_list    FindChildByName    text    slider    UIShape    ChangeObjectName    ChangeText    num         @   AddItem    UIText    IDS_CMN_NOWT    inactive_slider_ids    GetPosition    ChangePosition    default    SetSelection 
   slider_id    PhotoMode_UpdateFilters                     �   �         �                         �   �     �   E  �  ��   @�� \� @�  � � E�  F��@�  � � E FA�F��@ ��E�  F��� �B�AB��@�E� \A� E�  � �B��BI���E \A� ��E�  F��� �B�AC����E FA�F��@ ��E�  F��� �B�AB��@�E� \A� E �A \A ��E�  F��� �B��D��@�E� \A� E�  � �B�ABI���E \A� @�E�  F��� �B��B��@�E� \A� E�  � �B�ABI���E \A�  �E�  F��� �B��D��@�E� \A� E�  � �B��BI���E \A� ��E�  F��� �B�AC�� �E� \A� E�  � �B�ABI���E \A� E FA�F�@ @�E�  F��� �B�AB����EA F��� ��E�F\A EA FA��  \A E� F��\A� E�  IAG�E�  � �B�ACI���E \A� ��E�  F��� �B�AC�� �E�  F��@� �E� \A� E� \A� ��E�  F��� �B��B�� �E�  F�@� �E� \A� E�  � �B��DI���E \A�  � !      SCUI_MessageUpdate    GUI 	   finished    UIEnums    Message    ButtonY    current_mode 
   PhotoMode    Camera    PlaySfxNext    Effects    PhotoMode_UpdateMode    Viewing 	   MenuBack    PlaySfxBack 	   GoScreen    InGame\Paused.lua    CamControls    EffectsColour 	   MenuNext 	   UISystem 
   PlaySound    SoundEffect    PhotoTaken    Render    Amax 
   TakePhoto    enable_render_in       �?	   can_save    StartAsyncSavePhotos    colour_option_selected                     �   �        E   \@� E@  \@� E�  F�� @ � �E�  F��  � � �E@ F�� � � \@ E�  ��  ��@��AI��� �       PhotoMode_UpdateMode    PhotoMode_UpdateFilters    GUI    enable_render_in         	   UISystem    Render       �?                    �   �          �                         �   �         �                         �   �            @@ @�  �       Amax    EndPhotoCam                     �   ?     �      	���   	���   	�@�   	���   	�@�   �A E  F@� F�� @  ��� E  F@� �  ��C�  ���@    	 Ā��   �A E  F@� F@� @   �� @�    	 D���   �A E  F@� F�� @  ��  @E E� F�� F � � @F  �E   I D�E� \@� � �E   I�@�E� \@� E   I ā��   �A E  F@� F � @   �� E  F�� @    	 Ă   	�@���   �A E  F@� F@� @   �   E� �  �@H��� � � \��W �   �B@  B � 	@ �   	�@�   �G  D ��� E  F�� �  ��C@�@ �� @�    	 D�  �H A 	 �   �@@@�  �H A@	 �   ��A@�  �H A�	 �   ��@@�  �H A�	 �   �@A@�    A  D ��  �H A 	 �   � 
 @   �H A@	 �   � 
 @   @J E� F�� F�� �   � A� � @   �J E� F�� F � �   �@A@�  �J E� F�� F � �   ��@@�@ E   F�� T � �@  �� AJE  F��F���  A����  L E   F�� Z@  @�E   F � Z@  @ �E   F@� @  � 1      GUI 
   do_camera     do_effects 	   do_photo 
   do_colour    do_controls    current_mode    UIEnums 
   PhotoMode    Camera    SetupInfoLine    UIText    INFO_PHOTO_TAKE_A    INFO_B_BACK    INFO_PHOTO_EFFECTS_Y    CamControls 
   SetupBack    Effects 
   UIButtons    GetSelection    SCUI    name_to_id    effects_node_list       @   colour_option_selected    SetupMenuOptions    EffectsColour    Viewing 	   can_save    CanSave    Profile    GetPrimaryPad    INFO_PHOTO_SAVE_A    TimeLineActive    reticule_on    controls_on    effects_on 
   colour_on {�G�z�?
   SetActive    photo_dummy    SetSelected    colour_picker       �?   inactive_slider_ids    Amax    LockPhotoCamControls                     A  D       E   F@� ��  ��@�  � A\� ��  ��@�  �@Aŀ  ���� �ƀ��  �@ AA� ��  �@ �AB� ��@��� �   � 	   
   UIButtons    GetSelection    GUI    options 
   slider_id    min    max    num       �?                    F  Q     4      @@ E�  �  \� 	@ �   @@ E�  �� \� 	@��   @@ E�  �  \� 	@��   @@ E�  �� \� 	@��   @@ E   F � F�� F@� 	@��   @@ E�  �� \� 	@ �   @@ E�  �@ \� 	@ �� �D E   F@� �  �@E��E@� �       GUI    values    brightness    PhotoMode_GetValue       �?	   contrast        @   saturation       @   shutter_angle       @   max_shutter_angle    options    max 	   aperture       @   hint_amount       @   Amax    SetPhotoFilters    SCUI    name_to_id    colour_picker                     T  ^           E@  F�� F�� @   A F@A F�� F�� �  �@B� � �� �B ��  ��� � A �@� �       ContextTable    UIEnums    Context    Main    GUI    options       @
   slider_id 
   UIButtons    GetSelection            SetSelection       @                            