LuaQ                "   
� 	���J   	@��	@A�	�A�	@B�	�B�	@C�	�C�	�C�	���   $   � $@  � $�    $�  @ $  � $@ � $�   $� @ $  � $@ �  �       GUI 	   finished     PlayerGadgets 
   countdown       @   SelectedSlot       �   PlayerColour 
   Support_4    FailedColour 
   Support_3    TimeoutColour 
   Support_2    OtherColour 
   Support_1    WinnerColour    SetupResults    Init 
   StartLoop 	   PostInit    MessageUpdate    FrameUpdate    MpRaceResults_RefreshInfoLines    RefreshList    Render    EndLoop    End 
          >      
i      @� @  E�  F � F@� 	@ �@  E� F � \�� 	@ �@  	�@  E� F � \�� F@� 	@��@  E� F � \�� 	@ �
�  	�Ĉ	 ŉA@ �@ �@  ���A ����A  �AEŁ ��� FB  ܁������ �AF�A  Ɓ�B  BEB@��A @� @ �A�   �A@ �� ��FŁ ���B  BEBA ܁�B @�B�A������ ��G�� � �� � ��  W@H���� ��H�� � �� � ��  @H ��� � 	 �@��@ � ��� � 	 �@��@ ��	 ��I� 
 �@�ƀ��@ ��
 ��A�@H� � -      AddSCUI_Elements    GUI    PlayersMenu    SCUI    name_to_id    players_list    Results    Multiplayer    GetRaceResults    num_finished            num_racers    VehiclesFinished    num_players    GamerPictures    Profile    GetRemoteGamerPictureMap       �?   player_left        @   player_right    PlayerGadgets 
   UIButtons    CloneXtGadgetByName %   Multiplayer\Ingame\MpRaceResults.lua    AddListItem    ChangeText    FindChildByName 	   position 
   GAME_POS_    NetServices    CanViewGamerCard    GetPrimaryPad    CanSubmitPlayerReview    SetupInfoLine    UIText    INFO_QUIT_RACE 	   UISystem 
   PlaySound    UIEnums    SoundEffect    Toggle 
   UIGlobals    ViewingResults                     @   B         �                         D   N            @@ E�  F�� F � �   � � @    @@ E�  F�� F@� �   � � @ � @� � @�  �    
   UIButtons 
   SetActive    SCUI    name_to_id    player_left    player_right    RefreshList    MpRaceResults_RefreshInfoLines                     P   f     G   E  �  ��   @�� \� @�  � � E�  F��@�  � � E FA�F��@ �	�E� F���  �AB\� L��� ��B� ���A�� 	���  ��C��C�A�D@D@��� ��DŁ  Ɓ����� BE�  FB�� �B���A������ � ������A @�E FA�FA�@  �E� � ��E��F\A  �       SCUI_MessageUpdate    GUI 	   finished    UIEnums    Message 	   MenuNext 
   UIButtons    GetSelectionIndex    PlayersMenu       �?   CurrentPlatform 	   Platform    Xenon    Results 
   standings 
   ai_driver  
   UIGlobals    Multiplayer    SelectPlayerJoinRef 	   join_ref    SetupCustomPopup    CustomPopups    ViewPlayer 	   MenuBack 	   ExitRace                     h   |     #   E   F@� ��   � � E   �   ��@�  I���E   F��  � @�E@ \�� �� @�E   I ��E� F � \�� �� � �E@ �� \@ � �E@ �� \@ E  \@�  �       GUI 	   finished 
   countdown            net_Disconnecting     Amax    IsGameModeRanked 	   GoScreen %   Multiplayer\Ingame\MpProgression.lua $   Multiplayer\Ingame\MpRaceAwards.lua    MpRaceResults_RefreshInfoLines                     ~   �            @@ E�  F�� �  A E�  F@� F�� F � F�� ��  ��AW@ �� �  ��@ ŀ ����@ � ��@ ŀ ����@  �    
   UIButtons    GetSelectionIndex    GUI    PlayersMenu       �?   Results 
   standings 
   ai_driver    SetupInfoLine    UIText    INFO_QUIT_RACE                     �   �      �      E�  F�� \�� 	@��  E   F@� F@�   ,�F�A��@+�E FA��  ��B�� �� \��� �AB�  Ɓ���� ���� �A�  �B� AB ܁� BBE  F��F�� ��E FB��  ��B�� �� \��� �BB�  Ƃ�� ���� �B�  �B� AC ܂� CBE  F��FÀ�� ��E F����� D���\C�E F������ D���\C�E F������ D���\C�E � ��CDF\C E F��� �� � \C E F����  �C�\C�E F�� �  �C�\C�E F�� �� \C�E F����� \C�FH@���E F����  ƃ�\C� �F�H��@�E F����  ��\C�FCI@� �E�	 ����I\C� 	�E  FC�F�@� �E F����  �C�\C�E F�� �  �C�\C�E F�� �  �C�\C�E�
 ����
 ���� \C  ��EC ���  ƃ��K��\C�!�   � � 0      GUI    Results    Multiplayer    GetRaceResults    ipairs 
   standings    racing  
   UIButtons    FindChildByName    PlayerGadgets 	   gamertag 	   gamerpic    gamerpic_image    frame    rank 
   rank_icon    result 	   position    ChangeText    MPL_RESULT_NAME       �?   MPL_RESULT_RANK    MPL_RESULT_RESULT    Mp_RankIcon    legend    PrivateTimeLineActive    fly_in    ChangeColour    OtherColour 
   Support_2    Main_White    timeout    TimeoutColour 	   finished    FailedColour 
   ai_driver    AIGamerPicture    ai_avatar_id    player_index    PlayerColour    LocalGamerPicture    Profile    GetPrimaryPad    RemoteGamerPicture    GamerPictures 	   join_ref                     �   �          �                         �   �         �                         �   �            @@ A�  ��  @�   �@ @�   @A 	�A� �    	   UIScreen    SetScreenTimers            CancelPopup 
   UIGlobals    Multiplayer    ViewingResults                              