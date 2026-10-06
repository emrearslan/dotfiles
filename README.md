# dotfiles

[![asciicast](https://asciinema.org/a/539147.svg)](https://asciinema.org/a/539147)

# Install

```sh
git clone --recurse-submodules https://github.com/emrearslan/dotfiles ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

Already cloned without `--recurse-submodules`:

```sh
git submodule update --init --recursive
```

# Update

Pull dotfiles and the `private` submodule (`dotfiles-private`, needs access to the private repo):

```sh
cd ~/.dotfiles
git pull --recurse-submodules
git submodule update --init --remote --recursive
```

`--remote` moves `private` to the latest `master` of `dotfiles-private`. Commit the updated submodule pointer afterwards:

```sh
git add private && git commit -m "update private submodule"
```

# Components

* topic/preinstall.sh
* topic/install.sh
* topic/alias.sh
* topic/init.sh
* topic/export.sh

# License

The code is available under the [MIT license][license].