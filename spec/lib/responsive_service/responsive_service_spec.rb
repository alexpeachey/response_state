require 'spec_helper'

module ResponsiveService
  describe ResponsiveService do
    subject(:service) { ResponsiveService.new(dependencies) }
    let(:dependencies) { { responder_factory: responder_factory } }
    let(:responder_factory) { double :responder_factory, new: nil }
    let(:responder) { double :responder }

    describe '#call' do
      before { responder_factory.stub(:new).with(:unimplemented, "A ResponsiveService should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponsiveService::Responder object.\n").and_return(responder) }
      it 'yields with a responder indicating instructions' do
        expect { |b| service.call(&b) }.to yield_with_args(responder)
      end
    end
  end
end