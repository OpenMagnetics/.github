## Setup steps

 Install [Docker for Ubuntu](https://docs.docker.com/engine/install/ubuntu).  The installation instructions were tested on the following OS/Docker version combination:
- Docker 23.0.03,  Ubuntu 22.04.2 LTS

Prepare a directory to download and build Docker image.  
```
cd ~
mkdir openmagnetics
cd openmagnetics
sudo wget https://raw.githubusercontent.com/OpenMagnetics/.github/main/Dockerfile
```

## Build steps

Build Docker image

```
cd ~/openmagnetics
docker build -t openmagnetics .
```

Run built the OpenMagnetics docker image form command line

```
docker run -it openmagnetics bash
```

To confirm proper installation and project compilation run the tests in each project.  Each test should run without error.

```
/home/openmagnetics/OpenMagnetics/MAS/build/./MAS_tests
/home/openmagnetics/OpenMagnetics/MKF/build/./MKF_tests
python3 /home/openmagnetics/OpenMagnetics/MVB/tests/test_builder.py
```
