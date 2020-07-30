FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

LABEL maintainer="Dajin Han <dajinstory@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
        libopencv-dev vim

RUN apt-get install -y apt-utils apt-transport-https ca-certificates curl gnupg-agent software-properties-common sudo wget locales git unzip tmux

RUN apt-get install -y --no-install-recommends \
        language-pack-ko

#RUN locale-gen ko_KR ko_KR.UTF-8
#RUN update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX
#ENV LANGUAGE=ko_KR.UTF-8
#ENV LANG=ko_KR.UTF-8
ENV LC_ALL=C.UTF-8

WORKDIR /workspace

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888
