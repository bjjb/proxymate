FROM scratch
COPY main proxymate
ADD app/ www
ENTRYPOINT ["/proxymate"]
EXPOSE 8899
