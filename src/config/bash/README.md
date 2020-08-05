## bash  
  
Bash is the GNU Project's shell  
  
requires:    
```
apt install bash bash-completion direnv
```  
```
yum install bash bash-completion direnv
```  
```
pacman -S bash bash-completion direnv
```  
```
xbps-install -S bash bash-completion direnv
```
```
brew install bash bash-completion direnv
```
Automatic install/update:
```
bash -c "$(curl -LSs https://github.com/casjay-dotfiles/bash/raw/master/install.sh)"
```
Manual install:
```
mv -fv "$HOME/.config/bash" "$HOME/.config/bash.bak"
git clone https://github.com/casjay-dotfiles/bash "$HOME/.config/bash"
ln -sf $HOME/.config/bash/.bash* "$HOME/"
```
  
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/bash" target="_blank">bash wiki</a>  |  
  <a href="https://www.gnu.org/software/bash/" target="_blank">bash site</a>
</p>  
    
  
