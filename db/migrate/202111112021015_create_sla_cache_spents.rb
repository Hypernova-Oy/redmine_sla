class CreateSlaCacheSpents < ActiveRecord::Migration[5.2]

  def change

    reversible do |dir|
    
      dir.up do      

        create_table :sla_cache_spents do |t|
          t.belongs_to :sla_cache, type: :bigint, :null => false, foreign_key: { name: 'sla_cache_spents_sla_caches_fkey', on_delete: :cascade }
          t.belongs_to :project, type: :integer, :null => false, foreign_key: { name: 'sla_caches_spents_projects_fkey', on_delete: :cascade }
          t.belongs_to :issue, type: :integer, :null => false, foreign_key: { name: 'sla_cache_spents_issues_fkey', on_delete: :cascade }
          t.belongs_to :sla_type, type: :bigint, :null => false, foreign_key: { name: 'sla_cache_spents_sla_types_fkey', on_delete: :cascade }
          t.integer :spent, :null => false
          t.datetime :created_on, :null => false, default: -> { 'CURRENT_TIMESTAMP' }
          t.datetime :updated_on, :null => false, default: -> { 'CURRENT_TIMESTAMP' }
        end
        say "Created table sla_cache_spents"

        add_index :sla_caches, [:project_id], :unique => false, name: 'sla_cache_spents_projects_key'
        add_index :sla_caches, [:issue_id], :unique => false, name: 'sla_cache_spents_issues_key'
        say "Created index on table sla_cache_spents"
        
        add_index :sla_cache_spents, [:sla_cache_id, :sla_type_id], :unique => true, name: 'sla_cache_spents_sla_caches_sla_types_ukey', \
          comment: "This index is an important constraint for update the sla cache spent on conflict instead insert"
        say "Created unique index on table sla_cache_spents"

      end

      dir.down do
      
        drop_table :sla_cache_spents
        say "Dropped table sla_cache_spent"

      end

    end

  end

end
