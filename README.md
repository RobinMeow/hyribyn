# hyribyn

this is already working, in [ribynlinux](https://github.com/RobinMeow/ribynlinux)
which is my dotfiles repo. I working on extracting the hyprland build from source
scripts, to share them with the communiy.

build hyprland from source on non arch distros.

Currently supported distros:
fedora

## installation

```sh
# the git directory of all the git repos following the unix posix conventions
# for example:
# ~/.local/share/hyribyn/hyribyn will contain this repository
# ~/.local/share/hyribyn/hyprland will contain the hyprland repository
export HYRIBYN_ROOT=${HYRIBYN_ROOT:-"$HOME/.local/share/hyribyn"} \
  && git clone "https://github.com/RobinMeow/hyribyn" "$HYRIBYN_ROOT/hyribyn" \
  "$HYRIBYN_ROOT/hyribyn/install.sh"
```

> You may freely change HYRIBYN envvariable in your .zshenv / .bashenv
its recommended to put `export HYRIBYN_ROOT="$HOME/.local/share/hyribyn"`
into your dotfiles repository, but not required.

## philosophy and contributions

minimal, stable
TODO: add short notes on why this repo exists,
and mention contributions are welcome, whithin the philosophy

## features

TODO: list features and non hyprland apps

- [x] rollback to previous working state

## hypr ecosystem

- [x] hyprshutdown
- [x] hyprtoolkit
- [x] hyprpolkitagent
- [x] hyprmoncfg
- [x] hyprpaper
- [x] mpvpaper
- [x] hyprlock
- [x] hyprpicker
- [x] hy3

## planned

- [ ] automate the process of reading minimum dependecies
  all based on hyprland version.
  this will discard all env variables, in favor of one single one for hyprland

> these are planned, but I do not plan on doing them any time soon.
The state of this repo already solves its purpose well enough.
So any additions are just sugar currently.

## configuration

[hyprland lua docs](https://alejandrominaya.github.io/hyprland-lua-docs/)

when setting the env to specific git revs it is helpful to know, that
you need to try to build it in docker, to get the required deps, you
can just look into the `CMakeLists.txt` to see execat minimum dependencies
and optional depencencies.

## xdg-desktop-portal

hyprland-session.target
xdg-desktop-portal requires a graphical session target or it refuses to start.
`systemctl --user edit --full --force hyprland-session.target`
to create the config file

> this has been done already. and is put into this repo as file.
just keeping this to know how to re-generate it.

## Tasks

I dont use tickets. Im much more productive, but just writing it into
the readme to keep track of stuff.

- run_on_distro and os-detect
- source-manager
