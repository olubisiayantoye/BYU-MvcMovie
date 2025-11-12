# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy remaining files and build
COPY . ./
RUN dotnet publish -c Release -o out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

# Copy published app
COPY --from=build /app/out .

# Create folder for SQLite database
RUN mkdir -p /app/Data

# Set environment variables
ENV ASPNETCORE_ENVIRONMENT=Production
ENV ConnectionStrings__MvcMovieContext="Data Source=/app/Data/MvcMovie.db"

# Expose port 8080 for Render
EXPOSE 8080

# Start the app
ENTRYPOINT ["dotnet", "MvcMovie.dll"]
