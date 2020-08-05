## git  
  
Git is the version control system  
  
requires:    
```
apt install git
```  
```
yum install git
```  
```
pacman -S git
```  
  
Automatic install/update:
```
bash -c "$(curl -LSs https://github.com/casjay-dotfiles/git/raw/master/install.sh)"
```
Manual install:
```
mv -fv "$HOME/.config/git" "$HOME/.config/git.bak"
git clone https://github.com/casjay-dotfiles/git "$HOME/.config/git"
git clone -q https://github.com/arialdomartini/oh-my-git.git "$HOME/.config/git/plugins"
ln -sf git "$HOME/.config/git/gitconfig" "$HOME/.gitconfig"
```
  
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/git" target="_blank">git wiki</a>  |  
  <a href="https://git-scm.com" target="_blank">git site</a>
</p>  
    
