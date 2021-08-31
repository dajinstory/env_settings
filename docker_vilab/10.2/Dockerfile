# Root image
FROM nvidia/cuda:10.2-cudnn8-devel-ubuntu18.04

# Maintainer
LABEL maintainer="Dajin Han <dajinstory@gmail.com>"

# Basic settings
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
ENV LC_ALL=C.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y \
    language-pack-ko \
    ca-certificates \
    apt-utils \
    apt-transport-https \
    gnupg-agent \
    software-properties-common \
    libopencv-dev \
    sudo \
    wget \
    curl \
    locales \
    git \
    unzip \
    tmux \
    vim \
&& rm -rf /var/lib/apt/lists/*

# Miniconda settings
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda --version

# Get vim settings
WORKDIR /root
RUN git clone https://github.com/morhetz/gruvbox.git
RUN mkdir .vim
RUN mkdir .vim/colors
RUN mv gruvbox/colors/gruvbox.vim .vim/colors/
RUN rm -rf gruvbox
RUN git clone https://github.com/dajinstory/env_settings.git
RUN mv env_settings/vimrc/.vimrc .
RUN rm -rf env_settings

# Change workdir
RUN mkdir workspace
RUN mkdir datasets
WORKDIR /root/workspace

# TensorBoard
EXPOSE 6006

# IPython
EXPOSE 8888
