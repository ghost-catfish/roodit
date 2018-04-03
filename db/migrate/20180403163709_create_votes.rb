class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :link, foreign_key: true
      t.integer :upvote
      t.integer :downvote

      t.timestamps
    end
  end
end
