# guided by https://docs.astral.sh/uv/guides/integration/docker/
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS model_training

WORKDIR /app

COPY src ./src
COPY pyproject.toml ./
COPY uv.lock ./

RUN uv sync --locked

RUN mkdir model
WORKDIR /app/src
RUN uv run train.py


# Stage 2: Serve Predictions
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS serving

WORKDIR /app

COPY pyproject.toml ./
COPY uv.lock ./
RUN uv sync --locked 

COPY --from=model_training /app/model ./
COPY src ./src

ENV PATH="/app/.venv/bin:$PATH"
ENTRYPOINT []

WORKDIR /app/src
CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]