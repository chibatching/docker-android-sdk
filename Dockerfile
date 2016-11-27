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

RUN mkdir $ANDROID_HOME/licenses
RUN echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_HOME/licenses/android-sdk-license
RUN echo 84831b9409646a918e30573bab4c9c91346d8abd > $ANDROID_HOME/licenses/android-sdk-preview-license

# Update Android SDK Tools
RUN echo y | android update sdk --no-ui --all --filter "tools"
# Update and install SDK dependencies
RUN echo y | android update sdk --no-ui --all --filter "platform-tools,build-tools-24.0.3,build-tools-25.0.0,build-tools-25.0.1,android-25,android-24,android-23"
# Android Support Repository 40, Google Repository 39
RUN echo y | android update sdk --no-ui --all --filter "extra-android-m2repository,extra-google-m2repository"
# Get constraint-layout-beta4
RUN wget https://dl.google.com/android/repository/com.android.support.constraint-constraint-layout-1.0.0-beta4.zip -O tmp/temp.zip && mkdir -p $ANDROID_HOME/extras/android/m2repository/com/android/support/constraint/constraint-layout/ && unzip tmp/temp.zip -d tmp/ && mv tmp/constraintlayout $ANDROID_HOME/extras/android/m2repository/com/android/support/constraint/constraint-layout/1.0.0-beta4 && rm -rf tmp/temp.zip tmp/constraintlayout 
# Get constraint-layout-solver-beta4
RUN wget https://dl.google.com/android/repository/com.android.support.constraint-constraint-layout-solver-1.0.0-beta4.zip -O tmp/temp.zip && mkdir -p $ANDROID_HOME/extras/android/m2repository/com/android/support/constraint/constraint-layout-solver/ && unzip tmp/temp.zip -d tmp/ && mv tmp/solver $ANDROID_HOME/extras/android/m2repository/com/android/support/constraint/constraint-layout-solver/1.0.0-beta4 && rm -rf tmp/temp.zip tmp/solver 
