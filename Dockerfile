FROM alpine as builder

ARG version=latest

RUN apk add --no-cache git make cmake gcc g++ gperf zlib-dev openssl-dev linux-headers

RUN git clone git://github.com/tdlib/td.git /tdlib

WORKDIR /tdlib

RUN [ "$version" == latest ] || git checkout "$version"

RUN mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build .


FROM scratch

COPY --from=builder /tdlib/build /
