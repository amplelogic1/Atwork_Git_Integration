FROM ample.lims.web AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
#ENV ASPNETCORE_URLS=https://*:443;http://*:5000

FROM ample.lims.web
COPY /Output plugins/
WORKDIR /App
ENTRYPOINT ["dotnet", "Ample.Web.dll"]
