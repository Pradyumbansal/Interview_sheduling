class InterviewsController < ApplicationController
    before_action :set_participant, only: [:show, :edit, :update, :destroy]
    def index
        @interview = Interview.all
    end
    def show 
        
    end
    def new
        @interview = Interview.new 
        @participant1 = Participant.where(participanttype: 'Interviewee')
        @participant2 = Participant.where(participanttype: 'Interviewer')
    end
    def create
        @participant1 = Participant.where(participanttype: 'Interviewee')
        @participant2 = Participant.where(participanttype: 'Interviewer')
        @interview = Interview.new(interview_params)
        if @interview.save
            UserMailer.with(user: @interview).welcome_email.deliver_later
            UserMailer.with(user: @interview).reminder.deliver_later!(wait_untill: @interview.st_time - 5.hours - 1.minutes)
            redirect_to interview_path(@interview)
        else 
        render 'new'
        end
    end
    def edit
        @participant1 = Participant.where(participanttype: 'Interviewee')
        @participant2 = Participant.where(participanttype: 'Interviewer')
    end

    def update
        @participant1 = Participant.where(participanttype: 'Interviewee')
        @participant2 = Participant.where(participanttype: 'Interviewer')
        if @interview.update(interview_params)
            redirect_to interview_path(@interview)
        else 
        render 'edit'
        end 
    end
    def destroy
        if @interview.present?
            # MailsJob.perform_later(@interview, "delete")
            @interview.destroy
        end
        redirect_to interviews_path
    end
    private
        def interview_params
            params.require(:interview).permit(:id1, :id2, :st_time, :en_time) 
        end
        def set_participant
            @interview = Interview.find(params[:id])
        end
end
