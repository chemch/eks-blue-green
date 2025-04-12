#!/usr/bin/env bash
set -euo pipefail

versions=(
  "1.0.0 parrot-1.jpg 'Blue Parrot'"
  "1.1.0 parrot-2.jpg 'Green Parrot'"
  "1.2.0 parrot-3.jpg 'Red Parrot'"
)

for entry in "${versions[@]}"; do
  read -r VERSION IMAGE TITLE <<<"$entry"

  info "BUILD" "$PROJECT_NAME:$VERSION"

  docker buildx build \
    --platform linux/amd64 \
    --build-arg WEBSITE_VERSION="$VERSION" \
    --build-arg WEBSITE_IMAGE="$IMAGE" \
    --build-arg WEBSITE_TITLE="$TITLE" \
    -t "$PROJECT_NAME:$VERSION" \
    --load \
    website/
done