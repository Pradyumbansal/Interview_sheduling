class ChangeTypeToparticipanttype < ActiveRecord::Migration[5.1]
  def change
    rename_column :participants, :type, :participanttype
  end
end
