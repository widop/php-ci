execute "Install selenium" do
    command "sudo rm -rf /opt/selenium-server-standalone* && sudo rm -rf /opt/chromedriver*"
    command "sudo curl -o /opt/selenium-server-standalone.jar http://selenium.googlecode.com/files/selenium-server-standalone-2.30.0.jar"
    command "sudo curl -o /opt/chromedriver https://chromedriver.googlecode.com/files/chromedriver_linux32_26.0.1383.0.zip"
    action :run
end

execute "Unzip chromedriver" do
    command "sudo unzip /opt/chromedriver_linux32_26.0.1383.0.zip"
end

execute "Launch selenium" do
    command "DISPLAY=:1 xvfb-run java -jar /opt/selenium-server-standalone-2.30.0.jar -Dwebdriver.chrome.driver=/opt/chromedriver"
end