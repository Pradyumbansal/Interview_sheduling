class User < ApplicationRecord
    has_attached_file :resume
    validates_attachment_content_type :resume,
        :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :resume_attached?,
        presence: true

    def resume_attached?
        self.resume?
    end
end


