node.set['apache']['listen_ports'] = [80,8080]

include_recipe "apache2"
include_recipe "apache2::mod_cgi"

apt_repository "trusty-media" do
  uri  "ppa:mc3man/trusty-media"
  distribution node['lsb']['codename']
end

package "ffmpeg" do
  action :install
end

package "jodconverter" do
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

#create content dir
directory "#{node['nateApp']['content_root']}" do
  action :create
  owner "#{node['apache']['user']}"
  group "#{node['apache']['group']}"
  mode '0755'
  recursive true
end

#TODO: NFS


