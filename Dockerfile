FROM ubuntu:15.10
MAINTAINER Florin Patan "florinpatan@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update -qq && \
    echo 'Installing OS dependencies' && \
    apt-get install -qq -y --fix-missing sudo software-properties-common git libxext-dev libxrender-dev libxslt1.1 \
        libxtst-dev libgtk2.0-0 libcanberra-gtk-module unzip && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update -qq && \
    echo 'Installing JAVA 8' && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -qq -y --fix-missing oracle-java8-installer && \
    echo 'Cleaning up' && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y &&  \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN echo 'Creating user: developer' && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    sudo echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    sudo chmod 0440 /etc/sudoers.d/developer && \
    sudo chown developer:developer -R /home/developer && \
    sudo chown root:root /usr/bin/sudo && \
    chmod 4755 /usr/bin/sudo

RUN mkdir -p /home/developer/.IdeaIC15/config/options && \
    mkdir -p /home/developer/.IdeaIC15/config/plugins

ADD ./jdk.table.xml /home/developer/.IdeaIC15/config/options/jdk.table.xml
ADD ./jdk.table.xml /home/developer/.jdk.table.xml

ADD ./run /usr/local/bin/intellij

RUN chmod +x /usr/local/bin/intellij && \
    chown developer:developer -R /home/developer/.IdeaIC15

RUN echo 'Downloading IntelliJ IDEA' && \
    wget https://download.jetbrains.com/idea/ideaIC-15.0.4.tar.gz -O /tmp/intellij.tar.gz -q && \
    echo 'Installing IntelliJ IDEA' && \
    mkdir -p /opt/intellij && \
    tar -xf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij && \
    rm /tmp/intellij.tar.gz

RUN echo 'Downloading Go 1.6.0' && \
    wget https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz -O /tmp/go.tar.gz -q && \
    echo 'Installing Go 1.6.0' && \
    sudo tar -zxf /tmp/go.tar.gz -C /usr/local/ && \
    rm -f /tmp/go.tar.gz

RUN echo 'Installing Go plugin' && \
    wget https://plugins.jetbrains.com/files/5047/24428/Go-0.10.1164.zip -O /home/developer/.IdeaIC15/config/plugins/go.zip -q && \
    cd /home/developer/.IdeaIC15/config/plugins/ && \
    unzip -q go.zip && \
    rm go.zip

RUN echo 'Installing Markdown plugin' && \
    wget https://plugins.jetbrains.com/files/7793/23750/markdown.zip -O markdown.zip -q && \
    unzip -q markdown.zip && \
    rm markdown.zip

USER developer
ENV HOME /home/developer
ENV GOPATH /home/developer/go
ENV PATH $PATH:/home/developer/go/bin:/usr/local/go/bin
WORKDIR /home/developer/go
CMD /usr/local/bin/intellij
