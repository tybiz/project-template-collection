# ASP.NET MVC + PostgreSQL — Docker Template

Template dla ASP.NET MVC (.NET 9) z bazą PostgreSQL.

## Szybki start

```bash
git clone --depth 1 -b mvc-postgres https://github.com/user/docker-templates.git .
rm -rf .git
cp .env.example .env
# Uzupełnij .env swoimi wartościami
git init
```

## Uruchomienie

```bash
docker compose up -d
```

Aplikacja dostępna pod `http://localhost:8080`

## Struktura projektu

Dostosuj nazwy projektów w `Dockerfile` — zamień `MyApp.MVC` na nazwę swojego projektu:

```
src/
└── MyApp.MVC/
    └── MyApp.MVC.csproj
```

## Zmienne środowiskowe

| Zmienna | Opis | Domyślna |
|---|---|---|
| `ASPNETCORE_ENVIRONMENT` | Środowisko .NET | `Development` |
| `MVC_PORT` | Port aplikacji | `8080` |
| `POSTGRES_DB` | Nazwa bazy | `myapp` |
| `POSTGRES_USER` | Użytkownik bazy | `myapp_user` |
| `POSTGRES_PASSWORD` | Hasło bazy | — |
| `POSTGRES_PORT` | Port bazy | `5432` |
