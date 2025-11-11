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

## Mac Terminal

Install the attached `mac.terminal` file.

# Development Machine Configuration

* If your development machine is a remote machine, set up an SSH public key.
* Disable password on sudo: `visudo` and append to the end: `<username> ALL=(ALL) NOPASSWD: ALL` (replace `<username>` with your username).
* Install ZSH: `sudo apt install zsh` (if you're on Mac, you already have it).
* If mounting any drives, set UID and GID to yourself (so you don't have to sudo to write) and set fmask to 117 and dmask to 007 (prevents `ls` from doing any crazy highlighting).

# Install Software

Install node and npm yourself.

Run `install.sh`.

