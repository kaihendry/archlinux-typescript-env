FROM archlinux/base

RUN pacman -Syu --needed --noconfirm \
  base-devel \
  # We use git to install yay; it's also a dependency of yay.
  git \
  # makepkg does not run as root
  sudo

# makepkg user and workdir
ARG user=makepkg
RUN useradd -m $user
RUN echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
USER $user
WORKDIR /home/$user

# Install yay for nodejs-neovim :/
RUN git clone https://aur.archlinux.org/yay.git \
  && cd yay \
  && makepkg -sri --needed --noconfirm \
  && cd \
  # Clean up
  && rm -rf .cache yay

RUN yay -Syu --noconfirm typescript neovim ts-node nodejs-neovim python-neovim

RUN echo 'alias vim=nvim' >> ~/.bashrc

RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY --chown=$user nvimrc /home/$user/.config/nvim/init.vim

# Doesn't work
#RUN nvim +PlugInstall +qall

CMD bash
