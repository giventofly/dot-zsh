if [ -d $HOME/icecube ]
then
  alias ice-env="$ICESIM/env-shell.sh"



  alias ice-port="$I3_PORTS/bin/port"
  # alias ice-cmake="$I3_PORTS/bin/cmake"
  #alias shovel="$ICESIM/../build/bin/steamshovel"
  alias shovel="$ICESIM/bin/steamshovel"
  alias clsim-make="cd $ICESIM/clsim && make -j 4 && cd -"
  alias cdc="cd /Users/fiedl/icecube/clsim"

  #alias icesim="$ICESIM/env-shell.sh"
  #alias icesimfix="source ~/icecube/geant4fix.sh"
  #alias icedoc="open $ICESIM/../documentation/html/index.html && cd $ICESIM/../src && doxygen sim.doxygen"
  #alias nb='cd ~/diplomarbeit/Logbuch && jupyter notebook' # 'ipython notebook --pylab=inline'

  function ice-inspect () { $ICESIM/bin/icetray-inspect dataio icetray interfaces phys-services rootwriter tableio |grep "$*" -A 500 |ruby -e ' print $stdin.read.split("------").first' }

  alias ci="./zsh_to_markdown *.sh && git add . && git commit -m"

  # python
  # export PYTHONPATH=/usr/local/lib/python3.3:$PYTHONPATH
  # alias ipy='cd ~/diplomarbeit/Notebooks && ipython3 notebook --pylab=inline'

  # iruby
  alias iruby-notebook=' iruby notebook --pylab=inline'

fi


# On the icecube machine in zeuthen, there's I3_PORTS installed.
# Make some shortcuts:
#
#     ice-port
#     ice-cmake
#     clsim-make
#     icesim      # runs the env-shell
#
if [[ -z "$I3_PORTS" ]]; then
  alias ice-port="$I3_PORTS/bin/port"
  alias ice-cmake="$I3_PORTS/bin/cmake ../src"
  alias clsim-make="cd $SIM && make -j 4 && cd -"
  alias icesim="$SIM/env-shell.sh"
fi

# ### Jupyter bash kernel
#
# A great way to document console output is to run a bash kernel
# inside a jupyter session in the browser. That way, the input
# as well as the output is documented and can be extended with
# text blocks, headings et cetera.
#
# https://github.com/takluyver/bash_kernel
#
# Install with: `pip install [--upgrade] jupyter bash_kernel`
#
# Short commands:
#
# * `nb`: Start a new bash kernel notebook in the log directory. Next, click "New", "Bash".
#
alias nb='cd ~/diplomarbeit/Logbuch && jupyter notebook'