FROM python:3.12.3-slim
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN pip install poetry && poetry config virtualenvs.create false
WORKDIR /app
COPY pyproject.toml poetry.lock /app/
RUN poetry install --no-dev --no-interaction --no-ansi
COPY . /app/
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]
