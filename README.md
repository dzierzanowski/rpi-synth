# fluidsynth-rpi-bootstrap
Bootstrap script to run FluidSynth headless on a Raspberry Pi with MIDI
keyboard input.

The script has been tested for FluidSynth 2.1.1 on Raspbian on a Raspberry Pi 4
rev. 1.2 with JustBoom DAC Standard HAT and a Nektar Impact LX61+ controller.
It takes about 30 to 60 seconds to boot.


## Requirements

### FluidSynth
```
sudo apt update
sudo apt install fluidsynth
```

### SoundFont
Get a desired SoundFont and place it wherever you like, then note this
location. FluidSynth should ship with some default SoundFonts located in
`/usr/share/sounds/sf2`. You can also check `SOUNDFONTS.md` for a list of
decent locations to obtain a SoundFont.


## Installation
Clone this repository to `pi` user's home directory with:
```
git clone https://github.com/Waked/fluidsynth-rpi-bootstrap.git
```

Then, copy (or link) files from `systemd` to `/etc/systemd/system` and enable
services:
```
cp ~/fluidsynth-rpi-bootstrap/systemd/fluidsynth.service /etc/systemd/system/
cp ~/fluidsynth-rpi-bootstrap/systemd/midi-autoconnect.service /etc/systemd/system/
sudo systemctl enable fluidsynth
sudo systemctl enable midi-autoconnect
```

The Raspberry Pi should now boot with Fluidsynth and automatically connect
the first MIDI device to it.


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

