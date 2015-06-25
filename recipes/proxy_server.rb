include_recipe "haproxy::install_package"

template "/etc/haproxy/haproxy.cfg" do
  source "haproxy.cfg.erb"
  variables({
    :web_servers => node['nateApp']['webservers']
  })
  notifies :restart, "service[haproxy]"
end
