web_servers_ips = node['nateApp']['webservers']

web_servers = []
web_servers_ips.each do |web_server|
  web_servers.push("#{web_server} #{web_server}:8080 check")
end

include_recipe "haproxy::install_package"

haproxy_lb 'nateAppWeb' do
  bind '0.0.0.0:80'
  mode 'http'
  servers web_servers
  params({
    'maxconn' => 20000,
    'balance' => 'leastconn'
  })
end
