# frozen_string_literal: true

RSpec.shared_examples 'associations' do |model, associations, trait: nil|
  describe 'associations' do
    it 'has the given associations' do
      associations.each do |association|
        expect(build(model, trait)).to respond_to(association)
      end
    end
  end
end
