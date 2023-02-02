FROM debian
LABEL maintainer="maxim"

ARG DEBIAN_FRONTEND=noninteractive
ARG PYTHON=python3

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install chromium-chromedriver || \
    apt-get -y install chromium-driver || \
    apt-get -y install chromedriver
RUN apt-get -y install ${PYTHON}-pip
RUN $PYTHON -m pip install selenium
RUN apt-get -y install curl wget

RUN mkdir -p /home/maxim && \
    useradd -d /home/maxim -u 1001 maxim && \
    chown maxim:maxim /home/maxim
USER maxim
WORKDIR /home/maxim
COPY /noip-renew.py /home/maxim/
CMD touch /usr/local/bin/noip-renew-skd.sh
ENTRYPOINT ["python3", "/home/maxim/noip-renew.py"]
