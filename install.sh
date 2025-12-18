# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Set up fzf key bindings and fuzzy completion (unless it already did it)
source <(fzf --zsh)

# Install vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install language servers
npm i -g intelephense @vtsls/language-server @vue/language-server remark-language-server

curl https://sh.rustup.rs -sSf | sh
rustup component add rust-analyzer

# Install ripgrep (note that FzfLua will silently fall back to grep if this isn't installed and it will be slow)
sudo apt install ripgrep
