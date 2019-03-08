# radioshell
Little bash program that allows to keep a list of online radio and listen to them in the terminal 📻

## Installation
1. Put the script anywhere you want
2. Make sure you have [MPV](https://mpv.io/) installed
3. Set the environment variable `$RADIOS_LIST` to the path of your `radios.txt` file (make sure it's full path, no `~` allowed)

## How to use

Just start the script and enjoy :)

**Warning** : The URLs must be direct stream links. Playlist files like `*.pls` or `*.m3u` are allowed too.

Otherwise, mpv will throw an error.

## Tips

- You don't have to write the complete name of the radio when playing it. It's made with a grep so you just need few letters actually :)
- Commands can be called with only the first letter. For example if you want the list, instead of typing `list`, you just can type `l`

## Other

![](https://tilde.town/~von/assets/media/sFU6.png)

[My personal radio list](https://gist.github.com/VonKavalier/cd55dd6d66db9064864a5e2c9a5aa660)

If you want to contribute any help will be appreciated :)
