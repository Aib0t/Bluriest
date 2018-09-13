# Bluriest
An attempt to RE Blur - 8 year old racing videogame. And fix it.

This is my first ever project in c++ and first RE project as well. I'm aiming to have a stable 20 people lobby in lan and couple other features.

# What is done so far:

1) Baisc dll injection lib for name changing is created.
2) Basic analysis of UDP and TCP packets
3) Baisc code RE

# What is known about Blur inner structure:

- Written in C++, menu scripts use Lua.
- Lan multiplayer uses P2P
- Utilising following public libs:
OpenSSL (0.9.8i and 0.9.8k) - Unknown purposes.
zlib (1.2.2) - Unknown, probably io with .pak files.
LibTomCrypt(1.10) - Encryption. 
libcurl (version unknown)
- Blur encrypts every and all network packages.
- Have anti debugging feature (but attaching debugger to a working proccess works fine)



