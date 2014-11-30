require 'generator_spec/test_case'
require 'generators/acts_as_liked/migration_generator'

describe MigrationGenerator, type: :generator do
  include GeneratorSpec::TestCase

  destination File.expand_path("../tmp", File.dirname(__FILE__))

  before :all do
    prepare_destination
    run_generator
  end

  after :all do
    FileUtils.rm_r Dir.glob('tmp/*') # Clean up tmp after test
  end

  # it "creates a migration" do
  # 	assert_file "db/migrate/#{Regexp.new([0-9]*)}_acts_as_likeable_migration.rb"
  # end

  it "creates model" do
    assert_file "app/models/like.rb"
  end

  specify {
  	expect(destination_root).to have_structure { 
  		directory "db" do
  			directory "migrate" do
  				migration "acts_as_liked_migration"
  			end
  		end
  	}
  }
end