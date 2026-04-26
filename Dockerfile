# ─── Build Stage ───────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# TODO: Replace "MyApp" with your project name everywhere below + ENTRYPOINT
COPY ["src/MyApp.Domain/MyApp.Domain.csproj",           "src/MyApp.Domain/"]
COPY ["src/MyApp.Application/MyApp.Application.csproj", "src/MyApp.Application/"]
COPY ["src/MyApp.Infrastructure/MyApp.Infrastructure.csproj", "src/MyApp.Infrastructure/"]
COPY ["src/MyApp.API/MyApp.API.csproj",                 "src/MyApp.API/"]

RUN dotnet restore "src/MyApp.API/MyApp.API.csproj"

COPY . .
WORKDIR "/src/src/MyApp.API"
RUN dotnet build "MyApp.API.csproj" -c Release -o /app/build

# ─── Publish Stage ─────────────────────────────────────────────────────────────
FROM build AS publish
RUN dotnet publish "MyApp.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

# ─── Runtime Stage ─────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

COPY --from=publish /app/publish .

RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 8080
# TODO: Replace "MyApp.API.dll" with your project name
ENTRYPOINT ["dotnet", "MyApp.API.dll"]
