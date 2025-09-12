class RenameRespondIdToResponseIdInAnswers < ActiveRecord::Migration[8.0]
  def change
    rename_column :answers, :respond_id, :response_id
  end
end
