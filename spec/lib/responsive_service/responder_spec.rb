require 'spec_helper'

module ResponsiveService
  describe Responder do
    subject(:responder) { Responder.new(type) }
    let(:type) { :success }

    it 'yields when sent :success with a type of :success' do
      expect { |b| responder.success(&b) }.to yield_control
    end

    it 'does not yield when sent :failure with a type of :success' do
      expect { |b| responder.failure(&b) }.to_not yield_control
    end

    context 'when initialized with a message' do
      subject(:responder) { Responder.new(type, message) }
      let(:message) { double(:message) }

      specify { expect(responder.message).to eq message }

      context 'when additionally initialized with a context' do
        subject(:responder) { Responder.new(type, message, context) }
        let(:context) { double(:context) }

        specify { expect(responder.context).to eq context }
      end
    end
  end
end