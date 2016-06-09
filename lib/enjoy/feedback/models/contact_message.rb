module Enjoy::Feedback
  module Models
    module ContactMessage
      extend ActiveSupport::Concern
      include Enjoy::Model

      include Enjoy::Feedback.orm_specific('ContactMessage')

      included do
        if Enjoy::Feedback.config.simple_captcha_support
          include SimpleCaptcha::ModelHelpers
          apply_simple_captcha message: Enjoy::Feedback.configuration.captcha_error_message
        end

        validates_email_format_of :email, unless: 'email.blank?'
        if Enjoy::Feedback.config.message_required
          validates_presence_of :content
        end
        validate do
          if email.blank? && phone.blank?
            errors.add(:email, Enjoy::Feedback.configuration.no_contact_info_error_message)
          end
        end

        after_create do
          mailer_class.send(mailer_method, self).deliver if send_emails?
        end
      end

      def send_emails?
        true
      end

      def mailer_class
        Enjoy::Feedback::ContactMailer
      end

      def mailer_method
        :new_message_email
      end
    end
  end
end
