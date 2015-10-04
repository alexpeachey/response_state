require 'spec_helper'


describe ResponseState do

  context 'without allowed states specified' do

    before do
      def tester param, &block
        result = ResponseState.init(&block)
        param.times { result.success }
      end
    end

    it 'calls the state handler for the given response' do
      called = false
      tester 1 do |result|
        result.success   { called = true }
        result.failure { fail }
      end
      expect(called).to be true
    end

    it 'can call state handlers multiple times' do
      call_count = 0
      tester 3 do |result|
        result.success   { call_count += 1 }
        result.failure { fail }
      end
      expect(call_count).to eq 3
    end

    it 'tolerates not subscribing to some states that are returned' do
      tester 1 do |result|
        result.failure { fail }
      end
    end

    it 'tolerates subscribing to a non-existing state' do
      tester 1 do |result|
        result.zonk { fail }
      end
    end

  end


  context 'with allowed states specified' do

    before do
      def tester param, &block
        result = ResponseState.init(allowed_states: [:success, :failure],
                                    &block)
        param == 1 ? result.success : result.zonk
      end
    end

    it 'allows valid response states' do
      called = false
      tester 1 do |result|
        result.success { called = true }
      end
      expect(called).to be true
    end

    it 'errors when subscribing to invalid response states' do
      expect do
        tester 1 do |result|
          result.non_existing {}
        end
      end.to raise_error "Unknown state: non_existing"
    end

    it 'errors when providing invalid response states' do
      expect do
        tester 2 do |result|
        end
      end.to raise_error "Unknown state: zonk"
    end
  end

end
