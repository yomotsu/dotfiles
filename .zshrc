#文字コード
export LANG=ja_JP.UTF-8

#プロンプト
autoload colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%{'${fg[red]}'%}(%s %b) %{'$reset_color'%}'

setopt prompt_subst
precmd () {
  LANG=en_US.UTF-8 vcs_info
  if [ -z "${SSH_CONNECTION}" ]; then
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
[%n]$ "
  else
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
  fi
}

PROMPT2='[%n]> ' 

#補間
autoload -U compinit
compinit -u

#補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#ディレクトリ名だけで移動できる 
setopt auto_cd 

#lsと補間にでる一覧の色
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

#nvmでNode.jsのバージョンを自動で設定する
# nvm と指定されたバージョンの Node.js がインストール済みの場合だけ
# 設定を有効にする
if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh

  if which nvm >/dev/null 2>&1 ;then
    _nodejs_use_version="v0.6.14"
    if nvm ls | grep -F -e "${_nodejs_use_version}" >/dev/null 2>&1 ;then
      nvm use "${_nodejs_use_version}" >/dev/null
    fi
    unset _nodejs_use_version
  fi
fi
