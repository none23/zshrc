#!/bin/zsh

__file_exists () { [[ -a "$1" ]] }

__FZF_ROOT="$HOME/.fzf"

# Use fd instead of the default find command for listing path candidates.
_fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1" }

# Use fd to generate the list for directory completion
_fzf_compgen_dir() { fd --type d --hidden --follow --exclude ".git" . "$1" }

__fzf_install () {
  git clone --depth 1 https://github.com/junegunn/fzf.git "$__FZF_ROOT" \
    && "$__FZF_ROOT/install"
}

__file_exists "$__FZF_ROOT"

export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || fd --type f --exclude coverage --exclude node_modules --exclude flow-typed) 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source "$__FZF_ROOT/shell/completion.zsh" 2> /dev/null
source "$__FZF_ROOT/shell/key-bindings.zsh"

