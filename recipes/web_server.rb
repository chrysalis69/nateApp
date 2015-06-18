include_recipe "apache2"
include_recipe "apache2::mod_php5"

include_recipe "php::module_mysql"

# disable default site
apache_site '000-default' do
  enable false
end

# create apache config
template "#{node['apache']['dir']}/sites-available/#{node['nateApp']['config']}.conf" do
  source "apache.conf.erb"
  notifies :restart, "service[apache2]"
end

# create document root
directory "#{node['nateApp']['document_root']}" do
  action :create
  owner "#{node['apache']['user']}"
  group "#{node['apache']['group']}"
  mode '0755'
  recursive true
end

# copy website
remote_directory "#{node['nateApp']['document_root']}" do
  files_mode '0440'
  files_owner "#{node['apache']['user']}"
  owner "#{node['apache']['user']}"
  mode '0770'
  source 'website'
end

# write site
template "#{node['nateApp']['document_root']}/config.php" do
  source 'config.php.erb'
  owner "#{node['apache']['user']}"
  group "#{node['apache']['group']}"
  mode '0644'
end

# enable nateApp
apache_site "#{node['nateApp']['config']}" do
  enable true
end
