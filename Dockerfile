FROM ubuntu:eoan

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

ENV WINEDEBUG=-all

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    cabextract \
    curl \
    gnupg2 \
    software-properties-common \
    unzip \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /tmp/*

RUN dpkg --add-architecture i386 \
  && curl -sL https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
  && apt-add-repository 'deb http://dl.winehq.org/wine-builds/ubuntu/ eoan main' \
  && apt-get install -y --no-install-recommends \
    winehq-stable \
  && apt-get purge -y \
    apt-transport-https \
    ca-certificates \
    cabextract \
    curl \
    gnupg2 \
    software-properties-common \
    unzip \
  && apt-get autoremove -y \
  && apt-get autoclean \
  && rm -rf /tmp/*

RUN winecfg \
  && rm -rf /tmp/*
