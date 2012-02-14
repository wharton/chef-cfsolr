# CF Solr installation folder
default["cfsolr"]["install_path"] = "/opt/coldfusionsolr"
# JVM
default["cfsolr"]["java_home"] = "#{node['cfsolr']['install_path']}/jre"
default["cfsolr"]["java_max_heap"] = "256m"
