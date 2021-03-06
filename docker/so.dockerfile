FROM ubuntu:bionic

MAINTAINER "Vitor Carreira" <vitor.carreira@gmail.com>

WORKDIR /tmp

RUN mkdir /opt/templates

COPY EmptyProject-Template.zip /opt/templates
COPY new-app.sh /usr/local/bin
COPY tmux-help.txt /usr/share/doc

RUN chmod +x /usr/local/bin/new-app.sh

RUN echo 'alias memcheck="valgrind --track-origins=yes --tool=memcheck --leak-check=full"' >> /etc/bash.bashrc
RUN echo 'alias tmux-help="cat /usr/share/doc/tmux-help.txt"' >> /etc/bash.bashrc

RUN echo "deb http://us.archive.ubuntu.com/ubuntu bionic main multiverse" >> /etc/apt/sources.list

# Do not exclude man pages & other documentation
RUN rm /etc/dpkg/dpkg.cfg.d/excludes

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    build-essential \
    libc6-dev \
    glibc-doc \
    manpages \
    manpages-dev \
    manpages-posix \
    manpages-posix-dev \
    gdb \
    gdb-doc \
    valgrind \
    gengetopt \
    man-db \
    sudo \
    unzip \
    wget \
    tmux \
    ltrace \
    netcat \
    cppcheck \
    indent \
    pmccabe \
    imagemagick \
    net-tools \
    lsof \
    less \
    curl && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash so

RUN echo so:admin | chpasswd

RUN usermod -aG sudo so

USER so

WORKDIR /home/so

VOLUME ["/home/so"]

CMD ["/bin/bash", "--rcfile", "/etc/skel/.bashrc"]
