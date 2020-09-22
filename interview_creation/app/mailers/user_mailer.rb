class UserMailer < ApplicationMailer
    before_action :set_interviews, only: [:schedule, :update, :reminder]
    default from: 'notifications@example.com'
    def schedule
        puts mail(to: @interviewee.email, subject: 'Your interview has been scheduled')
        mail(to: @interviewer.email, subject: 'Your interview has been scheduled')
    end
    def update
        mail(to: @interviewee.email, subject: 'Your interview has been updated')
        mail(to: @interviewer.email, subject: 'Your interview has been updated')
    end
    def reminder
        mail(to: @interviewee.email, subject: 'Reminder for the interview')
        mail(to: @interviewer.email, subject: 'Reminder for the interview')
    end
    private
        def set_interviews
            @user = params[:user]
            @interviewee = Participant.find(@user.id1)
            @interviewer = Participant.find(@user.id2)
            @url  = 'http://example.com/login'
        end
end
