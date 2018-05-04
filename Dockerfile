################################################
#
#
#
#
#
################################################

FROM				ehudkaldor/alpine-s6:latest
MAINTAINER	Ehud Kaldor <ehud@unfairfunction.net>

ENV					NODE_VERSION v10.0.0
ENV					ARC linux-x64

RUN 				apk add --update curl tar gzip git python make g++ clang linux-headers binutils-gold nginx xz

RUN					cd tmp && \
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
						echo "npm version: "`npm -v`

RUN					npm install aurelia-cli -g

RUN					apk del clang linux-headers binutils-gold git python make g++ curl tar gzip && \
						rm -rf /var/cache/apk/*

ADD         rootfs /

ENTRYPOINT	["/init"]
