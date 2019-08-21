FROM centos:7
ENV LANG en_US.UTF-8
ENV LD_LIBRARY_PATH /home/solace/solclient/lib
RUN useradd -d /home/solace -m -s /bin/bash -U solace
USER solace:solace
WORKDIR /home/solace
ADD --chown=solace:solace run-sol-cache .
RUN chmod +x run-sol-cache
ARG CACHE_FILENAME=SolaceCache_Linux26-x86_64_debug_1.0.6.tar.gz
ARG SOLCLIENT_FILENAME=solclient_Linux26-x86_64_debug_7.11.0.8.tar.gz
ADD $CACHE_FILENAME .
ADD $SOLCLIENT_FILENAME .
USER root:root
RUN chown -R solace:solace /home/solace/*
USER solace:solace
RUN mv solclient* solclient && mkdir config
CMD ["/bin/sh", "-c", "/home/solace/SolaceCache/bin/SolaceCache --file=$CONFIG_FILE_PATH"]
