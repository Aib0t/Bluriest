# Bluriest.dll

This dll is a ongoing project for creating solution to fix bugs, problems and to add QoL improvments. Right now it's in its first stages. 

# Features:
1) Name Changer for profile. Affects player name in lan games.

...and that's it

# Planed Features in no particular order:
1) Add Fans / Unlocks / Level / Master Level features to local profile.
2) Fix for unreliable lan connection.
3) Controller/Keyboard remapping.
4) Adding an ability to change graphic settings.
5) Increasing server tick rate.

# How to use it

To use this dll you have 2 way of doing so:
1)Injection - not gonna explain it here, plenty of examples over the Internet.
2)Dll loader - the way I preffer and recommend.

- Download https://github.com/aap/simpledllloader
- Put `dinput8.dll` and `bluriest.dll` to Blur game folder.
- Create `dll.cfg` file and add `bluriest.dll` as first line.
- Create `name.txt`. That's where your should put your player name. Player name has 16 characters limit.
- Launch Blur. If everything is done correctly you should be greeted with 'DLL was attached' message.

