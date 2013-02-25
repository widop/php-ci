include_recipe "nodejs"
include_recipe "nodejs::npm"

execute "install lesscss" do
  command "npm install -g less"
  action :run
end
