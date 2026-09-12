# hyribyn

this is already working, in [ribynlinux](https://github.com/RobinMeow/ribynlinux)
which is my dotfiles repo. I working on extracting the hyprland build from source
scripts, to share them with the communiy.

build hyprland from source on non arch distros.

Currently supported distros:
fedora

## philosophy and contributions

minimal, stable
TODO: add short notes on why this repo exists,
and mention contributions are welcome, whithin the philosophy

## Features

TODO: list features and non hyprland apps
- [x] rollback to previous working state

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
