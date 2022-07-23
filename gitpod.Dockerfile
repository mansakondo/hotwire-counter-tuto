FROM gitpod/workspace-ruby-3.1

RUN sudo apt-get update

RUN sudo apt-get install -y redis-server

RUN sudo rm -rf /var/lib/apt/lists/*
