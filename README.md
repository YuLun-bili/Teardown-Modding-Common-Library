# Teardown Modding Library by YuLun (YuLunCommonLib)

#### This library is created as an extended library, based upon [Teardown scripting API](https://teardowngame.com/modding/api.html) and [Lua 5.1 functions](http://www.lua.org/manual/5.1/), for a better scripting and modding experience.

## Features
1. **Hex and RGB (table) color support**
```lua
UiHexColor("0f459a")
UiRGBColor({240, 93, 115})
```
2. [**Pack Operations**](../../wiki)
3. **Number System Conversion**
```lua
value = BinToDec("110101")  -- 0b110101 -> 53
```
4. **UI Modules**
5. **Other extention functions**

## Issues & Pull Requests
Feel free to submit any [issues](../../issues) or [pull requests](../../pulls) within the scope of this project.

## Wiki
For now, no there isn't one. (soon™️)

## Installation
### From release page
  * Download the latest release
  * [**DO NOT**](../../) extract, directly put `YuLunCommonLib.zip` file into your project's folder
  * Use `#include "YuLunCommonLib.zip"` in the scripts which you want to use this library (check the path, here only for example)
  * Call function `LibVerWatch()` **OR** `LibVerPrint()` anywhere in script would show information of library you've installed
  * Ready to use, happy scripting :)
### From source code
  * I would let you to figure out how on yourself :D

## Other
1. Licence Template from [ChooseALicense.com](https://github.com/github/choosealicense.com)
