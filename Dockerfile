# Using centos 7 base image, because dealing with RHEL's subscription manger HAX is pissing me off
FROM registry.access.redhat.com/rhel7

# Add Puppet Keys
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-reductive
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppet

# Add puppet repo and install puppet
RUN yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum install -y puppet

# Install things so that grpc will build
RUN yum install -y make gcc gcc-c++

RUN ["/opt/puppetlabs/puppet/bin/gem", "install", "--no-rdoc", "--no-ri", "grpc", "-v", "1.6.7"]
# RUN ["/opt/puppetlabs/puppet/bin/gem", "install", "--no-rdoc", "--no-ri", "cisco_node_utils"]

# RUN yum autoremove -y make gcc gcc-c++

ENTRYPOINT ["/opt/puppetlabs/puppet/bin/puppet", "agent", "--no-daemonize"]
