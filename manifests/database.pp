define postgresql::database($owner, $ensure=present) {
  $dbexists = "psql -ltA | grep '^$name|'"

  class { "postgresql::user":
    owner  => $owner,
    ensure => $ensure,
  }

  if $ensure == 'present' {

    exec { "createdb $name":
      command => "createdb -O $owner $name",
      user => "postgres",
      unless => $dbexists,
    }


  } elsif $ensure == 'absent' {

    exec { "dropdb $name":
      command => "dropdb $name",
      user => "postgres",
      onlyif => $dbexists,
    }
  }
}
