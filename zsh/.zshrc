# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# --------------------------- oh-my-zsh --------------------------------
# Path to your oh-my-zsh installation.
export ZSH="/home/dmfk/.oh-my-zsh"

# Zsh Theme in use
ZSH_THEME="powerlevel10k/powerlevel10k"

# ZSH_THEME_RANDOM_CANDIDATES=("af-magic" "agnoster")

# Plugins
plugins=(git vi-mode themes alias-finder colored-man-pages colorize extract z zsh-interactive-cd)

# Cache dir
ZSH_CACHE_DIR="/home/dmfk/.config/zsh"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE=true

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Path to completion cache file
ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"

# To Reset the completion cache run
# rm "$ZSH_COMPDUMP"
# exec zsh

# Zsh automatically detects directories in $fpath that might have insecure permissions. These are directories that are checked when loading completion functions or other functions, so if a directory has insecure permissions, it could mean that you end up running code that a malicious actor put there.
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# Only the following commands will be prevented to have filename correction: cp, ebuild, gist, heroku, hpodder, man, mkdir, mv, mysql, sudo.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# NOTE: this setting has been known to cause issues with multiline prompt themes.



# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="~/D/.config/zsh/custom/theme"

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Example aliases
alias apl='~/D/Downloads/apl-1.6/src/apl'
alias ll='lsd -lh'
alias la='lsd -lah'
alias ls='lsd'
alias vim='nvim'
alias vi='nvim'
alias g++='g++ -std=c++20'
alias config="cd ~/.config"
alias cpd="cd ~/D/Documents/Programming/Cpp"
alias jd="cd ~/D/Documents/Programming/Java"
alias pd="cd ~/D/Documents/Programming/Python"
alias webd="cd ~/D/Documents/Programming/WebDev"
alias cat='bat'
alias yy='xclip -selection clipboard'

# --------------------------------- Plugins -------------------------------
# alias-finder
# To see if there is an alias defined for the command, pass it as an argument to alias-finder. This can also run automatically before each command you input
ZSH_ALIAS_FINDER_AUTOMATIC=true

# battery
# Then, add the battery_pct_prompt function to your custom theme. For example:
# RPROMPT='$(battery_pct_prompt) ...'

# colorize
# ZSH_COLORIZE_TOOL=chroma
# ZSH_COLORIZE_STYLE="colorful"
# ZSH_COLORIZE_CHROMA_FORMATTER=terminal256


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# /usr/share/fzf/completion.zsh
# /usr/share/fzf/key-bindings.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

export PATH=$HOME/.config/rofi/bin:$PATH

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
