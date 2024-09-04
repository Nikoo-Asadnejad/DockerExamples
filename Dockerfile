# Use the official .NET 8 SDK image as the build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the .csproj file and restore any dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Use the official .NET 8 runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Set the working directory in the runtime container
WORKDIR /app

# Copy the build artifacts from the build stage
COPY --from=build /app/out .

# Expose the port the application will run on
EXPOSE 80

# Define the entry point for the container
ENTRYPOINT ["dotnet", "dockerExample.dll"]