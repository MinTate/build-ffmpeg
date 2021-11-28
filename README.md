ffmpeg builder
==============

A docker image to build ffmpeg.

Instructions taken from: https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

## Build docker image

```sh
docker build . --build-arg BUILD_ARCH=native --tag tatemin/ffmpeg-builder:latest
```

Running above code should produce a natively optimised copy of ffmpeg dependencies.
For a generic build, use the following instead:

```sh
docker build . --tag tatemin/ffmpeg-builder:latest
```

## Build ffmpeg

To build latest snapshot of ffmpeg:

```sh
mkdir -p bin
docker run --rm -v "$(pwd)/bin:/build/bin" tatemin/ffmpeg-builder
```

To build a release (e.g. 4.4):

```sh
mkdir -p bin
docker run --rm -v "$(pwd)/bin:/build/bin" tatemin/ffmpeg-builder 4.4
```