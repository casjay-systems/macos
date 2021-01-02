## mpd  
  
flexible, powerful, server-side application for playing music  
  
Automatic install/update:

```shell
bash -c "$(curl -LSs https://github.com/dfmgr/mpd/raw/master/install.sh)"
```

Manual install:
  
requires:

Debian based:

```shell
apt install mpd mpc ncmpcpp
```  

Fedora Based:

```shell
yum install mpd mpc ncmpcpp
```  

Arch Based:

```shell
pacman -S mpd mpc ncmpcpp
```  

MacOS:  

```shell
brew install mpd mpc ncmpcpp
```
  
```shell
mv -fv "$HOME/.config/mpd" "$HOME/.config/mpd.bak"
git clone https://github.com/dfmgr/mpd "$HOME/.config/mpd"
mkdir -p $HOME/.ncmpcpp
ln -sf $HOME/.config/mpd/ncmpcpp.conf $HOME/.ncmpcpp/config
```
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/mpd" target="_blank" rel="noopener noreferrer">mpd wiki</a>  |  
  <a href="https://www.musicpd.org" target="_blank" rel="noopener noreferrer">mpd site</a>
</p>  
