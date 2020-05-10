#!/usr/bin/env zsh

OH_MY_ZSH_PATH="$HOME/.oh-my-zsh"

if ! command -v 'xcodebuild' >/dev/null 2>&1; 
then
	xcode-select --install
fi

if [[ ! -d $OH_MY_ZSH_PATH/.git ]]
then 
	git clone https://github.com/ohmyzsh/ohmyzsh $OH_MY_ZSH_PATH -q
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $OH_MY_ZSH_PATH/custom/themes/powerlevel10k -q
else
	git -C $OH_MY_ZSH_PATH pull -q
	git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k pull -q
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
		-avun --no-perms . ~;
}

	read "?This may overwrite existing files in your home directory. Are you sure? (y/n) ";
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
unset doIt;
