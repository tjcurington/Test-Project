#!/bin/bash -e
docker build -t cerebral -f Dockerfile.web-client .
docker run -e AWS_ACCESS_KEY_ID=noop -e AWS_SECRET_ACCESS_KEY=noop cerebral /bin/sh -c "cd efcms-service && npm run install:dynamodb && (npm start &) && ../wait-until.sh http://localhost:3000/v1/swagger && cd ../web-client && npm run test"