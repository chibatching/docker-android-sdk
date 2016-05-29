FROM java:8

MAINTAINER Takao Chiba <chibatching.apps@gmail.com>

RUN apt-get update && \
    apt-get install -yq expect --no-install-recommends && \
    apt-get clean

RUN curl -L https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar xz -C /usr/local

ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

RUN echo y | android update sdk --no-ui --all --filter "tools"
RUN echo y | android update sdk --no-ui --all --filter "platform-tools,build-tools-23.0.3,android-23"
RUN echo y | android update sdk --no-ui --all --filter "extra-android-m2repository,extra-google-m2repository"
