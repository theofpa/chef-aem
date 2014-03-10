# chef-aem cookbook
[![Build Status](https://travis-ci.org/theofpa/chef-aem.png?branch=master)](https://travis-ci.org/theofpa/chef-aem)
[![GitHub version](https://badge.fury.io/gh/theofpa%2Fchef-aem.png)](http://badge.fury.io/gh/theofpa%2Fchef-aem)

A cookbook to install Adobe Experience Manager 5.6.

# Requirements

A valid Adobe ID for authentication needs to be edited in the recipe.

# Attributes #

* `node['java']['jdk_version']=` - The version of Java prefered to use as the JVM of the AEM.
* `node['aem']['adobe_id']` - Your Adobe ID used to authenticate on daycare website to download AEM.
* `node['aem']['adobe_password']` - Your Adobe password.
* `node['aem']['license.customer.name']` - Company name used for the license.
* `node['aem']['license.downloadID']` - The license key.

# Recipes #

* `default` - Creates a user/group for AEM, downloads the JAR from Adobe website and runs it.

# Author

Author:: Theofilos Papapanagiotou (theofilos@ieee.org)
