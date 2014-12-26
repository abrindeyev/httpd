require 'spec_helper'

describe 'httpd_service::single on ubuntu-12.04' do
  let(:httpd_service_single_22_stepinto_run_ubuntu_12_04) do
    ChefSpec::Runner.new(
      step_into: 'httpd_service',
      platform: 'ubuntu',
      version: '12.04'
      ).converge('httpd_service::single')
  end

  before do
    stub_command('test -f /usr/sbin/a2enmod').and_return(true)
    stub_command('test -f /usr/sbin/a2enmod-instance-1').and_return(true)
    stub_command('test -f /usr/sbin/a2enmod-instance-2').and_return(true)
  end

  context 'when using default parameters' do
    it 'creates httpd_service[default]' do
      expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_httpd_service('default')
        .with(
        parsed_contact: 'webmaster@localhost',
        parsed_hostname_lookups: 'off',
        parsed_keepalive: true,
        parsed_maxkeepaliverequests: '100',
        parsed_keepalivetimeout: '5',
        parsed_listen_addresses: ['0.0.0.0'],
        parsed_listen_ports: %w(80 443),
        parsed_log_level: 'warn',
        parsed_version: '2.2',
        parsed_package_name: 'apache2',
        parsed_run_user: 'www-data',
        parsed_run_group: 'www-data',
        parsed_timeout: '400'
        )
    end
  end

  it 'steps into httpd_service[default] and installs package[default :create apache2]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to install_package('default :create apache2')
      .with(
      package_name: 'apache2'
      )
  end

  it 'steps into httpd_service[default] and does not run bash[default :create remove_package_config]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to_not run_bash('default :create remove_package_config')
      .with(
      user: 'root'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /var/cache/apache2]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /var/cache/apache2')
      .with(
      path: '/var/cache/apache2',
      owner: 'root',
      group: 'root',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /var/log/apache2]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /var/log/apache2')
      .with(
      path: '/var/log/apache2',
      owner: 'root',
      group: 'adm',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /var/run/apache2]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /var/run/apache2')
      .with(
      path: '/var/run/apache2',
      owner: 'root',
      group: 'adm',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /etc/apache2]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /etc/apache2')
      .with(
      path: '/etc/apache2',
      owner: 'root',
      group: 'root',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /etc/apache2/conf.d]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /etc/apache2/conf.d')
      .with(
      path: '/etc/apache2/conf.d',
      owner: 'root',
      group: 'root',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /etc/apache2/mods-available]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /etc/apache2/mods-available')
      .with(
      path: '/etc/apache2/mods-available',
      owner: 'root',
      group: 'root',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /etc/apache2/mods-enabled]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /etc/apache2/mods-enabled')
      .with(
      path: '/etc/apache2/mods-enabled',
      owner: 'root',
      group: 'root',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /etc/apache2/sites-available]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /etc/apache2/sites-available')
      .with(
      path: '/etc/apache2/sites-available',
      owner: 'root',
      group: 'root',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates directory[default :create /etc/apache2/sites-enabled]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_directory('default :create /etc/apache2/sites-enabled')
      .with(
      path: '/etc/apache2/sites-enabled',
      owner: 'root',
      group: 'root',
      mode: '0755'
      )
  end

  it 'steps into httpd_service[default] and creates template[default :create /etc/apache2/envvars]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_template('default :create /etc/apache2/envvars')
      .with(
      path: '/etc/apache2/envvars',
      source: 'envvars.erb',
      owner: 'root',
      group: 'root',
      mode: '0644',
      cookbook: 'httpd'
      )
  end

  it 'steps into httpd_service[default] and creates template[default :create /usr/sbin/a2enmod]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_template('default :create /usr/sbin/a2enmod')
      .with(
      path: '/usr/sbin/a2enmod',
      source: '2.2/scripts/a2enmod.erb',
      owner: 'root',
      group: 'root',
      mode: '0755',
      cookbook: 'httpd'
      )
  end

  it 'steps into httpd_service[default] and creates link[default :create /usr/sbin/a2enmod]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to_not create_link('default :create /usr/sbin/a2enmod')
      .with(
      target_file: '/usr/sbin/a2enmod',
      to: '/usr/sbin/a2enmod',
      owner: 'root',
      group: 'root'
      )
  end

  it 'steps into httpd_service[default] and creates link[default :create /usr/sbin/a2dismod]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_link('default :create /usr/sbin/a2dismod')
      .with(
      target_file: '/usr/sbin/a2dismod',
      to: '/usr/sbin/a2enmod',
      owner: 'root',
      group: 'root'
      )
  end

  it 'steps into httpd_service[default] and creates link[default :create /usr/sbin/a2ensite]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_link('default :create /usr/sbin/a2ensite')
      .with(
      target_file: '/usr/sbin/a2ensite',
      to: '/usr/sbin/a2enmod',
      owner: 'root',
      group: 'root'
      )
  end

  it 'steps into httpd_service[default] and creates link[default :create /usr/sbin/a2dissite]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_link('default :create /usr/sbin/a2dissite')
      .with(
      target_file: '/usr/sbin/a2dissite',
      to: '/usr/sbin/a2enmod',
      owner: 'root',
      group: 'root'
      )
  end

  it 'steps into httpd_service[default] and creates template[default :create /etc/apache2/mime.types]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_template('default :create /etc/apache2/mime.types')
      .with(
      path: '/etc/apache2/mime.types',
      source: 'magic.erb',
      owner: 'root',
      group: 'root',
      mode: '0644',
      cookbook: 'httpd'
      )
  end

  it 'steps into httpd_service[default] and :delete file[default :create /etc/apache2/ports.conf]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to delete_file('default :create /etc/apache2/ports.conf')
      .with(
      path: '/etc/apache2/ports.conf'
      )
  end

  it 'steps into httpd_service[default] and creates template[default :create /etc/init.d/apache2]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_template('default :create /etc/init.d/apache2')
      .with(
      path: '/etc/init.d/apache2',
      source: '2.2/sysvinit/ubuntu-12.04/apache2.erb',
      owner: 'root',
      group: 'root',
      mode: '0755',
      cookbook: 'httpd'
      )
  end

  # begin mpm config section
  it 'steps into httpd_service[default] and installs package[default :create apache2-mpm-worker]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to install_package('default :create apache2-mpm-worker')
      .with(
      package_name: 'apache2-mpm-worker'
      )
  end

  it 'steps into httpd_service[default] and creates httpd_config[default :create mpm_worker]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_httpd_config('default :create mpm_worker')
      .with(
      config_name: 'mpm_worker',
      instance: 'default',
      source: 'mpm.conf.erb',
      cookbook: 'httpd'
      )
  end

  it 'steps into httpd_service[default] and :delete httpd_config[default :create mpm_prefork]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to delete_httpd_config('default :create mpm_prefork')
      .with(
      config_name: 'mpm_prefork',
      instance: 'default'
      )
  end

  it 'steps into httpd_service[default] and :delete httpd_config[default :create mpm_event]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to delete_httpd_config('default :create mpm_event')
      .with(
      config_name: 'mpm_event',
      instance: 'default'
      )
  end

  it 'steps into httpd_service[default] and creates template[default :create /etc/apache2/apache2.conf]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_template('default :create /etc/apache2/apache2.conf')
      .with(
      path: '/etc/apache2/apache2.conf',
      source: 'httpd.conf.erb',
      owner: 'root',
      group: 'root',
      mode: '0644',
      cookbook: 'httpd'
      )
  end

  %w(
    alias autoindex dir
    env mime negotiation
    setenvif status auth_basic
    deflate authz_default
    authz_user authz_groupfile
    authn_file authz_host
    reqtimeout
  ).each do |mod|
    it "steps into httpd_service[default] and creates httpd_module[default :create #{mod}]" do
      expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to create_httpd_module("default :create #{mod}")
        .with(
        module_name: mod,
        instance: 'default',
        httpd_version: '2.2'
        )
    end
  end

  it 'steps into httpd_service[default] and manages service[default :create apache2]' do
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to start_service('default :create apache2')
      .with(
      provider: Chef::Provider::Service::Init::Debian
      )
    expect(httpd_service_single_22_stepinto_run_ubuntu_12_04).to enable_service('default :create apache2')
      .with(
      provider: Chef::Provider::Service::Init::Debian
      )
  end
end
