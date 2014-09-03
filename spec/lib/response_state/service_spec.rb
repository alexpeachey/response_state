require 'spec_helper'
require 'ostruct'

module ResponseState
  describe Service do
    subject(:service) { Service.new }
    before do
      Response.instance_variable_set :@class_valid_states, nil
      Service.instance_variable_set :@valid_states, nil
    end

    describe '.call' do
      it 'news up an instance and passes the block on to #call' do
        expect { |b| Service.(&b) }.to raise_error(NotImplementedError, "A ResponseState::Service should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponseState::Response object.\n")
      end
    end

    describe '.response_states' do
      it 'sets the valid response states' do
        Service.response_states :success, :failure
        expect(Service.valid_states).to eq [:success, :failure]
      end
    end

    describe '.valid_states' do
      it 'defaults to []' do
        expect(Service.valid_states).to eq []
      end
    end

    describe '#call' do
      it 'raises an error' do
        expect { service.call }.to raise_error(NotImplementedError, "A ResponseState::Service should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponseState::Response object.\n")
      end
    end

    describe '#send_state' do
      context 'given :success, "a message", {}' do
        let(:response) { service.send_state(:success, 'a message', {}) }
        before { Service.response_states :success, :failure }

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
          expect(response.valid_states).to eq [:success, :failure]
        end
      end

      context 'given :success, "a message"' do
        let(:response) { service.send_state(:success, 'a message') }
        before { Service.response_states :success, :failure }

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
          expect(response.valid_states).to eq [:success, :failure]
        end
      end

      context 'given :success' do
        let(:response) { service.send_state(:success) }
        before { Service.response_states :success, :failure }

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
          expect(response.valid_states).to eq [:success, :failure]
        end
      end
    end
  end
end
