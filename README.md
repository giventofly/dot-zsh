# .zsh

My zsh configuration. I'm using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and place some overrides in `~/.zsh`.

<img src="screenshots/Bildschirmfoto 2018-06-14 um 17.53.37.png" width="500">

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
plugins=(git bundler editor auto-update highlight fiedl icecube gnuplot install plattform latex powerlevel lcars)
source $ZSH/oh-my-zsh.sh
```

Then, start a new terminal. Done!

## Update

* When starting a terminal, oh-my-zsh will ask you to perform an upgrade, regularly. This will also update `~/.zsh`.
* Or, run: `zsh-update`.
* Or, pull changes manually: `cd $HOME/.zsh; git pull`

## Install on fresh systems

```bash
# basic packages (arch linux only)
sudo pacman -S zsh emacs-nox htop ruby

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Clone repo
git clone https://github.com/fiedl/dot-zsh ~/.zsh

# MANUALLY: copy required content from above into ~/.zshrc

# Start a new shell
zsh

# Start an auto-update
zsh-update
```

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


#### Passing sudo

Aliases also work with sudo.
This trick is from https://wiki.archlinux.org/index.php/Sudo#Passing_aliases.

Why? From the alias section in the bash manpage (http://serverfault.com/a/178956/167331):

> A trailing space in value causes the next word to be checked
> for alias substitution when the alias is expanded.


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

#### Finding files on the NAS

Find files on the NAS by:

    nas-find Keith Jarrett
    nf Keith Jarrett

My NAS has a cron job to create a file index at `/share/Sebastian/.find.txt`.
In the work machine's file system, this is `/Volumes/Sebastian/.find.txt`.
The above commands just grep in that file.

    # crontab -e
    0 2 * * * cd /share/Sebastian; /usr/bin/find ./ |sed -e 's/\.\//\/Volumes\/Sebastian\//g' > .find.tmp; /bin/rm .find.txt; /bin/mv .find.tmp .find.txt


#### Follow files

Tail a file and follow it, even if the file is deleted
and re-created.

    tailf filename

This needs the gnu verion of `tail`. Install it with
`brew install coreutils.`


#### Moving files

Move multiple files with wildcards using multimove.

    mmv foo-*.txt foo/*.md

See also:
http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/

#### Fun stuff

Display the matrix.
This requires `brew install cmatrix`.

    matrix

#### Killing processes

    ka vlc

#### Shortcut for controlling services through homebrew.

    service restart elasticsearch

Will be the same as:

    brew services restart elasticsearch


### [gnuplot.plugin.zsh](oh-my-zsh-customization/plugins/gnuplot/gnuplot.plugin.zsh)

Use gnuplot to plot something and display it right inside the terminal
using `imgcat`.

Examples:

    plot "sin(x)"
    cat data.txt |plot



### [highlight.plugin.zsh](oh-my-zsh-customization/plugins/highlight/highlight.plugin.zsh)


#### Selective history

To select a command from the history to repeat, type the beginning
and press the up key.

    ssh<up>
    # =>  ssh mccoy

See also: https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys


#### Home and end keys

This makes them also work in the terminal.
I've taken this from http://zshwiki.org/home/zle/bindkeys.


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

### Jupyter bash kernel

A great way to document console output is to run a bash kernel
inside a jupyter session in the browser. That way, the input
as well as the output is documented and can be extended with
text blocks, headings et cetera.

https://github.com/takluyver/bash_kernel

Install with: `pip install [--upgrade] jupyter bash_kernel`

Short commands:

* `nb`: Start a new bash kernel notebook in the log directory. Next, click "New", "Bash".



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



### [latex.plugin.zsh](oh-my-zsh-customization/plugins/latex/latex.plugin.zsh)


#### Shared libraries

This repository contains some shared libraries and extensions
I use in my latex projects.

They can be symlinked or hardlinked into existing projects:

    cd /path/to/my/latex/project
    ln -s ~/.zsh/oh-my-zsh-customization/plugins/latex/lib lib
    hln ~/.zsh/oh-my-zsh-customization/plugins/latex/lib lib

Or, with this extension, short:

    cd /path/to/my/latex/project
    latex-link-lib
    latex-unlink-lib

When hardlinked, the lib directory is included in git's source control.

The `hln` command is defined in https://github.com/selkhateeb/hardlink
and can be installed on mac os using `brew install hardlink-osx`.

Then the shread libraries can be included into the tex document:

    % /path/to/my/latex/project/main.tex
    % ...
    % \input{lib/todo}



### [lcars.plugin.zsh](oh-my-zsh-customization/plugins/lcars/lcars.plugin.zsh)

<img src="screenshots/Bildschirmfoto 2017-07-20 um 23.41.49.png" width="500">
Experimental lcars features.


#### lcars command

Prefix any command with `lcars` if you like.


#### Play sound

Play random lcars sound from `~/Music/lcars`.
This requires `brew install mplayer coreutils`.

    lcars-sound


#### Terminal lcars

Display terminal head with system info in lcars style.

    lcars-new

This is executed when the plugin is included, i.e. don't use it
together with the *welcoem* plugin.
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="▇▇▇▇▇▇▇▇▇▇▇\n▇▇▇▇▇▇▇▇▇▇▇    "
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="▇▇▇▇▇▇▇▇▇▇▇    ➜ "
◖ button ◗
export POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='◗ ◖'
export POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='◗ ◖'
export POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR='◗ ◖'
export POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='◗ ◖'
export POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='◗ ◖'


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

Run parallel tests

    para spec/models

The node js binary path `/usr/local/nodejs-binary/bin` is added to the `PATH`
by this script.



### [powerlevel.plugin.zsh](oh-my-zsh-customization/plugins/powerlevel/powerlevel.plugin.zsh)

This plugin is for working with the powerlevel9k zsh theme.
https://github.com/bhilburn/powerlevel9k


#### Auto install

If the directory `$ZSH_CUSTOM/themes/powerlevel9k`
is missing, it is fetched from https://github.com/bhilburn/powerlevel9k.


If you want to use the theme, please specify it in your `~/.zshrc`.

    # ~/.zshrc
    # ...
    ZSH_THEME="powerlevel9k/powerlevel9k"

See also: https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions


#### Configuration

You may configure powerlevel9k in `~/.zshenv` using environment variables.
But this plugin sets some nice defaults.

See also: https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
And: https://gist.github.com/athityakumar/1bd5e9e24cd2a1891565573a893993eb



### [welcome.plugin.zsh](oh-my-zsh-customization/plugins/welcome/welcome.plugin.zsh)

This plugins prints some useful information about the current machine
when opening a new terminal.

This is done using [screenfetch](https://github.com/KittyKatt/screenFetch).
Install with `brew install screenfetch`.

Next to the starfleet sign, of course :)

I've taken this from mooos: https://github.com/idk/moo-skel




## Author

(c) 2017, Sebastian Fiedlschuster
