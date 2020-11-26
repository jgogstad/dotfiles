# Dotfiles

**In short**

* All dotfiles are managed with [YADM]
* Secrets are managed with [YADM secrets](https://yadm.io/docs/encryption) and kept out of ZSH history by [passwordless-history](https://github.com/jgogstad/passwordless-history) plugin
* ZSH configuration is managed by [antibody]
* ZSH in short is [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for prompt theme, and a minimal import of [oh-my-zsh][oh-my-zsh] along with several [plugins](.zsh_plugins.txt) for shell configuration
* VIM on desktop is [SpaceVim](https://spacevim.org/), a small and fast `.vimrc` is provided for server setups.
* All software is managed by [brew] and [brew cask](https://github.com/Homebrew/homebrew-cask). New environments are set up with [brew bundle](https://github.com/Homebrew/homebrew-bundle)
* GPG setup is a consolidation of the man page and various sources, but particular [riseup](https://riseup.net/en/security/message-security/openpgp/best-practices)'s guide was influential
* Dev environments for Java, Python, Ruby and NodeJS are configured with version managers. Always keep default macOS versions where they were originally installed.

## Essential software

[brew], [exa], [bat], [z], [fzf], [yadm][YADM] to name a few. 

## ZSH plugin managers

[Antibody][antibody] is the fastest plugin manager, [zplug] has most features.

[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[YADM]: https://yadm.io/
[antibody]: https://github.com/getantibody/antibody
[brew]: https://brew.sh/
[zplug]: https://github.com/zplug/zplug
[exa]: https://github.com/ogham/exa
[bat]: https://github.com/sharkdp/bat
[z]: https://github.com/rupa/z
[fzf]: https://github.com/junegunn/fzf
