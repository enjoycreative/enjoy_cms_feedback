module ActionDispatch::Routing
  class Mapper

    def enjoy_cms_feedback_routes(config = {})
      routes_config = {
        use_contacts_path: true,
        contacts_path: 'contacts',
        classes: {
          contacts: :contacts
        }
      }
      routes_config.deep_merge!(config)

      generate_enjoy_feedback_user_routes(routes_config)
      generate_enjoy_feedback_cms_routes(routes_config)
    end


    private
    def generate_enjoy_feedback_user_routes(routes_config)
      if !routes_config[:use_contacts_path] and !routes_config[:classes][:contacts].nil?
        get   "#{routes_config[:contacts_path]}"      => "#{routes_config[:classes][:contacts]}#new"
        post  "#{routes_config[:contacts_path]}"      => "#{routes_config[:classes][:contacts]}#create"
        get   "#{routes_config[:contacts_path]}/sent" => "#{routes_config[:classes][:contacts]}#sent"
      end
    end
    def generate_enjoy_feedback_cms_routes(routes_config)
      scope module: 'enjoy' do
        scope module: 'feedback' do
          if routes_config[:use_contacts_path]
            get   "#{routes_config[:contacts_path]}"      => "#{routes_config[:classes][:contacts]}#new",     as: :enjoy_feedback_contacts
            post  "#{routes_config[:contacts_path]}"      => "#{routes_config[:classes][:contacts]}#create",  as: :create_enjoy_feedback_contacts
            get   "#{routes_config[:contacts_path]}/sent" => "#{routes_config[:classes][:contacts]}#sent",    as: :enjoy_feedback_contacts_sent
          end
        end
      end
    end

  end
end
