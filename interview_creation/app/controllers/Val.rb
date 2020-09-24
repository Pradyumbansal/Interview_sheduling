class Val
    def check(params)
        if params[:participant][:participanttype] == nil
            return false
        elsif params[:participant][:participanttype] == 'Interviewee' && params[:participant][:resume] == nil
            return false
        else 
            return true
        end
    end
end