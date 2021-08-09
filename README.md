# rpi-synth
Bootstrap script to run [FluidSynth] and [setBfree] headless on a Raspberry Pi
with MIDI keyboard input.

The script has been tested for FluidSynth 2.1.1 and setBfree 0.8.11  on
Raspbian on a Raspberry Pi 4 rev. 1.2 with JustBoom DAC Standard HAT and a
Nektar Impact LX61+ controller. It takes about 30 seconds to boot.

[FluidSynth]: https://github.com/FluidSynth/fluidsynth
[setBfree]: https://github.com/pantherb/setBfree


## Requirements

### FluidSynth
```
sudo apt update
sudo apt install fluidsynth
```

### SoundFont
Get a desired SoundFont and place it in the `sounds` directory. FluidSynth
should ship with some default SoundFonts located in `/usr/share/sounds/sf2`,
I recommend browsing the Internet for your favorite founds and compiling them
into a single SoundFont using [Polyphone].

`SOUNDFONTS.md` contains a curated list of decent locations to obtain
SoundFonts.

[Polyphone]: https://github.com/davy7125/polyphone


## Installation
Clone this repository to `pi` user's home directory with:
```
git clone https://github.com/Waked/rpi-synth.git
```

Then, copy (or link) files from `systemd` to `~/.config/systemd/user/` and
enable services:
```
mkdir -p ~/.config/systemd/user
cd ~/.config/systemd/user
ln -s ~/rpi-synth/systemd/* .
systemctl --user enable *
```

The Raspberry Pi should now boot with FluidSynth and setBfree and automatically
connect the first MIDI device to them.

Adjust the `fluidsynth.cfg` and `setBfree.cfg` according to your HiFi hat and 
SoundFont's configuration, or taste, and reboot. Documentation for setBfree is
found in the binary's help (but the config itself contains lots of comments),
while FluidSynth is documented in [the wiki].

[the wiki]: https://github.com/FluidSynth/fluidsynth/wiki/UserManual#shell-commands


## Tips

### Headless Raspbian
To disable booting to GUI, use `sudo raspi-config`.

### Read-only root filesystem
When using a Raspberry Pi as a headless synth, you will probably be turning off
the device by pulling the plug, which creates a risk of damaging the SD card
if it is being written to. To decrease this risk, edit `/etc/fstab` by adding
`ro` as one of the options for the root directory, so that the line looks
similar to this:
```
PARTUUID=ea7d04d6-02  /               ext4    defaults,noatime,ro  0       1
```

This can be easily temporarily reverted with:
```
sudo mount -o remount,rw /
```

### Instruments vs. programs vs. soundbanks
When in the Fluidsynth's console (`telnet localhost 9800`), you can check what
instruments are available for you by checking font ID with: `fonts` and then
instruments with: `inst <id>`. Each instrument will have two three-digit
numbers associated with it - the first one is the bank number, the second is
the program number. In order to use an instrument from a bank other than the
nullth, first send a bank change message, then a program change message with
your MIDI controller.

