# name 'mides_setup'
# version: '0.0.1'
# author 'Javier Alvarez - jalvarezsamayoa@gmail.com'
# summary 'Configuracion base para servidor api.mides.gob.gt'
# license 'GPL3'
# dependency 'opengobgt/puppet-rvm'

Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}


#-------------------------------------
# RVM, Ruby, Gems
#-------------------------------------

include rvm
rvm::system_user { api: ;}

$ruby_version = 'ruby-2.0.0-p247'

rvm_system_ruby {
  $ruby_version:
ensure => 'present',
  default_use => true;
}


rvm_gem {
  'bundler':
  name => 'bundler',
  ruby_version => $ruby_version,
ensure => latest,
  require => Rvm_system_ruby[$ruby_version];
}


#------------------------------------
# Herramientas de Sistema
#------------------------------------

package { ['tmux', 
           'tree', 
           'htop', 
           'tig', 
           'imagemagick',
           'libsqlite3-ruby',
           'libpgsql-ruby',
           'graphicsmagick-libmagick-dev-compat',
           'libmagickwand-dev',
           'openjdk-7-jre',
           'openjdk-7-jdk',
	   'libicu48',
	   'build-dep',
	   'libqt4-gui',
	   'libqt4-network',
	   'libqt4-webkit',
	   'xorg',
	   'git-doc'.9.9-static-i386.tar.bz2

          ]:
ensure => latest,
}

#------------------------------------
# Postgresql
#------------------------------------

package {'libpq-dev':
ensure => latest
}


# Apache Fussion Passenger

group {"rvm":
ensure => present,
}
user {"openwolf":
ensure => present,
  groups => ["www-data", "rvm"]
}

class {'apache': }

  apache::vhost {'openwolf.transparencia.gob.gt':
    docroot => '/var/www/openwolf.transparencia.gob.gt',
    docroot_owner => 'openwolf',
    docroot_group => 'www-data'
  }




  class {
      'rvm::passenger::apache':
      version => '4.0.21',
      ruby_version => 'ruby-2.0.0-p247',
      mininstances => '3',
      maxinstancesperapp => '0',
      maxpoolsize => '30',
      spawnmethod => 'smart-lv2';
    }

###########################
# Postgresql
###########################


class { 'postgresql::server':
    postgres_password => '123456'
}

postgresql::server::db { 'openwolf_development':
  user     => 'openwolf',
  password => '123456',
}

    #------------------------------------
    # Keyboard Shortcuts
    #------------------------------------

    import 'utils.pp'

    append_if_no_such_line { "bundle-exec-shortcut":
      file => "/home/openwolf/.bashrc",
      line => 'alias be="bundle exec"',
    }

    append_if_no_such_line { "bundle-rspec":
      file => "/home/openwolf/.bashrc",
      line => 'alias br="be rspec"',
    }

    append_if_no_such_line { "bundle-install":
      file => "/home/openwolf/.bashrc",
      line => 'alias bi="bundle install"',
    }

    append_if_no_such_line { "bundle-update":
      file => "/home/openwolf/.bashrc",
      line => 'alias br="bundle update"',
    }

    append_if_no_such_line { "git-status":
      file => "/home/openwolf/.bashrc",
      line => 'alias gst="git status"',
    }
