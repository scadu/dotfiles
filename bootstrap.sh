#!/usr/bin/env zsh

OH_MY_ZSH_PATH="$HOME/.oh-my-zsh"

if ! command -v 'xcodebuild' >/dev/null 2>&1; 
then
	xcode-select --install
fi

if [[ ! -d $OH_MY_ZSH_PATH/.git ]]
then 
	git clone https://github.com/ohmyzsh/ohmyzsh $OH_MY_ZSH_PATH -q
else
	git -C $OH_MY_ZSH_PATH pull -q
fi

brew bundle

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".macos" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude "Brewfile" \
		--exclude "Brewfile.lock.json" \
		-avh --no-perms . ~;
}

	read "?This may overwrite existing files in your home directory. Are you sure? (y/n) ";
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
unset doIt;
