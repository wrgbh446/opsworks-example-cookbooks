include_recipe "java"

remote_file "/tmp/apache-maven.tar.gz" do
  source node['maven']['m2_download_url']
  checksum node['maven']['m2_checksum']
end

directory node['maven']['m2_home']

bash "install_maven2" do
  folder_name = node['maven']['m2_download_url'].split('/')[-1].split('-bin.tar.gz')[0]
  puts folder_name
  cwd "/tmp"
  user "root"
  code <<-EOH
    tar xvzf apache-maven.tar.gz
    cp -r #{folder_name}/* #{node['maven']['m2_home']}
    rm -rf apache-maven.tar.gz #{folder_name}
  EOH
end

template "/etc/mavenrc" do
  source "mavenrc.erb"
  mode "0755"
end

link "/usr/bin/mvn" do
  to "#{node['maven']['m2_home']}bin/mvn" 
end