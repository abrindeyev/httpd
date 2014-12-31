class Chef
  class Resource
    class HttpdService < Chef::Resource::LWRPBase
      self.resource_name = :httpd_service
      actions :create, :delete, :start, :stop, :restart, :reload
      default_action :create

      attribute :contact, kind_of: String, default: 'webmaster@localhost'
      attribute :hostname_lookups, kind_of: String, default: 'off'
      attribute :instance, kind_of: String, name_attribute: true
      attribute :keepalive, kind_of: [TrueClass, FalseClass], default: true
      attribute :keepalivetimeout, kind_of: String, default: '5'
      attribute :listen_addresses, kind_of: String, default: ['0.0.0.0']
      attribute :listen_ports, kind_of: [String, Array], default: %w(80)
      attribute :log_level, kind_of: String, default: 'warn'
      attribute :maxclients, kind_of: String, default: nil
      attribute :maxconnectionsperchild, kind_of: String, default: nil
      attribute :maxkeepaliverequests, kind_of: String, default: '100'
      attribute :maxrequestsperchild, kind_of: String, default: nil
      attribute :maxrequestworkers, kind_of: String, default: nil
      attribute :maxspareservers, kind_of: String, default: nil
      attribute :maxsparethreads, kind_of: String, default: nil
      attribute :minspareservers, kind_of: String, default: nil
      attribute :minsparethreads, kind_of: String, default: nil
      attribute :modules, kind_of: Array, default: nil
      attribute :mpm, kind_of: String, default: nil
      attribute :package_name, kind_of: String, default: nil
      attribute :run_group, kind_of: String, default: nil
      attribute :run_user, kind_of: String, default: nil
      attribute :servername, kind_of: String, default: nil
      attribute :startservers, kind_of: String, default: nil
      attribute :threadlimit, kind_of: String, default: nil
      attribute :threadsperchild, kind_of: String, default: nil
      attribute :timeout, kind_of: String, default: '400'
      attribute :version, kind_of: String, default: nil

      include HttpdCookbook::Helpers

      def parsed_maxclients
        return maxclients if maxclients
        default_value_for(parsed_version, parsed_mpm, :maxclients)
      end

      def parsed_maxconnectionsperchild
        return maxconnectionsperchild if maxconnectionsperchild
        default_value_for(parsed_version, parsed_mpm, :maxconnectionsperchild)
      end

      def parsed_maxrequestsperchild
        return maxrequestsperchild if maxrequestsperchild
        default_value_for(parsed_version, parsed_mpm, :maxrequestsperchild)
      end

      def parsed_maxrequestworkers
        return maxrequestworkers if maxrequestworkers
        default_value_for(parsed_version, parsed_mpm, :maxrequestworkers)
      end

      def parsed_maxspareservers
        return maxspareservers if maxspareservers
        default_value_for(parsed_version, parsed_mpm, :maxspareservers)
      end

      def parsed_maxsparethreads
        return maxsparethreads if maxsparethreads
        default_value_for(parsed_version, parsed_mpm, :maxsparethreads)
      end

      def parsed_minspareservers
        return minspareservers if minspareservers
        default_value_for(parsed_version, parsed_mpm, :minspareservers)
      end

      def parsed_minsparethreads
        return minsparethreads if minsparethreads
        default_value_for(parsed_version, parsed_mpm, :minsparethreads)
      end

      def parsed_modules
        return modules if modules
        return %w(
          alias autoindex dir
          env mime negotiation
          setenvif status auth_basic
          deflate authz_default
          authz_user authz_groupfile
          authn_file authz_host
          reqtimeout
        ) if parsed_version == '2.2'

        return %w(
          authz_core authz_host authn_core
          auth_basic access_compat authn_file
          authz_user alias dir autoindex
          env mime negotiation setenvif
          filter deflate status
        ) if parsed_version == '2.4'
      end

      def parsed_mpm
        return mpm if mpm
        parsed_version == '2.4' ? 'event' : 'worker'
      end

      def parsed_package_name
        return package_name if package_name
        package_name_for_service(
          node['platform'],
          node['platform_family'],
          node['platform_version'],
          parsed_version
          )
      end

      def parsed_run_group
        return run_group if run_group
        node['platform_family'] == 'debian' ? 'www-data' : 'apache'
      end

      def parsed_run_user
        return run_user if run_user
        node['platform_family'] == 'debian' ? 'www-data' : 'apache'
      end

      def parsed_servername
        return servername if servername
        node['hostname']
      end

      def parsed_startservers
        return startservers if startservers
        default_value_for(parsed_version, parsed_mpm, :startservers)
      end

      def parsed_threadlimit
        return threadlimit if threadlimit
        default_value_for(parsed_version, parsed_mpm, :threadlimit)
      end

      def parsed_threadsperchild
        return threadsperchild if threadsperchild
        default_value_for(parsed_version, parsed_mpm, :threadsperchild)
      end

      def parsed_version
        return version if version
        return '2.2' if node['platform_family'] == 'debian' && node['platform_version'] == '10.04'
        return '2.2' if node['platform_family'] == 'debian' && node['platform_version'] == '12.04'
        return '2.2' if node['platform_family'] == 'debian' && node['platform_version'] == '13.04'
        return '2.2' if node['platform_family'] == 'debian' && node['platform_version'] == '13.10'
        return '2.2' if node['platform_family'] == 'debian' && node['platform_version'].to_i == 6
        return '2.2' if node['platform_family'] == 'debian' && node['platform_version'].to_i == 7
        return '2.2' if node['platform_family'] == 'freebsd'
        return '2.2' if node['platform_family'] == 'omnios'
        return '2.2' if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 5
        return '2.2' if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 6
        return '2.2' if node['platform_family'] == 'suse'
        return '2.4' if node['platform_family'] == 'debian' && node['platform_version'] == '14.04'
        return '2.4' if node['platform_family'] == 'debian' && node['platform_version'] == '14.10'
        return '2.4' if node['platform_family'] == 'debian' && node['platform_version'] == 'jessie/sid'
        return '2.4' if node['platform_family'] == 'fedora'
        return '2.4' if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 2013
        return '2.4' if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 2014
        return '2.4' if node['platform_family'] == 'rhel' && node['platform_version'].to_i == 7
        return '2.4' if node['platform_family'] == 'smartos'
      end
    end
  end
end
