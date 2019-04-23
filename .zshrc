source <(antibody init)

# oh-my-zsh must know where it lives
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

antibody bundle robbyrussell/oh-my-zsh
antibody bundle robbyrussell/oh-my-zsh path:plugins/git
antibody bundle robbyrussell/oh-my-zsh path:plugins/gitfast
antibody bundle robbyrussell/oh-my-zsh path:plugins/gpg-agent
antibody bundle robbyrussell/oh-my-zsh path:plugins/z
antibody bundle robbyrussell/oh-my-zsh path:plugins/fzf
antibody bundle robbyrussell/oh-my-zsh path:plugins/pyenv
antibody bundle robbyrussell/oh-my-zsh path:plugins/colored-man-pages

antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions

antibody bundle jgogstad/brew-zsh
antibody bundle jgogstad/exa-zsh
antibody bundle jgogstad/homebin
antibody bundle jgogstad/powerlevel9k-gcp
antibody bundle jgogstad/passwordless-history

antibody bundle bhilburn/powerlevel9k

for file in ~/.zsh_config/*.zsh; do
  source $file
done
