# Teardown Modding Library by YuLun (YuLunCommonLib)

#### This library is created as an extended library, based upon [Teardown scripting API](https://teardowngame.com/modding/api.html) and [Lua 5.1 functions](http://www.lua.org/manual/5.1/), for a better scripting and modding experience.

## Features
1. **Hex and RGB (table) color support**
```lua
UiHexColor("0f459a")
UiRGBColor({240, 93, 115})
```
2. [**Pack Operations**](../../wiki/Pack-Operation)
3. **Number System Conversion**
```lua
value = BinToDec("110101")  -- 0b110101 -> 53
```
4. **UI Modules**
5. **Other extention functions** (game entity related)

## Issues & Pull Requests
Feel free to submit any [issues](../../issues) or [pull requests](../../pulls) within the scope of this project.

## [Wiki](../../wiki)

## Installation
### From release page
  * Download the [latest release](../../releases/latest)
  * [**DO NOT**](../../) extract, directly put `YuLunCommonLib.zip` file into your project's folder
  * Use `#include "YuLunCommonLib.zip"` in the scripts which you want to use this library (check the path, here only for example)
  * Call function `LibVerWatch()` **OR** `LibVerPrint()` anywhere in script would show information of library you've installed
  * Ready to use, happy scripting :)
### From source code
  * I would let you to figure out how on yourself :D

## Other
1. Licence Template from [ChooseALicense.com](https://github.com/github/choosealicense.com)
2. <p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/YuLun-bili/Teardown-Modding-Common-Library">YuLunCommonLib</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://github.com/YuLun-bili">YuLun Zhou</a> is licensed under <a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-SA 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1"></a></p>
