require 'spec_helper'

module ResponsiveService
  describe ResponsiveService do
    subject(:service) { ResponsiveService.new(dependencies) }
    let(:dependencies) { { response_factory: response_factory } }
    let(:response_factory) { double :response_factory, new: nil }
    let(:response) { double :response }

    describe '#call' do
      before { response_factory.stub(:new).with(:unimplemented, "A ResponsiveService should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponsiveService::Response object.\n").and_return(response) }
      it 'yields with a response indicating instructions' do
        expect { |b| service.call(&b) }.to yield_with_args(response)
      end
    end

    # Deprecated
    describe '#responder_factory' do
      it 'is just a pointer to response_factory' do
        expect(service.responder_factory).to eq service.response_factory
      end
    end
  end
end