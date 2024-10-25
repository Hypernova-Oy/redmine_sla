class CreateSlaCaches < ActiveRecord::Migration[5.2]

  def change

    reversible do |dir|
    
      dir.up do    

        create_table :sla_caches, id: false do |t|
          t.bigint :id, :null => false
          t.belongs_to :project, type: :integer, :null => false, foreign_key: { name: 'sla_caches_projects_fkey', on_delete: :cascade }
          t.belongs_to :issue, type: :integer, :null => false, foreign_key: { name: 'sla_caches_issues_fkey', on_delete: :cascade }
          t.belongs_to :tracker, type: :integer, :null => false, foreign_key: { name: 'sla_caches_trackers_fkey', on_delete: :cascade }
          t.belongs_to :sla_level, type: :bigint, :null => false, foreign_key: { name: 'sla_caches_sla_levels_fkey', on_delete: :cascade }
          t.datetime :start_date, :null => false
          t.datetime :created_on, :null => false, default: -> { 'CURRENT_TIMESTAMP' }
          t.datetime :updated_on, :null => false, default: -> { 'CURRENT_TIMESTAMP' }
        end
        say "Created table sla_caches"

        execute "ALTER TABLE sla_caches ADD PRIMARY KEY (id) ; "

        add_index :sla_caches, [:project_id], :unique => false, name: 'sla_caches_projects_key'
        say "Created index on table sla_caches"        

        add_index :sla_caches, [:issue_id], :unique => true, name: 'sla_caches_issues_ukey'
        say "Created unique index on table sla_caches"
      end

      dir.down do
      
        drop_table :sla_caches
        say "Dropped table sla_caches"     
        
      end

    end

  end

end
