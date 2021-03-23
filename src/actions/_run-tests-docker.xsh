##
## Run tests with Docker.

set -x

local docker_params=''

if ${BX_TTY}; then
  docker_params='-ti'
fi

_dkrTest() {
  local docker_image="$1"

  @log.line
  @log.title "Docker tests: ${docker_image}"

  docker run --rm \
    -v "$(pwd):/root/.bashx/master" \
    -v "$(pwd):/app path" \
    --entrypoint "/app path/bashx" \
    ${docker_params} ${docker_image} '_run-tests' \
      | exit 1
}

_dkrTest ubuntu
_dkrTest debian:8
