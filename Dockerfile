FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app
COPY *.csproj ./
COPY nuget.config ./
RUN dotnet restore --configfile nuget.config --disable-parallel
COPY . ./
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/ .
EXPOSE 80

ENTRYPOINT ["dotnet", "dockerExample.dll"]