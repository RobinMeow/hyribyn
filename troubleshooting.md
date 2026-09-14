# Troubleshooting

**Compilation error:**
`The bug is not reproducible, so it is likely a hardware or OS problem.`  
or  
`internal compiler error: panic: runtime error:
invalid memory address or nil pointer dereference`  
Just re-run again. Usually does not happen twice. If it does, run again.
_(Usually does not happen at all. These errors originate from the compiler
and not from the the scripts in this repository)_

**dependency has wrong version**
lets say `aquamarine` throws "could not find required version
`hyprwayland-scanner` 0.4.0, which is the required version for
`aquamarine` 0.14.0. The scripts in here, already ensure the correct
versions are built. But you might have it installed yourself using
the package manager (e.g. `apt`, `pacman`, `dnf`). You should uninstall
the packages mentioned in [supported hyprland stack and hyprapps](README.md#supported-hyprland-stack-and-hyprapps)
re-run the scripts.
