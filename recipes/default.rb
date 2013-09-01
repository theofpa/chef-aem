#
# Cookbook Name:: chef-aem
# Recipe:: default
#
# Copyright (C) 2013 Theofilos Papapanagiotou
# 
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"
include_recipe "java"

group "#{node['aem']['group']}" do
  append true
end

user "#{node['aem']['user']}" do
  supports :manage_home => true
  comment "Adobe AEM user"
  gid "node['aem']['group']"
  home "#{node['aem']['install_path']}"
  shell "/bin/bash"
end

directory "#{node['aem']['install_path']}" do
  owner "#{node['aem']['user']}"
  group "#{node['aem']['group']}"
  mode 00755
  action :create
end

# remote_file does not support headers for authentication in this version of Chef, it will be fixed in a future version where CHEF-3786 will be released. This is a workaround to use both remote_file and http_request to pass the authentication file.
remote_file "#{node['aem']['install_path']}/AEM_5_6_Quickstart.jar" do
  source "http://daycare.day.com/home/products/cq_wcm/Adobe_Experience_Manager_5_6.Par.0021.file.tmp/AEM_5_6_Quickstart.jar"
  owner "#{node['aem']['user']}"
  group "#{node['aem']['group']}"
  action :nothing
end

if !File.exists?("#{node['aem']['install_path']}/AEM_5_6_Quickstart.jar")
 http_request "Download AEM_5_6_Quickstart.jar" do
  url "http://daycare.day.com/home/products/cq_wcm/Adobe_Experience_Manager_5_6.Par.0021.file.tmp/AEM_5_6_Quickstart.jar"
  message ""
# generate the hash by using your Adobe account:
# echo username:password | base64
  auth="#{node['aem']['adobe_id']}:#{node['aem']['adobe_password']}"
  headers "Authorization" => "Basic #{Base64.encode64(auth)}"
  action :head
  notifies :create, "remote_file[#{node['aem']['install_path']}/AEM_5_6_Quickstart.jar]", :immediately
 end
end

file "#{node['aem']['install_path']}/license.properties" do
  owner "#{node['aem']['user']}"
  group "#{node['aem']['group']}"
  mode 00644
  content "#Adobe Granite License Properties
#Tue Feb 28 10:45:30 EST 2012
license.product.name=Adobe CQ5
license.customer.name=#{node['aem']['license.customer.name']}
license.product.version=5.5.0
license.downloadID=#{node['aem']['license.downloadID']}
"
  action :create_if_missing
end

bash 'run_jar' do
  user 'aem'
  group 'aem'
  if !File.exists?("#{node['aem']['install_path']}/crx-quickstart/repository/.lock")
    code <<-EOH
    java -jar AEM_5_6_Quickstart.jar &
    EOH
  end
end
