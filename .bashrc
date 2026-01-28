# Some things need to be available in bash as well

# This needs to be in bash since copilot executes commands out of bash
alias frg="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/fast-rg.sh"

# Sometimes copilot will still ignore instructions
alias grep="echo 'Grep not available, use frg instead'"
alias rg="echo 'Ripgrep not available, use frg instead'"
