# == Class: tomcat::logging
#
# Links logging libraries in tomcat installation directory
#
# This class must not be included directly. It is automatically included
# by the tomcat module.
#
class tomcat::logging {

  $conffile = "puppet:///modules/${module_name}/conf/log4j.rolling.properties"

  $base_path = $::tomcat::version ? {
    '5'     => "${::tomcat::home}/common/lib",
    default => "${::tomcat::home}/lib",
  }

  # The source class need (and define) this directory before logging
  if $::tomcat::sources == false {
    file {$base_path:
      ensure => directory,
    }
  }

  file {'/var/log/tomcat':
    ensure => directory,
    owner  => 'tomcat',
    group  => 'tomcat',
  }

  file {'commons-logging.jar':
    path    => "${base_path}/commons-logging.jar",
    source    => "puppet:///modules/${module_name}/commons-logging.jar",
  }

  file {'log4j.jar':
    path    => "${base_path}/log4j.jar",
    source    => "puppet:///modules/${module_name}/log4j.jar",
  }

  file {'log4j.properties':
    path    => "${base_path}/log4j.properties",
    source  => $conffile,
  }
}
