# 🐳 Docker Templates

Ready-to-use Docker templates. Each branch is a standalone template — no shared history.

## Templates

| Branch | Stack | Database |
|---|---|---|
| `mvc-postgres` | ASP.NET MVC (.NET 9) | PostgreSQL 17 |
| `django-oracle` | Django (Python 3.13) | Oracle Free 23c |
| `dotnet-backend-postgres` | .NET 9 Clean Architecture API | PostgreSQL 17 |

## Usage

```bash
git clone --depth 1 -b <branch-name> https://github.com/user/docker-templates.git .
rm -rf .git && cp .env.example .env && git init
docker compose up -d
```

> Fill in `change_me` values in `.env` before running.
