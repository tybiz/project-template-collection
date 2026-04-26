# ─── Build Stage ───────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Kopiuj csproj i przywróć zależności (cache layer)
COPY ["src/MyApp.MVC/MyApp.MVC.csproj", "src/MyApp.MVC/"]
RUN dotnet restore "src/MyApp.MVC/MyApp.MVC.csproj"

# Kopiuj resztę i zbuduj
COPY . .
WORKDIR "/src/src/MyApp.MVC"
RUN dotnet build "MyApp.MVC.csproj" -c Release -o /app/build

# ─── Publish Stage ─────────────────────────────────────────────────────────────
FROM build AS publish
RUN dotnet publish "MyApp.MVC.csproj" -c Release -o /app/publish /p:UseAppHost=false

# ─── Runtime Stage ─────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

COPY --from=publish /app/publish .

RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 8080
ENTRYPOINT ["dotnet", "MyApp.MVC.dll"]
