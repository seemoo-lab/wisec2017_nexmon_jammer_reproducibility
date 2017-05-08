# What does this repository contain?

On the [10th ACM Conference on Security and Privacy in Wireless and Mobile 
Networks (WiSec 2017)](http://wisec2017.ccs.neu.edu/) we publish a paper on 
"Massive Reactive Smartphone-Based Jamming using Arbitrary Waveforms and 
Adaptive Power Control". As WiSec offers a reproducibility label, we use this 
repository to make all our measured data sets as well as the MATLAB scripts 
to evaluate them and create plots for the paper available to the public. 
Sharing these data should not only ease reproducibility, it should also 
allow fellow researchers to get started with our code and base their own 
research on it.

# How do I run your scripts to rebuild the graphics of the paper?

To run our scripts, you have two options, either you have a MATLAB license
(we used version R2016b) and can directly execute the m-files, or you can use
the [MATLAB Runtime](https://mathworks.com/products/compiler/mcr.html) and
execute our precompiled binaries on a 64-Bit Linux system.

## Execute m-files with MATLAB

1. Start MATLAB and navigate to the root directory of this repository.
2. Execute the `setup.m` file to add some directories to the path.
3. Navigate to the subdirectory of the figure you want to build and execute the corresponding `make_figureX.m` file.

## Execute Linux binaries with MATLAB Runtime

1. Install MATLAB Runtime version 9.1 (R2016b).
2. Export the following environment variables (you can do this by executing `source setup_env.sh` in the repository's source directory.):
```
export MCR_ROOT=/usr/local/MATLAB/MATLAB_Runtime
export XAPPLRESDIR=${MCR_ROOT}/v91/X11/app-defaults
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCR_ROOT}/v91/runtime/glnxa64:${MCR_ROOT}/v91/bin/glnxa64:${MCR_ROOT}/v91/sys/os/glnxa64:${MCR_ROOT}/v91/sys/opengl/lib/glnxa64
```
3. Navigate to the subdirectory of the figure you want to build and execute the `make_figureX` binary.

# How to reproduce the measurement results?

To reproduce the measurement results, you need four Nexus 5 smartphones 
running stock firmware version 6.0.1 (M4B30Z, Dec 2016). To root the phones
we used TWRP version 3.0.3 as recovery image and SuperSU version 2.79 to 
install the su binary. In the simplest setup, you can directly connect these
phones to a computer running the [nexmon](https://nexmon.org) firmware patching
framework including the external 
[nexmon_jammer](https://github.com/seemoo-lab/wisec2017_nexmon_jammer) patch.
To learn how to setup the nexmon environment, follow the "Getting started"
instructions from the readme of the nexmon_jammer repository. To also repeat 
the energy measurements, you need to connect one of the Nexus 5 smartphones
to a [Monsoon Power Monitor](https://www.msoon.com/LabEquipment/PowerMonitor/).
At the time of writing the WiSec paper, the power monitor had to be connected
to a Windows machine to collect the measurements.

In the following subsections, we explain how every dataset can be collected.

## Generating tssi_g70*_CH*_*0MHz_EXP*.m files

To generate tssi_g70X_CHX_X0MHz_EXPX.m files used for creating Figures 3 and 4
of the paper, nexutil is used to call the ioctls with numbers 700 to 705 and 
dump the results into the corresponding m-files. The handling of the ioctls is 
done in the
[ioctl_7xx.c](https://github.com/seemoo-lab/wisec2017_nexmon_jammer/blob/master/src/ioctl_7xx.c#L59)
file of the nexmon_jammer project. According to the ioctl numbers, different
channel specifications (channel number and bandwidth) are selected. Then we
trigger the generation and transmission of a test tone for measuring the 
transmit signal strength indicator (TSSI) and dump the result. To generate
the m-files, run the following commands on a computer connected to a Nexus 5
smartphone running the nexmon_jammer firmware:

``` 	
adb shell su -c "nexutil -g700 -l8196 -r" | strings > tssi_g700_CH7_20MHz_EXP0.m
adb shell su -c "nexutil -g700 -l8196 -r" | strings > tssi_g700_CH7_20MHz_EXP1.m
adb shell su -c "nexutil -g700 -l8196 -r" | strings > tssi_g700_CH7_20MHz_EXP2.m
adb shell su -c "nexutil -g701 -l8196 -r" | strings > tssi_g701_CH7_40MHz_L_EXP0.m
adb shell su -c "nexutil -g701 -l8196 -r" | strings > tssi_g701_CH7_40MHz_L_EXP1.m
adb shell su -c "nexutil -g701 -l8196 -r" | strings > tssi_g701_CH7_40MHz_L_EXP2.m
adb shell su -c "nexutil -g702 -l8196 -r" | strings > tssi_g702_CH7_80MHz_L_EXP0.m
adb shell su -c "nexutil -g702 -l8196 -r" | strings > tssi_g702_CH7_80MHz_L_EXP1.m
adb shell su -c "nexutil -g702 -l8196 -r" | strings > tssi_g702_CH7_80MHz_L_EXP2.m
adb shell su -c "nexutil -g703 -l8196 -r" | strings > tssi_g703_CH106_20MHz_EXP0.m
adb shell su -c "nexutil -g703 -l8196 -r" | strings > tssi_g703_CH106_20MHz_EXP1.m
adb shell su -c "nexutil -g703 -l8196 -r" | strings > tssi_g703_CH106_20MHz_EXP2.m
adb shell su -c "nexutil -g704 -l8196 -r" | strings > tssi_g704_CH106_40MHz_L_EXP0.m
adb shell su -c "nexutil -g704 -l8196 -r" | strings > tssi_g704_CH106_40MHz_L_EXP1.m
adb shell su -c "nexutil -g704 -l8196 -r" | strings > tssi_g704_CH106_40MHz_L_EXP2.m
adb shell su -c "nexutil -g705 -l8196 -r" | strings > tssi_g705_CH106_80MHz_L_EXP0.m
adb shell su -c "nexutil -g705 -l8196 -r" | strings > tssi_g705_CH106_80MHz_L_EXP1.m
adb shell su -c "nexutil -g705 -l8196 -r" | strings > tssi_g705_CH106_80MHz_L_EXP2.m
```
