class ChangeLongTermToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :cross_checks, :client_is_long_term, <<~SQL
      integer USING CASE
        WHEN true THEN 0
        WHEN false THEN 1
        ELSE 2
      END
    SQL
  end
end
