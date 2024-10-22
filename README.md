![NexMon logo](https://github.com/seemoo-lab/nexmon/raw/master/gfx/nexmon.png)

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

# Extract from our License

Any use of the Software which results in an academic publication or
other publication which includes a bibliography must include
citations to the nexmon project (1) and the paper cited under (2):

1. "Matthias Schulz, Daniel Wegemer and Matthias Hollick. Nexmon:
    The C-based Firmware Patching Framework. https://nexmon.org"

2. "Matthias Schulz, Francesco Gringoli, Daniel Steinmetzer, Michael
    Koch and Matthias Hollick. Massive Reactive Smartphone-Based
    Jamming using Arbitrary Waveforms and Adaptive Power Control.
    Proceedings of the 10th ACM Conference on Security and Privacy
    in Wireless and Mobile Networks (WiSec 2017), July 2017."

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

The following list shows which files are required to create a certain figure:

* tssi_g70X_CHX_X0MHz_EXPX.m => Figure 3 and 4
* experiment_2.mat => Figure 5
* experiment_1_CHX_X0MHz.mat => Figure 6
* experiment4.00X/S/capture.pcap => Figure 9
* experiment9.00X/S/capture.pcap => Figure 10
* experiment10.00X/S/capture.pcap => Figure 10
* experiment11.00X/S/capture.pcap => Figure 10
* experiment12.0XX/S/capture.pcap => experiment_12_precalculated_results.mat => Figure 11 and 12
* testjam24MbsL1400wack.iqt => Figure 13
* experiment12.01X/J/exp12.0XX.csv => Figure 14

## Preparing the Nexus 5 for energy measurements

Figures 5, 6, 11, 12 and 14 show results of energy measurements. To perform the 
measurements, connect one Nexus 5 to a Monsoon Power Monitor according to the
"[Preparation of a Nexus 5 Android Smartphone for Power Analysis](https://www.seemoo.tu-darmstadt.de/fileadmin/user_upload/Group_SEEMOO/mschulz/nexus5_power_analysis.pdf)"
manual. To keep the voltage drop over the supply lines low, we intend to keep the 
drawn current low by setting the supply voltage of the power monitor to 4.2 volts.
During our measurements, we then capture the power consumption as a product of voltage
and current at a sampling rate of 5 kHz.

Even though we measure the energy consumption of the complete phone in this setup, we
intend to focus on the energy consumption of the Wi-Fi chip. To be able to measure
its energy consumption, we turn the phones display off and wait until the main processor
of the smartphone goes into idle mode. In this mode the energy consumption is almost 
constantly low, except of periodic peaks every 640 milliseconds. We realized that those 
peaks can be avoided by turning off the CONFIG_MSM_SMD_PKT setting in the kernel, which 
disables the LTE related hardware. To rebuild the kernel, we used for our energy
measurement experiments, you can clone our
[nexmon_energy_measurement](https://github.com/seemoo-lab/nexmon_energy_measurement)
repository and build a new boot.img for booting over adb or for flashing.

In the following subsections, we explain how every dataset can be collected.

## Generating the tssi_g70X_CHX_X0MHz_EXPX.m files

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

## Generating the experiment_2.mat file

The file experiment_2.mat is the result of converting an experiment_2.csv file using 
MATLAB:
```
experiment_2 = csvread('experiment_2.csv',2,1);
save('experiment_2.mat','experiment_2','-v7.3');
```
The experiment_2.csv file itself is an export of the PowerTool (version 4.0.5.2)
that we use to perform measurements with the Monsoon Power Monitor. After the 
conversion we deleted the csv-file as it contains the same raw data as the mat-file 
but the mat-file has a much smaller file size.

To start the experiment on the phone, you need to recompile the firmware with the
additional parameter that sets EXPERIMENT to 2. Therefore, navigate to the 
wisec2017_nexmon_jammer directory in your nexmon development tree and run
`make clean && make install-firmware EXPERIMENT=2` (whenever you change the value of
EXPERIMENT, you need to run a `make clean` in advance). This will activate the 
execution of the code in experiment_2.c by the autostart.c file. The experiment starts 
after 20 seconds after loading the firmware.

To perform the power consumption measurement, you should directly activate the signal
capture in the PowerTool program. This cuts the USB connection to the phone which 
automatically lets the screen turn on. Simply press the power button to turn off the 
screen and observe in the PowerTool how the power reduces to a minimal almost constant 
power consumption. As soon as the experiments start on the phone you can see a raise
in power consumption. After all experiments are done, stop the capture and export the
data as csv-file so that it can be read by MATLAB to produce the mat-file, as described
above.

## Generating the experiment_1_CHX_X0MHz.mat files

The procedure for generating the experiment_1_CHX_X0MHz.mat files is similar to generating
the experiment_2.mat file. However, instead of installing the firmware for experiment 2, 
we install the firmware for experiment 1: 
`make clean && make install-firmware EXPERIMENT=1`. Depending on the channel (CHX) and the 
bandwidth (X0MHz), you have to manually uncomment one of the `set_chanspec` lines in the
`experiment_1` function of the experiment_1.c file.

## Generating the experimentX.0XX/S/capture.pcap files

To generate the pcap files, one needs four Nexus 5 smartphones that are placed as illustrated
in Figure 8 of our WiSec paper. Instead of connecting the phones to a Raspberry Pi and then
remotely accessing the adb server on the Raspberry Pi, the phones can directly be connected to
the controlling laptop. To reference the four nodes: jammer (J), transmitter next to the wall (W),
transmitter facing the room (R) and receiver (S), we use the variable `NODE` in the Makefile. It
is mainly used to differentiate the device ids that need to be setup in the `Makefile` by setting
the corresponding `ADBSERIAL` variables to the values presented by `adb devices`.

To manage the experiments, we use additional makefiles called Makefile.expX, where X is 4, 9, 10,
11 or 12. To start each experiment, you need to execute `make -f Makefile.expX` and wait until
all experiments belong to a set are done.

## Generating the experiment12.01X/J/exp12.0XX.csv files

In parallel to running `Makefile.exp12` to create the pcap files, you should connect a Monsoon
Power Monitor to the jamming smartphone. During experiments 12.011, 12.012 and 12.013, the makefile
instructs you to `START` or `STOP` the power monitor and then press enter. Before starting or
stopping, the makefile configures the jammer as during the operation of the power monitor, the 
adb connection to the phone is cut. Before pressing enter after starting the power monitor, you should
manually turn of the screen of the jamming node by pressing the power button to reduce the time until
the smartphone's main processor enters sleep mode. After stopping the power monitor, you should save
the corresponding csv file.

## Generating the testjam24MbsL1400wack.iqt file

The testjam24MbsL1400wack.iqt file is the result of jamming a transmission of 1400 byte long frames
transmitted at a rate of 24 Mbps with the acknowledging jammer. The file itself was captured with
a Tektronix RSA3408A. To produce similar results, you can simply use any oscilloscope with at least
40 MHz bandwidth and operation in the 2.4 or 5 GHz bands and run it in parallel to the experiments
for capturing the pcap files.

# References

* Matthias Schulz, Francesco Gringoli, Daniel Steinmetzer, Michael Koch and Matthias Hollick. **Massive Reactive Smartphone-Based Jamming using Arbitrary Waveforms and Adaptive Power Control**. Proceedings of the *10th ACM Conference on Security and Privacy in Wireless and Mobile Networks (WiSec 2017)*, July 2017.
* Matthias Schulz, Daniel Wegemer and Matthias Hollick. **Nexmon: The C-based Firmware Patching Framework**. https://nexmon.org

[Get references as bibtex file](https://nexmon.org/bib)

# Contact

* [Matthias Schulz](https://seemoo.tu-darmstadt.de/mschulz) <mschulz@seemoo.tu-darmstadt.de>
* [Francesco Gringoli](http://netweb.ing.unibs.it/~gringoli/) <francesco.gringoli@unibs.it>

# Powered By

## Secure Mobile Networking Lab (SEEMOO)
<a href="https://www.seemoo.tu-darmstadt.de">![SEEMOO logo](https://github.com/seemoo-lab/nexmon/raw/master/gfx/seemoo.png)</a>
## Networked Infrastructureless Cooperation for Emergency Response (NICER)
<a href="https://www.nicer.tu-darmstadt.de">![NICER logo](https://github.com/seemoo-lab/nexmon/raw/master/gfx/nicer.png)</a>
## Multi-Mechanisms Adaptation for the Future Internet (MAKI)
<a href="http://www.maki.tu-darmstadt.de/">![MAKI logo](https://github.com/seemoo-lab/nexmon/raw/master/gfx/maki.png)</a>
## Technische Universität Darmstadt
<a href="https://www.tu-darmstadt.de/index.en.jsp">![TU Darmstadt logo](https://github.com/seemoo-lab/nexmon/raw/master/gfx/tudarmstadt.png)</a>
## University of Brescia
<a href="http://netweb.ing.unibs.it/">![University of Brescia logo](https://github.com/seemoo-lab/nexmon/raw/master/gfx/brescia.png)</a>
