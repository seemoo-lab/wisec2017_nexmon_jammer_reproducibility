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

# How do I run your scripts to rebuild the graphics of your paper?

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
2. Export the following environment variables:
```
export MCR_ROOT=/usr/local/MATLAB/MATLAB_Runtime
export XAPPLRESDIR=${MCR_ROOT}/v91/X11/app-defaults
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCR_ROOT}/v91/runtime/glnxa64:${MCR_ROOT}/v91/bin/glnxa64:${MCR_ROOT}/v91/sys/os/glnxa64:${MCR_ROOT}/v91/sys/opengl/lib/glnxa64
```
   You can do this by executing `source setup_env.sh` in the repository's source directory.
3. Navigate to the subdirectory of the figure you want to build and execute the `make_figureX` binary.
