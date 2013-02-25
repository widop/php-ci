# PHP CI

## Introduction

This project build a continuous integration server for php.

This server contains [Jenkins](http://jenkins-ci.org/) and [Sonar](http://www.sonarsource.org/) with some usefull plugins :

* [Sonar plugin](http://docs.codehaus.org/pages/viewpage.action?pageId=116359341) for Jenkins
* [Build Breaker plugin](http://docs.codehaus.org/display/SONAR/Build+Breaker+Plugin) for Sonar

## Requirements

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://www.vagrantup.com)

## Installation

Clone the project and add your Vagrantfile.

```
$ git clone git@github.com:widop/php-ci.git
```

Add your custom config in the `Vagrantfile`. See [vagrant doc](http://docs.vagrantup.com/v1/docs/vagrantfile.html)

To create the server execute

```
$ vagrant up
```

Wait for the server to be ready.

Now you have to configure jenkins plugins.

Enjoy.

## Usage

* Sonar : [http://localhost:9001]((http://localhost:9001)
* Jenkins : [(http://localhost:8181](http://localhost:8181)

### Build project

Add a shell script

```
#!/bin/bash

rm -rf .sonar/
cp app/config/parameters.ini.ci app/config/parameters.ini
php bin/vendors install
php app/console doctrine:database:drop --force --env=test
php app/console doctrine:database:create --env=test
php app/console doctrine:schema:update --force --env=test
php app/console widop:fixtures:load --env=test
php app/console cache:clear --env=test
php app/console assetic:dump --env=test
```

### Analyse project

If you want Jenkins to call Sonar at the end of a build you have to add some configuration in your project configuration.

Go to Project > Configure > Sonar and add those propreties.

For example

```
sonar.projectKey=widop:project
sonar.projectName=Project
sonar.projectVersion=develop
sonar.language=php
sonar.sources=src,src2
sonar.phpUnit.configuration=app/phpunit.xml
# sonar.tests=
```

If you want to skip phpDepend analyse because of php54 problem please add sonar.phpDepend.skip=true to your sonar configuration.