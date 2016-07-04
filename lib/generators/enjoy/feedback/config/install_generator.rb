require 'rails/generators'

module Enjoy::Feedback
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy::Feedback Config generator'
    def config
      template 'enjoy_feedback.erb', "config/initializers/enjoy_feedback.rb"
    end

  end
end
