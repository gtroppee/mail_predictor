class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :first_name
      t.string :last_name
      t.string :domain_name
      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
