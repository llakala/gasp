{ llakaLib, ... }:


llakaLib.writeFishApplication
{
  name = "fmbl"; # `Fzf Modal Bind Life`

  text =
  /* fish */
  ''
    set -l options_list \
      "--border --cycle --exact --highlight-line --inline-info --multi --no-separator --reverse --ansi" \
      "--preview-window '75%'" \
      "--bind j:down --bind k:up" \
      "--bind 'esc:change-header(NORMAL MODE)+hide-input+rebind(i,j,k)'" \
      "--bind 'i:change-header(INSERT MODE)+show-input+unbind(i,j,k)'" \
      "--bind 'start:unbind(down,up)+hide-input+change-header(NORMAL MODE)'"

    echo (string join " " -- $options_list) # So user can set a variable to the output
  '';
}
