#!/bin/bash

#normal human voice is 80 to 1100 Hz or 0.08 to 1.1 kHz

rm -v *hpf* *lpf*

for num in $(seq 0.001 0.1 1.0) $(seq 0.1 0.5 8)
do
lame -V8 -vbr-new --highpass $num puscifer_original.mp3 puscifer_hpf_$num.mp3
done

for num in $(seq 0.001 0.1 1.0) $(seq 0.1 0.5 8)
do
lame -V8 -vbr-new --lowpass $num puscifer_original.mp3 puscifer_lpf_$num.mp3
done

#Orchestra works best
for num in $(seq 0.001 0.1 1.0) $(seq 0.1 0.5 8)
do
lame -V8 -vbr-new --highpass $num Terraria.mp3 Terraria_hpf_$num.mp3
done

for num in $(seq 0.001 0.1 1.0) $(seq 0.1 0.5 8)
do
lame -V8 -vbr-new --lowpass $num Terraria.mp3 Terraria_lpf_$num.mp3
done

#bandpass...lower than 0.08 and higher than 1.1
lame -V8 -vbr-new --lowpass 2.0 puscifer_original.mp3 lowpass.mp3
lame -V8 -vbr-new --highpass 4.0 puscifer_original.mp3 highpass.mp3
./ffmpeg -i lowpass.mp3 -i highpass.mp3 -filter_complex amerge -c:a libmp3lame -q:a 4 bandpass.mp3