##
## Run tests with Docker.

local docker_images="${@:-ubuntu debian:8}"

local docker_params=''

if ${BX_TTY}; then
  docker_params='-ti'
fi

_dkrTest() {
  local docker_image="$1"

  @log.line
  @log.title "Docker tests: ${docker_image}"

  docker run --rm \
    -v "$(pwd):/root/.bashx/master:ro" \
    -v "$(pwd):/app path:ro" \
    --entrypoint "/app path/bashx" \
    ${docker_params} ${docker_image} '_run-tests'
}

for img in ${docker_images}; do
  _dkrTest ${img}
done
