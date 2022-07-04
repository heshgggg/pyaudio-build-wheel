#!/bin/sh
set -ex

# Build and install PortAudio
wget https://github.com/PortAudio/portaudio/archive/refs/tags/v19.7.0.zip
unzip -q v19.7.0.zip
(
    cd portaudio-19.7.0
    ./configure
    make
    sudo make install
)

# Build wheel
git clone https://people.csail.mit.edu/hubert/git/pyaudio.git
cd pyaudio
python3.7 setup.py bdist_wheel
test -d dist
ls -la
ls -la dist

exit 0
