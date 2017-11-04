# Using centos 7 base image, because dealing with RHEL's subscription manger HAX is pissing me off
FROM centos:7

# Add Puppet Keys
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-reductive
RUN rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppet

# Add puppet repo
RUN yum install http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

RUN yum install puppet
