# ─── Build Stage ───────────────────────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# TODO: Replace "MyApp.MVC" with your project name (3 occurrences below + ENTRYPOINT)
COPY ["src/MyApp.MVC/MyApp.MVC.csproj", "src/MyApp.MVC/"]
RUN dotnet restore "src/MyApp.MVC/MyApp.MVC.csproj"

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
# TODO: Replace "MyApp.MVC.dll" with your project name
ENTRYPOINT ["dotnet", "MyApp.MVC.dll"]
