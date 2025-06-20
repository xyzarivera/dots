# http://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
autoload -U colors && colors

# vsc - git
# https://hzsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats 'on %F{red}%b%f '

# enable parameter expansion, command substitution and arithmetic expansion
setopt prompt_subst

PROMPT='%F{blue}%~%f ${vcs_info_msg_0_}%B%(?.%F{blue}>.%F{red}>)%f%b '
