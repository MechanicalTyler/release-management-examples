FROM python:3.12

COPY . /app/
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install poetry

RUN poetry config virtualenvs.create false

RUN poetry install --only main
