# frozen_string_literal: true

require 'pry'
require 'pry-byebug'
require 'diagrams-rb'

Jekyll::Hooks.register :site, :after_init do
  Diagrams::Resources.clean_resources_md('docs')
  Diagrams::Resources.build_resources_md('docs')
end
