#include_recipe "haproxy::install_package"

package "haproxy" do
  action :install
end
ruby_block "Enable HaProxy" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/defaults/haproxy")
    fe.search_file_replace(/ENABLED=0/,"ENABLED=1")
    fe.write_file
  end
end

service "haproxy" do
  supports :restart => true, :reload => true
  action :enable
end

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy.cfg.erb"
  variables({
    :web_servers => node['nateApp']['webservers']
  })
  notifies :restart, "service[haproxy]"
end
