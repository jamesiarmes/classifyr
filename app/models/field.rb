class Field < ApplicationRecord
  has_many  :unique_values
  belongs_to  :data_set

  TYPES = ['', 'Emergency Category', 'Call Category', Classification::CALL_TYPE,
           '-----------------', 'Call Identifier','Call Time', 'Call Disposition', 'Priority', 'Dispatched Unit Type',
           '-----------------', 'Geolocation Latitude', 'Geolocation Longitude',
           '-----------------', 'Flag Alcohol Related', 'Flag Domestic Violence', 'Flag Drug Related', 'Flag Mental Health']

    #FORMATS = ['', 'Lookup', 'Date', 'Time', 'Address', 'Geolocation', 'Text']
    #

  VALUE_TYPES = ['Emergency Category', 'Call Category', Classification::CALL_TYPE, 'Call Disposition', 'Priority']

  def self.mapped
    where("common_type IS NOT NULL AND common_type != ''")
  end

  def has_values?
    VALUE_TYPES.include? common_type
  end

  def self.with_values
    where(common_type: VALUE_TYPES)
  end

  def self.without_values
    where.not(common_type: VALUE_TYPES)
  end
end
