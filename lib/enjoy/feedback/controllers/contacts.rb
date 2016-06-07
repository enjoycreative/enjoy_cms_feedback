module Enjoy::Feedback
  module Controllers
    module Contacts
      extend ActiveSupport::Concern

      included do
        if Enjoy::Feedback.config.breadcrumbs_on_rails_support
          add_breadcrumb I18n.t('enjoy.breadcrumbs.contacts'), :enjoy_feedback_contacts_path
        end
      end

      def index
        @contact_message = model.new
        after_initialize
        xhr_checker
      end

      def new
        @contact_message = model.new
        after_initialize
        xhr_checker
      end

      def create
        @contact_message = model.new(message_params)
        after_initialize
        if Enjoy::Feedback.config.captcha
          if Enjoy::Feedback.config.recaptcha_support
            recaptcha_res = verify_recaptcha
            meth = :save
          else
            recaptcha_res = true
            meth = :save_with_captcha
          end
        else
          recaptcha_res = true
          meth = :save
        end
        if recaptcha_res and @contact_message.send(meth)
          after_create
          if request.xhr? && process_ajax
            ajax_success
          else
            redirect_after_done
          end
        else
          render_contacts_error
        end
      end

      def sent
      end

      private
      def render_contacts_error
        if request.xhr? && process_ajax
          render partial: form_partial, status: 422
          # render json: {errors: @contact_message.errors}, status: 422
        else
          flash.now[:alert] = @contact_message.errors.full_messages.join("\n")
          render action: Enjoy::Feedback.configuration.recreate_contact_message_action, status: 422
        end
      end
      def process_ajax
        true
      end
      def ajax_success
        render partial: success_partial
        # render json: {ok: true}
      end
      def redirect_after_done
        redirect_to action: :sent
      end
      def xhr_checker
        if request.xhr?
          render layout: false
        end
      end
      def after_initialize
      end
      def after_create
        # overrideable hook for updating message
      end
      def form_partial
        "enjoy/feedback/contacts/form"
      end
      def success_partial
        "enjoy/feedback/contacts/success"
      end
      def model
        Enjoy::Feedback::ContactMessage
      end
      def message_params
        params.require(model.to_param.gsub("::", "").underscore).permit(
          Enjoy::Feedback.config.fields.keys + [:name, :email, :phone, :content, :captcha, :captcha_key]
        )
      end
    end
  end
end
