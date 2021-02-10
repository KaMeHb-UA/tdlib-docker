FROM alpine as builder

RUN apk add --no-cache git make cmake gcc g++ gperf zlib-dev openssl-dev

RUN git clone git://github.com/tdlib/td.git /tdlib

WORKDIR /tdlib

RUN mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build .


FROM scratch

COPY --from=builder /tdlib/build /
