class Messaging::ContactsController < Messaging::MessagingController
  def index
    @user = current_user
  end

  # [POST] messaging/contacts/create
  def create 
    
  end
  
end
