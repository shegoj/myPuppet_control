filebucket { 'main':
  server => $::servername,
  path   => false,
}

File { backup => 'main' }

Package {
  allow_virtual => true,
}

node 'xmaster.vagrant.vm' {
  include role::puppet::master
}

node 'xagent.vagrant.vm' {
  include role::base
  class { 'brocadevtm':
  rest_user => 'admin',
  rest_pass => 'admin',
  rest_ip   => '10.65.84.114',
}

include brocadevtm::monitors_full_http
}

node default {
  ## Using hiera to classify our nodes
  hiera_include('classes')
}
