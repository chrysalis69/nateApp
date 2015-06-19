default['nateApp']['config'] = 'nateApp'
default['nateApp']['document_root'] = "#{node['apache']['docroot_dir']}/nateApp"
default['nateApp']['content_root'] = "/data/nateApp"
default['nateApp']['schema_root'] = "/var/lib/nateApp"
default['nateApp']['content_servers'] = ['127.0.0.1']

default['nateApp']['database']['host'] = '127.0.0.1'
default['nateApp']['database']['username'] = 'nateApp'
default['nateApp']['database']['password'] = 'N@TEApp'
default['nateApp']['database']['dbname'] = 'nateApp'


