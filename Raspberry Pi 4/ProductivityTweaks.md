## Use 64bit RaspberryPi OS

[Install 64bit RaspberryPi OS](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit)

## Overclock CPU/GPU to make Pi4 faster

[Overclocking](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%204/PrimaryDesktopTweak.md)

## Use a High Performance Browser (e.g Brave)

[Download Brave Browser for Arm64. Nightly Builds](https://brave.com/linux/#nightly-channel-installation)

## Use RAMDisk for Resource Demanding Applications

[Migrate and Load User Profiles and Cache from RAMDisk for Brave, Chrome, Vivaldi browsers](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%204/FastBrowsingWithRamDisk.md)

## Disable Logging/Journaling to make Pi4 IO faster

[Disable Logging](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%20II%20(Buster)/ExtendSDMemoryLifeSpanTweaks.md#disable-all-logging)

[Disable Journaling](https://github.com/avarghesein/-NIX/blob/main/Debian%2010/System/PerformanceTweaks.MD#optimize-systemd-journald-service)

## Use a Windows10 Theme

[Debian Windows10 Theme](https://github.com/avarghesein/-NIX/blob/main/Lubuntu%2020.04/WIN10-Theme/HowTo.md)

## Enhance Sound Quality and USB Sound Card Support

Follow [this link](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%204/EnhanceAudio.md) for implementation instructions

## Enable Audio and Custom Resolutions with RDP Remote Sessions

Follow [this link](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%204/EnableSoundInRDP.md) for implementation instructions

## Use a "Server Side" Browser to make Browsing Faster

To cope with the less processing power of RaspberryPi, use a Browser which offloads javascript executions to Cloud Servers.

This makes the Browsing experience incredibly faster.

Try Puffin Browser, which is the [fastest server side browser](https://cloudmosa.medium.com/puffin-browser-is-faster-than-other-browsers-heres-why-d5c7d8f0fcb6).

[Install from deb package](https://www.puffin.com/cloud-learning/download)

Note: Since Puffin uses old versions of ChromeEngine, some sites may not load properly.

## Add a "Show Desktop" Launcher To Toolbar
1. Navigate to "Start>Preferences>Main Menu Editor"
2. Click "New Item" Button
3. Give Name as "Show Desktop" and Command as 

        xdotool key --clearmodifiers ctrl+alt+d

4. Give a proper image as icon and Check "Lanuch In Terminal"
5. Right click on "Tool Bar" and click on "Application Launch Bar Settings"
6. Add the newly created "Show Desktop" item

[Reference](https://www.itsupportguides.com/knowledge-base/ubuntu/ubuntu-how-to-enable-show-desktop-icon/)
