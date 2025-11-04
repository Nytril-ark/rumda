# Created by newuser for 5.9
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# source ~/.config/zshrc.d/dots-hyprland.zsh
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(
  git
  zsh-shift-select
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_T_COMMAND="exa --icons"
export FZF_CTRL_T_OPTS="--accept-nth=2"
export FZF_CTRL_R_OPTS="--with-nth=2,-1"
export FZF_DEFAULT_OPTS="--height 40% --history-size=10000000000
  --layout=reverse --border=rounded --exact --cycle --wrap --history=/home/$USER/.zsh_history
  --color=bg:#00070B,bg+:#000f12,fg:#A9A9A9,fg+:#A9A9A9
  --color=hl:#F26E74,hl+:#F26E74
  --color=info:#79AAEB,prompt:#E9967E,pointer:#C488EC
  --color=marker:#78B892,spinner:#78B892
  --color=border:#E89982"


# User configuration

# Load vcs_info module
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Configure vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

## syntax highlighting
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
#   ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[path]=purple,bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=blue
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=blue
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=blue
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=gray,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#3E424A'
fi
  
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

export MANPAGER='nvim +Man!'

## sshot() {
##  sleep $1 && grim ~/Pictures/p.png &&
##    cat ~/Pictures/p.png | wl-copy
## }

## shot() {
##  sleep $1 && grim -g "$(slurp)" ~/Pictures/p.png &&
##    cat ~/Pictures/p.png | wl-copy
## }

EDITOR=nvim

if command -v eza > /dev/null; then
  alias ls='eza -h --git --icons -sold'
  alias ll='eza -h --git --icons -l -sold'
  alias l='eza -h --git --icons -l -sold'
  alias la='eza -h --git --icons -la -sold'
  alias lt='eza -h --tree --git --icons -l -sold'
  alias lta='eza -h --tree --git --icons -la -sold'
fi

## alias s='sleep 3 && grim "$HOME/Pictures/Screenshots/$(date +%Y%m%d-%H%M%S).png"'
#
alias s='nohup sh -c "sleep 3 && grim \"$HOME/Pictures/Screenshots/\$(date +%Y%m%d-%H%M%S).png\"" >/dev/null 2>&1 &'

alias run='./a.out'
alias runh='cd && ./a.out'
alias grep='grep --color=always'
alias objdump='objdump --disassembler-color=on --visualize-jumps=extended-color'
alias b64='base64'
alias q=exit
alias zig-std='cd /usr/lib/zig/std && nvim && cd ~'
alias gac='git add . && git commit -m'
alias iamb='EDITOR=nvim iamb'
alias cb='cargo build'
alias cr='cargo run'
alias cargo-generate-flamelens='cargo flamegraph --post-process "flamelens --echo"'
alias temp='echo "CPU Temp: $(sensors | awk '\''/Tctl/ {print $2}'\'')" | sed "s/+/\x1b[31m+/;s/°C/°C\x1b[0m/"'
alias rumda='Hyprland --config /home/hexogen/.config/rumda-pistachio/hyprland.conf'
alias rumdafetch='neofetch --source /home/$USER/.config/rumda-pistachio/neofetch/2.svg --kitty --size 230'
alias wall='/$HOME/.config/rumda-pistachio/scripts/wall.sh'
alias hyprtheme='/$HOME/.config/rumda-pistachio/scripts/hyprtheme.sh'


BRACK_HEX="%F{#53595f}"
USER_HEX="%F{#BAC7DD}"
AT_HEX="%F{#c9938a}"
HOST_HEX="%F{#2D6880}"
CWD_HEX="%F{#79AAEB}"
UID_HEX="%F{#F26E74}"

zstyle ':vcs_info:*' unstagedstr ' +%%'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats "$BRACK_HEX($USER_HEX%b$HOST_HEX%u$USER_HEX%c$BRACK_HEX)"
zstyle ':vcs_info:git:*' actionformats "$BRACK_HEX($USER_HEX%b$BRACK_HEX|$CWD_HEX%a$HOST_HEX%u$USER_HEX%c$BRACK_HEX)"

## PS1='%B%F{034}%n@%m%f%b:%B%F{#00bbbb}%~ %#%f%b '
## PS1="%B%K{#6791C9}%F{#12171d} skin crawler %K{#333B3F}%F{#6791C9} %~ %f%k%b "
## PS1="%K{#131E22} %B%K{#78B892}%F{#131E22} $HOSTNAME %K{#131E22}%F{#78B892} %~ %f%k%b "
## PS1="%B%K{#789978}%F{#12171d} toji %K{#2f343f}%F{#789978} %~ %f%k%b "
########### PS1="[%{${fg_bold[magenta]}%}$USER%{${fg_bold[cyan]}%}@${fg[green]}$HOST %{${fg[red]}%}%3~%(0?..%{ ${fg[red]}%}%?)%{${fg[blue]}%} %{${reset_color}%}] "
#
#
# custom 24-bit colors
C_MAGENTA=$'%{\e[1;38;2;186;199;221m%}'   # #BAC7DD
C_GREEN=$'%{\e[1;38;2;45;104;128m%}'     # #2D6880
RESET=$'%{\e[0m%}'



# Update the color definitions
C_USER=$'%{\e[1;38;2;109;94;83m%}'      # #6D5E53 (user color)
C_HOST=$'%{\e[1;38;2;159;104;76m%}'     # #9F684C (host color)
C_ERR=$'%{\e[1;38;2;154;66;53m%}'       # #9A4235 (error color)
C_AT=$'%{\e[1;38;2;173;112;74m%}'       # #AD704A (@ symbol color)
RESET=$'%{\e[0m%}'

# Updated PS1
PS1="[$C_USER$USER$C_AT@$C_HOST$HOST $C_ERR%3~%(0?..$C_ERR%?)%{${fg[blue]}%} $RESET]"

####################################################
#
## PS1="$BRACK_HEX""[$USER_HEX$USERNAME$AT_HEX@$HOST_HEX$HOST $CWD_HEX%~$BRACK_HEX]$GIT_HEX"'${vcs_info_msg_0_}'"$UID_HEX%(!.#.$)%f%k%b "

export PATH="$HOME/.cargo/bin/:$HOME/.local/bin/:$PATH"
export RUSTC_WRAPPER=sccache

. "$HOME/.local/bin/env"

# bun completions
[ -s "/home/hexogen/.bun/_bun" ] && source "/home/hexogen/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
