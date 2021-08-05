# User Settings for New User
1. Create User Account
2. Docker without Sudo
3. Create Own Docker Image
4. Run Docker Container


## 1. Create User Account
```bash
sudo adduser ${USERNAME}
sudo vim /etc/sudoers

```
/etc/sudoers 의 root계정밑에 ${USERNAME} 추가


## 2. Docker without Sudo
```bash
sudo usermod -aG docker $USER

```
1에서 생성한 계정으로 서버 재접속 후, sudo없이 docker 동작하도록 권한설정


## 3. Create Own Docker Image
### case #1. Copy Baseline Image
```bash
docker tag ${BASELINE_IMAGE_NAME} ${OWN_IMAGE_NAME}

```
eg) docker tag hyuvilab/cuda:11.0-ubuntu20.04 hyuvilab/dajinhan:11.0

### case #2. Pull Own Image
```bash
docker pull ${OWN_IMAGE_NAME}

```
eg) docker pull hyuvilab/dajinhan:11.0


## 4. Run Docker Container
```bash
nvidia-docker run -d -it --volume ~/workspace:/root/workspace --volume ~/datasets:/root/datasets --name "${USERNAME}-${CONTAINER_NAME}" ${IMAGE_NAME} /bin/bash

```
eg) nvidia-docker run -d -it --volume ~/workspace:/root/workspace --volume ~/datasets:/root/datasets --name "dajinhan-vsr" hyuvilab/dajinhan:11.0 /bin/bash

