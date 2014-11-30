ActiveRecord::Schema.define do

    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :liker, polymorphic: :true
      
      t.timestamps
    end

    add_index :likes, [:likeable_id, :likeable_type]
    add_index :likes, [:liker_id, :liker_type]

    create_table :users do |t|
      t.string :name
    end

    create_table :posts do |t|
      t.string :name
    end

end