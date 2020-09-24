class ParticipantsController < ApplicationController
    skip_before_action  :verify_authenticity_token 
    before_action :set_participant, only: [:show, :edit, :update, :destroy]
    require 'Val'
    def index
        @participant = Participant.all
        render json: @participant
    end
    def new
        @participant = Participant.new
        @user = User.new
    end
    def show 
        @user = User.find_by user_id: @participant.id
        resume = ""
        if @participant.participanttype == 'Interviewee'
            resume = @user.resume.url
        end
        render json: {participant: @participant, user: @user, Userresume: resume}
    end
    def create
        params[:participant] = params
        @participant = Participant.new(participant_params)
        val = Val.new
        response = val.check(params)
        
        if response && @participant.save
            if (params[:participant][:resume] != nil) 
                params[:participant][:user_id] = @participant.id
                @user = User.new(user_params)
                @user.save
            end 
            # redirect_to participant_path(@participant)
            render json: @participant
        else     
        # render 'new'
        render json: @participant.errors, status: 401
        end
    end
    def edit
        @participant = Participant.find(params[:id])
    end
    def update
        params[:participant] = params
        val = Val.new
        response = val.check(params)
        
        puts params
        
        if response && @participant.update(participant_params)
            @user = User.find_by user_id: @participant.id
            if (params[:participant][:resume] != nil) 
                params[:participant][:user_id] = @participant.id
                @user.update(user_params)
            end 
            render json: @participant
            # redirect_to participant_path(@participant)
        else
            # render 'edit'
            render json: @participant.errors, status: 401
        end
    end
    def destroy
        if @participant.present?
          @user = User.find_by user_id: @participant.id
          @participant.destroy
          if @user.present?
            @user.destroy
          end
          render json: {msg: "sucess"}
        else 
            render json: {msg: "not exist"}
        end
        # redirect_to participants_path 
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
