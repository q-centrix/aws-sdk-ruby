# frozen_string_literal: true

require 'json'

module BuildTools
  class ServiceEnumerator

    include Enumerable

    MANIFEST_PATH = File.expand_path('../../services.json', __FILE__)

    # @option options [String] :manifest_path (MANIFEST_PATH)
    def initialize(options = {})
      @manifest_path = options.fetch(:manifest_path, MANIFEST_PATH)
    end

    # @param [String] identifier
    def [](identifier)
      if services.key?(identifier)
        services[identifier]
      else
        raise ArgumentError, "unknown service #{identifier.inspect}"
      end
    end
    alias service []

    def each(&block)
      services.values.each(&block)
    end

    private

    def services
      # WARNING: not thread-safe
      @services ||= begin
        manifest.inject({}) do |hash, (name, config)|
          service = build_service(name, config)
          hash[service.identifier] = service
          hash
        end
      end
    end

    def manifest
      JSON.load(File.read(@manifest_path))
    end

    def build_service(svc_name, config)
      api = load_api(svc_name, config['models'])
      AwsSdkCodeGenerator::Service.new(
        name: svc_name,
        gem_version: gem_version(config['gemName'] || "aws-sdk-#{svc_name.downcase}"),
        gem_name: config['gemName'],
        endpoints_key: config.fetch('partitionsKey', api['metadata']['endpointPrefix']),
        api: api,
        docs: load_docs(svc_name, config['models']),
        paginators: model_path('paginators-1.json', config['models']),
        waiters: model_path('waiters-2.json', config['models']),
        resources: model_path('resources-1.json', config['models']),
        examples: model_path('examples-1.json', config['models']),
        gem_dependencies: gem_dependencies(api, config['dependencies'] || {}),
        add_plugins: add_plugins(config['addPlugins'] || []),
        remove_plugins: config['removePlugins'] || []
      )
    end

    def load_api(svc_name, models_dir)
      api = JSON.load(File.read(model_path('api-2.json', models_dir)))
      BuildTools::Customizations.apply_api_customizations(svc_name, api)
      api
    end

    def load_docs(svc_name, models_dir)
      docs = JSON.load(File.read(model_path('docs-2.json', models_dir)))
      BuildTools::Customizations.apply_doc_customizations(svc_name, docs)
      docs
    end

    def add_plugins(plugins)
      plugins.inject({}) do |hash, plugin|
        hash[plugin] = plugin_path(plugin)
        hash
      end
    end

    def plugin_path(plugin_name)
      parts = plugin_name.split('::')
      parts = parts.map { |part| AwsSdkCodeGenerator::Underscore.underscore(part) }
      parts.shift
      if parts[0] == 'plugins'
        gem = 'core'
      else
        gem = parts.shift.gsub('_', '')
      end

      gems_dir = File.expand_path('../../gems', __FILE__)
      (["#{gems_dir}/aws-sdk-#{gem}/lib/aws-sdk-#{gem}"] + parts).join('/') + '.rb'
    end

    def gem_version(gem_name)
      path = "#{$GEMS_DIR}/#{gem_name}/VERSION"
      if File.exists?(path)
        File.read(path).rstrip
      else
        "1.0.0"
      end
    end

    def gem_dependencies(api, dependencies)
      version_file = File.read("#{$GEMS_DIR}/aws-sdk-core/VERSION").rstrip
      core_version = version_file.match(/^\d+\.\d+\.\d+$/) ?
        "#{version_file.split('.')[0]}" :
        version_file
      dependencies['aws-sdk-core'] = "~> #{core_version}"

      case api['metadata']['signatureVersion']
      when 'v4' then dependencies['aws-sigv4'] = '~> 1.0'
      when 'v2' then dependencies['aws-sigv2'] = '~> 1.0'
      end
      dependencies
    end

    def model_path(model_name, models_dir)
      path = File.expand_path("../../apis/#{models_dir}/#{model_name}", __FILE__)
      File.exists?(path) ? path : nil
    end

  end

  Services = ServiceEnumerator.new

end
