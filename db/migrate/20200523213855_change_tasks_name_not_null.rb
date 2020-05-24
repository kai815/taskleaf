class ChangeTasksNameNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :name, false, 0
  end
end
