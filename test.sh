#!/bin/bash
echo Testing for 10s...
sudo plymouthd
sudo plymouth --show-splash
sleep 10
sudo plymouth quit
echo Everything seems to work!
