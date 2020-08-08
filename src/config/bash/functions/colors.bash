# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

NC="$(tput sgr0 2>/dev/null)"
RESET="$(tput sgr0 2>/dev/null)"
BLACK="\033[0;30m"    # Black
RED="\033[0;31m"      # Red
GREEN="\033[0;32m"    # Green
YELLOW="\033[0;33m"   # Yellow
BLUE="\033[0;34m"     # Blue
PURPLE="\033[0;35m"   # Purple
CYAN="\033[0;36m"     # Cyan
WHITE="\033[0;37m"    # White
ORANGE="\033[0;33m"   # Orange
LIGHTRED='\033[1;31m' # Light Red

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf_color() { printf "%b" "$(tput setaf "$2" 2>/dev/null)" "$1" "$(tput sgr0 2>/dev/null)"; }
printf_normal() { printf_color "\t\t$1\n" "$2"; }
printf_green() { printf_color "\t\t$1\n" 2; }
printf_red() { printf_color "\t\t$1\n" 1; }
printf_purple() { printf_color "\t\t$1\n" 5; }
printf_yellow() { printf_color "\t\t$1\n" 3; }
printf_blue() { printf_color "\t\t$1\n" 4; }
printf_cyan() { printf_color "\t\t$1\n" 6; }
printf_info() { printf_color "\t\t[ ℹ️ ] $1\n" 3; }
printf_exit() {
  printf_color "\t\t$1\n" 1
  return 1
}
printf_help() { printf_color "\t\t$1\n" 1; }
printf_read() { printf_color "\t\t$1" 5; }
printf_success() { printf_color "\t\t[ ✔ ] $1\n" 2; }
printf_error() { printf_color "\t\t[ ✖ ] $1 $2\n" 1; }
printf_warning() { printf_color "\t\t[ ❗ ] $1\n" 3; }
printf_question() { printf_color "\t\t[ ❓ ] $1 - [y/N] [❓] " 6; }
printf_error_stream() { while read -r line; do printf_error "↳ ERROR: $line"; done; }
printf_execute_success() { printf_color "\t\t[ ✔ ] $1 [ ✔ ] \n" 2; }
printf_execute_error() { printf_color "\t\t[ ✖ ] $1 $2 [ ✖ ] \n" 1; }
printf_execute_result() {
  if [ "$1" -eq 0 ]; then printf_execute_success "$2"; else printf_execute_error "$2"; fi
  return "$1"
}
printf_execute_error_stream() { while read -r line; do printf_execute_error "↳ ERROR: $line"; done; }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

###END
#/* vim: set expandtab ts=4 noai
