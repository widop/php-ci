#!/bin/bash

export DISPLAY=:1
`Xvfb :1 -screen 0 1280x800x24 &` && `sleep 3` && `DISPLAY=:1 java -jar -Dwebdriver.chrome.driver=/opt/selenium/chromedriver /opt/selenium/selenium-server-standalone.jar > /dev/null &` && `sleep 5`

