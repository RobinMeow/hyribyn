# Hyprland

[hyprland lua docs](https://alejandrominaya.github.io/hyprland-lua-docs/)

when setting the env to specific git revs it is helpful
to know, that you need to try to build it in docker,
to get the required deps, you can just look into the
`CMakeLists.txt` to see execat minimum dependencies
and optional depencencies.

## Abadoned Tasks

tasks from when I migrated to hyprland, but ended up not doing

- [ ] ~~only blur terminal, for performance~~
  had a discord discussion with the result, that I dont need to bother with it.
- [ ] ~~brightness notifications (im too lazy to do wob again)~~
  got it covered with waybar
- [ ] ~~mp4 video is now working on hyprland in chrome e.g. wl-freeze github page~~
  swapping to brave (chromium based and works), and firefox also works
- [ ] ~~keyboards inputs can be configured using comma seperations ai was lying~~
  my own solution is good enough and doesnt depend on this wierd a** syntax
  of using string for csv files
- [ ] ~~see if I can find better architecture to swap gaps/potate modes configs~~
  it is partial updates by default with the exception of animations being
  unloaded when disabled
- [ ] swappy/slurp/grim ~~desktop files~~ for fullscreen shots or non edit copy
  screenshots dont want to use desktop files for this => maybe a hyprpicker?
  or hypr-independend cli solution?
- [ ] ~~set qwertz to be the default and only apply qwerty to glove80~~
- [ ] ~~hyprglass~~ not sure if worth it. might requires gtk/qt or sth.
  could be visually pleasing.
- [ ] ~~check if hypr-dynamic-cursor can be useful~~
- [ ] ~~try custom warp script~~
  (tried it, but needs to target only window.active if keyboard driven)
- [ ] ~~file_chooser needs some rules to be focused and floating probably~~
- [ ] ~~bluetooth open bluetui using a desktop file~~

## Completed Tasks

most tasks I had written down when migrating to hyprland
and completed, one way or another.

- [x] allow hyprpicker for screencopy
- [x] wayscriber = EpicPen. Fortunatly I no longer use the mouse, but maybe...
- [x] mpvpaper engine (using mp4 and others for wallpapers)
- [x] use something else for desktop notifications
- [x] build from source for fedora: [gh/hyprland-guiutils](https://github.com/hyprwm/hyprland-guiutils)
- [x] waybar should kill itself on lockscreen. remember it was running,
  and start backup after lock screen
- [x] wl-freeze
  (freezes a process so it no longer consumes resources. Can work as pause for game)
- [x] improve the gpu/cpu/mem lockscreen to not feeze up
- [x] lock screen
- [x] floating window with keybinds SUPER + (SHIFT) + ?
  (keybinds should go trough a custom fn)
- [x] toggle border radius rounding on gaps.toggle
- [x] toggle margin/padding around windows
- [x] move env to environments.lua
- [x] hyprmoncfg seems to be able to have a gui to setup monitors, could be useful
- [x] make launchables for SUPER + E (oneshot gemini, google search, etc..)
- [x] ~~desktop file for ~~disk usage, or zshrc alias
- [x] rename performance mode to potato mode
- [x] swappy/slurp/grim shouldn tneed to ask for permission
- [x] swappy/slurp/grim print screen keybind
- [x] keybind toggle for performance (disable animations and blur)
- [x] cp wallpapers onto home and use those as reference instead of using
  $RIBYN_ROOT in hyprpaper.conf
- [x] file picker / download destination chooser is not yet in darkmode,
  and is disgusting to use (cant show hidden files)
- [x] wallpaper hyprpaper
- [x] disable mouse accel
- [x] prevent chrome from going into presentation mode when fullscreening
- [x] semi transparent / blurred background on all or just kitty windows
- [x] configure keyboard layouts at tty level and alphanumeric runns like
  `kb denodeadkeyscapswapesc` to switch em
- [x] local keyboard setup
- [x] allow a local lua file to define default workspaces
- [x] nodeadkeys for qwertz
- [x] swap capslock as altnernative to qwertz
- [x] set device to prefer darkmode
- [x] replace all color rgbs with hexstrings
- [x] volume
- [x] follow cursor? should not be centered in the middle of the focused window

## Migration Notes

- [x] disable login sddm `sudo systemctl disable sddm.service`

> kde login by using `startplasma-wayland` (`startplasma-x11` if needed)
> hypr login by using `start-hyprland`

---

hyprland-session.target
xdg-desktop-portal requires a graphical session target or it refuses to start.
`systemctl --user edit --full --force hyprland-session.target`
to create the config file

> I don't know what this one was about..
> Don't remember running it for my other machines, so I assume
> this is not needed.

## Other Notes

> has a built in [timer](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Expanding-functionality/#timers)

> [enable blur only for specific windows](https://github.com/hyprwm/Hyprland/discussions/4169)
> for now I take the performance hit

---

dead code I ended up not needing

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
