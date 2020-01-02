##
## Run tests with Docker.

docker run --rm \
  -v "$(pwd):/root/.bashx/master:ro" \
  -v "$(pwd):/app path:ro" \
  --entrypoint "/app path/bashx" \
  -ti ubuntu '_run-tests'

docker run --rm \
  -v "$(pwd):/root/.bashx/master:ro" \
  -v "$(pwd):/app path:ro" \
  --entrypoint "/app path/bashx" \
  -ti debian:8 '_run-tests'
