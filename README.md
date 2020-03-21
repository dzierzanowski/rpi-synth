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

### SoundFonts
```
mkdir ~/Sounds
```
Copy or symlink SoundFonts into this directory. FluidSynth should ship with
some default SoundFonts located in `/usr/share/sounds/sf2`.


## Installation
Clone this repository to `pi` user's home directory with:
```
git clone https://github.com/Waked/fluidsynth-rpi-bootstrap.git
```

Then, add the following line in `~/.profile`:
```
/home/pi/fluidsynth-rpi-bootstrap/run.sh
```


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

### Connect MIDI devices on USB device
Connect your MIDI controller and check its `vendor_id:product_id` with:
```
lsusb
```

Create a device rule file such as `/etc/udev/rules.d/50-nektar.rules` and put
this line inside:
```
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="<vendor_id>", ATTR{idProduct}=="<product_id>", RUN+="/home/pi/fluidsynth-rpi-bootstrap/connect-midi.sh"
```


## Caveats

I have not yet figured how to switch between fonts and between banks within a
font from a controller. Therefore, you might want to put only one font in the
`~/Sounds` directory, or modify the script to select the one you desire.
 
