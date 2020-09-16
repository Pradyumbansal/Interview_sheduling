class Participant < ApplicationRecord
    validates :email, uniqueness: true
end