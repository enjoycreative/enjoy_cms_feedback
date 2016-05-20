unless defined?(Enjoy) && Enjoy.respond_to?(:orm) && [:active_record, :mongoid].include?(Enjoy.orm)
  puts "please use enjoy_cms_mongoid or enjoy_cms_activerecord"
  puts "also: please use enjoy_cms_news_mongoid or enjoy_cms_news_activerecord and not enjoy_cms_news directly"
  exit 1
end

require "enjoy/feedback/version"

require 'enjoy/feedback/configuration'
require 'enjoy/feedback/engine'
require 'enjoy/feedback/routes'

require 'addressable/uri'
require 'validates_email_format_of'
require 'x-real-ip'

module Enjoy::Feedback
  class << self
    def orm
      Enjoy.orm
    end
    def mongoid?
      Enjoy::Feedback.orm == :mongoid
    end
    def active_record?
      Enjoy::Feedback.orm == :active_record
    end
    def model_namespace
      "Enjoy::Feedback::Models::#{Enjoy::Feedback.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end
  end

  autoload :Admin,  'enjoy/feedback/admin'
  module Admin
    autoload :ContactMessage, 'enjoy/feedback/admin/contact_message'
  end

  module Models
    autoload :ContactMessage, 'enjoy/feedback/models/contact_message'

    module Mongoid
      autoload :ContactMessage, 'enjoy/feedback/models/mongoid/contact_message'
    end
    module ActiveRecord
      autoload :ContactMessage, 'enjoy/feedback/models/active_record/contact_message'
    end
  end

  module Controllers
    autoload :Contacts, 'enjoy/feedback/controllers/contacts'
  end

end
