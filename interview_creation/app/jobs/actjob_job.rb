class ActjobJob < ApplicationJob
  queue_as :default

  def perform(interview, option)
    begin
      if Interview.find(interview.id)
        if (option == 'schedule') 
          UserMailer.with(user: interview).schedule.deliver_now
        end
        if (option == 'reminder')
            UserMail.with(user: interview).reminder.deliver_now
        end
        if (option == 'update')
          UserMailer.with(user: interview).update.deliver_now
        end
      end
    rescue => exception

    end
  end
end
