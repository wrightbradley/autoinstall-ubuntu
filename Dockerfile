FROM ubuntu:kinetic

RUN apt-get update && apt-get install --no-install-recommends -y p7zip wget xorriso \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
