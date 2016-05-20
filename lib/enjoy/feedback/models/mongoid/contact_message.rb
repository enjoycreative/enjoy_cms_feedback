module Enjoy::Feedback
  module Models
    module Mongoid
      module ContactMessage
        extend ActiveSupport::Concern
        included do
          field :name, type: String
          field :email, type: String
          field :phone, type: String
          field :content, type: String
          Enjoy::Feedback.config.fields.each_pair do |fn, ft|
            next if ft.nil?
            field fn, type: ft
          end
        end
      end
    end
  end
end
