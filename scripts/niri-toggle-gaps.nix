''
  #!/bin/bash

  GAPS0_PATH="$HOME/.config/niri/gaps0.kdl"
  if [ -f $GAPS0_PATH ]; then
    rm $GAPS0_PATH
  else
    echo "
    layout {
      gaps 0
    }
    " > $GAPS0_PATH
  fi
''
