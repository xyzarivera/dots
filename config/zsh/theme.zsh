# http://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
autoload -U colors && colors

# enable parameter expansion, command substitution and arithmetic expansion
setopt prompt_subst

PROMPT='%B%(?.%F{blue}>.%F{red}>)%f%b '
