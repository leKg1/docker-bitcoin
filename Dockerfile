FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Install.
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \  
  apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 \
  git libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev \
  libdb-dev libdb++-dev && \
  git clone https://github.com/bitcoin/bitcoin.git 

RUN cd bitcoin && \ 
    ./autogen.sh && \ 
    ./configure --with-incompatible-bdb && \ 
    make && \ 
    make install

COPY bitcoin.conf /root/.bitcoin/bitcoin.conf

EXPOSE 8332

CMD ["cat /root/.bitcoin/regtest/debug.log"]
CMD ["bitcoind"]  