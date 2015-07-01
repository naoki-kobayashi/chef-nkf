#
# Cookbook Name:: nkf
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

version = "2.1.3"
cache_path = Chef::Config[:file_cache_path]
package_path = "#{Chef::Config[:file_cache_path]}/nkf-#{version}.tar.gz"

remote_file package_path do
    not_if { File.exist?(package_path)}
    source "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fnkf%2F59912%2Fnkf-#{version}.tar.gz"
    notifies :run, "bash[install_nkf]", :immediately
end

bash 'install_nkf' do
    user 'root'

    cwd cache_path
    code <<-EOL
        tar xvf nkf-#{version}.tar.gz 
	cd nkf-#{version}
	make
	make install
    EOL
end
