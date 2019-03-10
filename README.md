# Auto-Ricing Arch Linux

This project is to bootstrap a fresh Arch Linux installation with all the basic tools I need.
Inspired by [i3wm-themer](https://github.com/unix121/i3wm-themer), actually, I'm using 004 theme here :)

## Usage

`curl -L https://bit.ly/p31d3ng-ricing -o a.sh && sh a.sh`

## Customizations

- Default shell is setting to fish while logging in.
- Xmodmap for emulating HHKB layout! Once you go HHKB you'll never go back :)
- Using Emacs keybinding in VS Code with some minor changes. Yes I'm using VIM + Emacs at the same time!

## Packages to be installed

| Required? | Name                        | Description                                                                          | Source |
| --------- | --------------------------- | ------------------------------------------------------------------------------------ | ------ |
| Y         | sudo                        | For adding sudoers                                                                   | pacman |
| Y         | go                          | Dependencies for Yay package manager for AUR, and of course, for the task framework. | pacman |
| Y         | ntp                         | For time/timezone sync                                                               | pacman |
| Y         | dhcp                        | For network address lease                                                            | pacman |
| Y         | git                         | Version control, also critical dependencies for later scripts                        | pacman |
| Y         | base-devel                  | Dependencies for polybar etc.                                                        | pacman |
| Y         | python                      | who don't need python :)                                                             | pacman |
| Y         | python-pip                  | python package manager                                                               | pacman |
| Y         | xorg-server                 | Xorg display server                                                                  | pacman |
| Y         | xorg-xrdb                   | For Xresources, basically for global emacs keybindings                               | pacman |
| Y         | xorg-xrandr                 | For multi-monitor display and resolution adjustment                                  | pacman |
| Y         | xorg-xmodmap                | For remapping keyboarding to my customized HHKB layout                               | pacman |
| Y         | xorg-xdpinfo                | For determining current display resolution                                           | pacman |
| Y         | xorg-xbacklight             | backlight control for laptops                                                        | pacman |
| Y         | networkmanager              | For managing network connections                                                     | pacman |
| Y         | xfce4-power-manager         | For log off/reboot/shutdown                                                          | pacman |
| Y         | i3-gaps                     | i3 window managaer with gaps between windows                                         | pacman |
| Y         | rofi                        | App quick lanucher like Mac Spotlight/Alfred                                         | pacman |
| Y         | rxvt-unicode                | Terminal emulator                                                                    | pacman |
| Y         | adobe-source-code-pro-fonts | fonts                                                                                | pacman |
| Y         | ttf-font-awesome            | fonts                                                                                | pacman |
| Y         | lxdm                        | A fast and lightweight login manager                                                 | pacman |
| Y         | jsoncpp                     | Dependencies for something which I forgot, basically adding json support to cpp      | pacman |
| Y         | ranger                      | File explorer which looks awesome                                                    | pacman |
| Y         | feh                         | Image viewer, also for setting desktop background                                    | pacman |
| Y         | polybar-git                 | status bar for i3 window manager                                                     | AUR    |
| Y         | ttf-nerd-fonts-symbols      | font                                                                                 | AUR    |
| Y         | pamac-tray-appindicator     | GUI for all installed packages                                                       | AU     |
| N         | facter                      | For summarize system hardware information                                            | pacman |
| N         | zeal                        | Ofiicial documentation lookup tool for development                                   | pacman |
| N         | fish                        | My favorite shell                                                                    | pacman |
| N         | VIM                         | Yeah I'm a VIM + Emacs user, VIM in terminal and VS Code + Emacs keybindings for dev | pacman |
| N         | jq                          | Terminal JSON query tool                                                             | pacman |
| N         | visual-studio-code-bin      | VS Code :) My personal favorite                                                      | AUR    |
| N         | clipit                      | Pasteboard history management tool                                                   | AUR    |
| N         | lxdm-themes                 | Making LXDM look better                                                              | AUR    |
| N         | firefox                     | browser, basically for DNS-over-HTTPS                                                | AUR    |
| N         | google-chrome               | browser, since firefox does NOT honor gtk keybindings anymore                        | AUR    |

## To-Do

- [ ] go tool to change theme like i3wm-themer
