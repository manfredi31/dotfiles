starship init fish | source
set -g fish_greeting
eval (/opt/homebrew/bin/brew shellenv)
set -gx EDITOR vim

if status is-interactive
# Commands to run in interactive sessions can go here
end
export PATH="$HOME/.local/bin:$PATH"

# opencode
fish_add_path /Users/manfredibernardi/.opencode/bin
