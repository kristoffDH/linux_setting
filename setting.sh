
# defore running shell

# add sudoers 
# echo "$(USER) ALL=(ALL:ALL) ALL" | sudo tee -a /etc/sudoers

# install git
# sudo install apt git

###############################################################

#!/bin/bash
CUR_WORK_PATH=$(pwd)
# update
echo "--------------------------------------------"
echo "Update add"
echo "--------------------------------------------"
sudo apt remove -y unattended-upgrades
sudo apt update -y
sudo apt upgrade -y

# install apt package
echo "--------------------------------------------"
echo "Install apt package"
echo "--------------------------------------------"
sudo apt install -y build-essential software-properties-common libssl-dev make curl tree python-openssl unzip
sudo apt install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
sudo apt install -y terminator fzf fd-find fasd openssh-server net-tools
sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat ripgrep

sudo dpkg -i $CUR_WORK_PATH/lsd_0.20.1_amd64.deb

# install neovim (nvim)
pip3 install --user neovim
sudo apt-get install -y neovim

# python3 link to python
sudo ln -s /usr/bin/python3 /usr/bin/python

# install vim-plug 
mkdir -p ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# setting nvim config
mkdir -p ~/.config/nvim/
cp $CUR_WORK_PATH/init.vim ~/.config/nvim/


# install zsh
sudo apt-get install -y zsh

# install oh-my-zsh
cd ~
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# zsh headline theme
git clone https://github.com/moarram/headline.git ~/.oh-my-zsh/custom/themes/headline

# zsh install auto-suggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# zsh install fast-syntax-highlighting plugin
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

# zsh alias-tip plugin
git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

# zsh autopair plugin
git clone https://github.com/hlissner/zsh-autopair ~/.oh-my-zsh/custom/plugins/zsh-autopair

# install fzf plugin
git clone https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf
./install --all

# copy theme file
cp $CUR_WORK_PATH/zsh_theme/* ~/.oh-my-zsh/custom/themes/

# setting .zshrc
sed -i "s/robbyrussell/headline\/headline/" ~/.zshrc
sed -i "s/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\n#zsh-syntax-highlighting\nfast-syntax-highlighting\ndocker\ndocker-compose\nalias-tips\ncommand-not-found\ngitfast\npip\nsudo\nurltools\nripgrep\nfzf\nfasd\nzsh-autopair\n)/" ~/.zshrc

cat << EOF >> ~/.zshrc
alias ls="lsd"
alias ll="lsd -al"
alias lt="lsd --tree"
alias vi='nvim'
alias fd='fdfind'
alias cat='batcat'
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

eval "$(fasd --init auto)"

export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "

# fzf ?????? ?????? fd??? ??????
export FZF_DEFAULT_COMMAND=???fd ??? type f???

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

EOF

# Modify login shell
sudo sed -i "s/${USER}:\/bin\/bash/${USER}:\/bin\/zsh/" /etc/passwd

# Copy Hack Font
FONT_PATH=~/.local/share/fonts
mkdir -p $FONT_PATH
cp $CUR_WORK_PATH/Hack_Font.ttf $FONT_PATH/

# Terminator config
TERMINATOR_CFG_PATH=~/.config/terminator
mkdir -p $TERMINATOR_CFG_PATH
cat << EOF > $TERMINATOR_CFG_PATH/config
[global_config]
[keybindings]
[profiles]
  [[default]]
    cursor_color = "#aaaaaa"
    font = Hack Nerd Font 11
    use_system_font = False
[layouts]
  [[default]]
    [[[window0]]]
      type = Window
      parent = ""
    [[[child1]]]
      type = Terminal
      parent = window0
[plugins]
EOF

# Autopair init
#autopair-init

# fd ignore setting
touch $CUR_WORK_PATH/.fdignore
