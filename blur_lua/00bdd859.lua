LuaQ                   
  	���	���	@A�	�A�   $     $@  @ $�  � $�  � $    $@ @ $� � $� � $    $@ @  �       GUI 	   finished  
   can_leave 
   countdown       @   scoreboard_writetime            Init 	   PostInit 
   StartLoop    MessageUpdate    FrameUpdate    Render    EndLoop    End    Awards_SetupAward    EnableLeave 
          2      i      @� @  �@ A�  �  @�@ �A A� �  @�@ E� F � F@� 	@ �@ E� F � \�� 	@ �@ E� F�� \�� 	@���  E @� @ E@ F@� T � M�� O�� N@  R � �@ �  �� �@ �@�� �	���   @�܁�B  G@��� � � B�L � B  BG@��� ��EB  FB����� \���B�H�B  �B� �A� ��������B �B  �B� �A� ���������B ��  @��� ��H��� � 	 �@�ƀ�W�  ���	 �   �@ �� � J�@� �@
 ��
 �@  � +      AddSCUI_Elements 
   UIButtons    CloneXtGadgetByName %   Multiplayer\Ingame\MpRaceResults.lua 
   MpBgStuff 	   UIScreen    SetScreenTimers         333333�?   GUI    timeout_id    SCUI    name_to_id 
   countdown    GamerPictures    Profile    GetRemoteGamerPictureMap    race_awards    Multiplayer    GetRaceAwards    PostFlaggedDataEvents      �A@      �?       @   y       �   ipairs    Awards_SetupAward    ChangePosition 	   GetXtVar    time_lines.0.time.end    time_lines.0.time.start 333333�?	   SetXtVar    Amax    GetGameMode    UIEnums 	   GameMode    SplitScreen    net_EnableGlobalUpdate    StartScoreboardWrite    print    Writing to scoreboard                     4   <            @@ E�  F�� F � �   @�@ �� �A ��   @@ E�  F�� F�� �   @�� �  E@ F�� @  �    
   UIButtons 
   SetActive    SCUI    name_to_id    award_node    IsSplitScreen 
   countdown    SetupInfoLine    UIText    INFO_QUIT_RACE                     ?   A         �                         C   O        E  �  ��   @�� \� @�  � � E�  F��@�  � � E FA�F��@  �E� \��  � �EA � ��B��B\A  �       SCUI_MessageUpdate    GUI 	   finished    UIEnums    Message 	   MenuBack    IsSplitScreen     SetupCustomPopup    CustomPopups 	   ExitRace                     Q   �     �   E   F@� ��   � � E�  \�� �� ��E   �   � A�  I� �E   F � @� ��E   I@A�E� \@� E� �  \@ E@ F�� \�� �� � C�@CW�� ��E   F�� �� @�E   �   � D�  I� �E@ F@� \�� W�� � �E   F � @ �@�E� �  �   � �\@�E@ \@� @�E� F�� \�� ��  �E  F@� �   � A\� �   �   � �� ��� ��  �@F�   � ��� W@ ����� ��F���� � �� AG�G�@ ���G@��� � �� AGH�@ �   � �@� ��   �@A��@ ܀� ����ŀ �@� ��  �@ ŀ �@� �� � �  AIA�	 � �AF�  ���� U���@� � '      GUI 	   finished    IsSplitScreen 
   countdown            StopIngameMusic 	   GoScreen    Loading\LoadingUI.lua    Amax    GetGameMode    UIEnums 	   GameMode    SplitScreen 
   can_leave     scoreboard_writetime    ScoreboardWriteComplete       .@   print #   Scoreboard write finished. Time :     EnableLeave    NetRace    CanStartResultsCountdown    math    ceil       @	   UISystem 
   PlaySound    SoundEffect    CountDown03       $@
   CountDown    net_Disconnecting    StartAsyncSave 
   UIButtons    ChangeText    timeout_id    MPL_RETURN_TO_LOBBY                     �   �          �                         �   �         �                         �   �            @@ @�  �    	   UIScreen    CancelPopup                     �   �     �   �   �@@��  �  ����   � �  AA ܀�  A@ �� ��E  F�� �� \���  �A�  ����  ��  AB ܁�  A@ �� ��E  F�� �� \���  �A�  ����  ��  AC ܂�  A@ �� ��E  F�����CA \C�E  F��� �D \C�E  F��� �C  � ��\C�E  F������  � ��\C�F�D  � �E  FC�� �� \C�E� F�����F \C�EC \��  ���E� ����F \C�E  F����C ƃ�����F ��\C�E  F�� �C ƃ�����F ��\C�E  F����C ƃ�����F ��\C�E  F����C ƃ�����F ��\C�E  FC�� �  � \C E  FC�� �  \C�@�FH  ���E� ���C ƃ��� \C  E  F����� \C�E  F�� �� \C�E  F����� \C�E  F����� \C�E  F�� �� \C���E	 ���C	 ƃ��I ��\C�E  F��� �
  � ��\C�EC
 ���C �J \C P��  �@�E  FC��  �A� � ������ \C �   � 0   
   UIButtons    CloneXtGadgetByName $   Multiplayer\Ingame\MpRaceAwards.lua    award_node    FindChildByName    name    desc    icon    amount 	   gamertag    frame 	   gamerpic    rank 
   rank_icon    tied_notification    ChangeText    description    MPL_AWARDS_AMOUNT    MPL_AWARDS_OWNER    tied 
   SetActive    UIShape    ChangeObjectName 
   icon_name    IsSplitScreen    LocalGamerPicture 
   pad_index    ChangeColour 
   UIGlobals    Splitscreen    colours    local_player    Profile    GetPrimaryPad 
   Support_4    RemoteGamerPicture    GUI    GamerPictures 	   join_ref    MPL_AWARDS_RANK    Mp_RankIcon    legend        @      �?   SetAlphaIntensity    backing �������?                    �   �            @@ �@ ���   A @� @ B � @    	��� �       GUI 
   can_leave     NetRace    EnterResultsIdle    net_EnableGlobalUpdate                             