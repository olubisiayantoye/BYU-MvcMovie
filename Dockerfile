
# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy solution and project files
COPY *.sln .
COPY *.csproj .

# Restore dependencies
RUN dotnet restore

# Copy the rest of the source code
COPY . .

# Publish
RUN dotnet publish -c Release -o /app/out --no-restore

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copy published output
COPY --from=build /app/out ./

# Create folder for SQLite database
RUN mkdir -p /app/Data

# Set environment variable for SQLite location
ENV ConnectionStrings__MvcMovieContext="Data Source=/app/Data/MvcMovie.db"

# Expose port
EXPOSE 80

# Run app
ENTRYPOINT ["dotnet", "MvcMovie.dll"]
