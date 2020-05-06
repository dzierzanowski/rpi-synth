#!/usr/bin/env bash

while true; do
    jack_connect "in-hw-1-0-0-Impact-LX61--MIDI-1" "fluidsynth:midi_00"
    jack_connect "in-hw-1-0-0-Impact-LX61--MIDI-1" "setBfree:midi_in"

    sleep 1
done
