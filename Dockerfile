# escape=`
ARG BASE
FROM mcr.microsoft.com/windows/servercore:$BASE

ARG VERSION
ENV VERSION=$VERSION

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN $url = ('https://github.com/traefik/traefik/releases/download/' + $env:VERSION + '/traefik_' + $env:VERSION + '_windows_amd64.zip'); `
    Write-Host "Downloading and expanding $url"; `
    Invoke-WebRequest -Uri $url -OutFile '/traefik.zip' -UseBasicParsing; `
    Expand-Archive -Path '/traefik.zip' -DestinationPath '/' -Force; `
    Remove-Item '/traefik.zip' -Force;

EXPOSE 80
ENTRYPOINT ["/traefik"]

LABEL org.opencontainers.image.vendor="Traefik Labs"
LABEL org.opencontainers.image.authors="Tobias Fenster"
LABEL org.opencontainers.image.url="https://traefik.io"
LABEL org.opencontainers.image.title="Traefik"
LABEL org.opencontainers.image.description="A modern reverse-proxy created by Traefik Labs. The container image is created by Tobias Fenster"
LABEL org.opencontainers.image.version="$VERSION"
LABEL org.opencontainers.image.documentation="https://docs.traefik.io"
