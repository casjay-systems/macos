#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
  . "../utils.sh"

srcdir="$(cd .. && pwd)"
customizedir="$(cd ../../customize && pwd)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if (sudo -vn && sudo -ln) 2>&1 | grep -v 'may not' >/dev/null; then

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  pip3_install() {

    echo ""
    execute \
      "sudo -H python3 -mpip install neovim powerline-status && \
      sudo -H python3 -mpip install cpython && \
      sudo -H python3 -mpip --no-cache-dir install git+https://github.com/pyx-project/pyx.git@fc66c078727b02693b122ad346b9fa5472e06eb7 && \
      sudo -H python3 -mpip install greenlet && \
      sudo -H python3 -mpip install neovim && \
      sudo -H python3 -mpip install msgpack && \
      sudo -H python3 -mpip install pynvim" \
      "Installing python3 modules"

  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  create_fonts() {

    echo ""
    execute \
      "sudo cp -Rf $customizedir/fonts/* /Library/Fonts/ && \
      sudo touch /Library/Fonts/.dfinst" \
      "Installing fonts"

  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  create_motd() {

    if [ -f /usr/games/fortune ]; then
      FORTUNE="/usr/games/fortune"
    else
      FORTUNE=$(which fortune 2>/dev/null)
    fi
    if [ -f /usr/games/cowsay ]; then
      COWSAY="/usr/games/cowsay"
    else
      COWSAY=$(which cowsay 2>/dev/null)
    fi

    declare -r FILE_PATH="/etc/motd"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    sudo touch /etc/motd &&
      $FORTUNE | $COWSAY >/tmp/motd &&
      sudo mv -f /tmp/motd $FILE_PATH

    print_result $? "$FILE_PATH"

  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  create_issue() {

    declare -r FILE_PATH="/etc/issue"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    sudo touch /etc/issue &&
      sudo cp -Rf "$(cd .. && pwd)/shell/motd" /etc/issue

    print_result $? "$FILE_PATH"

  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  create_sudo() {
    declare -r FILE_PATH="/etc/sudoers.d/insults"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    echo "Defaults    insults" >$FILE_PATH

    print_result $? "$FILE_PATH"

  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  create_user() {
    MYUSER=${SUDO_USER:-$(whoami)}
    ISINDSUDO=$(sudo grep -Re "$MYUSER" /etc/sudoers* | grep "ALL" >/dev/null)
    declare -r FILE_PATH="/etc/sudoers.d/$MYUSER"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    echo "$MYUSER ALL=(ALL)   NOPASSWD: ALL" >$FILE_PATH
    chmod -f 440 $FILE_PATH

    print_result $? "$FILE_PATH"
  }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

fi

main() {

  sudo chmod -f 755 /etc/sudoers.d

  pip3_install

  create_motd

  create_issue

  create_sudo

  create_user

  create_fonts

}

main
