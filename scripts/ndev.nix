''
  # maximize first to normalize # of switches
  niri msg action maximize-column

  # switch to largest non-maximized preset
  for i in {0..4};
  do niri msg action switch-preset-column-width;
  done

  if [ `nix develop --command echo OK` ]; then
    kitty --hold nix develop &
    nix develop --command nvim .
  else
    kitty --hold &
    nvim .
  fi
''
