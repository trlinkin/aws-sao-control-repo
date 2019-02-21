class profile::platform::baseline::windows::files {


  require profile::platform::baseline::windows::bootstrap
  
  dsc::lcm_config {'disable_lcm':
    refresh_mode => 'Disabled',
    }

  dsc_file { 'dsc.txt':
      dsc_ensure         => 'present',
      dsc_type            => 'file',
      dsc_contents        => 'This is a file created with dsc',
      dsc_destinationpath => 'C:\Users\vagrant\Desktop\dsc.txt',
      dsc_attributes      => ['ReadOnly'],
      require            => Dsc::Lcm_config['disable_lcm'],
    }
}
