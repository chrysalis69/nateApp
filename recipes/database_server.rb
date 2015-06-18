
#include_recipe "nateApp::_common_system"

mysql_service 'nateApp' do
  port '3306'
  version '5.5'
  initial_root_password 'P@ssw0rd'
  action [:create, :start]
end
