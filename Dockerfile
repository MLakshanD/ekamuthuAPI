# STEP 1: Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy solution and project files
COPY *.sln ./
COPY EkamuthAPI/EkamuthAPI.csproj ./EkamuthAPI/

# Restore dependencies
RUN dotnet restore EkamuthAPI/EkamuthAPI.csproj

# Copy all files and build
COPY . .  
WORKDIR /app/EkamuthAPI
RUN dotnet publish -c Release -o /publish

# STEP 2: Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /publish .

EXPOSE 8080
CMD ["dotnet", "EkamuthAPI.dll"]
