# STEP 1: Build the .NET 8 app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY *.sln ./
COPY *.csproj ./EkamuthAPI/
RUN dotnet restore EkamuthAPI/EkamuthAPI.csproj

COPY . .
WORKDIR /app/EkamuthAPI
RUN dotnet publish -c Release -o /publish

# STEP 2: Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /publish .
EXPOSE 8080
CMD ["dotnet", "EkamuthAPI.dll"]
