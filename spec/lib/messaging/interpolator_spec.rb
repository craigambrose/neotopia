require 'spec_helper'
require 'messaging/interpolator'

module Messaging
  describe Interpolator do
    let(:context) { double('context') }
    subject { Interpolator.new(context) }

    describe '#interpolate' do
      it 'does nothing to a string without handlebars' do
        expect(subject.interpolate('some string')).to eq('some string')
      end

      it 'acts context to replace items withing handlebars' do
        allow(context).to receive(:read_value).with('user.name').and_return('luke')
        allow(context).to receive(:read_value).with('ability').and_return('force')
        input = '{{user.name}}, use the {{ability}}'
        expected = 'luke, use the force'

        expect(subject.interpolate(input)).to eq(expected)
      end
    end
  end
end
