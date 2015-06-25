node.set['apache']['listen_ports'] = [80,8080]
node.set['apache']['mpm'] = 'prefork'

include_recipe "apache2"
include_recipe "apache2::mod_cgi"
include_recipe "apache2::mod_rewrite"

#apt_repository "trusty-media" do
#  uri  "ppa:mc3man/trusty-media"
#  distribution node['lsb']['codename']
#end

#package "ffmpeg" do
#  action :install
#end
package "libclass-dbi-mysql-perl" do
  action :install
end

package "jodconverter" do
  action :install
end

package "poppler-utils" do
  action :install
end

package "imagemagick" do
  action :install
end

template "/etc/init.d/soffice" do
  source "soffice.erb"
  mode '0744'
end

service "soffice" do
  action [:enable, :start]
end

package "libdata-guid-perl" do
  action :install
end

template "#{node['apache']['dir']}/sites-available/#{node['nateApp']['config']}-content.conf" do
  source "content.conf.erb"
  notifies :restart, "service[apache2]"
end

#create content dir
directory "#{node['nateApp']['content_root']}/presentations" do
  action :create
  owner "#{node['apache']['user']}"
  group "#{node['apache']['group']}"
  mode '0755'
  recursive true
end

directory "#{node['nateApp']['content_root']}/presentations/tmp" do
  action :create
  owner "#{node['apache']['user']}"
  group "#{node['apache']['group']}"
  mode '0755'
  recursive true
end

# copy website
remote_directory "#{node['nateApp']['content_root']}" do
  files_mode '0770'
  files_owner "#{node['apache']['user']}"
  owner "#{node['apache']['user']}"
  mode '0770'
  source 'content_cgi'
end


# write code config
template "#{node['nateApp']['content_root']}/config.pl" do
  source 'config.pl.erb'
  owner "#{node['apache']['user']}"
  group "#{node['apache']['group']}"
  mode '0774'
end

# enable nateApp
apache_site "#{node['nateApp']['config']}-content" do
  enable true
end

#TODO: NFS


