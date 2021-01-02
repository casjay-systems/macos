## git  
  
Git is a version control system  
  
Automatic install/update:

```shell
bash -c "$(curl -LSs https://github.com/dfmgr/git/raw/master/install.sh)"
```

Manual install:
  
requires:

Debian based:

```shell
apt install git
```  

Fedora Based:

```shell
yum install git
```  

Arch Based:

```shell
pacman -S git
```  

MacOS:  

```shell
brew install git
```
  
```shell
mv -fv "$HOME/.config/git" "$HOME/.config/git.bak"
git clone https://github.com/dfmgr/git "$HOME/.config/git"
git clone -q https://github.com/arialdomartini/oh-my-git.git "$HOME/.config/git/plugins"
ln -sf git "$HOME/.config/git/gitconfig" "$HOME/.gitconfig"
```
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/git" target="_blank" rel="noopener noreferrer">git wiki</a>  |  
  <a href="https://git-scm.com" target="_blank" rel="noopener noreferrer">git site</a>
</p>  
