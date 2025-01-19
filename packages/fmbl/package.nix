{ llakaLib, ... }:


llakaLib.writeFishApplication
{
  name = "fmbl"; # `Fzf Modal Bind Life`

  text =
  /* fish */
  ''
    set -l options_list \
      "--border --cycle --exact --highlight-line --inline-info --multi --no-separator --reverse --ansi" \
      "--bind j:down --bind k:up" \
      "--bind 'esc:change-header(NORMAL MODE)+rebind(i,j,k)'" \
      "--bind 'i:change-header(INSERT MODE)+unbind(i,j,k)'" \
      "--bind 'start:unbind(down,up)+change-header(NORMAL MODE)'"

    echo (string join " " -- $options_list) # So user can set a variable to the output
  '';
}
