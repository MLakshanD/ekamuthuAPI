# STEP 1: Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy project files (inside EkamuthAPI)
COPY EkamuthAPI.csproj ./

# Restore dependencies
RUN dotnet restore EkamuthAPI.csproj

# Copy all files and build
COPY . .
RUN dotnet publish -c Release -o /publish

# STEP 2: Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /publish .

EXPOSE 8080
CMD ["dotnet", "EkamuthAPI.dll"]
