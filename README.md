
<p align="center">
<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Silkscreen&size=75&duration=4000&pause=1500&color=9F684C&background=E4C198&center=true&vCenter=true&width=567&height=150&lines=RUMDA" alt="Typing SVG" /></a>
<br/>
        <img src="https://img.shields.io/badge/HYPRLAND%20-%20WM?style=for-the-badge&label=WM&labelColor=%236F4732&color=%23D1AB86" />
        <img src="https://img.shields.io/badge/QUICKSHELL%20-%20BAR?style=for-the-badge&label=BAR&labelColor=%236F4732&color=%23E4C198" />
        <img src="https://img.shields.io/badge/NEOVIM%20-%20NEOVIM?style=for-the-badge&label=EDITOR&labelColor=%236F4732&color=%23AF8C65"/>
        <img src="https://img.shields.io/badge/ZSH%20-%20SHELL?style=for-the-badge&label=SHELL&labelColor=%236F4732&color=%23DAB08B"/> <br>



```
      ／l、           
    （ﾟ､ ｡ ７                        a warmer, more cozy desktop..      へ      ╱|、
      l  ~ヽ                                                        ૮ -  ՛)   (`  -7
      じしf_,)ノ                                                 乀 (ˍ, ل ل     じしˍ,)ノ
```
</p>


> [!IMPORTANT]
> This is a *wip* and I'm adding things to it every day, but if you would like to try it
> see [installation](#installation).
>
> 
> you can also check: [Gallery](#gallery)  -  [Keybinds](#keybinds) - [Misc](#misc)
>

---

>  Big thanks to xfcasio, as this was based on his rice, [Amadeus](https://github.com/xfcasio/amadeus/). 
>
> **things I haven't finished:** themes for: Thunar (file manager), browser, discord + more widgets
>
> if you wanna [make your own changes](#config)
>


---


## Gallery
![1](pictures/1.png)


| ![image1](pictures/bpytop.png) | ![image2](pictures/3.png) |
| ------------------------------ | ------------------------- |
| ![image3](pictures/4.png)      | ![image4](pictures/2.png) |


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

Use your fav package manager to install those:
```
hyprland quickshell rofi alacritty swww thunar neofetch grim zathura yazi jetbrains-mono-fonts mako hyprpicker neovim \
ghostty  nautilus  btop bpytop papirus-icon-theme obs-studio \
xdg-desktop-portal-hyprland wl-clipboard git jq lz4-devel lua python3 brightnessctl playerctl wpctl pipewire wireplumber
```
If using dnf, copy this: 
```
sudo dnf install hyprland rofi alacritty swww zathura grim brightnessctl playerctl wpctl pipewire wireplumber \
thunar nautilus neovim btop bpytop papirus-icon-theme jetbrains-mono-fonts mako hyprpicker obs-studio \
xdg-desktop-portal-hyprland wl-clipboard git jq lua python3 --skip-unavailable 
```

Check the installation for those from their wikis if you're using dnf
```
quickshell
ghostty
yazi
```

Lastly, if you want to, I would recommend installing nvchad.

</details>

---


### install.sh
> [!CAUTION]
> please follow these steps:
> - make sure you have installed quickshell, hyprland, etc
> - make **sure** the repo is at _~/.config/rumda_
> 
> You can use this one-liner to clone it and install:


```bash
cd ~/.config && git clone https://github.com/Nytril-ark/rumda && cd rumda && chmod +x install.sh && ./install.sh
```
separated commands for readability:
```bash
cd ~/.config 
git clone https://github.com/Nytril-ark/rumda 
cd rumda 
chmod +x install.sh
./install.sh
```




## Keybinds

| **Keys**                     | **Description**            |
| ---------------------------- | -------------------------- |
| `$mainMod + W`               | Open Firefox               |
| `$mainMod + Enter`           | Open terminal              |
| `$mainMod + R`               | Launch app menu            |
| `$mainMod + F`               | Open file manager          |
| `$mainMod + S`               | Take screenshot            |
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
| `$mainMod + TAB`             | Toggle Rumda dashboard (WIP) |
| `$mainMod + ;`               | Shrink split ratio         |
| `$mainMod + ' `              | Grow split ratio           |
| `$mainMod + Alt + Space`     | Float/tile                 |
| `$mainMod + D`               | Maximize window            |
| `$mainMod + Shift + C`       | Color picker               |
| `Ctrl + Alt + R`             | Start OBS recording        |
|**note:**                     | mainmod =      `Super`     |





---
## misc



### theme switcher
I kick off the cat for a little fun

![themeswitch](/pictures/themeswitchsmooth.gif)

---
## config


> [!NOTE]
> Configuring your own changes in the rice

<details>
<summary>If you know what you're doing, click me!</summary>

> if you know what you're doing and you want to modify the rice
> you can change the files at /.config/ directly. **Except** for
> the hyprland config, which is modified at
> `.config/rumda/light-config/hypr` or similarly `/dark-config/hypr`
>
> this is because the file at .config/hypr/ is overwritten on theme switches
>
> 
</details>


#### Color-scheme for nvim:


##### rumda light
<img src="pictures/rl1.png">

#### experimental themes:
haven't refined those yet..
<details>
<summary>dark, warm, extra-warm</summary>
<img src="pictures/rd.png">
<img src="pictures/rw.png">
<img src="pictures/rew.png">
</details>

---

### Rumda the cat

Rumda the cat should be the main feature in these dotfiles. Sadly however, I am stuck with many side-projects, so I can't fully finish this widget yet. Here, Rumda is stuck too:

![rumda-trapped](pictures/RumdaIsTrapped.gif)

The cat widget ~might~ will (insha'allah) be able to get out soon. We'll see! 
Currently, the cat on top of the bar just does a ~goofy~ jump-out animation when you click it. If you click on its resting spot again, it comes back.

PS: the cat face at the bottom of the bar is an internet widget. if it's smiling, you're connected :)

