require 'rails/generators'
require 'rails/generators/migration'

class MigrationGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/acts_as_liked_migration.rb'
  end

  def create_model
    template 'model.rb', File.join('app/models', 'like.rb')
  end

end