echo 'export PYENV_ROOT="/usr/local/opt/pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
