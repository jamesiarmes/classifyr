# frozen_string_literal: true

# Represents a schema that a data set can be mapped to.
class Schema < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i[slugged history]

  has_paper_trail

  scope :ordered, -> { order(title: :asc) }

  def should_generate_new_friendly_id?
    title_changed? || super
  end
end
