class Field < ApplicationRecord
  has_many  :unique_values
  belongs_to  :data_set

  TYPES = ['', 'Emergency Category', 'Call Category', 'Detailed Call Type',
           '-----------------', 'Call Identifier','Call Time', 'Call Disposition', 'Priority', 'Dispatched Unit Type',
           '-----------------', 'Geolocation Latitude', 'Geolocation Longitude',
           '-----------------', 'Flag Alcohol Related', 'Flag Domestic Violence', 'Flag Drug Related', 'Flag Mental Health']

    #FORMATS = ['', 'Lookup', 'Date', 'Time', 'Address', 'Geolocation', 'Text']
    #

  VALUE_TYPES = ['Emergency Category', 'Call Category', 'Detailed Call Type', 'Call Disposition', 'Priority']

  def self.mapped
    where("common_type IS NOT NULL AND common_type != ''")
  end
end
