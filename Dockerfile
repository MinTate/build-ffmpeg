# Ubuntu 20.04
FROM ubuntu:focal-20200729

ARG BUILD_ARCH="x86_64"

# 更新安装依赖
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive \
  apt-get -y install \
    autoconf \
    automake \
    cmake \
    gcc-10 \
    g++-10 \
    git-core \
    libc6-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libmp3lame-dev \
    libnuma-dev \
    libopus-dev \
    libtool \
    libvpx-dev \
    make \
    nasm \
    pkg-config \
    python3-minimal \
    texinfo \
    wget \
    yasm \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

# 创建编译目录
RUN mkdir -p /build && \
  cd /build && \
  mkdir -p src deps bin lib

WORKDIR /build/lib

# 设置环境变量

ENV CC=gcc-10 \
    CXX=g++-10 \
    CFLAGS="-O3 -march=${BUILD_ARCH}" \
    CXXFLAGS="-O3 -march=${BUILD_ARCH}" \
    GCC_BUILD_ARCH="${BUILD_ARCH}" \
    PKG_CONFIG_PATH=/usr/lib64/pkgconfig:/usr/lib/pkgconfig

# 安装可选依赖
COPY deps/make-deps /usr/local/bin

COPY deps/libass /build/deps/
RUN make-deps

COPY deps/fdk-aac /build/deps/
RUN make-deps

COPY deps/x264_x265 /build/deps/
RUN make-deps

COPY deps/libvorbis /build/deps/
RUN make-deps

COPY deps/gnutls /build/deps/
RUN make-deps

COPY deps/libbluray /build/deps/
RUN make-deps

COPY deps/libsdl2 /build/deps/
RUN make-deps

VOLUME /build/bin

COPY build /

ENTRYPOINT [ "/build" ]
