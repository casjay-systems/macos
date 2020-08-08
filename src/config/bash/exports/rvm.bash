#  -*- shell-script -*-

# Ruby Version Manager

if [ -d /usr/local/rvm/bin ]; then
  export PATH="$PATH:/usr/local/rvm/bin"
fi

export GEM_HOME="$HOME/.local/share/gem"
export rvmsudo_secure_path=0
export rvm_ignore_gemrc_issues=1
export rvm_silence_path_mismatch_check_flag=1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
