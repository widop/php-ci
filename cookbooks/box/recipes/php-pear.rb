include_recipe "php"
include_recipe "jenkins"

execute "Init PEAR" do
    command "sudo pear update-channels; sudo pear config-set auto_discover 1"
end

phpmd = php_pear_channel "pear.phpmd.org" do
    action :discover
end

pdepend = php_pear_channel "pear.pdepend.org" do
    action :discover
end

phpunit = php_pear_channel "pear.phpunit.de" do
    action :discover
end

php_pear "PHP_Depend" do
    channel pdepend.channel_name
    preferred_state "beta"
    options "--alldeps"
    action :install
    not_if "which pdepend"
end

php_pear "PHP_PMD" do
    channel phpmd.channel_name
    action :install
    not_if "which phpmd"
end

php_pear "PHP_CodeSniffer" do
    action :install
    not_if "which phpcs"
end

php_pear "pear.phpunit.de/PHPUnit" do
    action :install
    not_if "which phpunit"
end

execute "Install Symfony2 coding standard for phpcs" do
    command "rm -rf /usr/share/php/PHP/CodeSniffer/Standards/Symfony2"
    command "git clone git://github.com/opensky/Symfony2-coding-standard.git /usr/share/php/PHP/CodeSniffer/Standards/Symfony2"
    not_if "ls /usr/share/php/PHP/CodeSniffer/Standards/ | grep Symfony2"
end

execute "Set Symfony2 coding standard to default for phpcs" do
    command "sudo phpcs --config-set default_standard Symfony2"
end

