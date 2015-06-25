
#include_recipe "nateApp::_common_system"
execute "apt-get update" do
end

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

execute "Load_Demo_Data" do
  action :nothing
  command "mysql -S /var/run/mysql-nateApp/mysqld.sock -u #{node['nateApp']['database']['username']} -p#{node['nateApp']['database']['password']} #{node['nateApp']['database']['dbname']} < #{node['nateApp']['schema_root']}/demo_data.sql"  
end

execute "Create DB" do
  command "mysql -u root -pP@ssw0rd -S /var/run/mysql-nateApp/mysqld.sock < #{node['nateApp']['schema_root']}/schema.sql"
  notifies :run, "execute[Load_Demo_Data]", :immediately
  not_if "mysql -S /var/run/mysql-nateApp/mysqld.sock -u #{node['nateApp']['database']['username']} -p#{node['nateApp']['database']['password']} #{node['nateApp']['database']['dbname']} -e 'describe presenters'"
end


