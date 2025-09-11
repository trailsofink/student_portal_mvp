class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.integer :respond_id
      t.integer :question_id
      t.string :value

      t.timestamps
    end
  end
end
