# -----------------------------------------------------------------------------
# docker-teamspeak
# -----------------------------------------------------------------------------

FROM ubuntu:14.04

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
RUN apt-get update -qq && \
    apt-get --yes upgrade && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl "http://dl.4players.de/ts/releases/3.0.11.3/teamspeak3-server_linux-amd64-3.0.11.3.tar.gz" -o teamspeak3-server.tar.gz && \
    tar zxf teamspeak3-server.tar.gz && \
    mv teamspeak3-server_linux-amd64 /opt/teamspeak && \
    rm teamspeak3-server.tar.gz

ADD ./scripts/run /start

RUN chmod +x /start

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

VOLUME ["/data"]
CMD    ["/start"]
