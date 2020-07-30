# Load root image
FROM nvcr.io/nvidia/pytorch:19.10-py3

# Label
LABEL maintainer="Dajin Han <dajinstory@gmail.com>"

# Basic Settings(local info, languages, etc.,)
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y --no-install-recommends \
        libopencv-dev vim
RUN apt-get install -y apt-utils apt-transport-https ca-certificates curl gnupg-agent software-properties-common sudo wget locales git unzip tmux
RUN apt-get install -y --no-install-recommends \
        language-pack-ko
ENV LC_ALL=C.UTF-8

# Install python Libraries
RUN pip install torchvision
RUN pip install torchnet
RUN pip install tqdm
RUN pip install jupyter
RUN pip install transformers
RUN pip install numpy
RUN pip install torchnet

# Install Library including perf_client
WORKDIR /root
RUN mkdir tensorrt_clients \
        && cd /root/tensorrt_clients \
        && wget https://github.com/NVIDIA/tensorrt-inference-server/releases/download/v1.7.0/v1.7.0_ubuntu1604.clients.tar.gz \
        && tar xzf v1.7.0_ubuntu1604.clients.tar.gz \
        && pip install --upgrade python/tensorrtserver-*.whl

ENV PATH tensorrt_clients/bin:$PATH
ENV LD_LIBRARY_PATH /root:/root/tensorrt_clients/lib:$LD_LIBRARY_PATH

WORKDIR /workspace

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888