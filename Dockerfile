FROM centos
WORKDIR /PTC
ADD . /PTC

# RUN yum update
RUN yum install -y git gcc gcc-c++ make python-devel mpich mpich-devel zlib-devel fftw-devel

RUN bash -c "git clone https://github.com/PyORBIT-Collaboration/py-orbit.git /pyORBIT"
RUN bash -c "cd /pyORBIT; source setupEnvironment.sh; make clean; make"
RUN bash -c "cd /PTC; source /pyORBIT/setupEnvironment.sh; make clean; make"
