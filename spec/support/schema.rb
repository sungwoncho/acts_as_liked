ActiveRecord::Schema.define do

    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :liker, polymorphic: :true
      
      t.timestamps
    end

    add_index :likes, [:likeable_id, :likeable_type]
    add_index :likes, [:liker_id, :liker_type]

    create_table :likers do |t|
      t.string :name
    end

    create_table :likeables do |t|
      t.string :name
    end

    create_table :non_likers do |t|
      t.string :name
    end

    create_table :non_likeables do |t|
      t.string :name
    end

end