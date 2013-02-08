#
# Cookbook Name:: cfsolr
# Recipe:: default
#
# Copyright 2011-2013, Nathan Mische, Brian Flad
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

cfsolr_version = Chef::Version.new(node["cfsolr"]["version"])

# Set Java home
if node.recipe?("java")    
  node.set["cfsolr"]["java_home"] = node["java"]["java_home"]
end

# Packages for ColdFusion 10 Solr
if cfsolr_version.major == 10
  package "unzip"
end

# Download Apache Solr Standalone Installer for ColdFusion
remote_file "#{Chef::Config[:file_cache_path]}/cfsolr-#{cfsolr_version}.bin" do
  source   node["cfsolr"]["url"]
  checksum node["cfsolr"]["checksum"]
  mode     "0744"
  action   :create_if_missing
end

# Template the installation input file
template "#{Chef::Config[:file_cache_path]}/cfsolr-#{cfsolr_version.major}-installer.input" do
  source "cfsolr-#{cfsolr_version.major}-installer.input.erb"
  mode "0644"
  owner "root"
  group "root"
end

# Run the installer
execute "cfsolr_#{cfsolr_version}_installer" do
  cwd Chef::Config[:file_cache_path]
  command "./cfsolr-#{cfsolr_version}.bin < cfsolr-#{cfsolr_version.major}-installer.input"
  creates node['cfsolr']['install_path']
  action :run
end

# Init script
template "#{node['cfsolr']['install_path']}/cfsolr" do
  source "cfsolr.erb"
  mode "0755"
end

# Link the init script
execute "symlink_cfsolr_init" do
  command "ln -sf #{node['cfsolr']['install_path']}/cfsolr /etc/init.d/cfsolr"
  creates "/etc/init.d/cfsolr"
end

# Jetty configuration
template "#{node['cfsolr']['install_path']}/etc/jetty.xml" do
  source "jetty.xml.erb"
  mode "0644"
  notifies :restart, "service[cfsolr]", :delayed
end

# Set up cfsolr as a service
service "cfsolr" do
  supports :restart => true
  action [ :enable, :start ]
end
