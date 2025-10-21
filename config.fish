# Add Homebrew to PATH
eval (/opt/homebrew/bin/brew shellenv)

# Set default editor
set -gx EDITOR vim

# Replace rm with trash 
function rm
    trash $argv
end

# Aliases
alias ll='ls -la'
alias g='git'

# Initialize direnv
direnv hook fish | source

# Initialize Starship prompt
starship init fish | source
