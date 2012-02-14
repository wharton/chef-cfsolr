Description
===========

Installs the Apache SOLR Standalone for ColdFusion 9.0.1.

Attributes
==========

* `node["cfsolr"]["install_path"]` - where to install solr, default `/opt/coldfusionsolr`.
* `node['cfsolr']['java_home']` - which JVM to use, default `#{node['cfsolr']['install_path']}/jre`
* `node['cfsolr']['java_max_heap']` - max heap for the JVM, default `256m`

