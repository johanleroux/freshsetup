function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

alias ..="cd .."
alias ...="cd ../.."

alias h='cd ~'
alias c='clear'
alias vm='homestead up && homestead ssh'
alias loc='cloc . --exclude-dir=node_modules,vendor,public,storage --exclude-ext=json'

function cargo() {
    ( ~/.cargo/bin/cargo $* )
}