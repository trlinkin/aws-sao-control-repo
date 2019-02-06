 

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

 

file { 'c:\\inetpub\\wwwroot\\famis':

  ensure => 'directory'

}

 

file { 'c:\\inetpub\\wwwroot\\famis\\portal':

  ensure => 'directory'

}

 

file { 'c:\\inetpub\\wwwroot\\famis\\control-panel':

  ensure => 'directory'

}

 

iis_application_pool { 'famis':

      ensure                  => 'present',

      state                   => 'started',

      managed_pipeline_mode   => 'Integrated',

      managed_runtime_version => 'v4.0',

      start_mode              => 'OnDemand',

      identity_type           => 'SpecificUser',

      user_name               => 'finance360.net\service.devcontent',

      password                => 'password',

 

}

 

 

 

 

iis_application { 'Default Web Site\famis/portal':

  ensure             => 'present',

  applicationpool    => 'famis',

  authenticationinfo => {

  'iisClientCertificateMapping' => false,

  'clientCertificateMapping' => false,

  'anonymous' => true,

  'basic' => false,

  'windows' => false

},

  enabledprotocols   => 'http',

  physicalpath       => 'C:\inetpub\wwwroot\famis\portal',

  sitename           => 'Default Web Site',

}

 

 

iis_application { 'Default Web Site\famis/control-panel':

  ensure             => 'present',

  applicationpool    => 'famis',

  authenticationinfo => {

  'iisClientCertificateMapping' => false,

  'clientCertificateMapping' => false,

  'anonymous' => true,

  'basic' => false,

  'windows' => false

},

  enabledprotocols   => 'http',

  physicalpath       => 'C:\inetpub\wwwroot\famis\control-panel',

  sitename           => 'Default Web Site',

}

 

iis_virtual_directory { 'portal':

     ensure                  => 'present',

     sitename                => 'Default Web Site\famis',

     physicalpath            => 'c:\\inetpub\\wwwroot\\famis\\portal',

     user_name               => 'finance360.net\service.devcontent',

     password                => 'password',

     require      => Iis_Application['Default Web Site\famis/portal'],

    }

 

 

}
