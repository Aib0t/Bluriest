LuaQ                (   
  	���	 ��	 ��	 A�	 ��J   	@ �J   	@��J   	@ �J   	@��J   	@ �	���	�C�   $     $@  @ $�  � $�  � $    $@ @ $� � $� � $    $@ @  �       GUI 	   finished     node_list_id       �   node_list_friends_id    current_option_selection    current_friend_selection    friend_text_ids    friend_icon_ids    friend_list    friend_list_text_ids    box_ids    choosing_friend    num_friends_chosen            Init 	   PostInit 
   StartLoop    MessageUpdate    FrameUpdate 	   EnterEnd    EndLoop    End    FdAddFriends_SetupInfoLines    FdAddFriends_UpdateGamerpics 
                )      @� @  @� �  E  F@� �� �� \��	@��   B E�  F�� �@ ��B��B�  �@�ƀ�@ �  �C E@ F�� F � 	@ ��  �C E@ F�� F�� 	@���  �C E@ F�� F � 	@ � �       AddSCUI_Elements    SetupInfoLine    GUI 
   camera_id 
   UIButtons    CloneXtGadgetByName 	   SCUIBank    Cam_Carousel 
   SetParent    SCUI    name_to_id    CameraDolly    UIEnums    Justify    MiddleCentre    friend_list       �?
   UIGlobals    FriendDemandFriends        @      @                    !   s      &     @@ �@ E   F@� F�� �  �@ ƀ�   A� � ��B �B�BB� � �B ���B� EC F��F���@ �� �@ ������ ��� 	��� EA F���� ��  C��B ��B��B��  EC F�FC�� �C ƃ����A � EA F����� ��� �A��� �AE� ���� B� �� �� �A � �  �A��A������ �� � �A�� ��F� C ���� Ƃ�  A� ܂����� H@ � �C�  @ ���� �C�� @��C ��H� 	�D Ƅ�	��	� À� �CI��� ��I�C�� ��I� ƃ�  A
 ܃��Ã� �CJ�CW�J��� ��J� ƃ��C� E FD�FD�D�C�� �CK� ��  @��C ��� ��F� � ���� �A�� @ �B �L������ �A� F@ �� �A � �A�  �LE  F��F�B܁  BM@��� �B Ƃ�Ƃ�B  E FB��  ��L�  �������\� 	B�� BME F���� �B Ƃ�Ƃ�B � EB F��\�� ��  � �FA �� ��E F�� ��G� D ���I��EC F�����\� � ��J� ���Â @�D�C�� �CK� ���  @��C B� BLE  F���  ��L��OF��� E FB�� �� C �B�M\B A� �B ��N��� �� `��EC F����E\� � �P� ��� �B  �C _��E FB�� ��M�  \B�E� \B� E� \B�  � D      SCUI    name_to_id    screen    screen_friends    SetupScreenTitle    UIText    FDE_FRIEND_DEMAND    message    common_icons    UIEnums    Justify 
   TopCentre    Panel    _3DAA_LIGHT    SetupBottomHelpBar    FDE_HELP_CHOOSE_FRIENDS    GUI    bottom_bar_add_id    FDE_HELP_CHOOSE_FRIEND    bottom_bar_choose_id 
   UIButtons    PrivateTimeLineActive    Hide_BottomHelp       �?   node_list_id    node_list_options       @   CloneXtGadgetByName $   Ingame\AddFriendsToFriendDemand.lua    _friend_node    FindChildByName    _friend_dummy    GetSize    ChangeSize    SetupSelectionBox    FDE_FRIEND_SLOT_EMPTY    MiddleLeft    box_ids    friend_text_ids    friend_icon_ids    _friend_pic    friend_list     ChangeText    GAME_FRIEND_DEMAND_FRIEND_    AddListItem    _setup_node       @   FDE_CREATE_CHALLENGE 
   AddButton 	   elements    name_to_index    _friends_stencil_read_on 
   SetParent    MiddleCentre    node_list_friends_id    _node_list_friends    Amax    GetNumFriends    _friend_list_node    friend_list_text_ids    _friend_list_name    GetFriendsIDFromIndex    _friends_stencil_read_off    SetNodeItemLocked    SetSelected    FdAddFriends_SetupInfoLines    FdAddFriends_UpdateGamerpics                     u   w         �                         y       �  E  �  ��   @�� \� @�  � � E�  F��F�@ @�AA �� �A `A�E� F�IBBE� F��F�W@�@�E FB��� ��B�\� @�@�E� F��� ��B�I�_�E� �� \A E�  F�FA�@ �@�E� F�����(�E� F�@���E� F��FA�@�@�E� F��F��@� �E� F��F��W@���E� F��� ��B�AAI���E� F��� ��B��EI��E� F��� ��B��AI��E F��\A� E� � \A EA \A� @Z�E� ��  ��F�G\A �X�EA F��\�� ���� B�AB ���B ��  ܂ C �HE� F�����  � C�� �BCAW �@�� �B�EW � �� �B�A �@�C IE� FC��CAF����	 C�C �HE� F������ � C��AA��C IE� FC��CAF����	 C��A�Ł ��@�@
�����	��A �A�� �JA�
 �� �A �A �A�� KA�
 �  �A �A �A�� �HB� �A��A �A�� �KB  �A�Ł �A@��A ��� B� �A��A �A� �A �A� Ł �A� �=��� �A�  =�EA \A� E \A� EA FA��� ��H\� �� ��MŁ ���A��A � �NŁ ���A� ��A��� ��BŁ ����@B ��� Ł ���A������ ��BŁ ���A��A �AKŁ ���  �A��A �AKŁ Ɓ�� �A��A �ANŁ Ɓ�� E��� E� F���� �EF��B�A��A �AJŁ Ɓ��
 B  �A �A �AJŁ ���
 B� �A �� ��D��A ��K�   �A��A �A� � �A�  &�E�  F�FA�@ ��E� F��@�@	�EA FA��� ��H�  \A�EA FA��� ��K�� \A�EA FA��� ��J��
   \A EA FA��� �K��
 � \A E� I�D�EA F��� �  \A�EA \A� E \A� ��E� �� Ł  ������ \A  EA \A� ��E�  F�F��@ @
�E� F������E� F�W@���E F��� �E�AA�� \A�E� F���� �EIABEA FA��� ��NŁ ����� �A�\A�E� �� �J�AAI��EA \A� E \A� E� \A�  �E�  F�F��@ �
�E�  F����  �R�AR�� 	�E� F������E� F�W@���E� F���� �EF��W@�@�E F���� ��BŁ ����\A  �E� F��@� �EA FA��� ��H\� � ��R���A  � K      SCUI_MessageUpdate    UIEnums    MiscMessage    FriendsUpdated       �?      @
   UIGlobals    FriendDemandFriends     GUI    friend_list    FriendDemand 	   IsFriend 	   GoScreen $   Ingame\AddFriendsToFriendDemand.lua    Message 	   MenuNext    choosing_friend     current_option_selection       @       @   Create !   Ingame\AddTextToFriendDemand.lua    PlaySfxNext    SetupCustomPopup    CustomPopups    FriendDemandNoFriendsChosen    Amax    GetNumFriends            GetFriendsIDFromIndex 
   UIButtons    SetNodeItemLocked    node_list_friends_id    ChangeColour    friend_list_text_ids    Main_Black    Main_White    num_friends_chosen    PrivateTimeLineActive    bottom_bar_add_id    Hide_BottomHelp    bottom_bar_choose_id    SetSelected    node_list_id    TimeLineActive    stage1    FdAddFriends_SetupInfoLines    PlaySfxGraphicNext    PlaySfxError    PlaySfxGraphicBack    GetSelection    Profile    ClearRemotePictureByRef 
   AddFriend    ChangeText    friend_text_ids    GAME_FRIEND_DEMAND_FRIEND_    FdAddFriends_UpdateGamerpics 	   MenuBack    GetStoredScreen    ScreenStorage    FE_FRIEND_DEMAND    PlaySfxBack    ButtonX       �   UIText    FDE_FRIEND_SLOT_EMPTY    ButtonY    CurrentPlatform 	   Platform    Xenon    ShowFriendGamerCard                       '    h   E   F@� ��  ��@\� ��  � AW��  ���  � AW@A@��   ��Aŀ  ����  A� � B  �@ ��  �@ ��   ��Aŀ  ����  A� � B� �A �@��� �@� �   ��Bŀ  � ��� ŀ  �@�W� ���   ƀ�� �CDAA @B  ��A  �� �@ �   ƀ�� �CDA� ��  �ACX�  ��A  �� �A �@��   ƀ�� �C�DAA � �AE��� ��E�  ��A  �� �@ �   ƀ�� �C�DA� ��  �ACX�   ��A  �� �A �@�ŀ  ɀ�� �    
   UIButtons    GetSelection    GUI    node_list_id    current_option_selection       �   PrivateTimeLineActive    box_ids    flash            FdAddFriends_SetupInfoLines    GetSelectionIndex    node_list_friends_id    current_friend_selection    SCUI    name_to_id 
   arrow_top    more    push    arrow_bottom    Amax    GetNumFriends       �?                    )  +         �                         -  /        �                         1  3         �                         5  b     	�      @@ �@ ��   �@  A @A @�   �@ �A @A  �   �@ �A W@A ��  E@ F�� �@ ��B@� �  E@ F�� @ ��    C @C  �  E@ F�� �@ ��B��  ADE F��F��W@  �A  � EA F�� �  @  ��   �@ E   F@� @  W@A ��@ �E �� A  �� �  `@�E  F��F�W@�  � A _ � ����E  �@ � F�@ ���A AFE� � �AD� Ɓ����W�  ��A  �� �A �� \ \@   �E  �@ ��B�@ �@�� E FA�� ��D��DW��  �BA  B� �A �E�� \@  ��@ �E �� A� �  ��  �@��  ��@�AW@A  �L � � � � ���  �@ ƀ�A �B�@�� ��  �@ ����@  �       GUI    current_option_selection       @   friend_list       �?        @      @   SetupInfoLine    UIText    INFO_A_CONTINUE    INFO_B_BACK    choosing_friend    INFO_A_ADD_FRIEND    Select    UIEnums    CurrentPlatform 	   Platform    Xenon    INFO_Y_VIEW_GAMER_CARD    Amax    GetNumFriends            INFO_A_CHANGE_FRIEND    INFO_REMOVE_FRIEND                     d  n     
'      @@ �� E�  ��  � A\ ����  �AA�W�A����A�� W�A��� �AB�A  � M�AFB B��� @��A ��� �AB�A  �C�� @��A a�  @� �       Profile    GetRemoteGamerPictureMap    ipairs    GUI    friend_icon_ids    friend_list        �?
   UIButtons    ChangeTexture 	   filename    REMOTE_GAMERPIC_    default_gamerpic                             