name             "cfsolr"
maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "chef-admins@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs Apache Solr Standalone for ColdFusion"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "cfsolr", "Installs Apache Solr Standalone for ColdFusion"

%w{ ubuntu }.each do |os|
  supports os
end

