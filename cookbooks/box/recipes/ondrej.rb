include_recipe "apt"

apt_repository "php54" do
    uri "http://ppa.launchpad.net/ondrej/php5/ubuntu"
    distribution "precise"
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "E5267A6C"
    action :add
    notifies :run, "execute[apt-get update]", :immediately
    deb_src true
end
