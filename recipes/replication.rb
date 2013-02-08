#
# Cookbook Name:: cfsolr
# Recipe:: master
#
# Copyright 2013, Brian Flad
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Solr configuration
template "#{node['cfsolr']['install_path']}/multicore/template/conf/solrconfig.xml" do
  source "solrconfig.xml.erb"
  mode "0644"
  notifies :restart, "service[cfsolr]", :delayed
end

# Solr configuration
template "#{node['cfsolr']['install_path']}/multicore/template/conf/solrcore.properties" do
  source "solrcore.properties.erb"
  mode "0644"
  notifies :restart, "service[cfsolr]", :delayed
end
