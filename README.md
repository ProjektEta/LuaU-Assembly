
# LSM

LuaU Assembly (LSM) Is a VM that can read code based on assembly inside Roblox Studio Environment, the main purpose of this is to make code harder to read for any potential attackers, as well as I just hate myself so, I made this and later attempt to make an entire game based on this Language.

## LSM Syntax

LSM's Syntax is quite simple yet complex. Everything is stored (potentially) by Hexadecimal for maximum unreadability, however you can use numbers or strings as well it doesn't really matter. here are the list of functions and there arguments they take, and what they do.

- def | Define | Store Value | Constant Value [def, 0x1234, 104]
- add, div, mul, sub | Operation | Store Value | Any operation value [add, 0x1234, 0x23, 0x482, 0x274]
- call | Call | Function Value | Input Arguments | Output Arguments [call, 0x1234, {0x23, 0x45}, {0x312, 0x374}]
- flag | Flag | Flag Address | Jump Instruction [flag, 0x24, 23]
- ret | Return [ret]
- jmp | Jump | Jump instruction [jmp, 23]
- jmpcon | Jump conditional | Condition Address | Jump instruction [jmpcon, 0x23, 23]
- sys | syscall | SyscallID | Param1 | Param2 | Param3... [sys, ind, 0x23, 0x45, 0x28]

## LSM Syscalls

- eq | equal | StoreAddress | Var1 | Var2 [sys, eq, 0x23, 0x45, 0x56]
- gt | greater than | StoreAddress | Var1 | Var2 [sys, gt, 0x23, 0x45, 0x56]
- gteq | Greater or Equal | StoreAddress | Var1 | Var2 [sys, gteq, 0x23, 0x45, 0x56]
- lt | Less than | StoreAddress | Var1 | Var2 [sys, lt, 0x23, 0x45, 0x56]
- lteq | Less or equal | StoreAddress | Var1 | Var2 [sys, lteq, 0x23, 0x45, 0x56]
- noteq | Not equal | StoreAddress | Var1 | Var2 [sys, noteq, 0x23, 0x45, 0x56]
- ind | Index | StoreAddress | Var1 | Var2 [sys, ind, 0x23, 0x45, 0x56]
- nind | New Index | StoreAddress | Var1 | Var2 [sys, nind, 0x23, 0x45, 0x56]

## LSM Example Script's

- Makes a Part, and then changes the parts Color randomly.
```lua
local Compiler = require(script.Compiler)

Compiler:Run({
	{"def", 0x119b2, workspace};
	{"def", 0xa520f, "new"};
	{"def", 0x0dccf, Instance};
	{"sys", "ind", 0xc2c87, 0x0dccf, 0xa520f}; -- 0xc2c87 : Instance.new(Class, Parent)
	{"def", 0x2056a, "Part"};
	{"call", 0xc2c87, {0x2056a, 0x119b2}, {0x81c54}}; -- 0x81c54 : BasePart
	{"def", 0x5ec04, Vector3};
	{"sys", "ind", 0x30294, 0x5ec04, 0xa520f}; -- 0x30294 : Vector3.new(x,y,z)
	{"def", 0xbae77, 10};
	{"def", 0x3abe4, "Position"};
	{"def", 0x27dad, "Size"};
	{"def", 0x69855, "CanCollide"};
	{"def", 0xaf4f9, "Anchored"};
	{"def", 0xe3b58, true};
	{"call", 0x30294, {0xbae77,0xbae77,0xbae77}, {0xdc20c}}; -- 0xdc20c : Vector3(10,10,10) 
	{"sys", "nind", 0xdc20c, 0x81c54, 0x3abe4};
	{"sys", "nind", 0xdc20c, 0x81c54, 0x27dad};
	{"sys", "nind", 0xe3b58, 0x81c54, 0x69855};
	{"sys", "nind", 0xe3b58, 0x81c54, 0xaf4f9};
	{"def", 0xb5c5b, "random"};
	{"def", 0x5d38b, math};
	{"sys", "ind", 0x65182, 0x5d38b, 0xb5c5b}; -- 0x65182 : math.random(x1, x2)
	{"def", 0x9f5b2, task};
	{"def", 0x61701, "wait"};
	{"sys", "ind", 0x87311, 0x9f5b2, 0x61701}; -- 0x87311 : task.wait(seconds)
	{"def", 0xb9ae0, true};
	{"flag", 0x44f41, 14}; --
	{"sys", "noteq", 0xb9ae0, 0xb9ae0, 0xde867}; -- while true do
	{"jmpcon", 0xde867, 13}; --
	{"def", 0x52c8d, .1};
	{"call", 0x87311, {0x52c8d}, {}}; -- task.wait(.1)
	{"def", 0x771d4, Color3};
	{"def", 0x9bacd, "fromRGB"};
	{"sys", "ind", 0x7aa52, 0x771d4, 0x9bacd}; -- Color3.fromRGB(R,G,B)
	{"def", 0x4fede, 0};
	{"def", 0xa9372, 255};
	{"call", 0x65182, {0x4fede, 0xa9372}, {0x33edc}}; -- 0x33edc : math.random(0, 255)
	{"call", 0x7aa52, {0x33edc,0x33edc,0x33edc}, {0x0ff3a}}; -- Color
	{"def", 0x327a2, "Color"};
	{"sys", "nind", 0x0ff3a, 0x81c54, 0x327a2};
	{"call", 0x44f41, {}, {}};
	{"ret"};
})
```
