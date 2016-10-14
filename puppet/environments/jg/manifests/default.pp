exec { "yum -y update":
	path => "/usr/bin"
}

package { "httpd":
	ensure => present,
	require => Exec["yum -y update"]
}
service { "httpd":
	ensure => "running",
	require => Package["httpd"]
}
package { "php56w":
	ensure => present
}

package { "php56w-common":
	ensure => present,
	require => Package["php56w"]
}

package { "php56w-mbstring":
	ensure => present,
	require => Package["php56w"]
}

package { "php56w-mysql":
	ensure => present,
	require => [ Package["php56w"], Package["mysql-community-server"] ]
}

package { "php56w-pdo":
	ensure => present,
	require => Package["php56w"]
}

package { "php56w-pear":
	ensure => present,
	require => Package["php56w"]
}

package { "php56w-pecl-imagick":
	ensure => present,
	require => Package["php56w"]
}

package { "php56w-pecl-imagick-devel":
	ensure => present,
	require => Package["php56w"]
}

package { "php56w-pecl-xdebug":
	ensure => present,
	require => Package["php56w"]
}

package { "php56w-opcache":
	ensure => present,
	require => Package["php56w"]
}

package { "php56w-phpdbg":
	ensure => present,
	require => Package["php56w"]
}

package { "mysql-community-server":
	ensure => present
}

package { "vim-common":
	ensure => present
}
