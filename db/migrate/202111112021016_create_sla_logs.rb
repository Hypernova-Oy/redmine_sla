class CreateSlaLogs < ActiveRecord::Migration[5.2]

  def change

    reversible do |dir|
    
      dir.up do

        create_table :sla_logs do |t|
          t.belongs_to :project, type: :integer, null: true, foreign_key: { name: 'sla_logs_projects_fkey', on_delete: :cascade }
          t.belongs_to :issue, type: :integer, null: true, foreign_key: { name: 'sla_logs_issues_fkey', on_delete: :cascade }
          t.belongs_to :sla_level, type: :bigint, null: true, foreign_key: { name: 'sla_logs_sla_levels_fkey', on_delete: :cascade }
          t.text :log_level, null: false 
          t.text :description, null: false
        end
        say "Created table sla_logs"

      end

      dir.down do

        drop_table :sla_logs
        say "Dropped table sla_logs"

      end 

    end

  end

end
