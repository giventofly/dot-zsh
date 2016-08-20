# .zsh

My zsh configuration. I'm using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and place some overrides in `~/.zsh`.

<img src="screenshots/Bildschirmfoto 2016-08-17 um 01.36.58.png" width="500">

## Installation

```bash
# Clone repo
git clone git@github.com:fiedl/dot-zsh ~/.zsh
```

This set of scripts won't touch your `~/.zshrc`.
Thus, add manually to your `~/.zshrc` what you'd like:

```bash
# ~/.zshrc

# Use https://github.com/fiedl/dot-zsh as override
# for oh-my-zsh:
ZSH_CUSTOM="$HOME/.zsh/oh-my-zsh-customization"
ZSH="$HOME/.oh-my-zsh"

# Shell theme:
ZSH_THEME="fiedl"

# Auto-install ~/.oh-my-zsh if missing.
if [ ! -d $ZSH ]; then
  curl -L http://install.ohmyz.sh | sh
fi

# Auto-install ~/.zsh if missing.
if [ ! -d ~/.zsh ]; then
  git clone git@github.com:fiedl/dot-zsh.git ~/.zsh
fi

# Auto-updating ~/.oh-my-zsh as well as ~/.zsh
# requires to use another upgrade script.
# Therefore, deactivate the oh-my-zsh-only one.
# The rest is done by the `auto-update` plugin.
export DISABLE_AUTO_UPDATE="true"
export DISABLE_UPDATE_PROMPT="false"
export UPDATE_ZSH_DAYS=1

# choose oh-my-zsh plugins
plugins=(git bundler editor auto-update fiedl install icecube plattform welcome)
```

Then, start a new terminal. Done!

## Update

* When starting a terminal, oh-my-zsh will ask you to perform an upgrade, regularly. This will also update `~/.zsh`.
* Or, run: `zsh-update`.
* Or, pull changes manually: `cd $HOME/.zsh; git pull`

## Documentation

### [auto-update.plugin.zsh](oh-my-zsh-customization/plugins/auto-update/auto-update.plugin.zsh)


#### Updating the zsh configuration

These commands help to sync the zsh configuration up and down.
Through the oh-my-zsh auto update process, the repo is down-synced
automatically. This is prevented by uncommited changes in ~/.zsh.

Quickly commit and push local changes:

    zsh-push

If needed, with commit message:

    zsh-push I added cool stuff ...

Get latest changes by running one of these:

    zsh-pull
    zsh-update

`zsh-push` will update the documentation in the README automatically.
But it may be run manually, e.g. before committing manually.

    zsh-update-documentation

To edit the plugin "welcome", just type:

    zsh-plugin welcome
    plugin welcome


#### Automated updates

This script hooks into the update process of oh-my-zsh
and also updates ~/.zsh as well as some other things
like homebrew.

To update manually, run:

    zsh-update


#### Update hooks

This plugin makes use of [zsh-hooks](https://github.com/willghatch/zsh-hooks)
to allow other plugins to hook into the update process.

When writing a plugin, hook the functions to execute when
updating into the process, like this:

    foo_plugin_update() {
      # stuff executed by this plugin when
      # the update process is run.
    }

    hooks-add-hook zsh_update foo_plugin_update

Or, short:

    hook zsh_update foo_plugin_update

Or, shorter:

    on_update foo_plugin_update



### [editor.plugin.zsh](oh-my-zsh-customization/plugins/editor/editor.plugin.zsh)

Quickly start a text editor:

    e
    e .
    e ~/.zshrc

If textmate (`mate`) is installed, it will be used as editor.
Otherwise, `emacs -nw` (in the terminal, not as window).
Otherwise, `vim`.



### [fiedl.plugin.zsh](oh-my-zsh-customization/plugins/fiedl/fiedl.plugin.zsh)


#### Code grepping

These helpers are useful to find definitions in code or quickly grep for
expressions.

    def current_user
    g class User

#### Finding files

Quickly find a file within the current directory.

    f user
    f user |count

This uses friendly find (ffind), which needs to be installed.
Mac: `brew install ffind`.

#### Moving files

Move multiple files with wildcards using multimove.

    mmv foo-*.txt foo/*.md

See also:
http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/

#### Fun stuff

Play random lcars sound from `~/Music/lcars`.
This requires `brew install mplayer coreutils`.

    lcars

Display the matrix.
This requires `brew install cmatrix`.

    matrix

#### Killing processes

    ka vlc


### [highlight.plugin.zsh](oh-my-zsh-customization/plugins/highlight/highlight.plugin.zsh)


#### Selective history

To select a command from the history to repeat, type the beginning
and press the up key.

    ssh<up>
    # =>  ssh mccoy

See also: https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys


#### Home and end keys

This makes them also work in the terminal.

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-beginning-search
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-beginning-search
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

#### Command highlighting

When you type, the zsh checks whether the command in known. If so,
it's highlighted.

I've taken this from
https://github.com/zsh-users/zsh-syntax-highlighting
and got the idea from
https://github.com/idk/moo-skel.



### [icecube.plugin.zsh](oh-my-zsh-customization/plugins/icecube/icecube.plugin.zsh)

On the icecube machine in zeuthen, there's I3_PORTS installed.
Make some shortcuts:

    ice-port
    ice-cmake
    clsim-make
    icesim      # runs the env-shell



### [install.plugin.zsh](oh-my-zsh-customization/plugins/install/install.plugin.zsh)

This plugin provides shortcuts for installing software
using homebrew cask.

    search vlc
    install vlc
    uninstall vlc

Or, in German (for parents :-) )

    suche skype
    installiere skype
    deinstalliere skype



### [keyboard.plugin.zsh](oh-my-zsh-customization/plugins/keyboard/keyboard.plugin.zsh)


#### Remap keys (macOS)

Using karabiner I have remapped my keyboard.

    p ü + ö ä # < -   (layout: de)
    ----------------------------------
    \ { }   [ ] |     Alt_L
    \ { }   [ ] | ~   Cmd_R
      [ ]             Alt_L + Shift_L

Karabiner provides a command-line interface to activate
or deactivate settings:

    karabiner set karabiner set remap.optionR2forwarddelete 1
    karabiner set karabiner set remap.optionR2forwarddelete 0

Also, this script provides a short comamnd to create and apply
new key remappings.

They keycodes can be looked up here:
https://github.com/tekezo/Karabiner/blob/master/src/bridge/generator/keycode/data/KeyCode.data

But be aware, they always refer to the us keyboard layout.

    create-key-map slash backslash
    create-key-map "slash shift" backslash

The new mapping is appended to
~/Library/Application Support/Karabiner/private.xml.

Manual: https://pqrs.org/osx/karabiner/xml.html.en

To edit this file, just type:

    key-maps



### [moo.plugin.zsh](oh-my-zsh-customization/plugins/moo/moo.plugin.zsh)

I have taken this excellent zsh configuration from mooOS, the gnu/linux
distro of shape shifting, time travelling alien space penguins, https://mooos.org.

The source can be found here: https://github.com/idk/moo-skel

https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
Show history
misc
control hardware
more custom commands


### [plattform.plugin.zsh](oh-my-zsh-customization/plugins/plattform/plattform.plugin.zsh)

These are some helpers for [Rails](https://github.com/rails/rails)
and [YourPlatform](https://github.com/fiedl/your_platform).

#### Directories

Here are some aliases to jump to directories.
On the development machine, the projects are expected to be in
`~/rails`, on the production machine, in `/var`.

    cdw  # wingolfsplattform
    cdy  # your_platform
    cdo  # your_platform_ops
    cdp  # platforms_ops
    cdm  # your_platform/demo_app/my_platform
    cdv  # vademecum app

#### Rails console

On our production machine, `console` logs in to the platform user
and runs the rails console.

#### Rails shortcuts

Some shortcuts for bundler:

    be    # bundle exec, with lcars sound ;)
    bi    # bundle install
    bu    # bundle update

Shortcut for `bin/rake`:

    r

Shortcut for `bin/rails server`:

    s

When starting `pry` within a rails project, the `config/environment`
is used automatically. No need to call `pry -r ./config/environment`
explicitly.

    pry

Ship it! To merge the `master` branch into `production`
just call `production`.

    production

To generate the platform documentation for `cdw` and open it locally,
call:

    doc


#### Testing

Run `bin/rspec` in an orange-colored tab with lcars sounds.

    rspec
    rspec spec/models

Run specs with selenium rather than phantomjs.

    SELENIUM=true rspec spec/features
    selenium spec/features
    selen spec/features



### [welcome.plugin.zsh](oh-my-zsh-customization/plugins/welcome/welcome.plugin.zsh)

This plugins prints some useful information about the current machine
when opening a new terminal.

This is done using [screenfetch](https://github.com/KittyKatt/screenFetch).
Install with `brew install screenfetch`.

Next to the starfleet sign, of course :)

I've taken this from mooos: https://github.com/idk/moo-skel




## Author

(c) 2016, Sebastian Fiedlschuster
