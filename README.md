# .NET Clean Architecture API + PostgreSQL — Docker Template

Template dla Web API (.NET 9) w architekturze Clean Architecture z bazą PostgreSQL.

## Szybki start

```bash
git clone --depth 1 -b dotnet-backend-postgres https://github.com/user/docker-templates.git .
rm -rf .git
cp .env.example .env
# Uzupełnij .env swoimi wartościami
git init
```

## Uruchomienie

```bash
docker compose up -d
```

API dostępne pod `http://localhost:8080`

## Struktura projektu (Clean Architecture)

Dostosuj nazwy projektów w `Dockerfile` — zamień `MyApp` na nazwę swojego projektu:

```
src/
├── MyApp.Domain/           # Encje, interfejsy, reguły biznesowe
├── MyApp.Application/      # Use cases, DTOs, serwisy aplikacji
├── MyApp.Infrastructure/   # EF Core, repozytoria, zewnętrzne serwisy
└── MyApp.API/              # Controllers, middleware, DI
```

## Connection String

Przekazywany automatycznie przez `docker-compose.yml`:
```
Host=db;Port=5432;Database={DB};Username={USER};Password={PASS}
```

W kodzie odczytaj przez:
```csharp
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));
```

## Zmienne środowiskowe

| Zmienna | Opis | Domyślna |
|---|---|---|
| `ASPNETCORE_ENVIRONMENT` | Środowisko .NET | `Development` |
| `API_PORT` | Port API | `8080` |
| `POSTGRES_DB` | Nazwa bazy | `myapp` |
| `POSTGRES_USER` | Użytkownik bazy | `myapp_user` |
| `POSTGRES_PASSWORD` | Hasło bazy | — |
| `POSTGRES_PORT` | Port bazy | `5432` |
