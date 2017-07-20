# Experimental lcars features.
#
# ## Play sound
#
# Play random lcars sound from `~/Music/lcars`.
# This requires `brew install mplayer coreutils`.
#
#     lcars-sound
#

lcars-sound() { $ZSH_CUSTOM/plugins/lcars/bin/lcars-sound > /dev/null 2>&1 }

# ## Terminal lcars
#
# Display terminal head with system info in lcars style.
#
#     lcars-new
#
# This is executed when the plugin is included, i.e. don't use it
# together with the *welcoem* plugin.

function lcars-new() {
  clear
  # osascript -e 'tell application "System Events" to keystroke "k" using command down'
  $ZSH_CUSTOM/plugins/lcars/bin/lcars-frame head
  lcars-sound
}

lcars-new

# Wrap a command in an lcars frame.
# 
#     lcars echo foo
#

function lcars() {
  lcars-sound
  $ZSH_CUSTOM/plugins/lcars/bin/lcars-frame start $*
  echo ""
  $*
  echo ""
  lcars-sound
  $ZSH_CUSTOM/plugins/lcars/bin/lcars-frame end
}

export TERM="xterm-256color"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_STATUS_BACKGROUND='yellow'
POWERLEVEL9K_TIME_BACKGROUND='magenta'
POWERLEVEL9K_TIME_FOREGROUND='black'

#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="▇▇▇▇▇▇▇▇▇▇▇\n▇▇▇▇▇▇▇▇▇▇▇ "
#POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="▇▇▇▇▇▇▇▇▇▇▇ "
# ◖ button ◗
# export POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='◗ ◖'
# export POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='◗ ◖'
# export POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR='◗ ◖'
# export POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='◗ ◖'
# export POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='◗ ◖'
