name             'chef-aem'
maintainer       'Theofilos Papapanagiotou'
maintainer_email 'theofilos@ieee.org'
license          'Apache License, Version 2.0'
description      'Installs/Configures Adobe Experience Manager'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.6'

depends "apt"
depends "java"
