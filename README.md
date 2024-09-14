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
### All Configurable Properties

#### Mode --> Overall display
- Icon Mode: Displays the icon followed by the value
- Inline Text Mode: Displays the title followed by the value on one line
- Breakline Text Mode: Displays the title followed by the value on two lines

#### Show As --> Display for the values
- Percent: Displays the value as a percentage only
- Percent + Size: Displays the value as a percentage and the current size in use
- Percent + Capacity: Displays the value as a percentage and the total/max size capacity
- Percent + Details: Displays the value as a percentage and detailed text
- Percent + Speed: Displays the value as a percentage and current speed details
- Size: Displays the value as size in use only
- Temp: Displays the current temperature only
- Speed: Displays the current speed only
- Size + Capacity: Displays the value as size in use and the total/max size capacity

#### Unit --> Display units to be used
- GB --> Data size in Gigabytes
- GiB --> Data size in Gibibytes
- C --> Temperature in Celsius
- F --> Temperature in Fahrenheit

#### Separator --> The separator between value 1 and value 2
- The separator can be any character you want. By default, the separator is "|". You can adjust it to your creativity!
> The separator will not be displayed if "Show As" uses a single value (does not include a second value).

#### TextMode Title --> Text displayed in Inline or Breakline Text Mode
- By default, the title usually contains text that identifies itself, followed by ":" and a space. For example, `CPU: `, `RAM: `, `Temp: `, etc. You can change it to whatever you like!
> TextMode Title will not appear in Icon Mode.

#### Dynamic Conversion --> Conversion to a larger/smaller unit
- Enabled: This will convert size values to KB, MB, GB, TB or KiB, MiB, GiB, TiB depending on the condition.
- Disabled: This will keep the value in GB or GiB.

#### Target --> The target used to fetch the value
##### Disk
- Can be set to the disk whose activity you want to monitor. The default is `/dev/sda`. You can set it to another disk if you have more than one.

##### Storage
- Overall: Calculates total storage usage and capacity across mounted partitions and disks.
- Can be set to a disk such as `/dev/sda`, to get the usage and capacity for that disk.
- Can be set to a partition such as `/dev/sda9`, to get the usage and capacity for that partition.

##### CPU
- All CPU: Fetches the average usage of all cores.
- Inputting a core number like `0` fetches the usage for that core only.

##### Temp
- All CPU: The average temperature of all cores, fetched from Sensors --> Package 0.
- Inputting a core number like `0` fetches the temperature for that core.
- Overall: The room temperature inside the computer case, usually fetched from `acpitz-acpi-0`.


<br>

### Configure ```.../Scripts/CPU Usage/CPU-Usage.sh```
![Properties](https://github.com/user-attachments/assets/f55f3c7f-d1e0-4685-a6ff-4e775924ff65)

The available config looks something like this:
```
#===================
#  EDITABLE ZONE
#===================

# Edit config here

mode="1"                   # [1] Icon Mode
                           # [2] Inline Text Mode
                           # [3] Breakline Text Mode

show_as="1"                # [1] Percent
                           # [2] Percent + Current Speed
                           # [3] Current Speed

separator="|"              # Fill in with the separator of your choice

textmode_title="CPU: "     # Title in Text Mode

target="overall"           # "overall" for all cores, or specific core (e.g. "1" for core 1)
                           # Remember: core always start from 0, not from 1.
```

Configure it with your preference & creativity, or here’s another example you can create:

![Example](https://github.com/user-attachments/assets/137db1b9-9e66-4883-982f-f5cde933699c)

<br>

### Configure ```.../Scripts/RAM Usage/RAM-Usage.sh```
![Properties](https://github.com/user-attachments/assets/6bf678d1-b05c-427f-8408-f8d7e1ccf844)


The available config looks something like this:
```
#===================
#  EDITABLE AREA
#===================

# Edit Config Here

mode="1"                # [1] Icon Mode
                        # [2] Inline Text Mode
                        # [3] Breakline Text Mode

unit="1"                # [1] GB
                        # [2] GiB

show_as="2"             # [1] Percent
                        # [2] Percent + Size
                        # [3] Percent + Capacity
                        # [4] Size
                        # [5] Size + Capacity

separator="|"           # Fill in with the separator of your choice

textmode_title="RAM: "  # Title in Text Mode
```

Configure it with your preference & creativity, or here's another example you can create:

![Example 1](https://github.com/user-attachments/assets/60f27734-0806-4c7a-acb5-0ab534352917)
![Example 2](https://github.com/user-attachments/assets/62abb248-f86d-4ad8-b696-25f6447c7770)
![Example 3](https://github.com/user-attachments/assets/d5217ba7-7d78-4ed7-9c79-61623422f426)

<br>

### Configure ```.../Scripts/Disk Usage/Disk-Usage.sh```
![Properties](https://github.com/user-attachments/assets/56084b5a-360d-49af-a477-f7ef716dfb9e)

The available config looks something like this:
```
#===================
#  EDITABLE ZONE
#===================

# Edit config here

mode="1"                  # [1] Icon Mode
                          # [2] Inline Text Mode
                          # [3] Breakline Text Mode

textmode_title="Disk: "   # Title for text mode

target="/dev/sda"         # Target disk, default is /dev/sda
```

Configure it with your preference & creativity. Here's example that you can try:

![Example Creativity](https://github.com/user-attachments/assets/0cfeb280-cbd9-4b6b-bef3-de90697ec301)

<br>

### Configure ```.../Scripts/Storage Usage/Storage-Usage.sh```
![Properties](https://github.com/user-attachments/assets/8a06c931-1fe0-4d30-9df4-80406fb954ba)

The available config looks something like this:
```
#===================
#  EDITABLE ZONE
#===================

# Edit config here

mode="1"                # [1] Icon Mode
                        # [2] Inline Text Mode
                        # [3] Breakline Text Mode

unit="1"                # [1] GB
                        # [2] GiB

show_as="1"             # [1] Percent
                        # [2] Percent + Size
                        # [3] Percent + Capacity
                        # [4] Size
                        # [5] Size + Capacity

separator="|"           # Fill in with the separator of your choice

textmode_title="Storage: "  # Title in Text Mode

target="overall"        # Target to all mounted partitions --> use "overall"
                        # Target to disk --> write like "/dev/sda"
                        # Target to partition -> write like "/dev/sda5"

dynamic_conversion="1"  # [1] Enable dynamic conversion (KB/MiB/GB/TiB)
                        # [0] Disable dynamic conversion, stick to GB/GiB
```

Configure it with your preference & creativity. And here's another example you can create:

![Example 1](https://github.com/user-attachments/assets/86834c75-990a-42fa-872f-e663f243a420)
![Example 2](https://github.com/user-attachments/assets/c61a1604-6765-46dc-a9f9-8c5077ac2da1)
![Example 3](https://github.com/user-attachments/assets/39eb0182-1c36-405c-8e59-c9fa1ea3abb6)

<br>

### Configure ```../Scripts/Temperature/Temperature.sh```
![Properties](https://github.com/user-attachments/assets/81978d60-c761-4978-90f6-f341947cb180)

The available config looks something like this:
```
#===================
#  EDITABLE ZONE
#===================

# Edit config here
mode="1"                    # [1] Icon Mode
                            # [2] Inline Text Mode
                            # [3] Breakline Text Mode

unit="C"                    # "C" for Celsius
                            # "F" for Fahrenheit

show_as="1"                 # [1] Temp
                            # [2] Temp + Detail

separator="|"               # Fill in with the separator of your choice

textmode_title="Temp: "     # Title in Text Mode

target="allCPU"             # "allCPU" for CPU Package 0
                            # "overall" for acpitz-acpi-0
                            # Write number for specific core (e.g. "0" for core 0)

# Limit & Details. Fill with:
# [Limit in Celsius], [Limit in Fahrenheit], [Detail text]

level1_limit=(40 104 "Idle")
level2_limit=(50 122 "Normal")
level3_limit=(72 162 "Warm")
level4_limit=(85 185 "Hot")
```

Configure it with your preference & creativity. Here's another example you can try:

![Example](https://github.com/user-attachments/assets/8fcf7520-3851-4ce3-b1b3-890e4dd651b1)

<br>

## Bonus: Screenshot of using it on Panel
![image](https://github.com/user-attachments/assets/b250dc04-48c4-42d6-84a4-2678499f5250)

<br>

# Credits
- Chris Holland - [Zren](https://github.com/Zren) (Command Output Plasma Widget)
- Ryan L McIntyre - [ryanoasis](https://github.com/ryanoasis) (Nerd Fonts)
