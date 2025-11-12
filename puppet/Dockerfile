FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Puppet
RUN apt-get update && \
    apt-get install -y wget lsb-release gnupg && \
    wget https://apt.puppet.com/puppet7-release-focal.deb && \
    dpkg -i puppet7-release-focal.deb && \
    apt-get update && \
    apt-get install -y puppet git curl nodejs npm && \
    apt-get clean

# Copy Puppet module
COPY modules /etc/puppetlabs/code/environments/production/modules/

# Apply the Puppet manifest
CMD ["puppet", "apply", "-e", "include appdeploy"]
