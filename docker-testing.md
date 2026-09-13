# docker testing

```sh
# run latest distro image in docker (data is cleaned up after exit)
sudo docker run -it --rm fedora:latest /bin/bash

# in docker setting up a user named ribyn
dnf update --refresh --assumeyes && dnf install --assumeyes sudo git bc vim && \
  sh -c "$(curl -fsSL "https://raw.githubusercontent.com/RobinMeow/ribynlinux/master/bootstrap/yet-another-setup.sh")"

export HYRIBYN_ROOT="$HOME" \
  && git clone -b "dev" --recurse-submodules "https://github.com/RobinMeow/hyribyn" "$HYRIBYN_ROOT/hyribyn" \
  && "$HYRIBYN_ROOT/hyribyn/install-stack.sh" \
  && "$HYRIBYN_ROOT/hyprland/sync-hyprland-session-target.sh"

# alternatively for other distros. example arch
pacman -Syu --noconfirm && pacman -S --noconfirm sudo git bc vim && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/RobinMeow/ribynlinux/master/bootstrap/yet-another-setup.sh)"
sudo docker run -it --rm archlinux:latest /bin/bash
```
