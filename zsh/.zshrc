HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

zstyle :compinstall filename '/home/dmfk/.config/zsh/.zshrc'
autoload -Uz compinit
compinit

# --------------------------- oh-my-zsh --------------------------------

# Path of the Oh My Zsh folder
export ZSH="/home/dmfk/.config/zsh"

# Zsh Theme in use
ZSH_THEME="robbyrussell"

# Plugins 
# plugins=(vi-mode themes alias-finder battery colored-man-pages colorize extract tmux z zsh-interactive-cd)

# Cache dir
ZSH_CACHE_DIR="/home/dmfk/.config/zsh"

# Auto Update
DISABLE_AUTO_UPDATE=true

# If automatic updates aren't disabled, the confirmation prompt will not appear, and instead Oh My Zsh will update without asking whenever the automatic update expires.
# DISABLE_UPDATE_PROMPT=true

# Check for update interval
UPDATE_ZSH_DAYS=13

# Path to completion cache file
ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"

# Reset the completion cache
# rm "$ZSH_COMPDUMP"
# exec zsh

# Zsh automatically detects directories in $fpath that might have insecure permissions. These are directories that are checked when loading completion functions or other functions, so if a directory has insecure permissions, it could mean that you end up running code that a malicious actor put there.
ZSH_DISABLE_COMPFIX=true

# Case-Sensitive completion
CASE_SENSITIVE=false

# Underscores (_) & Hyphens (-) are intervchangeable
HYPHEN_INSENSITIVE=true

# Bracketed-paste-magic and url-quote-magic are two Zsh utilities that are known buggy in some Zsh versions or user setups. If you're having problems when pasting URLs or pasting anything at all, use this setting to disable them.
# DISABLE_MAGIC_FUNCTIONS=true 

# Use this setting to disable the Oh My Zsh logic to automatically set ls color output based on the system you're running and which ls commands are available.
DISABLE_LS_COLORS=true

# Oh My Zsh automatically sets the title of your terminal and tabs when running a command or printing the prompt. Use this setting if you want to disable that.
DISABLE_AUTO_TITLE=true

# If you use this setting, Oh My Zsh will use setopt correct_all, which tells Zsh to try to correct command names and filenames passed as arguments. Only the following commands will be prevented to have filename correction: cp, ebuild, gist, heroku, hpodder, man, mkdir, mv, mysql, sudo.
ENABLE_CORRECTION=true

# If you enable this setting, Oh My Zsh will print a red ellipsis to indicate that Zsh is still processing a completion request, and will disappear when the completion finishes. This is useful for example when completing a command that requires a lot of processing before offering completion entries.
# COMPLETION_WAITING_DOTS=true
# NOTE: this setting has been known to cause issues with multiline prompt themes.

# Use this setting if you want to disable marking untracked files under VCS as dirty. This makes repository status checks for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY=true
# NOTE: this setting only takes effect if your theme calls the git_prompt_info or parse_git_dirty git prompt functions in lib/git.zsh.

# Oh My Zsh provides a wrapper for the history command. You can use this setting to decide whether to show a timestamp for each command in the history output.
HIST_STAMPS="dd.mm.yyyy"

#These settings only work if the random theme is selected 
# ZSH_THEME=random

# If above setting is set to "random" then a random theme is selected of the below mentioned theme
# ZSH_THEME_RANDOM_CANDIDATES=(robbyrussell af-magic ys)

# If above setting is disabled then only these themes be ignored
# ZSH_THEME_RANDOM_IGNORED=(agnoster pygmalion rkj)



# --------------------------------- Plugins -------------------------------
# alias-finder
# To see if there is an alias defined for the command, pass it as an argument to alias-finder. This can also run automatically before each command you input
ZSH_ALIAS_FINDER_AUTOMATIC=true

# battery
# Then, add the battery_pct_prompt function to your custom theme. For example:
# RPROMPT='$(battery_pct_prompt) ...'

# colorize
ZSH_COLORIZE_TOOL=chroma
ZSH_COLORIZE_STYLE="colorful"
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

# tmux
ZSH_TMUX_FIXTERM
ZSH_TMUX_FIXTERM_WITH_256COLOR
