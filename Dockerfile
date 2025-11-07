ARG PYTHON_VERSION=3.12
ARG ALPINE_VERSION=3.22

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONBUFFERED=1

WORKDIR /app

## ARG for build time only       --build-arg  PASSING ARGUMENT
## ENV is used inside running container, SHELL VAR 
RUN adduser \
    --diabled-password \
    --home "/nonexistent"\
    --shell "/sbin/nologin" \
    --uid "10001" \
    -- no-create-home \
    pythonuser

USER pythonuser

COPY . .

RUN python -m pip install -r reqirments.txt

EXPOSE 8000

CMD [ "python3", "-m", "unicorn", "app:app", "host=0.0.0.0", "port=8000" ]