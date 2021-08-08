class Messaging::ContactsController < Messaging::MessagingController
  def index
    @user = current_user
    @contacts = @user.contacts
    respond_to do |format|
      format.html
      format.js { render 'messaging/contacts/list_contacts', locals: { contacts: @contacts } }
    end
  end

  # [GET]  messaging/contacts/new_contact
  def new_contact
  end

  # [POST] messaging/contacts/create
  def create
  end
  
end
