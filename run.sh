#!/usr/bin/env bash
# Kill fluidsynth, if already running, and wait a second
# for ALSA connection daemon to react.
sudo kill $(pgrep fluidsynth) &>/dev/null
sleep 1

# Run FluidSynth with ALSA, highest priority and all
# SoundFonts in ~/Sounds.
sudo fluidsynth -i -a alsa -m alsa_seq -s -g 0.5 \
                -o audio.realtime-prio=99 \
                -o audio.alsa.device=hw:0 \
                -o synth.sample-rate=96000 \
                -o synth.midi-bank-select=mma \
                /home/pi/Sounds/* &>/dev/null &

~/fluidsynth-rpi-bootstrap/connect-midi.sh &>/dev/null &
