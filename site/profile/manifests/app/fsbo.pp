class profile::app::fsbo {

  $iis_features = [
    'Web-Server',
    'Web-WebServer',
    'Web-Http-Redirect',
    'Web-Mgmt-Console',
    'Web-Mgmt-Tools',
  ]

iis_feature { $iis_features:
  ensure => 'present',
}

file { 'c:\\inetpub\\wwwroot':
  ensure => 'directory',
}

file { 'c:\\inetpub\\wwwroot\\famis':
  ensure => 'directory',
  require => File['c:\\inetpub\\wwwroot'],
}

file { 'c:\\inetpub\\wwwroot\\famis\\portal':
  ensure => 'directory',
  require => File['c:\\inetpub\\wwwroot\\famis'],
}

#iis_site { 'Default Web Site':
#  ensure          => 'started',
#  physicalpath    => 'c:\\inetpub\\wwwroot',
#  applicationpool => 'DefaultAppPool',
  #preloadenabled => true,
#  require => File['c:\\inetpub\\wwwroot'],
#}


    iis_application_pool { 'famis':
      ensure                  => 'present',
      state                   => 'started',
      managed_pipeline_mode   => 'Integrated',
      managed_runtime_version => 'v4.0',
      start_mode              => 'OnDemand',
      identity_type           => 'SpecificUser',
      user_name               => 'Administrator',
      password                => 'password',
}

iis_virtual_directory { 'famis':
  ensure                  => 'present',
  sitename                => 'Default Web Site',
  physicalpath            => 'c:\\inetpub\\wwwroot\\famis',
  user_name               => 'Administrator',
  password                => 'password',
  require      =>       File['c:\\inetpub\\wwwroot\\famis'],
}

#iis_virtual_directory { 'portal':
#  ensure                  => 'present',
#  sitename                => 'Default Web Site\famis',
#  physicalpath            => 'c:\\inetpub\\wwwroot\\famis\portal',
#  user_name               => 'Administrator',
#  password                => 'password',
#  require      =>       File['c:\\inetpub\\wwwroot\\famis\portal'],
#}

iis_application { 'portal':
  ensure => 'present',
  virtual_directory        => "IIS:\\Sites\\Default Web Site\\famis\\portal",
  #virtual_directory        => 'c:\\inetpub\\wwwroot\\famis\\portal',
  applicationpool          => 'famis',
  #require                  => File['c:\\inetpub\\wwwroot\\famis\\portal'],
  require                   => Iis_Virtual_Directory['portal'],
  enabledprotocols => 'http',
  }

}
