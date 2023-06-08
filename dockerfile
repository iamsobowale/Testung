FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy the project file
COPY *.csproj ./

# Restore dependencies
RUN dotnet restore

# Copy the entire project
COPY . ./

# Build the project
RUN dotnet build

# Run the application (optional, can be omitted if you only want to publish)
RUN dotnet run

# Publish the project
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final-env
WORKDIR /app
COPY --from=build-env /app/out .

# Expose port 80 (change to the appropriate port number for your application)
EXPOSE 80

ENTRYPOINT ["dotnet", "TestWebHook.dll"]
