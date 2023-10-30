# Use the official SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY backend/APICodeCraft/APICodeCraft.csproj backend/APICodeCraft/
COPY backend/APICodeCraft.sln backend/
RUN dotnet restore backend/APICodeCraft.sln

# Copy the remaining files and build the application
COPY backend/. backend/
WORKDIR /app/backend/APICodeCraft
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/backend/APICodeCraft/out ./

# Expose the port the app will run on
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "APICodeCraft.dll"]
