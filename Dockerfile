FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get -y --no-install-recommends install \
		wget \
		openjdk-8-jdk \
		lib32gcc1 libc6-i386 lib32z1 lib32stdc++6 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
	
# Install Android SDK
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz \
	&& tar -xvzf android-sdk_r24.4.1-linux.tgz \
	&& mv android-sdk-linux /usr/local/android-sdk \
	&& rm android-sdk_r24.4.1-linux.tgz

# Install components
ENV ANDROID_COMPONENTS platform-tools,android-25,build-tools-25.0.2
RUN while true; do echo y; sleep 2; done | /usr/local/android-sdk/tools/android update sdk --filter "${ANDROID_COMPONENTS}" --no-ui -a

# Environment variables
ENV ANDROID_HOME /usr/local/android-sdk
ENV ANDROID_SDK_HOME $ANDROID_HOME
ENV PATH $PATH:$ANDROID_SDK_HOME/tools
ENV PATH $PATH:$ANDROID_SDK_HOME/platform-tools
ENV PATH $PATH:$ANDROID_SDK_HOME/build-tools/25.0.3
ENV PATH $PATH:$ANDROID_NDK_HOME

# Create user with UID=1000 (default for debian / ubuntu)
RUN adduser jenkins --home /var/jenkins_home
USER jenkins

VOLUME /var/jenkins_home
