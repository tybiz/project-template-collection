# Django + Oracle — Docker Template

## Quick start

```bash
git clone --depth 1 -b django-oracle https://github.com/user/docker-templates.git .
rm -rf .git && cp .env.example .env && git init
docker compose up -d
```

> ⚠️ Oracle takes ~60 seconds to initialize on first run.

App available at `http://localhost:8000`

## Rename the project

Replace `myapp` with your Django project name in `Dockerfile` — **1 place** marked with `# TODO`:

```
CMD ["gunicorn", "myapp.wsgi:application", ...]   ← last line
```

`myapp` is the folder that contains your `wsgi.py`:
```
yourproject/
└── wsgi.py   ← CMD should be "yourproject.wsgi:application"
```

## requirements.txt

```
django>=5.0
gunicorn
oracledb
```

## Database config (settings.py)

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.oracle',
        'NAME': os.environ['ORACLE_SERVICE'],
        'USER': os.environ['ORACLE_USER'],
        'PASSWORD': os.environ['ORACLE_PASSWORD'],
        'HOST': os.environ['ORACLE_HOST'],
        'PORT': os.environ['ORACLE_PORT'],
    }
}
```

## Environment variables

| Variable | Description | Default |
|---|---|---|
| `DJANGO_SECRET_KEY` | Django secret key | — |
| `DJANGO_DEBUG` | Debug mode | `False` |
| `DJANGO_PORT` | App port | `8000` |
| `ORACLE_SERVICE` | Oracle service name | `FREEPDB1` |
| `ORACLE_USER` | Database user | `myapp_user` |
| `ORACLE_PASSWORD` | Database password | — |
| `ORACLE_SYS_PASSWORD` | SYS password | — |
| `ORACLE_PORT` | Database port | `1521` |
