package "unzip"
package "xvfb"

directory "/opt/selenium" do
    action :create
end

execute "Install selenium" do
    command "sudo curl -o /opt/selenium/selenium-server-standalone.jar http://selenium.googlecode.com/files/selenium-server-standalone-2.30.0.jar"
end

execute "Install chrome driver" do
    command "sudo curl -o /opt/selenium/chromedriver.zip https://chromedriver.googlecode.com/files/chromedriver_linux32_26.0.1383.0.zip"
end

execute "Unzip chromedriver" do
    command "sudo unzip -o /opt/selenium/chromedriver.zip"
end

template "/opt/selenium/start.sh" do
    source "selenium/start.sh"
    mode "0755"
end
