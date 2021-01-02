## fish  
  
fish is a smart and user-friendly command line shell  
  
Automatic install/update:

```shell
bash -c "$(curl -LSs https://github.com/dfmgr/fish/raw/master/install.sh)"
```

Manual install:
  
requires:

Debian based:

```shell
apt install fish
```  

Fedora Based:

```shell
yum install fish
```  

Arch Based:

```shell
pacman -S fish
```  

MacOS:  

```shell
brew install fish
```
  
```shell
mv -fv "$HOME/.config/fish" "$HOME/.config/fish.bak"
git clone https://github.com/dfmgr/fish "$HOME/.config/fish"
fish "$HOME"/.config/fish/omf-install --path=~/.local/share/fish/oh-my-fish --config=~/.config/fish/omf --noninteractive --yes
fish "$HOME"/.config/fish/plugins.fish
rm -Rf "$HOME"/.config/fish/omf-install
```
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/fish" target="_blank" rel="noopener noreferrer">fish wiki</a>  |  
  <a href="https://fishshell.com" target="_blank" rel="noopener noreferrer">fish site</a>
</p>  
