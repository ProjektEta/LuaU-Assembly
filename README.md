
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

- Changes a Humanoid speed to 50
```lua
local LSM = require(script.LSM)
LSM:Run({
    {"def", 0x5d5a0, game};
    {"def", 0xbd7bf, "GetService"};
    {"sys", "ind", 0x7713d, 0x5d5a0, 0xbd7bf}; -- game.GetService(game, ServiceName);
    {"def", 0x6a4ff, "Players"};
    {"call", 0x7713d, {0x5d5a0, 0x6a4ff}, {0x078ed}};
    {"def", 0x35fca, "LocalPlayer"};
    {"sys", "ind", 0xf2412, 0x078ed, 0x35fca};
    {"def", 0x428da, "Character"};
    {"sys", "ind", 0x8e756, 0xf2412, 0x428da};
    {"def", 0x466e6, "Humanoid"};
    {"def", 0x8913a, "FindFirstChild"};
    {"sys", "ind", 0x8c383, 0x8e756, 0x8913a};
    {"call", 0x8c383, {0x8e756, 0x466e6}, {0xe7a78}}; -- Character.FindFirstChild(Character, PartName)
    {"def", 0x61504, "WalkSpeed"};
    {"def", 0xf90fe, 50};
    {"sys", "nind", 0xf90fe, 0xe7a78, 0x61504};
})
```
