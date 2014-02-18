install_pow() {
    curl get.pow.cx | sh
}

install_homebrew() {
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

install_rvm() {
    curl -sSL https://get.rvm.io | bash
}
