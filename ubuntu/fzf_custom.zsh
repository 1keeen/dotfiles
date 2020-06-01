export FZF_DEFAULT_OPTS='-e --height 100% --reverse --border --ansi'
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# git 関連処理
function is_git_repo() {
    git rev-parse &>/dev/null
    if [ $? -ne 0 ]; then
        echo false
        return
    fi
    echo true
}

## コミットの履歴を見ながらgitのログを見る

function gl() {
    if [[ $(is_git_repo) == "false" ]]; then
        echo "not a git repository"
        return 0
    fi
  git log --graph --color=always \
      --format="%C(auto) %h%d %s %an %C(black)%C(bold)%cr" "$@" |
      fzf -e --height 100% --prompt "Log>" --preview 'f(){
      local original=$@
        set -- $(echo "$@");
        id=$(echo $original | grep -o "[a-f0-9]\{7\}" | head -1)
        git show --color=always $id};f {}' \
        --preview-window right:50%:hidden --bind '@:toggle-preview'\
       --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
       --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

        #set -- $(echo "$@"); git show --color=always $2 };f {}' \
## コミットの履歴を見ながらgitのブランチを切り替える
function gb() {
    if [[ $(is_git_repo) == "false" ]]; then
        echo "not git repository"
        return 0
    fi
    local selected
    selected=$(git branch -a |grep -v HEAD |fzf -e --height 100% --prompt "CHECKOUT BRANCH>" --preview 'f(){
    set -- $(echo "$@"); git log --color=always $1 };f {}'| awk '{print $1}')
    if [[ -n "$selected" ]]; then
        if [[ $selected = *origin* ]]; then
            selected=$(echo $selected | sed -e 's/origin\///g')
        fi
        selected=$(echo $selected |cut -d "/" -f 2-)
        git checkout $selected
        local ret=$?
        zle reset-prompt 2> /dev/null
        return $ret
       fi
}

function __git_common() {
    if [[ $(is_git_repo) == "false" ]]; then
        echo "not git repository" >&2
        return 0
    fi
    local selected
    selected=$(unbuffer git status -u -s | \
    fzf -e --height 100% -m --ansi --reverse --prompt "$1"  --preview 'f() {
      local original=$@
      set -- $(echo "$@");
      if [ $(echo $original | grep -E "^M" | wc -l) -eq 1 ]; then # staged
        git diff --color --cached $2
      elif [ $(echo $original | grep -E "^\?\?" | wc -l) -eq 0 ]; then # unstaged
        git diff --color $2
      elif [ -d $2 ]; then # directory
        ls -la $2
      else
        git diff --color --no-index /dev/null $2 # untracked
      fi
  }; f {}' --preview-window right:50%:hidden --bind '@:toggle-preview')
    echo $selected
}
## ステータスをコマンドライン入力できる
function gss() {
    local selected
    selected=$(__git_common "Git Status>") &&
    if [[ -n "$selected" ]]; then
        selected=$(echo $selected | sed -e 's/^ //g' -e 's/  */ /g' | cut -d " " -f 2 | tr '\n' ' ')
        echo $selected
        LBUFFER="${LBUFFER}"$(echo $selected)
    fi;
    local ret=$?
    zle reset-prompt 2> /dev/null
    return $ret
}

## vimtoolで選択したファイルのdiffを見る
function gd() {
    local selected
    selected=$(__git_common "Diff>") &&
    if [[ -n "$selected" ]]; then
        selected=$(echo $selected | sed -e 's/^ //g' -e 's/  */ /g' | cut -d " " -f 2 | tr '\n' ' ')
        arr=(`echo $selected`)
        git difftool $arr ||
            nvim $arr 2> /dev/null
    fi;
    local ret=$?
    zle reset-prompt 2> /dev/null
    return $ret
}

## 変更履歴を表示
function gs() {
    local selected
    selected=$(__git_common "Diff>") &&
    if [[ -n "$selected" ]]; then
        selected=$(echo $selected | sed -e 's/^ //g' -e 's/  */ /g' | cut -d " " -f 2 | tr '\n' ' ')
        arr=(`echo $selected`)
        git diff $arr 2> /dev/null
    fi;
    local ret=$?
    zle reset-prompt 2> /dev/null
    return $ret
}


## 選択したファイルをvimで開く
function gsv() {
    local selected
    selected=$(__git_common "Open Vim>") &&
    if [[ -n "$selected" ]]; then
        selected=$(echo $selected | sed -e 's/^ //g' -e 's/  */ /g' | cut -d " " -f 2 | tr '\n' ' ')
        arr=(`echo $selected`)
        nvim $arr 2> /dev/null
    fi;
    local ret=$?
    zle reset-prompt 2> /dev/null
    return $ret
}


## 選択したファイルをaddする
function ga() {
    local selected
    selected=$(__git_common "Git Add>") &&
    if [[ -n "$selected" ]]; then
        selected=$(echo $selected | sed -e 's/^ //g' -e 's/  */ /g' | cut -d " " -f 2 | tr '\n' ' ')
        arr=(`echo $selected`)
        git add $arr
        echo $arr "added" >&1
    fi;
    local ret=$?
    zle reset-prompt 2> /dev/null
    return $ret
}

## 選択したファイルをcheckoutする
function gc() {
    local selected
    selected=$(__git_common "Git Checkout>") &&
    if [[ -n "$selected" ]]; then
        selected=$(echo $selected | sed -e 's/^ //g' -e 's/  */ /g' | cut -d " " -f 2 | tr '\n' ' ')
        arr=(`echo $selected`)
        git checkout $arr
        echo $arr "checkouted" >&1
    fi;
    local ret=$?
    zle reset-prompt 2> /dev/null
    return $ret
}


## 選択したファイルをresetする
function gr() {
    local selected
    selected=$(__git_common "Git Rest>") &&
    if [[ -n "$selected" ]]; then
        selected=$(echo $selected | sed -e 's/^ //g' -e 's/  */ /g' | cut -d " " -f 2 | tr '\n' ' ')
        arr=(`echo $selected`)
        git reset HEAD $arr
        echo "reset" $arr >&1
    fi;
    local ret=$?
    zle reset-prompt 2> /dev/null
    return $ret
}

PREVIEW_PARAM='[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {})'

## gitリポジトリのファイルを検索して開く
gv() {
  if [[ $(is_git_repo) == "false" ]]; then
      echo "not git repository"
      return 0
  fi
  files=$(git ls-files) &&
        selected_files=$(echo "$files" | fzf -e --height 100% -m\
        --preview "${PREVIEW_PARAM} 2> /dev/null" --preview-window right:50%:hidden --bind '@:toggle-preview') &&
        nvim $selected_files
}

# ファイル操作系　
## カレントディレクトリ以下のフォルダー名を検索して開く
ff() {
    files=$(unbuffer ag -g $1 ./) &&
        selected_files=$(echo "$files" | fzf -e --height 100% -m\
        --preview "${PREVIEW_PARAM} 2> /dev/null" --preview-window right:50%:hidden --bind '@:toggle-preview') &&
        nvim $selected_files
}

fd() {
    files=$(unbuffer ag -g $1 ./) &&
        selected_files=$(echo "$files" | fzf -e --height 100% -m\
        --preview "${PREVIEW_PARAM} 2> /dev/null" --preview-window right:50%:hidden --bind '@:toggle-preview') &&
        dir=${selected_files%/*}
        cd $dir
}




## カレントディレクトリ以下のファイル名を検索して開く。
fal() {
    file=$(unbuffer ag -l $1 ./ | \
    fzf -e --height 100% -m --ansi --reverse --prompt "Ag>"  --preview 'f() {
      local original=$@
      local line
      set -- $(echo "$@");
      line=$(echo $1 | cut -d ':' -f 1)
      highlight -O ansi -l $line ||
                      coderay $line ||
                      rougify $line ||
                      cat $line 2> /dev/null
  }; f {}' --preview-window right:50%:hidden --bind '@:toggle-preview')
  local selected_files
  selected_files=$(echo $file | cut -d ':' -f 1)
  if [[ -n $selected_files ]]; then
      nvim $selected_files
  fi
}

## カレントディレクトリ以下のファイルの中身を検索して開く。
fa() {
    file=$(unbuffer ag $1 ./ | \
    fzf -e --height 100% -m --ansi --reverse --prompt "Ag>"  --preview 'f() {
      local original=$@
      local line
      set -- $(echo "$@");
      line=$(echo $1 | cut -d ':' -f 1)
      highlight -O ansi -l $line ||
                      coderay $line ||
                      rougify $line ||
                      cat $line 2> /dev/null
  }; f {}' --preview-window right:50%:hidden --bind '@:toggle-preview')
  local selected_files
  selected_files=$(echo $file | cut -d ':' -f 1)
  if [[ -n $selected_files ]]; then
      nvim $selected_files
  fi
}

## カレントディレクトリ以下のファイルの中身を検索して、ファイル名を表示。
fag() {
    file=$(unbuffer ag -g $1 ./ | \
    fzf -e --height 100% -m --ansi --reverse --prompt "Ag>"  --preview 'f() {
      local original=$@
      local line
      set -- $(echo "$@");
      line=$(echo $1 | cut -d ':' -f 1)
      highlight -O ansi -l $line ||
                      coderay $line ||
                      rougify $line ||
                      cat $line 2> /dev/null
  }; f {}' --preview-window right:50%:hidden --bind '@:toggle-preview')
  local selected_files
  selected_files=$(echo $file | cut -d ':' -f 1)
  if [[ -n $selected_files ]]; then
      nvim $selected_files
  fi
}


fdd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf -e +m) &&
  cd "$dir"
}

dstart() {
  local container
  container="$(docker ps -a -f status=exited | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'starting container...'
    docker start ${container}
  fi
}

dstop() {
  local container
  container="$(docker ps -a -f status=running | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'stopping container...'
    docker stop ${container}
  fi
}

dcon() {
  local container
  container="$(docker ps -a -f status=running | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    docker exec -it ${container} /bin/bash
  fi
}

dlog() {
  local container
  container="$(docker ps -a -f status=running | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    docker logs -f --tail 100 ${container}
  fi
}

drm() {
  local container
  container="$(docker ps -a -f status=exited | sed -e '1d' | fzf --height 40% --reverse | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'removing container...'
    docker rm ${container}
  fi
}

drmi() {
  local image
  image="$(docker images -a | sed -e '1d' | fzf --height 40% --reverse | awk '{print $3}')"
  if [ -n "${image}" ]; then
    echo 'removing container image...'
    docker rmi ${image}
  fi
}

zle -N gb
bindkey '^F^B' gb

zle -N gl
bindkey '^F^L' gl

zle -N gs
bindkey '^F^S' gs

zle -N ga
bindkey '^F^A' ga

zle -N gv
bindkey '^F^V' gv

zle -N ff
bindkey '^F^F' ff
