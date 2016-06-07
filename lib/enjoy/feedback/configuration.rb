module Enjoy::Feedback
  def self.configuration
    @configuration ||= Configuration.new
  end
  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :captcha
    attr_accessor :fields
    attr_accessor :message_required

    attr_accessor :captcha_error_message
    attr_accessor :no_contact_info_error_message

    attr_accessor :recreate_contact_message_action

    attr_accessor :breadcrumbs_on_rails_support

    attr_accessor :recaptcha_support

    def initialize
      @captcha = false
      @fields = {}
      @message_required = true

      @captcha_error_message = "Код проверки введен неверно"
      @no_contact_info_error_message = "Пожалуйста введите Ваш e-mail или телефон, чтобы мы могли связаться с вами."

      @recreate_contact_message_action = "new"

      @breadcrumbs_on_rails_support = defined?(BreadcrumbsOnRails)

      @recaptcha_support = defined?(Recaptcha)
    end
  end
end
