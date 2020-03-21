#!/usr/bin/env bash

# Wait for FluidSynth to initalise and/or for the MIDI                          
# keyboard (card=1) to get connected.                                           
while [[ ! $( aconnect -l | grep "type=kernel,card=1" ) || ! $( aconnect -l | grep "FLUID Synth" ) ]]; do
    echo "Waiting for MIDI devices..."                                          
    sleep 1;                                                                    
done                                                                            
                                                                                
# Fetch MIDI device IDs for the keyboard and FluidSynth input.                  
input_dev_id=$(aconnect -l | grep "type=kernel,card=1" | awk '{print $2}')         
output_dev_id=$(aconnect -l | grep "FLUID Synth" | awk '{print $2}')            
                                                                                
echo "Input dev: '${input_dev_id}'"                                             
echo "Output dev: '${output_dev_id}'"                                           
                                                                                
# Connect keyboard output with FluidSynth input.                                
aconnect ${input_dev_id}0 ${output_dev_id}0
