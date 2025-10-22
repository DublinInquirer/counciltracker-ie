class AddCouncilToMeetings < ActiveRecord::Migration[6.1]
  def change
    add_column :meetings, :council, :string
    add_index :meetings, :council
  end
end
