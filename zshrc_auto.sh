#!/bin/bash 

# syntax highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.zsh/zsh-syntax-highlighting
echo "# zsh-syntax-highlighting" >> ${HOME}/.zshrc
echo "source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.zsh/zsh-autosuggestions
echo "# zsh-autoggestions" >> ${HOME}/.zshrc
echo "source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${HOME}/.zshrc
