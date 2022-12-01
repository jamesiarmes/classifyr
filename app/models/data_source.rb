# frozen_string_literal: true

# Represents the source of data for a data set.
class DataSource < ApplicationRecord
  has_one :data_set, as: :data_source

  def type_name
    self.class::TYPE_NAME
  end

  def storage_size
    0
  end
end
