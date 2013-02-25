include_recipe 'selenium::default'

arch = nil
case node['kernel']['machine']
when 'i686'
  arch = 'linux32'
when 'x86_64'
  arch = 'linux64'
end

package 'xvfb'
package 'chromium-browser'

execute 'unpack chromedriver' do
  command "unzip -o /usr/src/chromedriver_#{arch}_#{node['selenium']['chromedriver_version']}.zip -d /usr/local/bin"
  action :nothing
end

remote_file "/usr/src/chromedriver_#{arch}_#{node['selenium']['chromedriver_version']}.zip" do
  source "http://chromium.googlecode.com/files/chromedriver_#{arch}_#{node['selenium']['chromedriver_version']}.zip"
  action :create_if_missing
  notifies :run, "execute[unpack chromedriver]", :immediately
end

file '/usr/local/bin/chromedriver' do
  mode 0755
  owner 'root'
  group 'root'
end
