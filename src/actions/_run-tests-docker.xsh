##
## Run tests with Docker.

set -x

local docker_params=''

if ${BX_TTY}; then
  docker_params='-ti'
fi

@log.line
@log.title 'Docker tests: ubuntu'
docker run --rm \
  -v "$(pwd):/root/.bashx/master" \
  -v "$(pwd):/app path" \
  --entrypoint "/app path/bashx" \
  ${docker_params} ubuntu '_run-tests' \
    | exit 1

@log.line
@log.title 'Docker tests: debian:8'

docker run --rm \
  -v "$(pwd):/root/.bashx/master" \
  -v "$(pwd):/app path" \
  --entrypoint "/app path/bashx" \
  ${docker_params} debian:8 '_run-tests' \
    | exit 1
