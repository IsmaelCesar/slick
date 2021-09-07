module CustomValidations
  extend ActiveSupport::Concern

  class DifferenceInviteValidator < ActiveModel::Validator
    def validate(record)
      if record.invitee.id == record.inviter.id
        record.errors.add :inviter, 'Cannot be same as user'
      end
    end
  end

  class DifferenceChatValidator < ActiveModel::Validator
    def validate(record)
      if record.user.id == record.contact.id
        record.errors.add :contact, 'Cannot be same as user'
      end
    end
  end

end