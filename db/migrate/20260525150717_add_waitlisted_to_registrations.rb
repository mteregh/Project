class AddWaitlistedToRegistrations < ActiveRecord::Migration[8.1]
  def up
    execute <<-SQL
      ALTER TABLE registrations
        DROP CONSTRAINT IF EXISTS check_registrations_status;
    SQL

    execute <<-SQL
      ALTER TABLE registrations
        ADD CONSTRAINT check_registrations_status
        CHECK (status IN ('pending', 'confirmed', 'cancelled', 'waitlisted'));
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE registrations
        DROP CONSTRAINT IF EXISTS check_registrations_status;
    SQL
  end
end
