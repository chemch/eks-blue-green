#!/usr/bin/env bash
set -euo pipefail

# Check if repo exists
repo=$(aws ecr describe-repositories \
    --repository-names "$PROJECT_NAME" \
    --region "$AWS_REGION" \
    --profile "$AWS_PROFILE" \
    2>/dev/null || true)

if [[ -n "$repo" ]]; then
    warn warn repository already exists

    # Still grab the URI for later use
    REPOSITORY_URI=$(echo "$repo" | jq -r '.repositories[0].repositoryUri')
else
    REPOSITORY_URI=$(aws ecr create-repository \
        --repository-name "$PROJECT_NAME" \
        --query 'repository.repositoryUri' \
        --region "$AWS_REGION" \
        --profile "$AWS_PROFILE" \
        --output text \
        2>/dev/null)
    log REPOSITORY_URI $REPOSITORY_URI
fi

# Create the .ecr file
cd "$PROJECT_DIR"
export REPOSITORY_URI
envsubst < .ecr.tmpl > .ecr
info created file .ecr