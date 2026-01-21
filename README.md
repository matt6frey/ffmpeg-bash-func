# ffmpeg-bash-func
Simple bash functions for linux/unix when using ffmpeg

## Dependencies
- ffmpeg version 7.1.1
- bats version 1.11.1

## Installation

The init executable will check for your dependencies and add them for you. It will then make a symlink from where you have the repo to the `/usr/local/ffmpeg_functions` location.

1. Run the `init` executable
2. test for `vtrim` using `type vtrim` (or desired method)

**Step 2 output:**
```bash
YOUR_USER@YOUR_PC:~/Projects/ffmpeg-bash-func$ type vtrim
vtrim is a function
vtrim () 
{ 
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] || [[ -z "$1" ]]; then
        echo "Us.."
        # remaining method code
```

## Adding new methods

1. Add new methods in the functions folder. 
2. Follow the naming convention of `.[your_method_name] # i.e. .vtrim`.
3. Add a test file for the new file. 
4. Make sure the tests pass. 
5. Run `./refresh` executable to add it to `./main_functions` and update your `./bashrc`

## Next Steps...

Currently, this project is only set up for Debian v13/Ubuntu v2025. I want to make it more available to other distros. So some of the immediate steps are:

1. Add name conflict check for each method creation, so we don't overwrite existing system methods.
2. Add some Github Actions to check for popular packages that already exist to also help with step 1. 
3. Add Github Actions for testing, PR evaluation, security & vulnerability checks.
4. Update init script to have a flag for system wide scope (all users) or only user local scope
5. Update methods and repo with best practices from wiki.

## Contributing

TL/DR;
1. Create a branch off of `main`.
2. Follow the section on *adding new methods*.
3. Don't provide duplicate methods. 
4. Feel free to add your Github Handle/URL in a comment within the file
5. Create your PR! 🚀

Follow the section on *adding new methods*. For the most part, this is a fun project for me as I explore `ffmpeg` more, however, I definitely encourage people to contribute their functions to this project. If you're a new developer wanting to learn Bash/Shell scripting for Linux/Unix (and potentially Windows - we'll see), feel free to make a PR. I am happy to review your code when I get the chance and give you feedback & help you gain contributions. 

## Resources

- [ffmpeg Core docs](https://ffmpeg.org/documentation.html)
- [ffmpeg-filters](https://ffmpeg.org/ffmpeg-filters.html)
- [ffmpeg-protocols](https://ffmpeg.org/ffmpeg-protocols.html)
- [ffmpeg Wiki](https://trac.ffmpeg.org/wiki)
- [Bats (Bash Automated Testing System)](https://bats-core.readthedocs.io/en/stable/)
- [Bats Github Tutorial](https://github.com/bats-core/bats-core%23writing-tests)
- [Bats Assert & Bats-support](https://github.com/bats-core/bats-assert)

