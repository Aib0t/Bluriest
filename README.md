# Bluriest
An attempt to RE Blur - 11 year old racing videogame. And fix it.

# What is done so far:

1) Baisc dll injection lib for name changing is created.
2) Basic analysis of UDP and TCP packets
3) Baisc code RE

# What is known about Blur inner structure:

- Written in C++, menu scripts use Lua.
- Lan multiplayer uses P2P
- Online Multiplayer relies on BitDemon from Demonware (version 2.*.*)
- Utilising following public libs:
zlib (1.2.2) - Unknown, probably io with .pak files.
LibTomCrypt(1.10) - Encryption. 
libcurl (version unknown)



