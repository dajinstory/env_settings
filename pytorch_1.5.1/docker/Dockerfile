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

# Set work-directory
WORKDIR /root

# Get colorscheme
RUN git clone https://github.com/morhetz/gruvbox.git
RUN mkdir .vim
RUN mkdir .vim/colors
RUN cp gruvbox/colors/gruvbox.vim .vim/colors/

# Set .vimrc
RUN git clone https://github.com/dajinstory/env_settings.git
RUN cp env_settings/vimrc/.vimrc .vimrc

# Install Library including perf_client
RUN mkdir /root/tensorrt_clients \
        && cd /root/tensorrt_clients \
        && wget https://github.com/NVIDIA/tensorrt-inference-server/releases/download/v1.7.0/v1.7.0_ubuntu1604.clients.tar.gz \
        && tar xzf v1.7.0_ubuntu1604.clients.tar.gz \
        && pip install --upgrade python/tensorrtserver-*.whl

WORKDIR /workspace

ENV PATH /root/tensorrt_clients/bin:$PATH
ENV LD_LIBRARY_PATH /workspace:/root/tensorrt_clients/lib:$LD_LIBRARY_PATH

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888