require 'spec_helper'
require_relative 'messaging_helpers'
require 'messaging/transition_group'

module Messaging
  describe TransitionGroup do
    describe '#transition_for' do
      it 'follows direct match on text if found' do
        subject = TransitionGroup.new('foo' => 'bar')
        expect(subject.transition_for('text' => 'foo').target_message_id).to eq('bar')
      end

      it 'follows default if text match not found' do
        subject = TransitionGroup.new('foo' => 'bar', 'DEFAULT' => 'lala')
        expect(subject.transition_for('text' => 'moo').target_message_id).to eq('lala')
      end

      it 'follows error' do
        error = TestCommandFailure.new('someerror')
        subject = TransitionGroup.new('foo' => 'bar', 'ERROR:someerror' => 'fromerror')
        expect(subject.transition_for({'text' => 'moo'}, error).target_message_id).to eq('fromerror')
      end
    end
  end
end
