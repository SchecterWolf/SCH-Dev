# VIM Setup Notes

## CoC

When initializing a new vim dev env, some of the vim coc plugins will require
the user to input additional commands in order to finish installing the plugin.
This is expected behaviour and should only have to be done once

### CoC-clangd

As per the [documentation](https://github.com/clangd/coc-clangd), it is recommended that
the clangd setting be removed from the coc-settings.json config file, in order to prevent
clangd from running twice
