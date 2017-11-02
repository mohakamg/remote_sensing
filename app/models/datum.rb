class Datum < ApplicationRecord
  belongs_to :organization
  belongs_to :sensor

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      columns = %w(organiz_id	sens_id	value	unit	date_upload)
      csv << columns
      all.each do |d|
        csv << d.attributes.values_at(*columns)
      end
    end
  end

end
