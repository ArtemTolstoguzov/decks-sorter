FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
COPY DecksSorter/*.csproj ./
RUN dotnet restore DecksSorter.csproj
COPY DecksSorter ./
RUN dotnet publish DecksSorter.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "DecksSorter.dll"]
