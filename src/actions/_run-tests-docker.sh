##
## Run tests with Docker.

@log.line
@log.title 'Docker tests: ubuntu'
docker run --rm \
  -v "$(pwd):/root/.bashx/master:ro" \
  -v "$(pwd):/app path:ro" \
  --entrypoint "/app path/bashx" \
  -ti ubuntu '_run-tests'

@log.line
@log.title 'Docker tests: debian:8'

docker run --rm \
  -v "$(pwd):/root/.bashx/master:ro" \
  -v "$(pwd):/app path:ro" \
  --entrypoint "/app path/bashx" \
  -ti debian:8 '_run-tests'
