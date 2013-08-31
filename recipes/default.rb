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

group "aem" do
  append true
end

user "aem" do
  supports :manage_home => true
  comment "Adobe AEM user"
  gid "aem"
  home "/opt/aem"
  shell "/bin/bash"
end

directory "/opt/aem" do
  owner "aem"
  group "aem"
  mode 00755
  action :create
end

# remote_file does not support headers for authentication in this version of Chef, it will be fixed in a future version where CHEF-3786 will be released. This is a workaround to use both remote_file and http_request to pass the authentication file.
remote_file "/opt/aem/AEM_5_6_Quickstart.jar" do
  source "http://daycare.day.com/home/products/cq_wcm/Adobe_Experience_Manager_5_6.Par.0021.file.tmp/AEM_5_6_Quickstart.jar"
  owner 'aem'
  group 'aem'
  action :nothing
end

if !File.exists?("/opt/aem/AEM_5_6_Quickstart.jar")
 http_request "Download AEM_5_6_Quickstart.jar" do
  url "http://daycare.day.com/home/products/cq_wcm/Adobe_Experience_Manager_5_6.Par.0021.file.tmp/AEM_5_6_Quickstart.jar"
  message ""
# generate the hash by using your Adobe account:
# echo username:password | base64
  headers "Authorization" => "Basic xxxxxxx="
  action :head
  notifies :create, "remote_file[/opt/aem/AEM_5_6_Quickstart.jar]", :immediately
 end
end

bash 'run_jar' do
  if !File.exists?("/opt/aem/crx-quickstart/repository/.lock")
    code <<-EOH
    cd /opt/aem
    java -jar AEM_5_6_Quickstart.jar &
    EOH
  end
end
