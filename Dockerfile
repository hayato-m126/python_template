# https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
FROM python:3.12-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

COPY pyproject.toml uv.lock README.md /app/
COPY projects/ /app/projects

RUN uv sync
