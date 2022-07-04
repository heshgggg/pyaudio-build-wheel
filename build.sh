#!/bin/sh
set -ex

# Check what python version we are using
# The version should be set automatically by the calling GitHub Actions code
python --version

# Build and install PortAudio
curl -sSLO https://github.com/PortAudio/portaudio/archive/refs/tags/v19.7.0.zip
unzip -q v19.7.0.zip
(
    cd portaudio-19.7.0
    # We may only want the winapi flag when compiling on Windows
    ./configure --with-winapi=wasapi --enable-static=yes --enable-shared=no
    make
    sudo make install
)

# Build wheel
git clone https://people.csail.mit.edu/hubert/git/pyaudio.git
cd pyaudio
python setup.py bdist_wheel --static-link
test -d dist
ls -la
ls -la dist

exit 0
