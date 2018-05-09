#!/bin/sh

MAKE_LATEST=true

for VERSION in v10.1.0 v10.0.0 v9.11.1 v9.11.0 v8.11.1; do
  docker build -t ehudkaldor/aurelia:$VERSION --build-arg NODE_VERSION=$VERSION .;
  if $MAKE_LATEST; then
    docker tag ehudkaldor/aurelia:$VERSION ehudkaldor/aurelia:latest;
  fi
  MAKE_LATEST=false
done

docker push ehudkaldor/aurelia
