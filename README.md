# nateApp-cookbook


## Supported Platforms

Only ubuntu 14.04 - didn't have enough time to test ;)
## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['nateApp']['config']</tt></td>
    <td>String</td>
    <td>What to call the apache config</td>
    <td><tt>nateApp</tt></td>
  </tr>
  <tr>
    <td><tt>['nateApp']['document_root']</tt></td>
    <td>String</td>
    <td>Where to place website document root</td>
    <td><tt>#{node['apache']['docroot_dir']}/nateApp</tt></td>
  </tr>
  <tr>
    <td><tt>['nateApp']['content_root']</tt></td>
    <td>String</td>
    <td>Where to place the content of the site (Presentations and default icons)</td>
    <td><tt>/data/nateApp</tt></td>
  </tr>
  <tr>
    <td><tt>['nateApp']['schema_root']</tt></td>
    <td>String</td>
    <td>Where to store the schema that will be used for DB</td>
    <td><tt>/var/lib/nateApp</tt></td>
  </tr>
  <tr>
    <td><tt>['nateApp']['content_servers']</tt></td>
    <td>Array</td>
    <td>List of content servers</td>
    <td><tt>['127.0.0.1']</tt></td>
  </tr>
</table>

## Usage

To get started get a copy of ChefDK (https://downloads.chef.io/chef-dk/) & Vagrant (http://www.vagrantup.com/downloads.html)

Clone git repo and run ``vagrant up``

## License and Authors

Author:: Stefan Coetzee (<stefan.coetzee@uct.ac.za>)
