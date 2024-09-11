# Resource-Viewer-Plasma-Widget
## About
Simple KDE Plasma ```Command Set``` widget based from Zren's "Command Output" that displays:
- CPU Usage
- RAM Usage
- Disk Usage
- Storage Usage
- CPU Temperature

This widget can be attached on the Desktop or the Panel.

<br>

## Requirements
- "Command Output" Widget
- Monospace Nerd Fonts

<br>

## Installation
### 1. Clone this Repository
```
$ git clone https://github.com/yoelwep13578/Resource-Viewer-Plasma-Widget
$ cd ./Resource-Viewer-Plasma-Widget
```

### 2. Move Scripts to Your Location
To keep it simple, you can move the ```Scripts``` folder to ```/home/yourname/```
```
$ mv ./Scripts /home/yourname/
```

### 3. Install Output Command Widget
Since this is based on the Output Command, it needs to be installed first. Install it using one of the methods below:
- [Pling](https://www.pling.com/p/2136636/)
- [Github](https://github.com/Zren/plasma-applet-commandoutput)
- Or you can install it automatically with Right Click Desktop --> Enter Edit Mode --> Add Widgets --> Get New Widgets --> Download New Plasma Widgets and search with "Output Command" keyword.
![image](https://github.com/user-attachments/assets/815ae5d9-5844-4214-9ba2-27c0b8ac3d2c)

### 4. Install Nerd Font
Nerd Font is a font with additional icon sets. It needs to be installed for some icons to render correctly. You can download & choose it from [Nerd Font](https://www.nerdfonts.com/font-downloads) with your preference.

After downloaded the zip file, just extract it to the Desktop temporarily.
Then, install (move) using this command:
```
$ sudo mv /home/yourname/Desktop/*.ttf /usr/share/fonts/TTF/
```

> Sometimes, system need to be restarted to refresh any changes

<br>
But if you don’t want to choose, simply install JetBrains Mono Nerd Font that included in this repo. Then install it.

```
$ sudo cp ./Fonts/* /usr/share/fonts/TTF/
```

<br>

## Setting Up
### Initial Set-up
CPU, RAM, Disk, Storage, and Temperature must be attached separately. This means you can use each of these widgets according to your needs and attach them anywhere you like.

<br>

# Credits
- Chris Holland - [Zren](https://github.com/Zren) (Command Output Plasma Widget)
- Ryan L McIntyre - [ryanoasis](https://github.com/ryanoasis) (Nerd Fonts)
