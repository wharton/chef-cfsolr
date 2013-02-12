
default["cfsolr"]["version"] = "10.0.0"

case Chef::Version.new(node["cfsolr"]["version"]).major
when 10
  #default["cfsolr"]["url"] = "http://download.macromedia.com/pub/coldfusion/updates/10/SolrInstallers/ColdFusion_10_Jetty_Solr_linux.bin"
  #default["cfsolr"]["checksum"] = "4137ee93041139371fa73ed7ad48c781ea80cfed6742f296f1c1c4a2015b5a0d"
  default["cfsolr"]["url"] = "http://download.macromedia.com/pub/coldfusion/updates/10/SolrInstallers/ColdFusion_10_Jetty_Solr_linux64.bin"
  default["cfsolr"]["checksum"] = "c3f33aec960e44fd1ec87df3e72f19addd43aaa732e03ae73ab5293eac599f9f"
  default["cfsolr"]["java_max_heap"] = "512m"
  default["cfsolr"]["solrport"] = 8985
  default["cfsolr"]["stopport"] = 8077
when 9
  case Chef::Version.new(node["cfsolr"]["version"]).patch
  when 1
    default["cfsolr"]["url"] = "http://download.macromedia.com/pub/coldfusion/updates/901/ColdFusion_901_Solr_WWEJ_linux64.bin"
    default["cfsolr"]["checksum"] = "807b8fbdc0d7dfe841127fc8f7affd178d715f1a39e12ba99a7442c01c7ee9a7"
  when 0
    default["cfsolr"]["url"] = "http://download.macromedia.com/pub/coldfusion/9/solr_installer/ColdFusion_9_Solr_linux64.bin"
    default["cfsolr"]["checksum"] = "680aa4d70c645412de65e0370d78e93b23cfbffd360046b3f2f71363207342d6"
  end
  default["cfsolr"]["java_max_heap"] = "256m"
  default["cfsolr"]["solrport"] = 8983
  default["cfsolr"]["stopport"] = 8079
end

# CF Solr installation folder
default["cfsolr"]["install_path"] = "/opt/coldfusionsolr"

# JVM
default["cfsolr"]["java_home"] = "#{node['cfsolr']['install_path']}/jre"

# Replication
default["cfsolr"]["master"]["enable"] = true
default["cfsolr"]["master"]["hostname"] = node["fqdn"]
default["cfsolr"]["slave"]["pollInterval"] = "00:00:60"
