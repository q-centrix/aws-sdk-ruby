# frozen_string_literal: true

require_relative 'aws-sdk-code-generator/api'
require_relative 'aws-sdk-code-generator/apply_docs'
require_relative 'aws-sdk-code-generator/client_constructor'
require_relative 'aws-sdk-code-generator/client_operation_documentation'
require_relative 'aws-sdk-code-generator/client_operation_list'
require_relative 'aws-sdk-code-generator/client_response_structure_example'
require_relative 'aws-sdk-code-generator/crosslink'
require_relative 'aws-sdk-code-generator/docstring'
require_relative 'aws-sdk-code-generator/hash_formatter'
require_relative 'aws-sdk-code-generator/helper'
require_relative 'aws-sdk-code-generator/plugin_list'
require_relative 'aws-sdk-code-generator/resource_action'
require_relative 'aws-sdk-code-generator/resource_action_code'
require_relative 'aws-sdk-code-generator/resource_association'
require_relative 'aws-sdk-code-generator/resource_attribute'
require_relative 'aws-sdk-code-generator/resource_batch_action'
require_relative 'aws-sdk-code-generator/resource_batch_action_code'
require_relative 'aws-sdk-code-generator/resource_batch_action_documentation'
require_relative 'aws-sdk-code-generator/resource_batch_builder'
require_relative 'aws-sdk-code-generator/resource_builder'
require_relative 'aws-sdk-code-generator/resource_client_request'
require_relative 'aws-sdk-code-generator/resource_client_request_documentation'
require_relative 'aws-sdk-code-generator/resource_client_request_params'
require_relative 'aws-sdk-code-generator/resource_data_method'
require_relative 'aws-sdk-code-generator/resource_has_association'
require_relative 'aws-sdk-code-generator/resource_has_many_association'
require_relative 'aws-sdk-code-generator/resource_has_many_association_code'
require_relative 'aws-sdk-code-generator/resource_identifier'
require_relative 'aws-sdk-code-generator/resource_identifiers_method'
require_relative 'aws-sdk-code-generator/resource_load_method'
require_relative 'aws-sdk-code-generator/resource_method'
require_relative 'aws-sdk-code-generator/resource_skip_params'
require_relative 'aws-sdk-code-generator/resource_value_source'
require_relative 'aws-sdk-code-generator/resource_waiter'
require_relative 'aws-sdk-code-generator/service'
require_relative 'aws-sdk-code-generator/shared_example'
require_relative 'aws-sdk-code-generator/syntax_example'
require_relative 'aws-sdk-code-generator/syntax_example_hash'
require_relative 'aws-sdk-code-generator/underscore'
require_relative 'aws-sdk-code-generator/view'
require_relative 'aws-sdk-code-generator/views/client_api_module'
require_relative 'aws-sdk-code-generator/views/client_class'
require_relative 'aws-sdk-code-generator/views/docstring'
require_relative 'aws-sdk-code-generator/views/errors_module'
require_relative 'aws-sdk-code-generator/views/features/env'
require_relative 'aws-sdk-code-generator/views/features/step_definitions'
require_relative 'aws-sdk-code-generator/views/gemspec'
require_relative 'aws-sdk-code-generator/views/resource_class'
require_relative 'aws-sdk-code-generator/views/root_resource_class'
require_relative 'aws-sdk-code-generator/views/service_module'
require_relative 'aws-sdk-code-generator/views/spec/spec_helper'
require_relative 'aws-sdk-code-generator/views/types_module'
require_relative 'aws-sdk-code-generator/views/authorizer_class'
require_relative 'aws-sdk-code-generator/views/apig_endpoint_class'
require_relative 'aws-sdk-code-generator/views/apig_readme'
require_relative 'aws-sdk-code-generator/views/version'
require_relative 'aws-sdk-code-generator/views/waiters_module'
require_relative 'aws-sdk-code-generator/waiter'
require_relative 'aws-sdk-code-generator/yard_option_tag'

# Public interfaces
require_relative 'aws-sdk-code-generator/code_builder'
require_relative 'aws-sdk-code-generator/gem_builder'

module AwsSdkCodeGenerator

  GENERATED_SRC_WARNING = <<-WARNING_TXT
# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/master/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE
  WARNING_TXT

end
