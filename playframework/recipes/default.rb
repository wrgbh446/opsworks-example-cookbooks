package "zip"

directory "#{node['playframework']['install_dir']}" do
    user "#{node['playframework]['user']}"
    group "#{node['playframework']['group']}"
    mode "0755"
end

remote_file "#{node['playframework']['install_dir']}/#{node['playframework']['version']}.zip" do
    source "http://downloads.typesafe.com/play/#{node['playframework']['version']}/play-#{node['playframework']['version']}.zip"
    path "#{node['playframework']['install_dir']}/#{node['playframework']['version']}.zip"
    user "#{node['playframework']['user']}"
    group "#{node['playframework']['group']}"
    mode "0755"
    notifies :run, "execute[install-play]", :immediately
    action :create_if_missing
end

execute "install-play" do
    user "ec2-user"
    cwd node['playframework']['install_dir']
    command <<-EOH
    sudo unzip #{node['playframework']['version']}.zip
    sudo mv play-#{node['playframework']['version']} #{node['playframework']['version']}
    sudo chown -R #{node['playframework']['user']}:#{node['playframework']['group']} #{node['playframework']['version']} 
    export PATH=$PATH:#{node['playframework']['install_dir']}/#{node['playframework']['version']}
    EOH
    action :nothing
end