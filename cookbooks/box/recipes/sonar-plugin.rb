include_recipe "sonar"

template "/etc/init.d/sonar" do
    source "sonar/sonar"
    owner "root"
    group "root"
    mode "755"
    action :create
end

execute "Launch sonar at boot time" do
    command "sudo update-rc.d sonar defaults"
end

execute "Install sonar-php plugin" do
    command "sudo curl -o /opt/sonar/extensions/plugins/sonar-php-plugin.jar http://repository.codehaus.org/org/codehaus/sonar-plugins/php/sonar-php-plugin/1.1/sonar-php-plugin-1.1.jar"
    notifies :restart, resources(:service => "sonar")
    not_if "test -f /opt/sonar/extensions/plugins/sonar-php-plugin.jar"
end

execute "Install Build Breaker plugin" do
    command "sudo curl -o /opt/sonar/extensions/plugins/sonar-build-breaker-plugin.jar http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-build-breaker-plugin/1.1/sonar-build-breaker-plugin-1.1.jar"
    notifies :restart, resources(:service => "sonar")
    not_if "test -f /opt/sonar/extensions/plugins/sonar-build-breaker-plugin.jar"
end

