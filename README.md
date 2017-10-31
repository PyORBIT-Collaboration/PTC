[![Build Status](https://travis-ci.org/PyORBIT-Collaboration/PTC.svg?branch=master)](https://travis-ci.org/PyORBIT-Collaboration/PTC)
# PTC extension for pyORBIT code
Installation procedure requires building from source.
All installation steps happen in command line (terminal). This procedure has been tested on Linux so far.

 ## 1. Build pyORBIT as described [here](https://github.com/PyORBIT-Collaboration/py-orbit)
 ## 2. Clone the source code
```shell
git clone https://github.com/PyORBIT-Collaboration/PTC.git
```
Put the cloned repository somewhere outside of pyORBIT directory.
So your source is now in *PTC* directory.

## 3. Setup environment variables
If you built pyORBIT environment from source, use *customEnvironment.sh* instead.
```shell
source <path-to-pyORBIT-installation>/setupEnvironment.sh
```
## 4. Build the code

```shell 
make clean
make
```
This will put a dynamic library into *\<path-to-pyORBIT-installation\>/lib*.
If make failed, it usually means that some of the libraries aren't set up properly.

# Running Examples
 
```shell
cd examples/ptc_test_1
./START.sh run1.py 2
```
This will launch *ptc_test_1* example on two MPI nodes. Other PTC related examples are availabale in [Examples](https://github.com/PyORBIT-Collaboration/examples/tree/master/ext/ptc_orbit) repository.
