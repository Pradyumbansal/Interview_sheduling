class Interview < ApplicationRecord
    validate :cannot_overlap_another_event
    validate :correct_date
end
def correct_date
    if self.st_time > self.en_time
        errors.add(:invalid_date, "start time is greater than end time")
    end
    if self.st_time < Time.now
        errors.add(:Date_does_not_exist, "date is in the past")
    end
end
def cannot_overlap_another_event
        @user = Interview.where(id1: self.id1)
        @user.each do |user|
            st = user.st_time
            en = user.en_time
            if [st, self.st_time].max < [en, self.en_time].min
                errors.add(:Not_possible, "time overlap with interviewee")
            end
        end
        @user = Interview.where(id2: self.id2)
        @user.each do |user|
            st = user.st_time
            en = user.en_time
            if [st, self.st_time].max < [en, self.en_time].min
                errors.add(:cannot_schedule_interview, "time oerlap with interviewer")
            end
        end
  end
