require 'spec_helper'
require 'ostruct'

module ResponseState
  describe Service do
    subject(:service) { Service.new }
    before { Response.instance_variable_set :@class_valid_states, nil }

    describe '.call' do
      it 'news up an instance and passes the block on to #call' do
        expect { |b| Service.(&b) }.to yield_control
      end
    end

    describe '#call' do
      let(:yielded) { OpenStruct.new(response: nil) }
      let(:response) { yielded.response }
      before { service.call { |response| yielded.response = response} }

      it 'yields an unimplemented response' do
        expect(response.state).to eq :unimplemented
      end

      it 'yields with a response indicating instructions' do
        expect(response.message).to eq "A ResponseState::Service should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponseState::Response object.\n"
      end
    end
  end
end