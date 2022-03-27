class ClassificationsController < ApplicationController
  def index
    @term = Classification.pick
    @headings = @term.field.data_set.fields.order(:position).pluck(:heading)
    @data = @term.examples
    @common_incident_types = CommonIncidentType.all.order(:code).map do |cit|
      ["#{cit.code}: #{cit.notes || cit.description}", cit.id]
    end.to_h
  end
end
