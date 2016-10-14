exec { "yum update":
	path => "/usr/bin"
}
package { "apache2":
	ensure => present,
	require => Exec["yum update"]
}
service { "apache2":
	ensure => "running",
	require => Package["apache2"]
}
