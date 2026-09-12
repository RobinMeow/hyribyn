# hyribyn

just abosuing this branch to keep notes, I do not longer need.
But do not yet to delete them.
Yes I know, I can get them back using git, but this solve the purpose better.

## Deprecated

this is still in the repository, if it is actually needed.

## xdg-desktop-portal

hyprland-session.target
xdg-desktop-portal requires a graphical session target or it refuses to start.
`systemctl --user edit --full --force hyprland-session.target`
to create the config file

> I don't know what this one was about..
It fixed it, but I do not remember running it for my other machines,
so I assume it is not needed.

## dead code I ended up not needing

```sh
# build-stack-from-source.sh
# NOTE: according to ai I thought I had to manually build those.
# didnt need to do so in docker. Ima keep the idea around tho
# also worked on my laptop with fedora44 everything iso
#
# bulid [https://github.com/stephenberry/glaze](https://github.com/stephenberry/glaze) from source
# bulid hyprland-qtutils from source hyprland-qtutils-git
# qt6-qtwayland-devel
# qt6-qtbase-devel
# qt6-qtwayland-devel
#
# these three exist in dnf, probably pointless to build 'em from source.
# sudo dnf install --assumeyes \
#   qt6-qtbase-devel \
#   qt6-qttools-devel \
#   qt6-qtwayland-devel

# build-hyprland-from-source.sh
# NOTE: epoll-shim is primarily a compatibility library for BSD/macOS
# On Fedora, epoll is already provided by the Linux kernel/libc, so you normally do not install epoll-shim
#
# -- Checking for module 'epoll-shim'
# --   Package 'epoll-shim' not found

# these are kind of leftover from my first installs,
# where I didn't know yet which deps where scrictly neccessary
# 	libxcb-devel \
# 	xcb-proto \
# 	xcb-util-devel \
# 	xcb-util-keysyms-devel \
# 	libXfixes \
# 	libX11-devel \
# 	libXcomposite-devel \
# 	libXrender-devel \
# 	libxkbcommon \
# 	libxkbcommon-devel \
# 	xcb-util-wm \
# 	libliftoff-devel \
# 	cpio \
# 	mesa-libEGL-devel \
# 	mesa-libGL-devel \
# 	mesa-libGLES-devel \
# 	libuuid-devel \
# 	lua-devel \
# 	sdbus-cpp-devel \
# 	libcanberra-devel
```
