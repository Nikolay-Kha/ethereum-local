FROM ubuntu:16.04

MAINTAINER Nikolay Khabarov

RUN apt-get update
RUN apt-get install -y software-properties-common git curl build-essential
RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install -y ethereum

ADD init.sh /
RUN bash /init.sh

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs
RUN git clone https://github.com/carsenk/explorer
ADD explorer.patch /
RUN (cd /explorer && git apply /explorer.patch)
RUN (cd /explorer && npm install)
RUN npm install -g forever

EXPOSE 8545
EXPOSE 8000

ADD run.sh /
CMD ["bash", "/run.sh"]
