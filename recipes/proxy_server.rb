web_servers = node['nateApp']['webservers']

include_recipe "haproxy::install_package"

haproxy_lb 'nateAppWeb' do
  bind '0.0.0.0:80'
  mode 'http'
  servers web_servers.each do |web|
    #{web.name} #{web.ipaddress}:8080 check 
  end
  params({
    'maxconn' => 20000,
    'balance' => 'leastconn'
  })
end
