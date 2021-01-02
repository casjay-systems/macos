## tmux  
  
tmux is a terminal multiplexer  
  
Automatic install/update:

```shell
bash -c "$(curl -LSs https://github.com/dfmgr/tmux/raw/master/install.sh)"
```

Manual install:
  
requires:

Debian based:

```shell
apt install tmux powerline fonts-powerline python3-powerline python3-psutil
```  

Fedora Based:

```shell
yum install tmux powerline
```  

Arch Based:

```shell
pacman -S tmux powerline
```  

MacOS:  

```shell
brew install tmux powerline
```
  
```shell
mv -fv "$HOME/.config/tmux" "$HOME/.config/tmux.bak"
git clone https://github.com/dfmgr/tmux "$HOME/.config/tmux"
```
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/tmux" target="_blank" rel="noopener noreferrer">tmux wiki</a>  |  
  <a href="https://tmux.github.io" target="_blank" rel="noopener noreferrer">tmux site</a>
</p>  
