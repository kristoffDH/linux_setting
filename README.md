# linux_setting

## vim
설치 완료 후 실행해서 :PlugInstall 로 플러그인 설치 필요.


## fasd alias
alia a='fasd -a'        # any <br/>
alias s='fasd -si'       # show / search / select <br/>
alias d='fasd -d'        # directory <br/>
alias f='fasd -f'        # file <br/>
alias sd='fasd -sid'     # interactive directory selection <br/>
alias sf='fasd -sif'     # interactive file selection <br/>
alias z='fasd_cd -d'     # cd, same functionality as j in autojump <br/>
alias zz='fasd_cd -d -i' # cd with interactive selection <br/>


## fzf hot-key
Ctrl + R : View & Select History
Alt + C : current directory & change directory


## /etc/sudoers 수정
defaults secure_path 주석처리하고 아래 내용으로 변경
```
#Defaults       secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
Defaults env_keep=PATH
```
