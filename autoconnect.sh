#!/usr/bin/env bash

while true; do
    if [[ $( aconnect -l | grep "type=kernel,card=1" ) && $( aconnect -l | grep "FLUID Synth" ) ]]; then
        input_dev_id=$(aconnect -l | grep "type=kernel,card=1" | awk '{print $2}')
        output_dev_id=$(aconnect -l | grep "FLUID Synth" | awk '{print $2}')

        # Connect keyboard output with FluidSynth input.
        aconnect ${input_dev_id}0 ${output_dev_id}0 &>/dev/null
    fi

    sleep 1
done
