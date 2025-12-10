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

* Install node 20 and npm yourself. Recommended to use nvm.
* Install nvim using `updateNvim-*.sh`.
* Run commands from `install.sh`.
* Install mycli using the following instructions: https://github.com/dbcli/mycli/discussions/1401

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

Include the `.tmux.conf` in this repo in your `~/.tmux.conf` using the `source-file` directive.

# Set up nvim

Source the `nvim/init.vim` file in your nvim config.
Run `:PlugInstall` and update any paths in this config.

# Set up .gitconfig

Include the `.gitconfig` in this repo in your `~/.gitconfig`. Make sure to configure your name and e-mail.

# Set up .myclirc

Set up `~/.local-myclirc` to contain all local configuration (database aliases for example).

Run `install-myclirc.sh`.
