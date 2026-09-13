# hyribyn

build hyprland from source with ease on any distro.

Currently supported distros:
Fedora 44

## one time installation

`HYRIBYN_ROOT` is the git directory of all the git repos to be cloned.
for example:
`~/.local/share/hyribyn/hyribyn` will contain this repository.
`~/.local/share/hyribyn/hyprland` will contain the hyprland repository.

`HYRIBYN_DISTRO` is the linux distro you are on.
`fedora` is the default and does not need to be set.
`export HYRIBYN_DISTRO="fedora"`

`sync-hyprland-session-target.sh` is for [xdg-desktop-portal](#xdg-desktop-portal).
You probably want and need this. If not feel free to exclude it.
>I think when you use uwsm you don't need it.
I dont use uwsm so can't tell for sure.

```sh
export HYRIBYN_ROOT="$HOME/.local/share/hyribyn" \
  && git clone --recurse-submodules "https://github.com/RobinMeow/hyribyn" "$HYRIBYN_ROOT/hyribyn" \
  && "$HYRIBYN_ROOT/hyribyn/install.sh" \
  && "$HYRIBYN_ROOT/hyribyn/sync-hyprland-session-target.sh"
```

## dotfiles automated integration

I recommend using [sourcerer](https://github.com/RobinMeow/sourcerer) to
clone this repo, and call the corresponding scripts.

```sh
# hyribyn will be cloned in ~/.local/share/ribyn/hyribyn
export HYRIBYN="$HOME/.local/share/ribyn/"
# you gotta replace the filepath with whereever your sourcerer script is
SOURCERER_DEST="$HYRIBYN" source "$HOME/path/to/your/sourcerer.sh"

function hyribyn_installed() {
  # never consider it to be installed.
  # hyribyn is already idempotent and knows what it needs to run what not.
  return 1 # its an exit code, not a boolean
}

function hyribyn_build_and_install() {
  # use fedora as target distro
  export HYRIBYN_DISTRO="fedora"

  # this is where hyribyn will clone all the git repos,
  # build, install and update them.
  # hyribyn will also look in here for its own git location
  # unless you set HYRIBYN
  # replace ribyn with your username, or dont set it at all
  export HYRIBYN_ROOT="$HOME/.local/share/ribyn"

  # install all hyprland dependencies, hyprland itself,
  # and hyprland runtime dependencies
  "$HYRIBYN/hyprland/install-stack.sh"

  # call only the apps you wish to have, in any order
  "$HYRIBYN/common/install-app.sh" "hyprshutdown"
  "$HYRIBYN/common/install-app.sh" "hyprlock"
  "$HYRIBYN/common/install-app.sh" "hyprpaper"
  "$HYRIBYN/common/install-app.sh" "hyprpolkitagent"

  # dont call em, if you dont want em, duh :)
  # "$HYRIBYN/common/install-app.sh" "hyprpicker"
  # "$HYRIBYN/common/install-app.sh" "hy3"
}

check_source_state \
  "hyribyn" \
  "hl0.56.0"

source_git "https://github.com/RobinMeow/hyribyn.git"
```

TODO: reference ribynlinux instead
[sourcerer - dotfiles integration with neovim](https://github.com/RobinMeow/sourcerer#how-to-use-or-install)

## philosophy and contributions

Feel free to join the [hyribyn discord](https://discord.gg/6AGtnMkpM), if you want
to contribute. You can also open issues, just make sure to not
implement stuff without prior elaboration.

- no AI, its just a few lines of code.

> Your contributions are welcome to add install-deps-distro.sh for other distros.
Since I will only maintain fedora, however the foundation is the same for
all. Adding another distro is pretty straigt forward. Its mainly just looking for
the same packages, which might be named differently.
For example: for a from source build on arch you need the `cairo` package
`sudo pacman -S cairo` but on fedora you need to install `cairo-devel` package
`sudo dnf install cairo-devel` and on Ubuntu its the `libcairo2-dev` package
`sudo apt install libcairo2-dev`. Point is, the same package can have
different names on different distros. But building and installation is
mostly the same for all.

### hyprapps

if you wish to contribute the scripts for another hyprapp, lets say `hyprsunset`
seek elaboration with me first.
If I should decline an app, you can always just fork, or use [sourcerer](https://github.com/RobinMeow/sourcerer)
to implement it for your own needs. `sourcerer` results in less boiletplate code,
but you can just write your own script.

One acceptance criteria is, that I do not include apps, which are heavily AI
maintained. You can see this by a top-level AGENTS.md file, or if you look
into the git history and see many fix commits, its usually a sign of AI driven
projets. If it has alot of fixes (therefore unstable) I dont care if its
AI driven or not. If I include unstable repo in here, my the maintenance I
have to do rises for other peoples mistakes.

### Planned

**custom build flags:**
integrate these build flags so you can disable the ones you dont need,
for a even more minimal build.
NO_XWAYLAND - Removes XWayland support
NO_SYSTEMD - Removes systemd dependencies
NO_UWSM - Does not install the hyprland-uwsm.desktop file
NO_HYPRPM - Does not build and install hyprpm
[hyprland wiki - customer build flags](https://wiki.hypr.land/Getting-Started/Installation/#custom-build-flags)

- [ ] remove all versions.sh git revs, in favor of automatic dependency resolving with
  only the hyprland verision being set. Have not yet looked into this and
  do not know how to do this yet. Feel free to help if you know how to.
- [ ] allow installation to /usr/local instead of /usr which is the default
  shown in all the hypr-app's READMEs. To avoid conflict with pm installed versions.
  see [Limitations](#limitation) for more on this
- [ ] other programms which are based on hyprland

> these are planned, but I do not plan on doing them any time soon.
The state of this repo already solves its purpose, way beyond than needed.
So any additions are just sugar.

## supported hyprland stack and hyprland-based-programms

Uses [sourcerer](https://github.com/RobinMeow/sourcerer) to build the
whole hyprland stack from source as well as optional dependencies,
and other hypr-apps and hypr-programms.  
This includes building 11 dependecnies from source + hyprland itself:

- [x] `hyprland-protocols`
- [x] `hyprwayland-scanner`
- [x] `hyprutils`
- [x] `hyprgraphics`
- [x] `hyprlang`
- [x] `hyprcursor`
- [x] `aquamarine`
- [x] `xdg-desktop-portal-hyprland`
- [x] `hyprwire`
- [x] `hyprtoolkit`
- [x] `hyprland`
as mentioned in the [hyprland wiki - faq](https://wiki.hypr.land/FAQ/#:~:text=The%20order%20in%20which%20you%20must%20build,be%20built%20in%20any%20order%20after%20hyprland.)

and a runtime only dependency which the FAQ does not mention:

- [x] `hyprland-guiutils`_(runtime-only dependency. formerly hyprland-qtutils)_

and other hypr-apps and hypr-programms:

- [x] `hyprpolkitagent` to use hyprlands optional permission system
- [x] `hyprshutdown` logging out of hyprland. the official recommended way.
- [x] `hyprpaper` background wallpaper engine
- [x] `hyprlock` lockscreen
- [x] `hyprpicker` use your mouse as color picker on whatever the screen is
  rendering currently (nice for ricing)
- [x] `hyprmoncfg` generate a lua configuration for your monitors
  on the fly in a tui
- [x] `hy3` sway/i3 like window tiling layout strategy
- [ ] `mpvpaper` see [ribynlinux/mpvpaper](https://github.com/RobinMeow/ribynlinux/tree/master/lib/mpvpaper)
  for an example using [sourcerer](https://github.com/RobinMeow/sourcerer)
  on how to build and install mpvpaper from source
- [ ] `wl-freeze` see [ribynlinux/wl-freeze](https://github.com/RobinMeow/ribynlinux/tree/master/lib/wl-freeze)
  for an example using [sourcerer](https://github.com/RobinMeow/sourcerer)
  on how to build and install wl-freeze from source

> `mpvpaper` and `wl-freeze` do not depend on hyprland.
Therefore they will not be included in this repository.

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
just keeping this to know how to re-generate it, if ever needed.

## Limitation

- arch uses `pacman` as package manager. Which does not allow to install older versions
  of a package. _(You wouldnt be on a rolling-distro like arch if this is important
  to you)_ This means, if a dependency, lets say `cairo` makes an update with a
  breaking change, and hyprland also updates accordingly _(as it should)_ and
  you also updated your hyprland installation accordingly _(as you should)_ it
  will become incredibly difficult to re-build your previous hyprland
  binaries _(version)_. To work around this, you should just update to a latest
  stable version.  
  Just mentioning this, becuase this repo does support rollbacks
  as long as all dependencies did not update with breaking changes.
- to avoid issues, you may not install any hpyrland stuff using your package manger,
  if it is already installed from source. If you do it anyways, and things get messy,
  you should uninstall the ones you installed with your package manager,
  and then rebuild from source again. Should be fine, but no promises.
  I have done worse and managed to recover, but I do 40h a week of software
  development for a living, so thats not comparable to everyone.
- a build error can occur wich says `The bug is not reproducible, so it is
  likely a hardware or OS problem.` or `internal compiler error: panic: runtime error: invalid memory address or nil pointer dereference`
  which is not from this scripts.  
  Its from cmake I think, if you get, just re-run
  the script. Usually works on the 2nd try. In worst case, run a few times.
  You are unlikely to get this error, for me I usually get it when testing
  these scripts in docker, which shares my hardware resources with the main OS
  and therefore are more likely to run into segmentatin errors.  
  As I said, just re-run.
