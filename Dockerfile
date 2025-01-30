# STEP 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy project files
COPY EkamuthAPI/*.csproj ./EkamuthAPI/
RUN dotnet restore EkamuthAPI/EkamuthAPI.csproj

# Copy everything and publish
COPY . .
WORKDIR /app/EkamuthAPI
RUN dotnet publish EkamuthAPI.csproj -c Release -o /publish

# STEP 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /publish .

EXPOSE 8080
CMD ["dotnet", "EkamuthAPI.dll"]
