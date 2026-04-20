#bat
alias fzf-show=fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'

bat-themes() {
    if [ -z "$1" ]; then
        bat --list-themes
    else
        bat --list-themes | fzf --preview="bat --theme={} --color=always $1"
    fi
}

bat-use-theme() {
    bat --theme=$1
}

show-all-eza-themes () {
    for theme in $(vivid themes); do
        echo "Theme: $theme"
        LS_COLORS=$(vivid generate $theme)
        eza -l
        echo
    done
}

get-public-ip() {
    dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com
}

# TODO: change alias to function when added function support
# show_hidden () {
#    { defaults write com.apple.finder AppleShowAllFiles $1; killall -HUP Finder; }
# }