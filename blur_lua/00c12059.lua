LuaQ                    
� 	���	 ��	���	���	@B�d   	@ �   $@  � $�    $�  @ $  � $@ � $�   $� @ $  � $@ � $�   $� @  �       GUI 	   finished     carousel_branch    Options 
   selection       �   initial_selection    bottom_bar_text_id     CanExit    Init 	   PostInit 
   StartLoop    MessageUpdate    UpdateControllerButtons    FrameUpdate    Render 	   EnterEnd    EndLoop    End    GoBack        
           B   ^   �                            )      
k      @� @  E�  F � F@� 	@ �@  E� F � \�� 	@ �@ E@  F�� � �B ��� E@  F��  ��E FA��A  ��@���CB  \A�!�  @�� @�   E@ F�� �@ ��D@�  @E E  F�� F�� @   �  E@ F@� ��  � A��F�� @ ��  E@ F@� ��  � A��F�  @ @  E� F�� F � 	@��@  E@  �� �@  ƀ�� �GHI� �ƀ��� I� �	���  @I E�  F � F�� �@  ��H�  ���� �@   @I E�  F � F@� �@  ��H�  ���� �@  � *      AddSCUI_Elements    GUI 
   OptionsId    SCUI    name_to_id    OptionsList    configs_table    Amax    GetControllerConfigs    IsTable    ipairs 
   UIButtons    AddItem    name    StoreInfoLine    SetupInfoLine    UIText    INFO_A_CONFIRM    INFO_B_CANCEL    UIEnums    CurrentPlatform 	   Platform    PS3    SetupScreenTitle    CMN_CONTROLS_TITLE    Dummy    ps3_controller_options    controller_options    initial_selection 
   UIGlobals    OptionsTable    ctrl_index    bottom_bar_text_id    bottom_bar_root_id    SetupBottomHelpBar       �?
   SetParent    arrow_left    Justify    MiddleCentre    arrow_right                     +   U      �      @@ �@ E�  F � ��  �@A��A�� ��E� �  \@ E   F@� @� ��E�  F � ��  �@A��BW�� ��E�  F � ��  �@A��B�� @�E� �  \@ E   F@� �� E@ F�� �   � � \@�E� �  �@ �@�   A� ܀�A AD@  �� ��EA FA��  � \���A �AD�  B ����A �A�   A� ܁�B BD@  �� ��EB FB��  � \���B �BD�  C ����B �B�   A� ���@  I� �E� �  �@ �@�   A ܀�A AD@  �A ��EA FA��  �� \���A �AD�  � ����A �A�   A ܁�B BD@  �B ��EB FB��  �� \���B �BD�  � ����B �B�   A	 ���@  I���E@ F@� �� ��I��	 � ��@�̀�\@�E�
 \@�  � ,      SCUI    name_to_id    Bra_360    UIEnums    CurrentPlatform 	   Platform    PS3    print    Ps3    Bra_Ps3    Xenon    PC    360 
   UIButtons 
   SetActive    GUI    text_table    FindChildByName    Txt_AButton    Txt_BButton    Txt_XButton    Txt_YButton    Txt_LTrigger    Txt_RTrigger    Txt_LBumper    Txt_RBumper    Txt_RStickButton    parent_line_table    Gfx_LineA_AButton    Gfx_LineA_BButton    Gfx_LineA_XButton    Gfx_LineA_YButton    Gfx_LineA_LTrigger    Gfx_LineA_RTrigger    Gfx_LineA_LBumper    Gfx_LineA_RBumper    Gfx_LineA_RStick    SetSelection 
   OptionsId 
   UIGlobals    OptionsTable    ctrl_index       �?   UpdateControllerButtons                     W   Y         �                         [   {     Y   E  �  ��   @�� \� @�  � � E�  F��F�@  �E�  FA�F��@��E�  F��F�@�� �EA �� \A E�  F��F��@ @�@@��E� \A� E FA��� ��C\� M��A ��D��DW@��� �AE�A Ɓ���� ��A��A ��D�A���A �A@��� � �A E�  F��FA�@ ��@@@�E� F��� �ACŁ ����� �D��� �EA \A�  �E� ��  �AA��A\A  �       SCUI_MessageUpdate    UIEnums    Message 
   PopupNext    CustomPopups    DiscardOptionsChanges    PopupOptions    Yes    GoBack 	   MenuNext    PlaySfxNext 
   UIButtons    GetSelection    GUI 
   OptionsId       �?
   UIGlobals    OptionsTable    ctrl_index    Amax #   GameDataLogControllerLayoutChanged    SaveOptions 	   GoScreen    Shared\Options.lua 	   MenuBack    initial_selection    SetupCustomPopup                     }   �      �      @@ E�  F�� � E�  F �  �   � � E@ ��  ��A\� ��   � � E@ ��  ��A�  \� ��   � � E   F � ��  �@Bŀ  ƀ�� �ƀ�\@��B @�E   F � �@ �   \@�@��C @�E   F � �� �   \@�@�E   F � �@ � � \@�E   F � �� � � \@�E�  F �  � ��E�  F � W � ��E   F � �@ � � � \@ @�E   F � �� � � � \@ E�  F�� F � � �� � A� F�� ��� �� B� F�� ��� �� �@��@ �  �G�  	�W��� ���G@�  H@��  B�  HE�  FB�F���  �� B @�  H@��� B�  HE�  FB�F���� �� B   B@���B��   �ŀ  �  � � "   
   UIButtons    GetSelection    GUI 
   OptionsId 
   selection    IsTable    configs_table     ChangeText    bottom_bar_text_id    name       �?   TimeLineActive 
   left_fade       @   right_fade       �   move_right         
   move_left 	   ButtonsA 	   ButtonsB 	   ButtonsX 	   ButtonsY 
   ButtonsLT 
   ButtonsRT 
   ButtonsLB 
   ButtonsRB    ButtonsRThumb    ipairs    text_table     ���@
   SetActive    parent_line_table                     �   �        E   \@�  �       UpdateControllerButtons                     �   �          �                         �   �            @�  �       RestoreInfoLine                     �   �         �                         �   �          �                         �   �        W @ @ �E@  \@� E�  ��  \@  �       PlaySfxBack 	   GoScreen    Shared\Options.lua                             