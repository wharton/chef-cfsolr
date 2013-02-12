name             "cfsolr"
maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "chef-admins@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs Apache Solr Standalone for ColdFusion"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"

recipe "cfsolr", "Installs Apache Solr Standalone for ColdFusion"
recipe "cfsolr::replication", "Configures simple replication for new Solr cores"

%w{ centos redhat ubuntu }.each do |os|
  supports os
end

%w{ java }.each do |cb|
  suggests cb
end
