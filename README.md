# dotfiles
*Personal configuration files for day-to-day tools*

## Requirements

- [tmux](tmux.github.io) >= 2.4
- [OpenSSH](openssh.com) >= 7.3
- [neovim](neovim.io)
- [Git](git-scm.com) >= 2.13
- [pyenv](https://github.com/pyenv/pyenv-installer)

## Installation

1. Install `pyenv`

On OS X:
```text/x-sh
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 2.7.11
```

```text/x-sh
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
env PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 2.7.11
```

2. Set up a virtualenv to be used by `neovim`

```text/x-sh
pyenv virtualenv 2.7.11 neovim
pyenv activate neovim
pip install neovim
```
