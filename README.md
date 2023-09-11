
# WSL2 Install

## Creation of NixOS WSL machine

1. Install WSL using the following command:
```
wsl --install --no-distribution
```

2. Create the working directory
```
mkdir NixOS-WSL

cd NixOS-WSL
```

3. Download the NixOS Filesystem

Replace the release tag with the one most up to date

(can be found on https://github.com/nix-community/NixOS-WSL/releases/latest)

The download can take some time, it is around 300 Mb

`nixos-wsl-x86_64-linux.tar.gz` worked for me, with the non-x86 one I had a problem with systemd not starting

Name it as `install.tar.gz` and put it in the NixOS-WSL directory created earlier

4. Import NixOS
```
wsl --import NixOS .\NixOS\ installer.tar.gz --version 2
```

5. Set NixOS as default
```
wsl -s NixOS
```

6. Run it
```
wsl
```

## Configure the NixOS machine to source from this git repo
1. Clone the repo
```
nix-shell -p git
```
```
cd ~
git clone https://github.com/jkulzer/dotfiles
```

2. Fix some weird WSL stuff
```
mount -o remount,rw /tmp/.X11-unix
```


# Useful repos:
* https://github.com/gytis-ivaskevicius/nixfiles/
