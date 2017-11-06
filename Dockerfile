# Using centos 7 base image, because dealing with RHEL's subscription manger HAX is pissing me off
FROM registry.access.redhat.com/rhel7

# Add Puppet Keys
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-reductive
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppet

# Add puppet repo and install puppet
RUN yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum install -y puppet

# Install things so that the stupid old grpc v0.12 will build
RUN yum install -y make gcc gcc-c++ zlib-devel openssl-devel

RUN ["/opt/puppetlabs/puppet/bin/gem", "install", "--no-document", "--version", "0.12", "grpc"]
RUN ["/opt/puppetlabs/puppet/bin/gem", "install", "--no-document", "--version", "1.7.0", "cisco_node_utils"]

RUN yum autoremove -y make gcc gcc-c++ zlib-devel openssl-devel
RUN yum autoremove
RUN yum clean all
RUN rm -rf /var/cache/yum

ADD csr_attributes.yaml /etc/puppetlabs/puppet/csr_attributes.yaml

ENTRYPOINT ["/opt/puppetlabs/puppet/bin/puppet", "agent", "--no-daemonize"]

