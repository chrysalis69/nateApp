include_recipe "haproxy::install_package"

haproxy_lb 'nateAppWeb' do
  bind '0.0.0.0:80'
  mode 'http'
  params({
    'maxconn' => 20000,
    'balance' => 'leastconn'
  })
end
