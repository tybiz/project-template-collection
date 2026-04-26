# ─── Build Stage ───────────────────────────────────────────────────────────────
FROM python:3.13-slim AS build
WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Zależności systemowe wymagane przez cx_Oracle
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libaio1 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# ─── Runtime Stage ─────────────────────────────────────────────────────────────
FROM python:3.13-slim AS final
WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libaio1 \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

COPY --from=build /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
COPY --from=build /usr/local/bin /usr/local/bin
COPY . .

RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 8000
# TODO: Replace "myapp" with your Django project name (the folder containing wsgi.py)
CMD ["gunicorn", "myapp.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
