
# LSM

LuaU Assembly (LSM) Is a VM that can read code based on assembly inside Roblox Studio Environment, the main purpose of this is to make code harder to read for any potential attackers, as well as I just hate myself so, I made this and later attempt to make an entire game based on this Language.

## LSM Syntax

LSM's Syntax is quite simple yet complex. Everything is stored (potentially) by Hexadecimal for maximum unreadability, however you can use numbers or strings as well it doesn't really matter. here are the list of functions and there arguments they take, and what they do.

- rax | Register Absolute Value | {rax, {Address, Value}} | rax adds values to the registery to be used by other instructions, this function stores variables GLOBALLY. 
- rdx | Register Delete Absolute Value | {rdx {Address}} | rdx removes a value from the global register.
- rat  | Register Temporary Value | UNUSED
- rdt | Register Delete Temporary Value | UNUSED
- jmp | Jump | {jmp, {Instruction}} | Jumps the VM to a specific section of code unconditionally
- ret | Return | UNUSED
- con | Concat | {con, {strings....}} | Will combine all strings together.
- ind | Index | {ind, {TableAddress, StoreAddress, IndexAddress} } | Will store an index in another memory address
- nind | NewIndex | {nind, {TableAddress, IndexAddress, ValueAddress}} | Will change an index's value.

## LSM Example Script's

- Changes a Humanoid speed to 50
```lua
local LSM = require(script.LSM)
LSM:Run({
	{"rax", {0x393778c, game}}; -- Registers Game
	{"rax", {0x4f6e39f, "GetService"}}; -- Registers String getting ready for get index
	{"ind", {0x393778c, 0x1879615, 0x4f6e39f}}; -- Gets the GetService Namecall
	{"rdx", {0x4f6e39f}}; -- Dereferences "GetService" as it is no longer needed
	{"rax", {0x93c3291, "Players"}}; -- Gets ready to call GetService
	{"call", {0x1879615, {0x393778c, 0x93c3291}, {0x2591c0b}}}; -- Calls GetService and returns PlayerService
	{"rdx", {0x393778c}}; -- Dereferences game as it isnt needed
	{"rdx", {0x1879615}}; -- Dereferences GetService as it isnt needed
	{"rdx", {0x93c3291}}; -- Dereferences "Players" as it isnt needed
	{"rax", {0x8137fc3, "LocalPlayer"}}; -- Adds a string LocalPlayer
	{"ind", {0x2591c0b, 0xe11affe, 0x8137fc3}}; -- Gets the LocalPlayer
	{"rdx", {0x8137fc3}}; -- Derefs Players
	{"rdx", {0x2591c0b}}; -- Derefs "LocalPlayer"
	{"rax", {0x8420a63, "Character"}}; -- Adds a string Character
	{"ind", {0xe11affe, 0x729fe24, 0x8420a63}}; -- Gets the LocalCharacter
	{"rdx", {0x8420a63}}; -- Derefs "Character"
	{"rdx", {0xe11affe}}; -- Derefs LocalPlayer
	{"rax", {0xe0645b1, "Humanoid"}}; -- Adds a string Humanoid
	{"ind", {0x729fe24, 0xbf99e6f, 0xe0645b1}}; -- Gets the LocalHumanoid
	{"rdx", {0xe0645b1}}; -- Derefs "Humanoid"
	{"rdx", {0x729fe24}}; -- Derefs Character
	{"rax", {0x6a075f5, 50}}; -- Adds number 50
	{"rax", {0x33988af, "WalkSpeed"}}; -- Adds string WalkSpeed
	{"nind", {0xbf99e6f, 0x33988af, 0x6a075f5}}; -- Sets the WalkSpeed Index to 50
	{"rdx", {0x33988af}}; -- derefs "WalkSpeed"
	{"rdx", {0xbf99e6f}}; -- Derefs Humanoid
	{"rdx", {0x6a075f5}}; -- Derefs 50
})
```
