class Participant < ApplicationRecord
    validates :email, uniqueness: true, presence: true
    validates :participanttype, presence: true
    validates :name, presence: true
end