
#include_recipe "nateApp::_common_system"

mysql_service 'nateApp' do
  port '3306'
  version '5.5'
  initial_root_password 'P@ssw0rd'
  action [:create, :start]
end

remote_directory "#{node['nateApp']['schema_root']}" do
  files_mode '0440'
  source 'database'
end

template "#{node['nateApp']['schema_root']}/schema.sql" do
  source "schema.sql.erb"
end

execute "Load Demo Data" do
  action :nothing  
end

execute "Create DB" do
  command "mysql -u root -pP@ssw0rd -S /var/run/mysql-nateApp/mysqld.sock < #{node['nateApp']['schema_root']}/schema.sql"
end


