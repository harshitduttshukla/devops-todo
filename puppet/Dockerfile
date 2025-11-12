FROM ubuntu:22.04

# Install Puppet and dependencies
RUN apt-get update && \
    apt-get install -y puppet git curl nodejs npm

# Copy Puppet module
COPY modules /etc/puppet/modules

# Apply Puppet manifest
CMD ["puppet", "apply", "-e", "include appdeploy", "--modulepath=/etc/puppet/modules"]
