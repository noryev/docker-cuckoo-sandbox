# Use an official Ubuntu base image
FROM ubuntu:latest

# Install tcpdump, libcap2-bin, and other dependencies
RUN apt-get update && \
    apt-get install -y tcpdump libcap2-bin libmagic-dev libcairo2-dev libpango1.0-dev libssl-dev python3 python3-dev

# Add group pcap and user cuckoo
RUN groupadd pcap && \
    useradd -m -d /home/cuckoo -s /bin/bash -g pcap cuckoo

# Change group of tcpdump and set capabilities
RUN chgrp pcap /usr/sbin/tcpdump && \
    setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump

# Switch to the cuckoo user
USER cuckoo

# Set the working directory
WORKDIR /home/cuckoo

# Start command or entry point for your container
# Add your specific Cuckoo Sandbox setup and start-up commands here
