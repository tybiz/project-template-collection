# ASP.NET MVC + PostgreSQL — Docker Template

## Quick start

```bash
git clone --depth 1 -b mvc-postgres https://github.com/user/docker-templates.git .
rm -rf .git && cp .env.example .env && git init
docker compose up -d
```

App available at `http://localhost:8080`

## Rename the project

Replace `MyApp.MVC` with your actual project name in `Dockerfile` — there are **4 places** marked with `# TODO`:

```
COPY ["src/MyApp.MVC/MyApp.MVC.csproj", ...]   ← line 5
RUN dotnet restore "src/MyApp.MVC/MyApp.MVC.csproj"  ← line 6
WORKDIR "/src/src/MyApp.MVC"                    ← line 10
ENTRYPOINT ["dotnet", "MyApp.MVC.dll"]          ← last line
```

Expected project structure:
```
src/
└── YourApp.MVC/
    └── YourApp.MVC.csproj
```

## Environment variables

| Variable | Description | Default |
|---|---|---|
| `ASPNETCORE_ENVIRONMENT` | .NET environment | `Development` |
| `MVC_PORT` | App port | `8080` |
| `POSTGRES_DB` | Database name | `myapp` |
| `POSTGRES_USER` | Database user | `myapp_user` |
| `POSTGRES_PASSWORD` | Database password | — |
| `POSTGRES_PORT` | Database port | `5432` |
