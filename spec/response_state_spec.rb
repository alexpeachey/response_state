require 'spec_helper'



describe ResponseState do

  context 'without allowed states specified' do

    before do
      def tester param, &block
        result = ResponseState.init(&block)
        if param == 1
          result.success
        elsif param == 2
          result.success
          result.success
        else
          result.failure
        end
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
      tester 2 do |result|
        result.success   { call_count += 1 }
        result.failure { fail }
      end
      expect(call_count).to eq 2
    end

    it 'tolerates not subscribing to some states that are returned' do
      tester 1 do |result|
        result.zonk   {fail }
      end
    end

    it 'tolerates subscribing to a non-existing state' do
      tester 1 do |result|
        result.zonk   {fail }
      end
    end
  end



    end
    expect(call_count).to eq 2
  end

end
