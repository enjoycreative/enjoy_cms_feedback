module Enjoy::Feedback
  class ContactsController < ApplicationController
    include Enjoy::Feedback::Controllers::Contacts

    include Enjoy::Feedback::Decorators::Contacts
  end
end
