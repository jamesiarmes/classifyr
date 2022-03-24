class Field < ApplicationRecord
  belongs_to  :data_set

  TYPES = ['', 'Emergency Type', 'Call Category', 'Detailed Call Type', 'Call Time'].sort #, 'Call Origin', 'Disposition', 'Geolocation']
  #FORMATS = ['', 'Lookup', 'Date', 'Time', 'Address', 'Geolocation', 'Text']
end
