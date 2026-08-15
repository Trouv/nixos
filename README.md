# `nixos`
This is my nixos config.
It is fairly simple, shared across multiple systems, and generally satisfies my gaming and development wants, while also looking quite pretty.

## Features
- pretty niri desktop environment with some extra configuration reminiscent of i3
- gaming w/ heroic, steam, proton, for both nvidia and amd gpus
- excellent neovim configuration, mostly using the sensible defaults provided by [nvf](https://github.com/NotAShelf/nvf)

## Install
On a fresh nix install (with disk encryption enabled)..

Decide what your hostname should be.
The commands in these instructions will be parameterized by this:
```
export DESIRED_HOSTNAME=<hostname>
```

Install git and a text editor and clone the repository into your home directory.
```bash
nix-shell -p git neovim
git clone https://github.com/trouv/nixos ~/nixos
cd ~/nixos
```

Copy your nixos-auto-generated `hardware-configuration.nix` to the hardware-configuration directory, with a name matching your desired hostname.
```bash
cp /etc/nixos/hardware-configuration.nix hardware-configuration/$DESIRED_HOSTNAME.nix
```

Add a new system in `systemSettings/`.
You can copy the template and read the comments to understand what each value should be.
```bash
cp systemSettings/template systemSettings/$DESIRED_HOSTNAME.nix
nvim systemSettings/$DESIRED_HOSTNAME.nix
```

Move the original nixos config somewhere as a backup.
```bash
sudo mv /etc/nixos ~/original-nixos
```

Add the new files to git.
```bash
git add systemSettings hardware-configuration
```

Install the "pre-configuration".
This is a lightweight nixos config that gives you the bare essentials and some bonuses to make the full build experience better.
The name of the pre-configuration is your hostname prefixed with `pre-`.
```bash
sudo nixos-rebuild switch --flake .#pre-$DESIRED_HOSTNAME
```

Install the final configuration and reboot.
```bash
sudo nixos-rebuild switch
reboot
```
