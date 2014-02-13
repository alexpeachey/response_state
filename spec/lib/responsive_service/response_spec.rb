require 'spec_helper'

module ResponsiveService
  describe Response do
    subject(:response) { Response.new(type) }
    let(:type) { :success }
    before { Response.instance_variable_set :@class_valid_states, nil }

    it 'yields when sent :success with a type of :success' do
      expect { |b| response.success(&b) }.to yield_control
    end

    it 'does not yield when sent :failure with a type of :success' do
      expect { |b| response.failure(&b) }.not_to yield_control
    end

    context 'when initialized with a message' do
      subject(:response) { Response.new(type, message) }
      let(:message) { double(:message) }

      specify { expect(response.message).to eq message }

      context 'when additionally initialized with a context' do
        subject(:response) { Response.new(type, message, context) }
        let(:context) { double(:context) }

        specify { expect(response.context).to eq context }

        context 'when additionally initiaized with a set of valid states' do
          subject(:response) { Response.new(type, message, context, valid_states) }
          let(:valid_states) { [:success, :failure] }

          it 'yields when sent :success with a type of :success' do
            expect { |b| response.success(&b) }.to yield_control
          end

          it 'does not yield when sent :failure with a type of :success' do
            expect { |b| response.failure(&b) }.not_to yield_control
          end

          it 'throws method missing exception if sent a non-valid state' do
            expect { |b| response.foo(&b) }.to raise_exception
          end

          it 'reflects the valid_states' do
            expect(response.valid_states).to eq [:success, :failure]
          end

          context 'when initialized with an invalid type' do
            let(:type) { :foo }
            
            it 'raises an exception' do
              expect { response }.to raise_exception('Invalid type of response: foo')
            end
          end
        end
      end
    end

    context 'backwards compatibility' do
      it 'sets Responder as an alias for Response' do
        expect(Responder).to eq Response
      end
    end

    describe '.valid_states' do
      context 'when set to an array of states' do
        before { Response.valid_states(:success, :failure) }

        context 'when the response type is :success' do
          subject(:response) { Response.new(:success) }

          it 'yields when sent :success' do
            expect { |b| response.success(&b) }.to yield_control
          end

          it 'does not yield when sent :failure' do
            expect { |b| response.failure(&b) }.not_to yield_control
          end

          it 'throws method missing exception if sent a non-valid state' do
            expect { |b| response.foo(&b) }.to raise_exception
          end
        end

        context 'when initialized with an invalid type' do
          subject(:response) { Response.new(:foo) }
          
          it 'raises an exception' do
            expect { response }.to raise_exception('Invalid type of response: foo')
          end
        end

        describe '#valid_states' do
          subject(:response) { Response.new(:success) }

          it 'reflects the valid_states' do
            expect(response.valid_states).to eq [:success, :failure]
          end
        end
      end
    end
  end
end