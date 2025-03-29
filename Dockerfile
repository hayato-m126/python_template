# https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
FROM python:3.12-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

COPY pyproject.toml uv.lock README.md /app/
COPY projects/ /app/projects

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN uv sync

# create docker normal user after setup
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG DOCKER_USER=user
RUN groupadd -g $GROUP_ID $DOCKER_USER && \
    useradd -l -u $USER_ID -g $GROUP_ID -ms /bin/bash user
USER $DOCKER_USER

CMD ["tail", "-f", "/dev/null"]
