#!/bin/sh
set -ex

# Check what python version we are using
# The version should be set automatically by the calling GitHub Actions code
python --version

# Check what python detects for sys.platform
python -c 'import sys; print(sys.platform)'

command -v gcc
command -v g++
command -v make

# Build and install PortAudio
curl -sSLO https://github.com/PortAudio/portaudio/archive/refs/tags/v19.7.0.zip
unzip -q v19.7.0.zip
(
    cd portaudio-19.7.0
    # We may only want the winapi flag when compiling on Windows
    # Force full path of gcc and g++
    ./configure \
        --with-winapi=wasapi --enable-static=yes --enable-shared=no \
        CC="$(command -v gcc)" CXX="$(command -v g++)"
    make
    sudo make install
)

# Build wheel
git clone https://people.csail.mit.edu/hubert/git/pyaudio.git
cd pyaudio
# We might need to pass -cmingw32 flag here
python setup.py bdist_wheel --static-link
test -d dist
ls -la
ls -la dist

exit 0
