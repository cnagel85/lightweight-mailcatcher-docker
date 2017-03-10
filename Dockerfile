FROM alpine:3.4

ENV BUILD_PACKAGES \
	libstdc++ \
	ruby \
	sqlite-libs

ENV BUILD_DEPENDENCIES \
	build-base \
	ca-certificates \
	ruby-dev \
	sqlite-dev

RUN apk update && \
    apk upgrade && \
    apk add --no-cache $BUILD_PACKAGES && \
    apk add --no-cache --virtual .build-dependencies $BUILD_DEPENDENCIES && \
	gem install --no-ri --no-rdoc json && \
	gem install --no-ri --no-rdoc mailcatcher && \
    rm -rf /var/cache/apk/* && \
    apk del .build-dependencies && \
    rm -rf  $GEM_HOME/cache/*

EXPOSE 1025 1080

CMD ["mailcatcher", "-f", "--ip=0.0.0.0"]

