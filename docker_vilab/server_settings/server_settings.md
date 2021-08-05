# Initial Server Settings
1. Openssh-Server Installation
2. Ubuntu NVIDIA Driver Installation
3. Docker Installation
4. Docker Settings


## 1. Openssh-server Installation
```bash
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install openssh-server
sudo service sshd start

```


## 2. Ubuntu NVIDIA Driver Installation
- https://codechacha.com/ko/install-nvidia-driver-ubuntu/


## 3. Docker Installation
### a) Install Docker
```bash
curl -fsSL https://get.docker.com/ | sudo sh 

```

### b) Install Docker-nvidia2 for utilizing GPU
```bash
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

```


## 4. Download Baseline Images (if necessary)
```bash
docker pull hyuvilab/cuda --all-tags

```

