
<p align="center">
<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Silkscreen&size=75&duration=4000&pause=1500&color=c47c4f&background=f0c997&center=true&vCenter=true&width=567&height=150&lines=RUMDA" alt="Typing SVG" /></a>
<br/>
        <img src="https://img.shields.io/badge/HYPRLAND%20-%20WM?style=for-the-badge&label=WM&labelColor=%23a1694d&color=%23f2bc88" />
        <img src="https://img.shields.io/badge/QUICKSHELL%20-%20BAR?style=for-the-badge&label=BAR&labelColor=%23a1694d&color=%23f0c997" />
        <img src="https://img.shields.io/badge/NEOVIM%20-%20NEOVIM?style=for-the-badge&label=EDITOR&labelColor=%23a1694d&color=%23dba380"/>
        <img src="https://img.shields.io/badge/ZSH%20-%20SHELL?style=for-the-badge&label=SHELL&labelColor=%23a1694d&color=%23f0bb90"/> <br>



```
      ／l、           
    （ﾟ､ ｡ ７                        a warmer, more cozy desktop..      へ      ╱|、
      l  ~ヽ                                                        ૮ -  ՛)   (`  -7
      じしf_,)ノ                                                 乀 (ˍ, ل ل     じしˍ,)ノ
```
</p>


> [!IMPORTANT]
> if you would like to try it
> see [installation](#installation).
>
> 
> you can also check: [Gallery](#gallery)  -  [Keybinds](#keybinds) - [Misc](#misc)
>

---

>  Big thanks to xfcasio, as this was based on his rice, [Amadeus](https://github.com/xfcasio/amadeus/). 
>
> for config and some issues, [check this](#config)
>


---


## Gallery




![1](pictures/dark.png)


| ![discord](pictures/discord.png) | ![allwins](pictures/filled.png) |
| -------------------------------- | ------------------------------- |

![lightdashboard](pictures/lightdash.png)
![newBarThingy](pictures/barArt.png)


### old pistachio theme available in installer
<details>
  <summary>Rumda-pistachio</summary>

  ![1](pictures/1.png)

  ![image1](pictures/discordl.png)  
  ![image2](pictures/3.png)

  ![image3](pictures/4.png)  
  ![image4](pictures/triplewindows.png)

</details>


---



## Installation


> [!NOTE]
> the installation assumes you have all the dependencies
> 
> you could eyeball what dependencies to install if you want.
> 
> If you don't want to eyeball them, check the following:
>

<details>
<summary>All dependencies</summary>
        
Basic dependencies
```
hyprland
quickshell
rofi
alacritty
swww 
neofetch 
swappy slurp grim 
zathura 
yazi 
neovim
Cartograph-CF font
```

Full dependencies: 
```
hyprland quickshell rofi alacritty swww thunar neofetch swappy grim zathura yazi jetbrains-mono-fonts mako hyprpicker neovim \
ghostty  nautilus  btop bpytop obs-studio slurp xdg-desktop-portal-hyprland wl-clipboard git\
 jq lz4-devel lua python3 brightnessctl playerctl wpctl pipewire wireplumber Cartograph-CF
```

Recommended:
```
borders-plus-plus hyprland plugin (for the double borders)
Nvchad (cleanly manage your themes)
And lastly, something to setup the custom discord theme.
```

</details>

---


### install.sh
> [!CAUTION]
> please follow these steps:
> - make sure you have installed quickshell, hyprland, etc
> - don't delete or change the position of the repo after using the following command:
> 
> Use this one-liner to clone it and install:


```bash
cd ~/.config && git clone https://github.com/Nytril-ark/rumda && cd rumda && chmod +x install.sh && ./install.sh
```
#### note that the installer will let you install either the old pistachio theme or the new beige theme (beige is default)
> you can also edit the install.sh file to only install what you want by making some vars at the top = false.




## Keybinds

| **Keys**                     | **Description**            |
| ---------------------------- | -------------------------- |
| `$mainMod + W`               | Open Firefox               |
| `$mainMod + Enter`           | Open terminal              |
| `$mainMod + R`               | Launch app menu            |
| `$mainMod + F`               | Open file manager          |
| `$mainMod + S`               | Full screen screenshot     |
| `$mainMod + shift + S`       | screenshot a region        |
| `$mainMod + alt + shift S`   | screenshot region + edit   |
| `$mainMod + C`               | Close focused window       |
| `$mainMod + M`               | Exit Hyprland              |
| `$mainMod + V`               | Toggle floating mode       |
| `$mainMod + P`               | Toggle pseudo layout       |
| `$mainMod + L`               | Lock screen                |
| `$mainMod + Shift + Return`  | Open Ghostty terminal      |
| `$mainMod + Shift + Alt + Q` | Force kill window          |
| `$mainMod + Alt + Arrows`    | Move focus between windows |
| `$mainMod + Shift + [0–9]`   | Move window to workspace   |
| `$mainMod + Scroll / Arrows` | Switch workspace scroll    |
| `$mainMod + up/down arrows`  | Move or resize window      |
| `XF86Audio / F-keys`         | Volume and media control   |
| `$mainMod + TAB`             | Toggle Rumda dashboard     |
| `$mainMod + ;`               | Shrink split ratio         |
| `$mainMod + ' `              | Grow split ratio           |
| `$mainMod + Alt + Space`     | Float/tile                 |
| `$mainMod + D`               | Maximize window            |
| `$mainMod + Shift + C`       | Color picker               |
| `Ctrl + Alt + R`             | Start OBS recording        |
|**note:**                     | mainmod =      `Super`     |





---
## misc



### themeswitch, dashboard and lockscreen

![themeswitch](/pictures/showcase2.gif)

---
## config


> [!NOTE]
> Configuring your own changes in the rice & possible issues

<details>
<summary>Things that may cause issues</summary>

> you can go to rumda/common/quickshell/shared/Common.qml to change things like dashboard pfp, github account name (for the dashboard), as well as default bar theme. 
>
>MORE IMPORTANTLY if your dashboard has weird sizes because of the difference between my screen size and yours, you can tweak the dashboardWidth / height values in that same Common.qml file.
>
</details>



<details>
<summary>Basic configuration</summary>

> you can go to rumda/common/quickshell/light/config/Colors.qml to edit colors, same goes for .../dark/config/Color.qml
> 
> I don't recommend messing with them *too much* though
>
</details>



<details>
<summary>configuring further</summary>

> it would be better to make changes in the rumda dir itself, as the files at .config are just symlinked to there.
> you can then use any of the theme scripts in rumda/scripts/ to push your updates into place, in case they didn't
> get pushed there on their own. Please open an issue here if you need further guidance.
</details>



---

### Rumda the cat

Rumda the cat should be the main feature in these dotfiles. Sadly however, I am stuck with many side-projects, so I can't fully finish this widget yet. Here, Rumda is stuck too:

![rumda-trapped](pictures/RumdaIsTrapped.gif)
![kickoffthecat](/pictures/themeswitchsmooth.gif)

The cat widget ~might~ will (insha'allah) be able to get out soon. We'll see! 

PS: the cat face at the bottom of the bar is an internet widget. If it's smiling, you're connected :)

