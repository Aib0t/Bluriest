LuaQ                �      @@ A�  @ 
  	@A�	�A�	�A�E� F�� � � \� 	@���  @ �C �     d   	@��@ �C �     d@  	@��  d�  	@��@ �C � � � d�  	@��@ �C � � � d  	@��@ �C �     d@ 	@��@ �C � @ @ d� 	@��@ �C � � � d� 	@��
 �J ��  �  �@�� b@�� ��   �FA �@�� �� E FA��� �@�
�E� � ��G� "A�J�� � �A�� bA����A  �HA	 �A���� E FB���	 �A�"@�� @ �	 @
  
 $  �
 $@ �
 $�   $� @ $  � $@ � $�   $� @ $  � $@ � $�    � 5   	   UISystem    LoadLuaScript     Screens\Debug\DebugItemBase.lua    GUI 	   stringNo         	   finished     leaving_debug_menu    city_table 	   GameData 
   GetCities    CitySelectGadget 
   DebugItem    New    AddData    RouteSelectGadget    Update    LapSelectGadget    EnvironmentSelectGadget    PartyModeGadget    ViewPortSelectGadget     SplitscreenRaceModeSelectGadget 
   DebugMenu    UIText 	   CMN_CITY    City 
   CMN_ROUTE    Route 	   CMN_LAPS    Laps    CMN_ENVIRONMENT_OVERIDE    Environment    CMN_PARTY_MODE 
   PartyMode    CMN_VIEWPORTS 
   Viewports    CMN_SPLIT_SCREEN_RACEMODE    SplitScreenRaceMode    NumberOfItems    CurrentItemSelected       �?   Init 	   PostInit 
   StartLoop    MessageUpdate    LaunchGame    FrameUpdate    Render    EndLoop    End 	   MoveMenu    SetupRaceTable                   E   F@� ��@ \@ E�  �  �@A\ ���  ��AƁ@ ��F��  �A�a�  �� � 	   
   UIButtons    ClearItems    ID    ipairs    GUI    city_table    AddItem    id    name                        )     6   E@  F�� ��  � A� A�@A�  \�  G   E� F�� �   \� �  ���@  ��B� C �@ �@ � � � ���A  Ɓ� BBF�C�A��A  ��C FBD� �BB�� �A��  BBA�����  ���@  ��@��  ���� ��@��  ��  ��  �       CurrentCity 
   UIButtons    GetSelection 
   DebugMenu       �?   GetID 	   GameData 
   GetRoutes    GUI 	   stringNo            ClearItems    ID    ipairs    StoreString 
   debug_tag    AddItem    id    CurrentRoute        @                    +   7     0   E   �@  ��@��  � �� ��@��  ��  W��  �K�A \@ E� �  �@   E� �� \@ E� �@  ��@��  � �� ��@��  ��  W�� ��E@  F�� ��  � C� A�@A�  \�  G� E� �  �@   E� �� \@  �       CurrentCity 
   UIButtons    GetSelection 
   DebugMenu       �?   GetID    AddData    UpdateRouteShapes 
   Shp_Route       @   CurrentRoute    Shp_StartLine        @                    ;   V     �   E   F@� ��@ \@ E   F�� ��@ �  A �AB  \@�E   F�� ��@ �� A BB  \@�E   F�� ��@ �@ A �BB  \@�E   F�� ��@ �� A CB  \@�E   F�� ��@ �@ A �CB  \@�E   F�� ��@ �� A DB  \@�E   F�� ��@ �@ A �DB  \@�E   F�� ��@ �� A EB  \@�E   F�� ��@ �@ A �EB  \@�E   F�� ��@ �� A FB  \@�E   F�� ��@ �@ A �FB  \@�E   F�� ��@ �� A GB  \@�E   F�� ��@ �@ A �GB  \@�E   F�� ��@ �� A HB  \@�E   F�� ��@ �@ A �HB  \@�E   F�� ��@ �� A IB  \@�E   F�� ��@ �@	 A �IB  \@�E   F�� ��@ ��	 A JB  \@�E   F�� ��@ �@
 A �JB  \@�E   F�� ��@ ��
 A KB  \@�E   F�� ��@ �@ A �KB  \@� � /   
   UIButtons    ClearItems    ID    AddItem            UIText 	   CMN_NONE       �?   CMN_1        @   CMN_2       @   CMN_3       @   CMN_4       @   CMN_5       @   CMN_6       @   CMN_7        @   CMN_8       "@   CMN_9       $@   CMN_10       &@   CMN_11       (@   CMN_12       *@   CMN_13       ,@   CMN_14       .@   CMN_15       0@   CMN_16       1@   CMN_17       2@   CMN_18       3@   CMN_19       4@   CMN_20                     Y   a        E   F@� ��@ \@ E   F�� ��@ �  A �AB  \@�E� �  �@B\ ���  ��@Ɓ@ ��F���  �A�a�  �� �    
   UIButtons    ClearItems    ID    AddItem            UIText    CMN_NO    ipairs    GUI    city_table    id    name                     d   j        E   F@� ��@ \@ E   F�� ��@ �  A �AB  \@�E   F�� ��@ �� A BB  \@� � 	   
   UIButtons    ClearItems    ID    AddItem            UIText    CMN_NO       �?   CMN_YES                     m   v     %   E   F@� ��@ \@ E   F�� ��@ �  A �AB  \@�E   F�� ��@ �� A BB  \@�E   F�� ��@ �@ A �BB  \@�E   F�� ��@ �� A CB  \@� �    
   UIButtons    ClearItems    ID    AddItem       �?   UIText    CMN_1        @   CMN_2       @   CMN_3       @   CMN_4                     y   �        E   F@� ��@ \@ E�  F � \�� �@ � � � ���  Ɓ��@ F�A�B�  �A���  �� � 	   
   UIButtons    ClearItems    ID 	   GameData    GetSplitScreenEvents    ipairs    AddItem    id    name                     �   �      1      @� @  	�@�@  	@A�� 	 @ E� �� \ @����AC��AB �  �����    ���D�A �A �C�A a�  ��E� F�� \�� �� �� � ���C���A �C��@� �A���  ���@ �  �@  �       AddSCUI_Elements 
   UIGlobals    LoadFromDebug    Sp     GUI 	   stringNo               H@   ipairs 
   DebugMenu       �?
   AddButton        @      @   AddData    NumberOfItems    Amax    GetLevelData    SetSelection 	   MoveMenu                     �   �            A@  ��  ��   AA @  �       UpdateRouteShapes 
   Shp_Route       @   CurrentCity    CurrentRoute    Shp_StartLine                     �   �         �                         �       	�   �      @� � ܀ @�  � � ŀ  ���@�  � � ŀ  � �@����@ ƀ�����  @�ŀ  � B��@ � �@   � � �@ ���� ��   �@@��ŀ  �@@��@ ƀ�A �CD�@ �@ �@�  �@ �@ ƀ�  �@ �@ ���A �AE�@ @��@ ����@��   �@@� �ŀ �@� ���@ �������  @�@@� ��@  �@  ��@ ����@��  ��ŀ ���
 JA  I�ǎ�A  ��ǎ�A  �Ȏ
B  	BȎ"A � �ŀ �@� �� A IAI�@ ŀ	 �	 �@ ���@ ���� ��  @�@@� ��@ A
 �@  ��@ ���ƀ��  ��@@@���
 �@� �@  �@ ���@ ����@��  @�@@� �ŀ � �@  	��@ ���� ��  @�@@� �ŀ � �@ @��@ ����@�W�   ��@ ���ƀ��  ��@@@��� �����  �@�� E� L��A�G�M� A� �@� � 8      SCUI_MessageUpdate    GUI 	   finished    leaving_debug_menu    UIEnums    GameFlowMessage    StartGameRendering  	   GoScreen    Intro\StartScreen.lua    Message 	   MenuBack    Amax    SetGameMode 	   GameMode    Nothing    SetDebugEvent    SetUICarToMultiplayer    SendMessage    LoadUIScene 	   MenuNext    LaunchGame    ButtonLeftShoulder    Debug\DebugUI.lua    AutomationLoadGame 
   UIGlobals    Splitscreen    players    pad               �?       @      @   Splitscreen_ClearMessages    StoreScreen    ScreenStorage 
   FE_RETURN    GoLoadingScreen    Loading\LoadingGame.lua    ButtonLeftTrigger    Debug\DebugEventScreen.lua    ButtonRightTrigger    SetupRaceTable    Debug\DebugCarScreen.lua 	   ButtonUp 	   MoveMenu       �   ButtonDown    ButtonLeft    ButtonRight    CurrentItemSelected 
   UIButtons    SetSelectionByIndex 
   DebugMenu    GetID                                  E@  F�� F�� @   @� @ �A E� F � @ @ A� @  �       StoreScreen    UIEnums    ScreenStorage 
   FE_RETURN    SetupRaceTable    Amax    LoadTextureClone    GUI    route_texture_name    GoLoadingScreen    Loading\LoadingGame.lua                       Z    �   E   �@  \ � ������@�A a�  ��E  F@� ��   � � E  F��  � @ �E@ F�� �� ��B� C�� ��E@ �� \@ E� F � �@ � � \@�E� F�� �@ \@ E� F�� �@ \@ E  F@� \@� E� F�� �   \@ E� F�� �   \@ E� F � �   \@ E@ F�� �� ��F� G\@ E@ F@� �� ��G��G\@ E  F@� �� � � \@�E  F@� �� �   \@�E 	 F@� ��	 ��	 \@�E 
 �� �@J��J\@ E@ I���E@ I�A�J� I���I�K�I@L�I�L�I@M�I�M��@ � N�I@ �I@N����@ � N�@@ �I�N�@��@ � N�N@ �I�M�� ��@ � N�K���@ �@ � �̀��� ��@ � N���@ ��@ ��I��@ � O�@ �@ �� � � �@ �@ �@���@ � P� � �@ �@ �� �@  � C      ipairs 
   DebugMenu       �?   Update    GUI    leaving_debug_menu 	   finished  
   UIGlobals    LaunchMode    UIEnums    Automation    print    GOGO Automation    Profile    Setup    arg1 
   LockToPad    SetPrimaryPad    GameProfile    InitPrimary    AllowProfileChanges    ActOnProfileChanges    AllowAllPadInput    Amax    SendMessage    GameFlowMessage    EnteredDebugMenu    SetGameMode 	   GameMode    SinglePlayer 
   UIButtons    TimeLineActive    exit    start_fade 	   UIScreen    SetScreenTimers         ffffff�?   StoreScreen    ScreenStorage 
   FE_RETURN    AlreadySetupRace    LoadFromDebug    Difficulty    PickupSlots       @   HealthSlots       @   Vehicle      �TA   ShieldSlots       @   EventID    ��QA   automation_event_id    ����  �]1]��       @   LoadTextureClone    usa_amboy_3    show_table    DebugEvent    SetupDebugRace    GoLoadingScreen    Loading\LoadingGame.lua                     \  ^         �                         `  b        �                         d  f         �                         h  y    	    E   L � G   E   @� @ �E�  G   E   ��  @ @ �A@  G   E�  �  \ � ��A��AA  �A�a�  @�E  �   F�� F@� K@� � � \@� �       CurrentItemSelected       �?   NumberOfItems    ipairs 
   DebugMenu 	   Activate                     {  �        
      @  E�   � �F�@K��  \A�!�  @�@ �A E   @  �    
   DebugRace    ipairs 
   DebugMenu       �?   WriteToStructure    Amax 
   SetupRace                             