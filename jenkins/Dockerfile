FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
#COPY fontsub.dll C:/Windows/System32/
#COPY DWrite.dll C:/Windows/System32/
#COPY fonts C:/Windows/Fonts
COPY / app/
WORKDIR /app
ENTRYPOINT ["dotnet", "Ample.Web.dll"]
