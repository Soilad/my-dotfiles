if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting

alias nv='nvim'
alias nmtui-bw="NEWT_MONO=1 nmtui"
set -gx BROWSER zen-browser
# neofetch --chafa ~/.config/neofetch/FUCK\ YEAAAAA.png --size 800
fastfetch --logo ~/.config/fastfetch/shut.png --logo-height 15
starship init fish | source
#oh-my-posh init fish --config omp.json | source
fish_add_path -g ~/develop/flutter/bin
