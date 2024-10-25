class CreateSlaLevels < ActiveRecord::Migration[5.2]

  def change
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    create_table :sla_levels do |t|
      t.text :name, :null => false, index: { name: 'sla_levels_name_ukey', unique: true }
      t.belongs_to :sla, type: :bigint, foreign_key: { name: 'sla_levels_slas_fkey', on_delete: :cascade }
      t.belongs_to :sla_calendar, type: :bigint, foreign_key: { name: 'sla_levels_sla_calendars_fkey', on_delete: :cascade }
      t.belongs_to :custom_field, type: :integer, :default => nil, :null => true, foreign_key: { name: 'sla_levels_custom_fields_fkey',  on_delete: :cascade } # , to_table: :custom_fields, column: :custom_field_id }
    end
    say "Created table sla_levels"

  end

end
