# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY *.sln .
COPY MvcMovie/*.csproj ./MvcMovie/
RUN dotnet restore

# Copy everything else and build
COPY . .
WORKDIR /app/MvcMovie
RUN dotnet publish -c Release -o /app/out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copy published app
COPY --from=build /app/out ./

# Create folder for SQLite database
RUN mkdir -p /app/Data

# Set environment variable for SQLite location
ENV ConnectionStrings__MvcMovieContext="Data Source=/app/Data/MvcMovie.db"

# Expose port 80
EXPOSE 80

# Entry point: apply migrations, seed DB, then run app
ENTRYPOINT ["dotnet", "MvcMovie.dll"]
