# java-crate

Java uncrate cookbook for installing Java 7. This cookbook is a simple wrapper around the main chef [Java cookbook](https://github.com/opscode-cookbooks/java). By default it installs the OpenJDK. 

## Attributes

* `node['java']['oracle']['accept_oracle_download_terms']` - Indicates that you accept Oracle's EULA. This must be set to true if you are installing the Oracle JDK.
* `node['java']['jdk_version']` - JDK version to install, defaults to `'7'`.

## Recipes

* default - Installs the OpenJDK.
* openjdk - Install the OpenJDK.
* oraclejdk - Install the Oracle JDK. Must set the attribute for accepting the Oracle EULA.
