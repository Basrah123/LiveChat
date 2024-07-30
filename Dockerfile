# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy the project file and restore any dependencies
COPY ["BlazorServerCorr.csproj", "./"]
RUN dotnet restore "./BlazorServerCorr.csproj"

# Copy the rest of the application source code and build the application
COPY . .
RUN dotnet publish "BlazorServerCorr.csproj" -c Release -o /app/publish

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "BlazorServerCorr.dll"]
