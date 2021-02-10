FROM debian:stable-slim as builder

RUN [ -f /usr/sbin/dpkg-split ] || ln -s /usr/bin/dpkg-split /usr/sbin/dpkg-split
RUN [ -f /usr/sbin/dpkg-deb ] || ln -s /usr/bin/dpkg-deb /usr/sbin/dpkg-deb
RUN [ -f /usr/sbin/tar ] || ln -s /bin/tar /usr/sbin/tar

RUN apt update && apt install -y git cmake make gcc g++ gperf zlib1g-dev libssl-dev

RUN git clone git://github.com/tdlib/td.git /tdlib

WORKDIR /tdlib

RUN mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build .


FROM scratch

COPY --from=builder /tdlib/build /
