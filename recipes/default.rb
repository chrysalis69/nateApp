#
# Cookbook Name:: nateApp
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nateApp::database_server"
include_recipe "nateApp::content_server"
include_recipe "nateApp::web_server"
