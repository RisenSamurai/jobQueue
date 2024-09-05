FROM ubuntu:latest
LABEL authors="Vladyslav Boichuk"

ENTRYPOINT ["top", "-b"]