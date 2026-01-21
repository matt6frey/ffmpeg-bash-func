# ffmpeg-bash-func
Simple bash functions for linux/unix when using ffmpeg

## Dependencies
- ffmpeg version 7.1.1
- bats version 1.11.1

## Installation

The init executable will check for your dependencies and add them for you. It will then make a symlink from where you have the repo to the `/usr/local/ffmpeg_functions` location.

1. Run the `init` executable
2. test for `vtrim` using `type vtrim` (or desired method)

## Recommendation for manual changes
Store this repo in your `/opts` directory (or your desired directory) and symlink the `.main_functions` to `/usr/local/ffmpeg_functions`. Then reference within your `~/.bash_functions` file. Ensure that your `~/.bashrc` contains the lines:

```bash
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi
```

Keep adding new methods within the functions directory. After a new method has been added, run `./refresh_methods` to update your `~/.bashrc`.

## Adding Tests for your methods

Using Bats (Bash Automated Testing System) to your system, if you haven't run the `init` executable:

```
sudo apt update
sudo apt install bats
```
