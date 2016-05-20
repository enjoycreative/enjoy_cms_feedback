module Enjoy::Feedback
  class Engine < ::Rails::Engine
    # isolate_namespace Enjoy::Feedback

    # rake_tasks do
    #   require File.expand_path('../tasks', __FILE__)
    # end

    initializer "enjoy_cms_feedback.email_defaults" do
      # Write default email settings to DB so they can be changed.

      #temp
      begin
        if Settings and Settings.table_exists?
          Settings.default_email_from(default: 'noreply@site.domain')
          Settings.form_email(default: 'admin@site.domain')
          Settings.email_topic(default: 'с сайта')
        end
      rescue
      end
    end

    config.after_initialize do
      # Write default email settings to DB so they can be changed.
      if Settings and Settings.table_exists?
        Settings.default_email_from(default: 'noreply@site.domain')
        Settings.form_email(default: 'admin@site.domain')
        Settings.email_topic(default: 'с сайта')
      end
    end
  end
end
