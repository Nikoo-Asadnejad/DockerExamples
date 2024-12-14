
# Docker Example with Shared NuGet Cache

This repository demonstrates how to use 
a shared NuGet cache volume in a Dockerized .NET application 
to optimize build times by reusing NuGet packages across containers.

##Prerequisites

Docker: 
- Ensure Docker is installed on your system.
.NET SDK 8.0 or later: Required for local development or troubleshooting.
Getting Started

1. Build the Docker Image
Build the Docker image using the provided Dockerfile:

docker build -t docker-example .
2. Create Volume for NuGet Cache
Create a Docker volume to store the shared NuGet cache:

docker volume create nuget_cache
3. Run the Container
Run the container and mount the NuGet cache volume:

docker run -v nuget_cache:/app/nuget_cache docker-example
This command ensures that the NuGet packages are stored in the nuget_cache volume, making them reusable for subsequent container builds.

4. Access the Application
The application exposes port 80. To access it locally, map it to a host port (e.g., 8080) using the -p flag:

docker run -p 8080:80 -v nuget_cache:/app/nuget_cache docker-example
Visit http://localhost:8080 in your browser to access the application.

##NuGet Cache Configuration

This project includes a custom nuget.config file that specifies the cache directory for NuGet packages:

<configuration>
<config>
<add key="globalPackagesFolder" value="/app/nuget_cache" />
</config>
</configuration>

When running the container with the shared volume mounted 
to /app/nuget_cache, NuGet packages are cached across multiple containers for faster builds.

##Clean Up

To remove the Docker volume when it's no longer needed:

docker volume rm nuget_cache

## Example Commands

Build and Run Example
# Build the Docker image
docker build -t docker-example .

## Create a Docker volume for the shared NuGet cache
docker volume create nuget_cache

## Run the Docker container with the shared NuGet cache

docker run -p 8080:80 -v nuget_cache:/app/nuget_cache docker-example
Remove the NuGet Cache Volume

docker volume rm nuget_cache

## Notes

Using a shared NuGet cache significantly reduces build times by reusing previously downloaded packages.
The --disable-parallel flag in 
the dotnet restore command avoids 
concurrency issues when multiple 
containers use the shared cache.


