#
# Cookbook Name:: cfsolr
# Recipe:: default
#
# Copyright 2011, Nathan Mische
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

# Download Apache SOLR Standalone Installer for ColdFusion 9.0.1 (http://www.adobe.com/support/coldfusion/downloads.html#cf901proddl)
remote_file "#{Chef::Config[:file_cache_path]}/ColdFusion_901_Solr_WWEJ_linux.bin" do
  source "http://download.macromedia.com/pub/coldfusion/updates/901/ColdFusion_901_Solr_WWEJ_linux.bin"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
end

# Set Java home
if node.recipe?("java")    
  node["cfsolr"]["java_home"] = "/usr/lib/jvm/default-java"
end

# Template the installation input file
template "#{Chef::Config[:file_cache_path]}/cf901-solr-installer.input" do
  source "cf901-solr-installer.input.erb"
  mode "0644"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cfsolr']['install_path']}/Adobe_ColdFusion_9_Solr_Service_InstallLog.log") }
end

# Run the installer
execute "cf901_solr_installer" do
  command "./ColdFusion_901_Solr_WWEJ_linux.bin < cf901-solr-installer.input"
  creates "#{node['cfsolr']['install_path']}/Adobe_ColdFusion_9_Solr_Service_InstallLog.log"
  action :run
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
end

# Allow Jetty to accept connections from other hosts
template "#{node['cfsolr']['install_path']}/etc/jetty.xml" do
  source "jetty.xml.erb"
  mode "0755"
  owner "nobody"
  group "bin"
end

# Fix init script for Ubuntu
template "#{node['cfsolr']['install_path']}/cfsolr" do
  source "cfsolr.erb"
  mode "0755"
  owner "nobody"
  group "bin"
end

# Link the init script
execute "cf_init" do 
  command "ln -sf #{node['cfsolr']['install_path']}/cfsolr /etc/init.d/cfsolr"
  creates "/etc/init.d/cfsolr"
  action :run
  user "root"
  cwd "/tmp"
end

# Set up cfsolr as a service
service "cfsolr" do
  supports :restart => true
  action [ :enable, :start ]
end
