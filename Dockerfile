# Stage 1: build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY *.sln ./
COPY MvcMovie/*.csproj ./MvcMovie/
RUN dotnet restore

# Copy the rest of the code
COPY MvcMovie/. ./MvcMovie/
WORKDIR /app/MvcMovie
RUN dotnet publish -c Release -o out

# Stage 2: runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/MvcMovie/out ./

# Create a folder for the SQLite database
RUN mkdir -p /app/Data
ENV DOTNET_RUNNING_IN_CONTAINER=true

ENTRYPOINT ["dotnet", "MvcMovie.dll"]
