class InterviewsController < ApplicationController
    before_action :set_participant, only: [:show, :edit, :update, :destroy]
    before_action :set_participants, only: [:new, :create, :edit, :update]
    def index
        @interview = Interview.all
    end
    def show 
    end
    def new
        @interview = Interview.new 
    end
    def create
        @interview = Interview.new(interview_params)
        if @interview.save
            UserMailer.with(user: @interview).schedule.deliver_later
            scheduledtime = @interview.st_time - 5.hours - 30.minutes - 30.minutes
            if (scheduledtime < Time.now)
                scheduledtime = scheduledtime + 30.minutes
            end
            UserMailer.with(user: @interview).reminder.deliver_later!(wait_until: scheduledtime)
            redirect_to interview_path(@interview) 
        else 
        render 'new'
        end
    end
    def edit
    end

    def update
        if @interview.update(interview_params)
            UserMailer.with(user: @interview).update.deliver_later
            redirect_to interview_path(@interview)
        else 
        render 'edit'
        end 
    end
    def destroy
        if @interview.present?
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
        def set_participants
            @participant1 = Participant.where(participanttype: 'Interviewee')
            @participant2 = Participant.where(participanttype: 'Interviewer')
        end
end
