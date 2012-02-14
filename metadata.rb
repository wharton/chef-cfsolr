maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "nmische@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs Apache SOLR Standalone for ColdFusion 9.0.1"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

recipe "cfsolr", "Installs Apache SOLR Standalone for ColdFusion 9.0.1"

