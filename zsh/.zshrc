
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

# yazi wrapper (cd into directory on exit)
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

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
    sed -i '' 's/^theme = .*/theme = pdc-dark/' "$(readlink ~/.config/ghostty/config)"
    _apply_theme '#0d0806' '#EDE7F4' '#FF6B35' '#2a1810' '#EDE7F4' \
        '#141414' '#FF6B35' '#8B9A6B' '#FF8C00' '#7A8BA0' '#A0826D' '#6D9B8B' '#cccccc' \
        '#666666' '#FF8C55' '#A0B07D' '#FFB347' '#8B9DB5' '#C4A882' '#82B5A5' '#EDE7F4'
    export FZF_DEFAULT_OPTS="--color=bg+:#2a1810,fg:#EDE7F4,fg+:#EDE7F4,hl:#FF8C00,hl+:#FF6B35,info:#666666,prompt:#FF6B35,pointer:#FF6B35,marker:#FF8C00,spinner:#FF6B35,header:#666666,border:#2a1810"
    export BAT_THEME="ansi"
    export EZA_COLORS="da=38;5;242:di=38;2;255;140;0:ex=38;2;255;107;53"
    PROMPT='%F{#FF6B35}%n%f %F{#B8B8B8}in%f %F{#FF8C00}%~%f %F{#FF6B35}→%f '
    ln -sf "$HOME/dotfiles/yazi/theme-dark.toml" "$HOME/.config/yazi/theme.toml"
    _set_cmd_color '#61afef'
}

light() {
    sed -i '' 's/^theme = .*/theme = pdc-light/' "$(readlink ~/.config/ghostty/config)"
    _apply_theme '#d8d0e8' '#4a4a5a' '#7C3AED' '#d8d0f0' '#1a1a2e' \
        '#1a1a2e' '#7C3AED' '#5A7A4D' '#6D28D9' '#4A5A7A' '#8B5CF6' '#4D7A6B' '#333344' \
        '#999aaa' '#8B5CF6' '#6B8A5D' '#7C3AED' '#5A6A8A' '#1B5E3B' '#5D8A7B' '#1a1a2e'
    export FZF_DEFAULT_OPTS="--color=bg+:#d8d0f0,fg:#1a1a2e,fg+:#1a1a2e,hl:#6D28D9,hl+:#7C3AED,info:#999aaa,prompt:#7C3AED,pointer:#7C3AED,marker:#6D28D9,spinner:#7C3AED,header:#999aaa,border:#d8d0f0"
    export BAT_THEME="ansi"
    export EZA_COLORS="da=38;5;249:di=38;2;109;40;217:ex=38;2;124;58;237"
    PROMPT='%F{#7C3AED}%n%f %F{#555566}in%f %F{#6D28D9}%~%f %F{#7C3AED}→%f '
    ln -sf "$HOME/dotfiles/yazi/theme-light.toml" "$HOME/.config/yazi/theme.toml"
    _set_cmd_color '#1B5E3B'
}

# auto-detect theme on shell startup
if grep -q 'pdc-dark' ~/.config/ghostty/config 2>/dev/null; then
    export FZF_DEFAULT_OPTS="--color=bg+:#2a1810,fg:#EDE7F4,fg+:#EDE7F4,hl:#FF8C00,hl+:#FF6B35,info:#666666,prompt:#FF6B35,pointer:#FF6B35,marker:#FF8C00,spinner:#FF6B35,header:#666666,border:#2a1810"
    export BAT_THEME="ansi"
    export EZA_COLORS="da=38;5;242:di=38;2;255;140;0:ex=38;2;255;107;53"
    PROMPT='%F{#FF6B35}%n%f %F{#B8B8B8}in%f %F{#FF8C00}%~%f %F{#FF6B35}→%f '
    ln -sf "$HOME/dotfiles/yazi/theme-dark.toml" "$HOME/.config/yazi/theme.toml"
else
    export FZF_DEFAULT_OPTS="--color=bg+:#d8d0f0,fg:#1a1a2e,fg+:#1a1a2e,hl:#6D28D9,hl+:#7C3AED,info:#999aaa,prompt:#7C3AED,pointer:#7C3AED,marker:#6D28D9,spinner:#7C3AED,header:#999aaa,border:#d8d0f0"
    export BAT_THEME="ansi"
    export EZA_COLORS="da=38;5;249:di=38;2;109;40;217:ex=38;2;124;58;237"
    PROMPT='%F{#7C3AED}%n%f %F{#555566}in%f %F{#6D28D9}%~%f %F{#7C3AED}→%f '
    ln -sf "$HOME/dotfiles/yazi/theme-light.toml" "$HOME/.config/yazi/theme.toml"
fi

# === screensavers ===
alias matrix="cmatrix -C red"
alias poly="~/.local/bin/poly"

# === zsh plugins (must be last) ===
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
_set_cmd_color() {
    ZSH_HIGHLIGHT_STYLES[command]="fg=$1"
    ZSH_HIGHLIGHT_STYLES[builtin]="fg=$1"
    ZSH_HIGHLIGHT_STYLES[alias]="fg=$1"
    ZSH_HIGHLIGHT_STYLES[function]="fg=$1"
}
if grep -q 'pdc-dark' ~/.config/ghostty/config 2>/dev/null; then
    _set_cmd_color '#61afef'
else
    _set_cmd_color '#1B5E3B'
fi
