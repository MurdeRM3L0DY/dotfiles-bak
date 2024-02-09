[[ $COLORTERM = *(54bit|truecolor)* ]] || zmodload zsh/nearcolor
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"

# zsh completions
for profile in ${(z)NIX_PROFILES}; do
  fpath+=(
    $profile/share/zsh/site-functions
    $profile/share/zsh/$ZSH_VERSION/functions
    $profile/share/zsh/vendor-completions
  )
done
autoload -Uz _zi add-zsh-hook
(( ${+_comps} )) && _comps[zi]=_zi
zicompinit

zi light-mode for \
  z-shell/z-a-meta-plugins \
    @annexes \
    @zsh-users

# zi ice lucid depth=1
# zi light jeffreytse/zsh-vi-mode

zi ice lucid
zi pack"binary+keys" for fzf

# zi ice as'program' pick'$HOME/.sdkman/bin/sdk' \
#   atclone'curl -s "https://get.sdkman.io" | bash' \
#   atpull'sdk update' \
#   atinit'source $HOME/.sdkman/bin/sdkman-init.sh;'
# zi light z-shell/null


setopt automenu
setopt always_to_end          # cursor moved to the end in full completion
setopt auto_cd              # Use cd by typing directory name if it's not a command.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt bang_hist            # Treat the '!' character, especially during Expansion.
setopt complete_in_word       # allow completion from within a word/phrase
setopt hash_list_all          # hash everything before completion
setopt interactive_comments # Comments even in interactive shells.
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt listpacked
setopt multios              # Implicit tees or cats when multiple redirections are attempted.
setopt nocorrect              # spelling correction for commands
setopt nolisttypes
setopt no_beep              # Don't beep on error.
# setopt no_glob
setopt prompt_subst         # Substitution of parameters inside the prompt each time the prompt is drawn.
setopt pushd_ignore_dups    # Don't push multiple copies directory onto the directory stack.
setopt pushd_minus          # Swap the meaning of cd +1 and cd -1 to the opposite.

# history
setopt append_history         # Allow multiple sessions to append to one Zsh command history.
setopt extended_history       # Show timestamp in history.
setopt hist_expire_dups_first # Expire A duplicate event first when trimming history.
setopt hist_find_no_dups      # Do not display a previously found event.
setopt hist_ignore_all_dups   # Remove older duplicate entries from history.
setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_ignore_space      # Do not record an Event Starting With A Space.
setopt hist_reduce_blanks     # Remove superfluous blanks from history items.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file.
setopt hist_verify            # Do not execute immediately upon history expansion.
setopt inc_append_history     # Write to the history file immediately, not when the shell exits.
setopt share_history          # Share history between different instances of the shell.

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

alias cat="bat"
alias ls="eza"
alias l="eza -lah"
alias z="zellij"

functin wrap-fzf-file-widget() {
  source "$HOME/.zsh/functions/fzf_colors.zsh"
  fzf-file-widget
}
zle     -N            wrap-fzf-file-widget
bindkey -M emacs '^T' wrap-fzf-file-widget
bindkey -M vicmd '^T' wrap-fzf-file-widget
bindkey -M viins '^T' wrap-fzf-file-widget

function wrap-fzf-cd-widget() {
  source "$HOME/.zsh/functions/fzf_colors.zsh"
  fzf-cd-widget
}
zle -N wrap-fzf-cd-widget
bindkey -M emacs '\ec' wrap-fzf-cd-widget
bindkey -M vicmd '\ec' wrap-fzf-cd-widget
bindkey -M viins '\ec' wrap-fzf-cd-widget

function wrap-fzf-history-widget() {
  source "$HOME/.zsh/functions/fzf_colors.zsh"
  fzf-history-widget
}
zle     -N            wrap-fzf-history-widget
bindkey -M emacs '^R' wrap-fzf-history-widget
bindkey -M vicmd '^R' wrap-fzf-history-widget
bindkey -M viins '^R' wrap-fzf-history-widget

# function g_preexec_hook() {
#   local cmd=$1
#
#   if [[ "$cmd" == *"fzf"* || "$cmd" == *"flavours"* ]]; then
#     source "$HOME/.zsh/functions/fzf_colors.zsh"
#   fi
#
# }
# add-zsh-hook preexec g_preexec_hook

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
