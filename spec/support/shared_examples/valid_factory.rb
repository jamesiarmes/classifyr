# frozen_string_literal: true

RSpec.shared_examples 'valid factory' do |model, trait: nil|
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(model, trait)).to be_valid
    end
  end
end
