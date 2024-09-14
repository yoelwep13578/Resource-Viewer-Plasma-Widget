# Resource-Viewer-Plasma-Widget
![SRV Intro](https://github.com/user-attachments/assets/367ecbfd-727a-4ed7-bda9-bb0f9b5adc1a)

## About
![SRV Features](https://github.com/user-attachments/assets/99b5c050-8b6c-402a-92e4-e63d136546df)

Simple KDE Plasma ```Command Set``` widget based from Zren's "Command Output" that displays:
- CPU Usage
- RAM Usage
- Disk Usage
- Storage Usage
- CPU Temperature

This widget can be attached on the Desktop or the Panel.

![SRV Attach](https://github.com/user-attachments/assets/bcbb5d9e-40f7-4934-a3ae-c568c5183bfc)


<br>

## Requirements
- "Command Output" Widget
- Monospace Nerd Fonts
- Utility Linux Programs
  - ```top``` to view CPU Usage
  - ```sysstat``` --> ```iostat``` to view Disk Usage
  - ```df``` to view Storage Usage
  - ```lm-sensors``` --> ```sensors``` to view Temperature

<br>

## Installation
### 1. Clone this Repository
```
$ cd ~/Downloads
$ git clone https://github.com/yoelwep13578/Resource-Viewer-Plasma-Widget
$ cd ./Resource-Viewer-Plasma-Widget
```

### 2. Move Scripts to Your Location
To keep it simple, you can move the ```Scripts``` folder to ```/home/yourname/```
```
$ mv ./Scripts ~/
```

### 3. Install Output Command Widget
Since this is based on the Output Command, it needs to be installed first. Install it using one of the methods below:
- [Pling](https://www.pling.com/p/2136636/)
- [Github](https://github.com/Zren/plasma-applet-commandoutput)
- Or you can install it automatically with Right Click Desktop --> Enter Edit Mode --> Add Widgets --> Get New Widgets --> Download New Plasma Widgets and search with "Command Output" keyword.
![image](https://github.com/user-attachments/assets/815ae5d9-5844-4214-9ba2-27c0b8ac3d2c)

### 4. Install Nerd Font
Nerd Font is a font with additional icon sets. It needs to be installed for some icons to render correctly. You can download & choose it from [Nerd Font](https://www.nerdfonts.com/font-downloads) with your preference.

If you confused, you can use these example:
- [Hack](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip)
- [Cascadia Cove](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip)
- [JetBrains Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip)

After downloaded the zip file, just extract all TTFs to the Desktop temporarily.
Then, install (move) using this command:
```
$ sudo mv /home/yourname/Desktop/*.ttf /usr/share/fonts/TTF/
```

> Sometimes, system need to be restarted to refresh any changes

<br>

## Setting Up
### Basics
Each widget displaying CPU, RAM, Disk, Storage, and Temperature requires a separate Command Output Widget. This means you can use them according to your needs and place them freely.
> For example, if you want to display only CPU and RAM, simply attach 2 Command Output Widgets and place them wherever you like.

> Another example: if you want to display all of them, you will need to attach 5 Command Output Widgets. You can't use 1 Widget to display all 5 at once. If you want them in one place, you can group all 5 Command Output Widgets using the "Grouping Plasmoid" widget (only works when attached to the desktop).

<br>

### Set-Up
In this repository, the directory structure is as follows:
```
Resource-Viewer-Plasma-Widget
└── Scripts
    ├── CPU Usage
    │   └── CPU-Usage.sh
    ├── RAM Usage
    │   └── RAM-Usage.sh
    ├── Disk Usage
    │   └── Disk-Usage.sh
    ├── Storage Usage
    │   └── Storage-Usage.sh
    └── Temperature
        └── Temperature.sh
```

And this is what it looks like after you move the ```Scripts``` folder to your Home directory:

```
home
└── yourname
    └── Scripts
        ├── CPU Usage
        │   └── CPU-Usage.sh
        ├── RAM Usage
        │   └── RAM-Usage.sh
        ├── Disk Usage
        │   └── Disk-Usage.sh
        ├── Storage Usage
        │   └── Storage-Usage.sh
        └── Temperature
            └── Temperature.sh
```

You only need to focus on the ```Scripts``` folder and its contents. The command sets for CPU, RAM, Disk, Storage, and Temperature are already there.

> For example, you’ve attached 2 Command Output Widgets and want to display CPU and RAM. To do this, Right Click --> Configure Command Output --> In the Command section, enter ```bash``` followed by the location of the ```CPU-Usage.sh``` file:
> ```
> bash "/home/yourname/Scripts/CPU Usage/CPU-Usage.sh"
> ```
> Do the same for the other Command Output Widget, filling in bash and the location of the RAM-Usage.sh file:
> ```
> bash "/home/yourname/Scripts/Disk Usage/Disk-Usage.sh"
> ```

> What if you want to display all five? It’s simple. Make sure you’ve attached 5 Command Output Widgets --> Then configure each widget --> Provide the command with ```bash``` and the location of each ```.sh``` file:
> ```
> [1] bash "/home/yourname/Scripts/CPU Usage/CPU-Usage.sh"
> [2] bash "/home/yourname/Scripts/RAM Usage/RAM-Usage.sh"
> [3] bash "/home/yourname/Scripts/Disk Usage/Disk-Usage.sh"
> [4] bash "/home/yourname/Scripts/Storage Usage/Storage-Usage.sh"
> [5] bash "/home/yourname/Scripts/Temperature/Temperature.sh"
> ```

<br>

## Config
### ```CPU-Usage.sh```

# Credits
- Chris Holland - [Zren](https://github.com/Zren) (Command Output Plasma Widget)
- Ryan L McIntyre - [ryanoasis](https://github.com/ryanoasis) (Nerd Fonts)
