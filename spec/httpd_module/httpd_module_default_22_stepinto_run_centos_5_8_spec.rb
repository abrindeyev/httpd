require 'spec_helper'

describe 'httpd_module::default' do
  let(:httpd_module_default_22_stepinto_run_centos_5_8) do
    ChefSpec::Runner.new(
      step_into: 'httpd_module',
      platform: 'centos',
      version: '5.8'
      ) do |node|
      node.set['httpd']['version'] = '2.2'
    end.converge('httpd_module::default')
  end

  let(:auth_basic_load_content) do
    'LoadModule auth_basic_module /usr/lib64/httpd/modules/mod_auth_basic.so'
  end

  let(:auth_kerb_load_content) do
    'LoadModule auth_kerb_module /usr/lib64/httpd/modules/mod_auth_kerb.so'
  end

  context 'when using default parameters' do
    it 'creates httpd_module[auth_basic]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to create_httpd_module('auth_basic')
    end

    it 'installs package[(auth_basic :create httpd)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to install_package('(auth_basic :create httpd)').with(
        package_name: 'httpd'
        )
    end

    it 'create directory[(auth_basic :create /etc/httpd-default/conf.d)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to create_directory('(auth_basic :create /etc/httpd-default/conf.d)').with(
        owner: 'root',
        group: 'root',
        recursive: true
        )
    end

    # auth_basic
    it 'create template[(auth_basic :create /etc/httpd-default/conf.d/auth_basic.load)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to create_template('(auth_basic :create /etc/httpd-default/conf.d/auth_basic.load)').with(
        owner: 'root',
        group: 'root',
        source: 'module_load.erb',
        mode: '0644'
        )
    end

    it 'renders file[(auth_basic :create /etc/httpd-default/conf.d/auth_basic.load)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to render_file('(auth_basic :create /etc/httpd-default/conf.d/auth_basic.load)').with_content(
        auth_basic_load_content
        )
    end

    # auth_kerb
    it 'creates httpd_module[auth_kerb]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to create_httpd_module('auth_kerb')
    end

    it 'installs package[(auth_kerb :create mod_auth_kerb)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to install_package('(auth_kerb :create mod_auth_kerb)').with(
        package_name: 'mod_auth_kerb'
        )
    end

    it 'deletes file[(auth_kerb :create /etc/httpd-default/conf.d/auth_kerb.conf)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to_not delete_file('(auth_kerb :create /etc/httpd-default/conf.d/auth_kerb.conf)').with(
        path: '/etc/httpd-default/conf.d/auth_kerb.conf'
        )
    end

    it 'create directory[(auth_kerb :create /etc/httpd-default/conf.d)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to create_directory('(auth_kerb :create /etc/httpd-default/conf.d)').with(
        owner: 'root',
        group: 'root',
        recursive: true
        )
    end

    it 'create template[(auth_kerb :create /etc/httpd-default/conf.d/auth_kerb.load)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to create_template('(auth_kerb :create /etc/httpd-default/conf.d/auth_kerb.load)').with(
        owner: 'root',
        group: 'root',
        source: 'module_load.erb',
        mode: '0644'
        )
    end

    it 'renders file[(auth_kerb :create /etc/httpd-default/conf.d/auth_kerb.load)]' do
      expect(httpd_module_default_22_stepinto_run_centos_5_8).to render_file('(auth_kerb :create /etc/httpd-default/conf.d/auth_kerb.load)').with_content(
        auth_kerb_load_content
        )
    end
  end
end
