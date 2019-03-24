source <(antibody init)

# oh-my-zsh must know where it lives
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

antibody bundle robbyrussell/oh-my-zsh
antibody bundle robbyrussell/oh-my-zsh path:plugins/gitfast
antibody bundle robbyrussell/oh-my-zsh path:plugins/gpg-agent
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions

antibody bundle jgogstad/powerlevel9k-gcp
antibody bundle bhilburn/powerlevel9k
#
#
#source ~/.antigen.zsh
#
#antigen use oh-my-zsh
#
#antigen bundle gitfast
#
#ANTIGEN_LOG=~/antigen.log
#
#antigen theme bhilburn/powerlevel9k powerlevel9k
#
#antigen apply
#
#
