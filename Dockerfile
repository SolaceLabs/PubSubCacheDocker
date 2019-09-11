FROM centos:7
ENV LANG en_US.UTF-8
ENV LD_LIBRARY_PATH /home/solace/solclient/lib
RUN useradd -d /home/solace -m -s /bin/bash -U solace
WORKDIR /home/solace
ARG CACHE_FILENAME=SolaceCache_Linux26-x86_64_opt_1.0.6.tar.gz
ARG SOLCLIENT_FILENAME=solclient_Linux26-x86_64_opt_7.11.0.8.tar.gz
ADD $CACHE_FILENAME .
ADD $SOLCLIENT_FILENAME .
RUN mv solclient* solclient && mkdir config && chown -R solace:solace /home/solace/*
USER solace:solace
CMD ["/bin/sh", "-c", "/home/solace/SolaceCache/bin/SolaceCache --file=$CONFIG_FILE_PATH"]
