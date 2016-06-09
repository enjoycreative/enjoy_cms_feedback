module Enjoy::Feedback
  if Enjoy::Feedback.active_record?
    class ContactMessage < ActiveRecord::Base
    end
  end

  class ContactMessage

    include Enjoy::Feedback::Models::ContactMessage

    include Enjoy::Feedback::Decorators::ContactMessage

    rails_admin(&Enjoy::Feedback::Admin::ContactMessage.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
