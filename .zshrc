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
PROMPT='`whoami`%{$fg[cyan]%}$%{$reset_color%} '
RPROMPT='[%{$fg[white]%}%(8~,%-1~/.../%1~,%~)%{$reset_color%}%{$fg[green]%}$(__git_ps1 " %s")%{$reset_color%}]'

unsetopt promptcr     # 出力の文字列末尾に改行コードが無い場合でも表示

setopt nobeep         # ビープを鳴らさない
setopt long_list_jobs # 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt list_types     # 補完候補一覧でファイルの種別をマーク表示
setopt auto_resume    # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_list      # 補完候補を一覧表示
setopt list_packed    # 補完候補を詰めて表示
setopt hist_ignore_dups     # 直前と同じコマンドをヒストリに追加しない
setopt autopushd            # cd 時に自動で push
setopt pushd_ignore_dups    # 同じディレクトリを pushd しない
setopt auto_menu            # TAB で順に補完候補を切り替える
setopt extended_history     # zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt equals               # =command を command のパス名に展開する
setopt hist_verify          # ヒストリを呼び出してから実行する間に一旦編集
setopt print_eight_bit      # 出力時8ビットを通す
setopt share_history        # ヒストリを共有
setopt auto_cd              # ディレクトリ名だけで cd
setopt auto_param_keys      # カッコの対応などを自動的に補完
setopt auto_param_slash     # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt correct              # スペルチェック
setopt complete_aliases     # エイリアス

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # ## 補完時に大小文字を区別しない
zstyle ':completion:*' menu select=1                      # ## 補完候補のカーソル選択を有効に

## 補完候補の色づけ
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## 補完方法の設定。指定した順番に実行する。
### _oldlist 前回の補完結果を再利用する。
### _complete: 補完する。
### _match: globを展開しないで候補の一覧から補完する。
### _history: ヒストリのコマンドも補完候補とする。
### _ignored: 補完候補にださないと指定したものも補完候補とする。
### _approximate: 似ている補完候補も補完候補とする。
### _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer \
    _complete _match _ignored _approximate _prefix
## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
## 詳細な情報を使う。
zstyle ':completion:*' verbose yes
## sudo時にはsudo用のパスも使う。
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

setopt complete_in_word  # カーソル位置で補完する。
setopt glob_complete     # globを展開しないで候補の一覧から補完する。
setopt hist_expand       # 補完時にヒストリを自動的に展開する。
setopt no_beep           # 補完候補がないときなどにビープ音を鳴らさない。
setopt numeric_glob_sort # 辞書順ではなく数字順に並べる。


# 展開
## --prefix=~/localというように「=」の後でも
## 「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst
## 拡張globを有効にする。
## glob中で「(#...)」という書式で指定する。
setopt extended_glob
## globでパスを生成したときに、パスがディレクトリだったら最後に「/」をつける。
setopt mark_dirs

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|_-"
zstyle ':zle:*' word-style unspecified


source ~/bin/.git-completion.sh

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
alias gcm='gc -m'

alias r='rails'
alias be='bundle exec'
alias ber='bundle exec rails'

alias reload='source ~/.zshrc'

alias e='emacsclient -t'
if pgrep emacs >/dev/null 2>&1; then
  echo "Emacs server is already running..."
elif pgrep Emacs >/dev/null 2>&1; then
  echo "Emacs server is already running..."
else
  `emacs --daemon`
fi

if [ `uname` = "Darwin" ]; then
  export PATH="$PATH://Applications/android-sdk-macosx/platform-tools:/Applications/android-sdk-macosx/tools"
  export PATH="$PATH:/usr/local/share/npm/bin"
  export PATH="$PATH:$HOME/bin"
  export PATH="/usr/local/bin:$PATH"
  export JAVA_HOME=/Library/Java/Home
  export CATALINA_HOME=/usr/local/tomcat
  alias ff='/Applications/Firefox.app/Contents/MacOS/firefox'
fi

if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
