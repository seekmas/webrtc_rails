class AddCoverToHome < ActiveRecord::Migration
  def self.up
    add_attachment :homes, :cover
  end

  def self.down
    remove_attachment :homes, :cover
  end
end
