#!/usr/bin/env bash
set -euo pipefail
source "$PROJECT_DIR/.ecr"

# Make sure Docker is logged in to ECR
aws ecr get-login-password \
  --region "$AWS_REGION" \
  | docker login --username AWS \
    --password-stdin "$REPOSITORY_URI"

# Define versions to push
versions=(
  "1.0.0 parrot-1.jpg 'Blue Parrot'"
  "1.1.0 parrot-2.jpg 'Green Parrot'"
  "1.2.0 parrot-3.jpg 'Red Parrot'"
)

for entry in "${versions[@]}"; do
  # Split version, image, and title
  read -r VERSION IMAGE TITLE <<<"$entry"

  info "PUSH" "$REPOSITORY_URI:$VERSION"

  docker buildx build \
    --platform linux/amd64 \
    --build-arg WEBSITE_VERSION="$VERSION" \
    --build-arg WEBSITE_IMAGE="$IMAGE" \
    --build-arg WEBSITE_TITLE="$TITLE" \
    -t "$REPOSITORY_URI:$VERSION" \
    --push \
    website/
done