# Load root image
FROM nvidia/cuda:10.1-cudnn8-devel-ubuntu18.04

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

# Get Anaconda
#RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh

# Set work-directory
WORKDIR /workspace

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888
