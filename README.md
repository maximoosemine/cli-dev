# Keyboard Config

I have a Keychron K15 Max.

## Critical Config

My keyboard has a `fn` key between each side of the space bar. I have that remapped to `ctrl + space` for tmux (Since `ctrl` and `cmd` are swapped for iTerm2, there's a keybind in the profile to map this macro back to `ctrl`).
On Windows, I have the modifier keys remapped in this order from the space bar out: `ctrl`, `alt`, `win`.
Caps lock should be remapped to `esc`.

## Other Config

In the upper right corner, the K15 comes with a delete key, then an insert key (one in to the left). The inner of the two should be remapped to delete, and the outer key should be remapped to end.

The K15 comes with 5 macros. The first one `M1` has been swapped with `fn` between the space bar.
- `M2`: Switch window (`cmd + tab` or `alt + tab`).
- `M3`: Capture region. On my Windows host I have Greenshot installed and capture region is bound to printscreen. On Mac, it's bound to `cmd + shift + 3`.
- `M4`: Record screen. On my Windows host, I have ScreenToGif installed and an AHK script that launches it when I press `win + ctrl + F3`. On Mac, it's bound to `cmd + shift + 4`.
- `M5`: On my Windows host, I have this bound to `win`, because the key that would otherwise be bound to `win` is bound to `alt + space` to pull up the command palette. On mac, I have it bound to `option + space` to pull up Claude.

The K15 has this handy scroll wheel. On Mac, I use it for volume and mute. I don't listen to music on my Windows host, so I have it mapped to control my monitor's brightness by setting up hotkeys through Twinkle Tray, and pressing the scroll wheel locks my computer.

# Colors

All colors are based off of the [Everforest](https://github.com/sainnhe/everforest) theme.

# Fonts

Download and install 0xProto Nerd Font Mono [here](https://www.nerdfonts.com/font-downloads).

# Terminal Configuration

## PuTTY/KiTTY

Changes to the defaults:

* "Disable application cursor keys mode" -> true
* "Disable application keypad mode" -> true
* "Cursor appearance" -> Block

| Color | RGB Values |
|-------|------------|
| Default Foreground | rgb(211, 198, 170) |
| Default Bold Foreground | rgb(239, 235, 226) |
| Default Background | rgb(45, 53, 59) |
| Default Bold Background | rgb(17, 20, 23) |
| Cursor Color | rgb(239, 235, 226) |
| ANSI Red | rgb(230, 126, 128) |
| ANSI Green | rgb(167, 192, 128) |
| ANSI Yellow | rgb(219, 188, 127) |
| ANSI Blue | rgb(127, 187, 179) |
| ANSI Magenta | rgb(214, 153, 182) |
| ANSI Cyan | rgb(131, 192, 146) |

*All bold ANSI variants are the same as their non-bold variants*

## iTerm2

Install the included iTerm2 JSON profile.

Configure iTerm2:
- Remap ctrl keys to cmd, and cmd keys to ctrl.
- Set Appearance -> General -> Theme to Minimal.

# Development Machine Configuration

* If your development machine is a remote machine, set up an SSH public key.
* Disable password on sudo: `visudo` and append to the end: `<username> ALL=(ALL) NOPASSWD: ALL` (replace `<username>` with your username).
* Install ZSH: `sudo apt install zsh` (if you're on Mac, you already have it).
* Set timezone so tmux shows the correct time: `sudo timedatectl set-timezone America/Los_Angeles`.

# Install Software

* Install node 20 and npm yourself. Recommended to use nvm.
* Install nvim using `updateNvim-*.sh`.
* Run commands from `install.sh`.
* Install mycli using the following instructions: https://github.com/dbcli/mycli/discussions/1401
* Install tmux if necessary (Mac will need it).

# Set up .zshrc

* Point at the .zshrc in this repo.
* Run `install-omz-theme.sh`.
* Configure PATH to include nvim. Example:

    ```
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
    ```

* Source fzf keybinding script. Example:

    ```
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    ```

# Set up .tmux.conf

Include the `.tmux.conf` in this repo in your `~/.tmux.conf` (creating it if necessary) using the `source-file` directive.

# Set up nvim

Source the `nvim/init.vim` file in your nvim config.
Run `:PlugInstall` and update any paths in this config.

# Set up .gitconfig

Include the `.gitconfig` in this repo in your `~/.gitconfig`. Make sure to configure your name and e-mail.

# Set up .myclirc

Set up `~/.local-myclirc` to contain all local configuration (database aliases for example).

Run `install-myclirc.sh`.

# Other Handy Software

## Windows

- Command Palette. Like Spotlight on Mac.
- Twinkle Tray. For controlling monitor brightness on a schedule or with hotkeys.
- Auto Hot Key.
- Greenshot.
- ScreenToGif.
