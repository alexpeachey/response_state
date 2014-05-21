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

    describe '#send_state' do
      context 'given :success, "a message", {}, [:success, :failure]' do
        let(:response) { service.send_state(:success, 'a message', {}, [:success, :failure]) }

        it 'has a success state' do
          expect(response.state).to eq :success
        end

        it 'has the message "a message"' do
          expect(response.message).to eq 'a message'
        end

        it 'has the context {}' do
          expect(response.context).to eq Hash.new
        end

        it 'has valid_states [:success, :failure]' do
          expect(response.valid_states).to eq [:success, :failure]
        end
      end

      context 'given :success, "a message", {}' do
        let(:response) { service.send_state(:success, 'a message', {}) }

        it 'has a success state' do
          expect(response.state).to eq :success
        end

        it 'has the message "a message"' do
          expect(response.message).to eq 'a message'
        end

        it 'has the context {}' do
          expect(response.context).to eq Hash.new
        end

        it 'has valid_states nil' do
          expect(response.valid_states).to eq []
        end
      end

      context 'given :success, "a message"' do
        let(:response) { service.send_state(:success, 'a message') }

        it 'has a success state' do
          expect(response.state).to eq :success
        end

        it 'has the message "a message"' do
          expect(response.message).to eq 'a message'
        end

        it 'has the context nil' do
          expect(response.context).to be_nil
        end

        it 'has valid_states nil' do
          expect(response.valid_states).to eq []
        end
      end

      context 'given :success' do
        let(:response) { service.send_state(:success) }

        it 'has a success state' do
          expect(response.state).to eq :success
        end

        it 'has the message nil' do
          expect(response.message).to be_nil
        end

        it 'has the context nil' do
          expect(response.context).to be_nil
        end

        it 'has valid_states nil' do
          expect(response.valid_states).to eq []
        end
      end
    end
  end
end