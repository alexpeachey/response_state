require 'spec_helper'

module ResponsiveService
  describe ResponsiveService do
    subject(:service) { ResponsiveService.new }

    describe '#call' do
      it 'yields with a responder indicating instructions' do
        service.call do |response|
          expect(response.type).to eq :unimplemented
          expect(response.message).to eq "A ResponsiveService should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponsiveService::Responder object.\n"
        end
      end
    end
  end
end