class ParticipantsController < ApplicationController
    skip_before_action  :verify_authenticity_token 
    before_action :set_participant, only: [:show, :edit, :update, :destroy]
    require 'Val'
    def index
        @participant = Participant.all
        # render json: @participant
    end
    def new
        @participant = Participant.new
        @user = User.new
    end
    def show 
        @user = User.find_by user_id: @participant.id
        render json: {participant: @participant, user: @user}
    end
    def create
        @participant = Participant.new(participant_params)
        val = Val.new
        response = val.check(params)
        if response && @participant.save
            if (params[:participant][:resume] != nil) 
                params[:participant][:user_id] = @participant.id
                @user = User.new(user_params)
                @user.save
            end 
            redirect_to participant_path(@participant)
        
        else     
        render 'new'
        end
    end
    def edit
        @participant = Participant.find(params[:id])
    end
    def update
        val = Val.new
        response = val.check(params)
        if response && @participant.update(participant_params)
            params[:participant][:user_id] = @participant.id
            @user = User.find_by user_id: @participant.id
            if (params[:participant][:resume] != nil) 
                params[:participant][:user_id] = @participant.id
                @user = User.update(user_params)
            end 
            redirect_to participant_path(@participant)
        else
            render 'edit'
        end
    end
    def destroy
        if @participant.present?
          @user = User.find_by user_id: @participant.id
          @participant.destroy
          if @user.present?
            @user.destroy
          end
        end
        redirect_to participants_path 
    end
    private 
        def participant_params
            params.require(:participant).permit(:name, :email, :participanttype) 
        end
        def user_params
            params.require(:participant).permit(:resume, :user_id) 
        end
        def set_participant
            @participant = Participant.find(params[:id])
        end
    end
