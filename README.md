# hyribyn

build hyprland from source with ease.

Currently supported distros:  
Fedora 44

Supported and tested Hyprland Versions:  
hl0.56.0

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

This is the way I did it, on my dotfile repo. [See here](https://github.com/RobinMeow/ribynlinux/blob/master/lib/hypr/install-hyribyn-fedora.sh)
for an example.  
Or an [example building neovim from source using sorcerer](https://github.com/RobinMeow/sourcerer#how-to-use-or-install)

## How to build the latest "stable" version automatically

Look at the environment variables in [./versions.sh](./versions.sh).
Before running the scripts, export all of these, and set the strings to
`latest-tag`. This is a feature by [sourcerer](https://github.com/RobinMeow/sourcerer)
which builds against the latest available git tag using standard versioning.
Most of the time it will just work, and behave **similar** to `pacman` updates.

> I personally don't like, nor use this. But who am I to tell you what to do :)

## How to build a specific hyprland version

you can checkout this repository using git tags. using this versioning scheme:
`hlx.x.x`. So if you want to build hyprland 0.56.0 you checkout this
repository at `hl0.56.0` and run the scripts. Thats it.  

However not every single version is included here, especially not older versions.
This is okay, you can still build them, just a bit more work.
Look at the environment variables in [./versions.sh](./versions.sh).  
You need to export these variables in the versions you want to build against,
before running the scripts. Thats it for most use cases, but you might need to install
some packages which were needed in the past, or added in the future.  

## How to build the absolute latest development commit

same as the above honestly, just specify the dev branch in the string.
e.g. `origin/dev`. You can even build against feature-branches
which are currently in development if you want to. Commit hashes
are also supported. Everything [sourcerer](https://github.com/RobinMeow/sourcerer)
supports, this repo supports also.

> Saying you can build against any commit hash, does not mean, it will build
or run successfully. This is for advanced users, who know what they are doing,
or people who just wanna mess around in a VM.

## Contributions

Feel free to join the [hyribyn discord](https://discord.gg/6AGtnMkpM), if you want
to contribute. You can also open issues, just make sure to not
implement stuff without prior elaboration.

- no AI. everything is hand written.

## How to support other distros

I will only maintain fedora, however the foundation is the same for
all. Adding another distro is straight forward _(for most distros)_.
Its mainly just looking for the same packages, which might be named differently.
For example: for a from source build on arch you need the `cairo` package
`sudo pacman -S cairo` but on fedora you need to install `cairo-devel` package
`sudo dnf install cairo-devel` and on Ubuntu its the `libcairo2-dev` package
`sudo apt install libcairo2-dev`. Point is, the same package can have
different names on different distros. But building and installation is
mostly the same for all.  
**Each repository has a `install-deps-fedora.sh` script. Copy it to
`install-deps-distroname.sh`, and change the package names for the distro you wish
to implement.**

### hyprapps

If you wish to contribute the scripts for another hyprapp, e.g. `hyprsunset`
seek elaboration with me first, using the hyribyn discord or github issues.

### Planned

- [ ] allow to only specify the hyprland version, and have a depenceny resolver
  at runtime, which resolves the latest support version for each dependency.
  _(not the latest minimum supported version)_
- [ ] allow installation to `/usr/local` instead of `/usr` and use it as default.
  easy to implement as expirimental.
  But testing it at runtime takes some time for me.
- [ ] other programms which are based on hyprland

> the state of this repo already serves it purpose for me.  
If you wish something to be done. Open an issue or upvote an existing one.

### Not planned

- [hyprland wiki - customer build flags](https://wiki.hypr.land/Getting-Started/Installation/#custom-build-flags)
  the original distribution of binaries by the hyprland team in arch (using pacman)
  does not strip those out either. Not only you increase risk of breakage, but you
  increase maintenance just for a few kilobytes of disk space
- apps which do not depend on hyprland. e.g. [mpvpaper](https://github.com/GhostNaN/mpvpaper)
  and [wl-freeze](https://github.com/Zerodya/wl-freeze). You can check out my
  dotfiles repo for examples on how to build [mpvpaper with sourcer](https://github.com/RobinMeow/ribynlinux/tree/master/lib/mpvpaper)
  or [wl-freeze with sourcerer](https://github.com/RobinMeow/ribynlinux/tree/master/lib/wl-freeze)
  from source
- older versions prior to hyprland 0.56.0

## supported hyprland stack and hyprapps

Uses [sourcerer](https://github.com/RobinMeow/sourcerer) to build the
whole hyprland stack from source as well as optional dependencies,
and other hyprapps.  

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

and other hyprapps:

- [x] `hyprpolkitagent` to use hyprlands optional permission system
- [x] `hyprshutdown` logging out of hyprland. the official recommended way.
- [x] `hyprpaper` background wallpaper engine
- [x] `hyprlock` lockscreen
- [x] `hyprpicker` use your mouse as color picker on whatever the screen is
  rendering currently _(handy for people who enjoy ricing)_
- [x] `hyprmoncfg` generate a lua configuration for your monitors
  on the fly in a tui
- [x] `hy3` sway/i3 like window tiling layout strategy

## Troubleshooting

see [./troubleshooting.md](./troubleshooting.md)
