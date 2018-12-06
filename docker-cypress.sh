#!/bin/bash -e
docker build -t cypress -f Dockerfile.web-client .
docker run -e SLS_DEBUG=* -e AWS_ACCESS_KEY_ID=noop -e AWS_SECRET_ACCESS_KEY=noop --rm cypress /bin/sh -c 'cd efcms-service && npm run install:dynamodb && (npm start &) && ../wait-until.sh http://localhost:3000/v1/swagger && cd ../web-client && (npm run dev &) && ../wait-until.sh http://localhost:1234 && npm run cypress'