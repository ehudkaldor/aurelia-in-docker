################################################
#
#
#
#
#
################################################

FROM				ehudkaldor/alpine-s6-rpi:latest
MAINTAINER	Ehud Kaldor <ehud@unfairfunction.net>

ARG					NODE_VERSION=v10.1.0
ARG					ARC=linux-x64

RUN 				apk add --update curl tar gzip git python make g++ clang linux-headers binutils-gold nginx && \
  					cd tmp && \
						curl -sSL https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION.tar.gz > node-$NODE_VERSION.tar.gz && \
						tar -zxvf node-$NODE_VERSION.tar.gz && \
						cd node-$NODE_VERSION && \
						./configure && \
						make && \
						make install && \
						cd / && \
						rm -rf /tmp/node-$NODE_VERSION && \
						rm -rf /tmp/node-$NODE_VERSION.tar.gz && \
						echo "node version: "`node -v` && \
						echo "npm version: "`npm -v` && \
						npm install npm -g && \
  					npm install aurelia-cli -g && \
  					apk del linux-headers binutils-gold python make g++ curl tar gzip && \
						rm -rf /var/cache/apk/*

COPY         rootfs /

ENTRYPOINT	["/init"]
