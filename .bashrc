# Some things need to be available in bash as well

# This needs to be in bash since copilot executes commands out of bash
alias frg="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/fast-rg.sh"
