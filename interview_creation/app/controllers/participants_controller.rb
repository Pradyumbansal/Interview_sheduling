class ParticipantsController < ApplicationController
    before_action :set_participant, only: [:show, :edit, :update, :destroy]
    require 'Val'
    def index
        @participant = Participant.all
    end
    def new
        @participant = Participant.new
        @user = User.new
    end
    def show 
    end
    def create
        @participant = Participant.new(participant_params)
        puts "hhghg"
        val = Val.new
        response = val.check(params)
        puts response
        puts "here"
        puts val
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
        if @participant.update(participant_params)
            params[:participant][:user_id] = @participant.id
            @user = User.find_by user_id: @participant.id
            if (@user != nil) 
                if @user = User.update(user_params)

                    redirect_to participants_path(@participant)
                else render 'edit'
                end
            end  
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
