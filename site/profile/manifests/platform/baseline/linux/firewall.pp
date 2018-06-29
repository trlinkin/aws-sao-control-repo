class profile::platform::baseline::linux::firewall (
  $purge = false,
) {

  Firewall {
    before  => Class['profile::platform::baseline::linux::firewall_post'],
    require => Class['profile::platform::baseline::linux::firewall_pre'],
  }

  File[['/etc/sysconfig/ip6tables','/etc/sysconfig/iptables']] ->
  Firewall <||> ->
  Service[['iptables','ip6tables']]

  class { ['::profile::platform::baseline::linux::firewall_pre', '::profile::platform::baseline::linux::firewall_post']: }

  resources { 'firewall':
    purge => $purge,
  }

  include ::firewall

}
