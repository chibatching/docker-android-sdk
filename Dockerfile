FROM java:8

MAINTAINER Takao Chiba <chibatching.apps@gmail.com>

RUN dpkg --add-architecture i386 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 expect ruby --no-install-recommends && \
    apt-get clean

# Download and untar Android SDK
RUN curl -L https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar xz -C /usr/local

# Set environment variable
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

# Update Android SDK Tools
RUN echo y | android update sdk --no-ui --all --filter "tools"
# Update and install SDK dependencies
RUN echo y | android update sdk --no-ui --all --filter "platform-tools,build-tools-23.0.3,android-23"
# Install extra module
RUN echo y | android update sdk --no-ui --all --filter "extra-android-m2repository,extra-google-m2repository"
