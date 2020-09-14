class ParticipantsController < ApplicationController
    before_action :set_participant, only: [:show, :edit, :update, :destroy]
    def index
        @participant = Participant.all
    end
    def new
        @participant = Participant.new
    end
    def show 
    end
    def create
        @participant = Participant.new(participant_params)
        
        if @participant.save
            redirect_to participants_path(@participant)
        else render 'new'
        end
    end
    def edit
    end
    def update
        if @participant.update(participant_params)
            redirect_to participants_path(@participant) 
        else
            render 'edit'
        end
    end
    def destroy
        if @participant.present?
          @participant.destroy
        end
        redirect_to participants_path 
    end
    private 
        def participant_params
            params.require(:participant).permit(:name, :email, :participanttype, :resume) 
        end
        def set_participant
            @participant = Participant.find(params[:id])
        end
    end
