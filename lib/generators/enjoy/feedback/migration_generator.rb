require 'rails/generators'
require 'rails/generators/active_record'

module Enjoy::Feedback
  class MigrationGenerator < Rails::Generators::Base
    include ActiveRecord::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy Feedback migration generator'
    def install
      if Enjoy::Feedback.active_record?
        %w(contact_messages).each do |table_name|
          migration_template "migration_#{table_name}.rb", "db/migrate/enjoy_feedback_create_#{table_name}.rb"
        end
      end
    end
  end
end
