# chef-aem cookbook

A cookbook to install Adobe Experience Manager 5.6.

# Requirements

A valid Adobe ID for authentication needs to be edited in the recipe.

# Attributes #

* `node['aem']['adobe_id']` - Your Adobe ID used to authenticate on daycare website to download AEM.
* `node['aem']['adobe_password']` - Your Adobe password.

# Recipes #

* `default` - Creates a user/group for AEM, downloads the JAR from Adobe website and runs it.

# Author

Author:: Theofilos Papapanagiotou (theofilos@ieee.org)
