// dllmain.cpp : Defines the entry point for the DLL application.
#include "stdafx.h"
#include <windows.h>
#include <fstream>
#include <iostream>
#include <string>
#include <cstdint>
#include <cstring>
#include <string>



#define nameadress 0x010E6B28
#define baseadress 0x01000000

void changename()
{

	std::ifstream file;

	file.open("name.txt");
	std::string line;
	if (!file) //checks to see if file opens properly
	{
		line = "noname";
	}
	else
	{
		getline(file, line); // Get and print the line.
		file.close(); // Remember to close the file.
	}
	char* myStr2 = new char[line.length()*2];
	int i = 0;

	for (char& c : line) {
		myStr2[i] = c;
		myStr2[i + 1] = 0x00;
		i = i + 2;
	}	
	
for(;; )
	{
char* buffer = reinterpret_cast<char*>(nameadress);
//size_t length = strlen(buffer) + 1;
//char *myStr = new char[line.length()+1];
//std::strcpy(myStr, line.c_str());
//char myStr[] = { 0x70, 0x00,0x72,0x00, 0x65 , 0x00 ,0x6F, 0x0 };
//DWORD oldProtect;
//VirtualProtect(buffer, length, PAGE_EXECUTE_READWRITE, &oldProtect);
//size_t length = strlen(myStr) + 1;

std::memcpy(buffer, myStr2,28);
//VirtualProtect(buffer, length, oldProtect, nullptr);

	}
}


BOOL APIENTRY DllMain( HMODULE hModule,DWORD ul_reason_for_call, LPVOID lpReserved)
{
    switch (ul_reason_for_call)
    {
        case DLL_PROCESS_ATTACH:
        /* The DLL is being loaded for the first time by a given process.
        Perform per-process initialization here.  If the initialization
        is successful, return TRUE; if unsuccessful, return FALSE. */
			MessageBoxA(0 , "DLL has been attached !" , "DLL Bot" , MB_ICONEXCLAMATION | MB_OK);
            CreateThread(0, 0, (LPTHREAD_START_ROUTINE)changename, 0, 0, 0);
    }
    return TRUE;
}

