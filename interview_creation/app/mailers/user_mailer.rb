class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
 
    def welcome_email
        @user = params[:user]
        @participant = Participant.find(@user.id1)
        @url  = 'http://example.com/login'
        puts "hghg"
        puts mail(to: @participant.email, subject: 'Your interview has been scheduled')
    end
    def delete_email
        @user = params[:user]
        @participant = Participant.find(@user.id1)
        @url  = 'http://example.com/login'
        puts "hghg"
        puts mail(to: @participant.email, subject: 'Your interview has been canceled')
    end
    def reminder
        @user = params[:user]
        @participant = Participant.find(@user.id1)
        @url  = 'http://example.com/login'
        puts "hghg"
        puts mail(to: @participant.email, subject: 'reminder')
    end
end
