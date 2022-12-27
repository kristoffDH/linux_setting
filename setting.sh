
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

git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes

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

# fzf 검색 옵션 fd로 변경
export FZF_DEFAULT_COMMAND=’fd — type f’

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function bat_tail {
    tail -f "$@" | cat --paging=never -l log
}

s=' ' # fix too wide icons
POWERLEVEL9K_MODE=nerdfont-complete
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_beginning
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true # <- Set this to false for simgle line prompt
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='${P9K_CONTENT} $(whoami | grep -v "^root\$")'
POWERLEVEL9K_OS_ICON_BACKGROUND=red
POWERLEVEL9K_OS_ICON_FOREGROUND=white
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND=black
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND=red
POWERLEVEL9K_SSH_BACKGROUND=white
POWERLEVEL9K_SSH_FOREGROUND=blue
POWERLEVEL9K_FOLDER_ICON=
POWERLEVEL9K_DIR_BACKGROUND=blue
POWERLEVEL9K_DIR_FOREGROUND=black
POWERLEVEL9K_DIR_WRITABLE_BACKGROUND=black
POWERLEVEL9K_DIR_WRITABLE_FOREGROUND=red
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=black
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=green
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=black
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=yellow
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=white
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=black
POWERLEVEL9K_VCS_UNTRACKED_ICON=●
POWERLEVEL9K_VCS_UNSTAGED_ICON=±
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=↓
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=↑
POWERLEVEL9K_VCS_COMMIT_ICON=$s
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_EXECUTION_TIME_ICON=$s
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=black
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=blue
POWERLEVEL9K_COMMAND_BACKGROUND_JOBS_BACKGROUND=black
POWERLEVEL9K_COMMAND_BACKGROUND_JOBS_FOREGROUND=cyan
POWERLEVEL9K_TIME_ICON=
POWERLEVEL9K_TIME_FORMAT='%D{%I:%M}'
POWERLEVEL9K_TIME_BACKGROUND=black
POWERLEVEL9K_TIME_FOREGROUND=white
POWERLEVEL9K_RAM_ICON=
POWERLEVEL9K_RAM_FOREGROUND=black
POWERLEVEL9K_RAM_BACKGROUND=yellow
POWERLEVEL9K_VI_MODE_FOREGROUND=black
POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=green
POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND=blue
POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=OVERTYPE
POWERLEVEL9K_VI_MODE_OVERWRITE_BACKGROUND=red
POWERLEVEL9K_VI_INSERT_MODE_STRING=
POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B2'
POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B0'
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%F{blue}╭─'
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}╰%f '
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator ssh dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status command_execution_time background_jobs time ram)

ZLE_RPROMPT_INDENT=0

# ---- load POWERLEVEL10K ---
source ~/.oh-my-zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
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
