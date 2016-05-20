Enjoy.rails_admin_configure do |config|
  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Enjoy::Feedback::ContactMessage'
    config.action_visible_for :model_comments, 'Enjoy::Feedback::ContactMessage'
  end
end

Enjoy.configure do |config|
  config.ability_manager_config ||= []
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::Feedback::ContactMessage,
    actions: [:read]
  }

  config.ability_admin_config ||= []
  config.ability_admin_config << {
    method: :can,
    model: Enjoy::Feedback::ContactMessage,
    actions: :manage
  }
end
