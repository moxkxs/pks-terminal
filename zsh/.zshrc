
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pbk/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pbk/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pbk/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pbk/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# === completions ===
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

# === cli tools ===
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# aliases
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -la"
alias lt="eza --icons --group-directories-first --tree --level=2"
alias cat="bat --style=plain"
alias catn="bat"

# === pdc terminal theme ===

_apply_theme() {
    local bg=$1 fg=$2 cursor=$3 selbg=$4 selfg=$5
    shift 5
    printf '\e]11;%s\a' "$bg"
    printf '\e]10;%s\a' "$fg"
    printf '\e]12;%s\a' "$cursor"
    printf '\e]17;%s\a' "$selbg"
    printf '\e]19;%s\a' "$selfg"
    local i=0
    for color in "$@"; do
        printf '\e]4;%d;%s\a' "$i" "$color"
        ((i++))
    done
}

dark() {
    sed -i '' 's/^theme = .*/theme = pdc-dark/' ~/.config/ghostty/config
    osascript -e 'tell application "System Events" to tell process "Ghostty" to click menu item "Reload Configuration" of menu 1 of menu bar item "Ghostty" of menu bar 1' &>/dev/null &
    export FZF_DEFAULT_OPTS="--color=bg+:#2a1810,fg:#EDE7F4,fg+:#EDE7F4,hl:#FF8C00,hl+:#FF6B35,info:#666666,prompt:#FF6B35,pointer:#FF6B35,marker:#FF8C00,spinner:#FF6B35,header:#666666,border:#2a1810"
    export BAT_THEME="ansi"
    export EZA_COLORS="da=38;5;242:di=38;2;255;140;0:ex=38;2;255;107;53"
    PROMPT='%F{#FF6B35}%n%f %F{#666666}in%f %F{#FF8C00}%~%f %F{#FF6B35}→%f '
}

light() {
    sed -i '' 's/^theme = .*/theme = pdc-light/' ~/.config/ghostty/config
    osascript -e 'tell application "System Events" to tell process "Ghostty" to click menu item "Reload Configuration" of menu 1 of menu bar item "Ghostty" of menu bar 1' &>/dev/null &
    export FZF_DEFAULT_OPTS="--color=bg+:#d8d0f0,fg:#1a1a2e,fg+:#1a1a2e,hl:#6D28D9,hl+:#7C3AED,info:#999aaa,prompt:#7C3AED,pointer:#7C3AED,marker:#6D28D9,spinner:#7C3AED,header:#999aaa,border:#d8d0f0"
    export BAT_THEME="ansi"
    export EZA_COLORS="da=38;5;249:di=38;2;109;40;217:ex=38;2;124;58;237"
    PROMPT='%F{#7C3AED}%n%f %F{#999aaa}in%f %F{#6D28D9}%~%f %F{#7C3AED}→%f '
}

# auto-detect theme on shell startup
if grep -q 'pdc-dark' ~/.config/ghostty/config 2>/dev/null; then
    dark
else
    light
fi

# === screensavers ===
alias matrix="cmatrix -C red"

# === zsh plugins (must be last) ===
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
