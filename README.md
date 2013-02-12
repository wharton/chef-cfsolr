# chef-cfsolr [![Build Status](https://secure.travis-ci.org/wharton/chef-cfsolr.png?branch=master)](http://travis-ci.org/wharton/chef-cfsolr)

## Description

Installs/Configures Apache Solr standalone for Adobe ColdFusion.

## Requirements

### Platforms

* CentOS 6.3
* RHEL 6.3
* Ubuntu 12.04

## Attributes

These attributes are under the `node['cfsolr']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
checksum | ColdFusion Solr download checksum | String | see attributes/default.rb
install_path | Solr installation path | String | /opt/coldfusionsolr
java_home | JVM for usage | String | `#{node['cfsolr']['install_path']}/jre`
java_max_heap | JVM maximum heap memory | String | 256m (CF9) or 512m (CF10)
solrport | Solr port | Fixnum | 8983 (CF9) or 8985 (CF10)
stopport | Solr stop port | Fixnum | 8079 (CF9) or 8077 (CF10)
url | ColdFusion Solr download URL | String | see attributes/default.rb
version | ColdFusion Solr version | String | 10.0.0

### Replication Attributes

These attributes are under the `node['cfsolr']['master']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
enabled | Node is master server | Boolean | true
hostname | Hostname of master server | String | `node['fqdn']`

These attributes are under the `node['cfsolr']['slave']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
pollInterval | Solr poll interval | String | 00:00:60

## Recipes

* `recipe[cfsolr]` - Installs/configures Apache Solr standalone for Adobe ColdFusion
* `recipe[cfsolr::replication]` - Simple replication configuration for ColdFusion Solr servers

## Usage

### Solr Standalone Server Installation

* Add `recipe[cfsolr]` to your node's run list

### Simple Solr Replication Server Setup

* On master nodes:
  * Add `recipe[cfsolr]` and `recipe[cfsolr::replication]` to run list
* On slave nodes:
  * Add `recipe[cfsolr]` and `recipe[cfsolr::replication]` to run list
  * Set `node['cfsolr']['master']['enable']` to false
  * Set `node['cfsolr']['master']['hostname']` to FQDN of master node
  * Adjust `node['cfsolr']['slave']` attributes as necessary

## Testing and Development

Here's how you can quickly get testing or developing against the cookbook thanks to [Vagrant](http://vagrantup.com/) and [Berkshelf](http://berkshelf.com/).

    gem install bundler --no-ri --no-rdoc
    git clone git://github.com/wharton/chef-cfsolr.git
    cd chef-cfsolr
    bundle install
    bundle exec vagrant up BOX # BOX being centos6 or ubuntu1204

The running ColdFusion Solr server is accessible from the host machine:

* Web UI: http://33.33.33.10:8983/solr/admin/cores?action=status

You can then SSH into the running VM using the `vagrant ssh` command.
The VM can easily be stopped and deleted with the `vagrant destroy`
command. Please see the official [Vagrant documentation](http://vagrantup.com/v1/docs/commands.html)
for a more in depth explanation of available commands.

## Contributing

Please use standard Github issues/pull requests and if possible, in combination with testing on the Vagrant boxes.

## License and Author

Author:: Nathan Mische (<nmische@wharton.upenn.edu>), Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2011-2013

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
