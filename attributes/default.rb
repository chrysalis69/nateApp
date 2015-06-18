default['nateApp']['config'] = 'nateApp'
default['nateApp']['document_root'] = "#{node['apache']['docroot_dir']}/nateApp"
default['nateApp']['content_root'] = "/data/nateApp"
default['nateApp']['schema_root'] = "/var/lib/nateApp"

default['nateApp']['database']['host'] = 'localhost'
default['nateApp']['database']['username'] = 'nateApp'
default['nateApp']['database']['password'] = 'N@TEApp'
default['nateApp']['database']['dbname'] = 'nateApp'


