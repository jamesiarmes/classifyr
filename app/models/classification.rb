class Classification < ApplicationRecord
  CALL_TYPE = 'Detailed Call Type'

  belongs_to  :common_incident_type

  def self.pick(type = Classification::CALL_TYPE)
    Field.where(common_type: type).order(Arel.sql('RANDOM()')).first.unique_values.order(Arel.sql('RANDOM()')).first
  end
end
