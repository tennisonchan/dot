# Dot [WIP]
Simply a command to backup, restore, and sync the prefs and settings for your toolbox.

### Get Start
```sh
# To install dot via git clone
git clone git@github.com:tennisonchan/dot.git
# Or install dot via brew
brew install dot

# To initialize, start backing up to the dotfiles and then symlink files to $HOME
dot init
```

###
```sh
#
dot init
```

### Topical And Structure
Everything is built around topics. For example, `brew` and `npm`, they are topics.
Each topic has the basic block to handle different tasks.
```sh
# To install the related software, reset all the backups and restore the dotfiles by running bundle
init.sh
# To start the whole cycle of update > install > symlink
bundle.sh
# For brew and npm, to install the formulas or packages based on the Brewfile and Npmfile
install.sh
# To update / sync the dotfiles to the `dot/dotfiles` and update files like Brewfile and Npmfile
update.sh
# To symlink certain files in `dot/dotfiles`to $HOME
symlink.sh
```

If you're adding a new area to your forked dotfiles — say, "vim" — you can simply add a `vim` directory in the folder `Topics`.
