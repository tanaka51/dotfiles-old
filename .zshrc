export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

## 補完機能の強化
autoload -U compinit
compinit

## プロンプトの設定
autoload colors
colors
GIT_PS1_SHOWDIRTYSTATE=1
setopt prompt_subst
PROMPT='`whoami`%{$fg[cyan]%}%#%{$reset_color%} '
RPROMPT='[%{$fg[white]%}%(8~,%-1~/.../%1~,%~)%{$reset_color%}%{$fg[green]%}$(__git_ps1 " %s")%{$reset_color%} %{$fg[red]%}$(rvm_prompt)%{${reset_color}%}]'
if [[ -r /proc/loadavg ]]; then
    PROMPT='%{$(load_avg)%}%{$reset_color%}'$PROMPT
else
    PROMPT=''$PROMPT
fi

## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## ビープを鳴らさない
setopt nobeep
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## 補完候補を一覧表示
setopt auto_list
## 補完候補を詰めて表示
setopt list_packed
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## cd 時に自動で push
setopt autopushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## TAB で順に補完候補を切り替える
setopt auto_menu
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## =command を command のパス名に展開する
setopt equals
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## 出力時8ビットを通す
setopt print_eight_bit
## ヒストリを共有
setopt share_history
## 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## 補完候補のカーソル選択を有効に
zstyle ':completion:*' menu select=1
## 補完候補の色づけ
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## ディレクトリ名だけで cd
setopt auto_cd
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## エイリアス
setopt complete_aliases

## 補完方法の設定。指定した順番に実行する。
### _oldlist 前回の補完結果を再利用する。
### _complete: 補完する。
### _match: globを展開しないで候補の一覧から補完する。
### _history: ヒストリのコマンドも補完候補とする。
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix
## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
## 詳細な情報を使う。
zstyle ':completion:*' verbose yes
## sudo時にはsudo用のパスも使う。
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

## カーソル位置で補完する。
setopt complete_in_word
## globを展開しないで候補の一覧から補完する。
setopt glob_complete
## 補完時にヒストリを自動的に展開する。
setopt hist_expand
## 補完候補がないときなどにビープ音を鳴らさない。
setopt no_beep
## 辞書順ではなく数字順に並べる。
setopt numeric_glob_sort


# 展開
## --prefix=~/localというように「=」の後でも
## 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst
## 拡張globを有効にする。
## glob中で「(#...)」という書式で指定する。
setopt extended_glob
## globでパスを生成したときに、パスがディレクトリだったら最後に「/」をつける。
setopt mark_dirs

source ~/dotfiles/.git-completion.sh

alias ls='ls -G'
alias la="ls -G -a"
alias lf="ls -G -F"
alias ll="ls -G -l"
alias sl='ls -G'
alias rm='rm -i'

alias g='git'
compdef g=git
alias gst='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gb='git branch'
alias glg='git log --stat --max-count=5'
alias ga='git add'
alias gm='git merge'
alias gpr='git pull --rebase'
alias gg='git grep -n -i -I --color'
alias gcom='git checkout master'
alias gd='g diff'
alias gdc='g diff --cached'

alias r='rails'
alias be='bundle exec'
alias ber='bundle exec rails'

alias reload='source ~/.zshrc'

alias ec='emacsclient'

if [ `uname` = "Darwin" ]; then
    export PATH="$PATH:/opt/local/bin:/opt/local/sbin/"
    # for Ruby on Android
    export PATH="$PATH://Applications/android-sdk-macosx/platform-tools:/Applications/android-sdk-macosx/tools"
    export MANPATH="/opt/local/man:$MANPATH"
    export LANG=ja_JP.UTF-8
    export CC="/opt/local/bin/gcc-apple-4.2"
    [[ -s "/Users/koichi/.rvm/scripts/rvm" ]] && source "/Users/koichi/.rvm/scripts/rvm"  # This loads RVM into a shell session.
fi

function rvm_prompt {
    result=`rvm-prompt v g 2> /dev/null`
    if [ "$result" ] ; then
echo "$result"
    fi
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
