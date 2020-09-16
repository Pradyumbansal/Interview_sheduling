class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
 
    def welcome_email
        @user = params[:user]
        @participant = Participant.find(@user.id1)
        @url  = 'http://example.com/login'
        mail(to: @participant.email, subject: 'Welcome to My Awesome Site')
    end
end
