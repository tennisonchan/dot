# Dot
Simply a command to backup, restore, and sync the prefs and settings for your toolbox.

### Get Start
```sh
# Install dot via brew
brew install dot

# For the first time to backup all dotfiles and packages
# To initialize, start backing up to the dotfiles and then symlink them to $HOME
dot init

# Every time you need to backup you dotfiles and packages
# To backup all dotfiles and packages if there is no backup yet
dot backup

# create a new workplace, which is a branch on dotfiles
dot config workplace [workplace_name]

# Whenever you have a new local machine
# first clone your dotfiles repo on $HOME
dot bundle
```

### Topical And Structure
Dot manages the dotfiles, it also keeps track on other package managers, like `brew` and `npm`, for you.

For `brew`, Dot uses [homebrew-bundle](https://github.com/Homebrew/homebrew-bundle) to generate `.Brewfile` to store all your brew formulas and setting.
For `npm`, Dot generate a file called `Npmfile`, which is your global packages in json formate, to keep track on all your global npm packages.

If you're adding a new area to your forked dotfiles — say, "vim" — you can simply add a `vim` directory in the folder `Topics`.
