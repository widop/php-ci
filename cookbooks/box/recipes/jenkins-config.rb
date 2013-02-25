include_recipe "jenkins"
include_recipe "ant"

execute "Change jenkins default shell" do
    command "sudo chsh -s /bin/bash jenkins"
end

execute "Set jenkins git username" do
    command "sudo -u jenkins -i git config --global user.name jenkins"
end

execute "Set jenkins git email" do
    command "sudo -u jenkins -i git config --global user.email jenkins@php-ci.box"
end

directory "#{node['jenkins']['server']['home']}/jobs/php-template/" do
    recursive true
    owner node['jenkins']['server']['user']
    group node['jenkins']['server']['user']
    action :create
end

template "#{node['jenkins']['server']['home']}/jobs/php-template/config.xml" do
    source "php-template/config.xml"
    owner node['jenkins']['server']['user']
    group node['jenkins']['server']['user']
    mode "0644"
end

template "#{node['jenkins']['server']['home']}/hudson.plugins.sonar.SonarPublisher.xml" do
    source "sonar/hudson.plugins.sonar.SonarPublisher.xml"
    owner node['jenkins']['server']['user']
    group node['jenkins']['server']['user']
    mode "0644"
end

template "#{node['jenkins']['server']['home']}/hudson.plugins.sonar.SonarRunnerInstallation.xml" do
    source "sonar/hudson.plugins.sonar.SonarRunnerInstallation.xml"
    owner node['jenkins']['server']['user']
    group node['jenkins']['server']['user']
    mode "0644"
end
