####################################################################
# COOKBOOK NAME: freegeoip
# RECIPE: default
# DESCRIPTION: Installs & Configures freegeoip 3.x
#
####################################################################
# (C)2014 DigiTar, All Rights Reserved
#
# Redistribution and use in source and binary forms, with or without modification, 
#    are permitted provided that the following conditions are met:
#
#        * Redistributions of source code must retain the above copyright notice, 
#          this list of conditions and the following disclaimer.
#        * Redistributions in binary form must reproduce the above copyright notice, 
#          this list of conditions and the following disclaimer in the documentation 
#          and/or other materials provided with the distribution.
#        * Neither the name of DigiTar nor the names of its contributors may be
#          used to endorse or promote products derived from this software without 
#          specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
# SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
# DAMAGE.
#
####################################################################
include_recipe "logrotate"

FreeGeoIP = Chef::Recipe::FreeGeoIP.new()

if node[:kernel][:machine] == "x86_64" then
  arch = "amd64"
else
  arch = "i386"
end

pkg = "freegeoip-#{node[:freegeoip][:version]}-linux-#{arch}.tar.gz"
unpack_loc = ::File.join(Chef::Config[:file_cache_path], "/" , pkg)
print "hola"
print node[:freegeoip][:download_path] + "/#{node[:freegeoip][:version]}/"+ pkg
remote_file unpack_loc do
 source node[:freegeoip][:download_path] + "/#{node[:freegeoip][:version]}/"+ pkg
end
 
directory "#{node[:freegeoip][:install_path]}" do
 action :create
 owner node[:freegeoip][:user]
 mode "0755"
end

bash "Install freegeoip" do
 cwd Chef::Config[:file_cache_path]
 code <<-EOS
   tar zxf #{pkg} -C #{node[:freegeoip][:install_path]} --strip 1
   cd #{node[:freegeoip][:install_path]}
   chown -R #{node[:freegeoip][:user]} #{node[:freegeoip][:install_path]}/*
   EOS
 creates "#{node[:freegeoip][:install_path]}/freegeoip"
 not_if { File.exists?("#{node[:freegeoip][:install_path]}/freegeoip") and (FreeGeoIP.freegeoip_version(node[:freegeoip][:install_path]) == node[:freegeoip][:version])}
end

directory node[:freegeoip][:log_path] do
  action :create
  owner node[:freegeoip][:user]
  mode "0755"
end

case node['platform']
when "ubuntu"
  template "/etc/init/freegeoip.conf" do
    mode "0644"
    source "ubuntu/upstart.freegeoip.conf.erb"
    notifies :restart, "service[freegeoip]"
  end
  
  logrotate_app "freegeoip" do
    cookbook "logrotate"
    path "#{node["freegeoip"]["log_path"]}/freegeoip.log"
    frequency "daily"
    rotate 7
    create "644 root root"
  end
  
  service "freegeoip" do
    provider Chef::Provider::Service::Upstart
    action [ :enable, :start ]
  end
end