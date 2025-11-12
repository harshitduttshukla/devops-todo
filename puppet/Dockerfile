FROM ubuntu:22.04

# Install dependencies
RUN apt-get update -y && \
    apt-get install -y curl git unzip wget puppet && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Copy Puppet module
COPY ./modules /etc/puppetlabs/code/environments/production/modules

# Apply Puppet configuration
RUN puppet apply -e "include appdeploy"

# Expose React app port
EXPOSE 8082

# Start the React app and keep it running
CMD ["npm", "start", "--prefix", "/opt/todo"]
