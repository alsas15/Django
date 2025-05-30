FROM python:3.12.3-slim
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN pip install poetry && poetry config virtualenvs.create false
WORKDIR /app
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-root --no-interaction --no-ansi
RUN python -c "import django; print('Django version:', django.get_version())"
RUN DJANGO_SETTINGS_MODULE=mysite.settings python -c "from django.conf import settings; print('ALLOWED_HOSTS:', settings.ALLOWED_HOSTS)"
COPY . .
WORKDIR /app/mysite
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]
