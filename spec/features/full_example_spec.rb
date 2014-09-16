require 'spec_helper'
require 'ostruct'

class MyService < ResponseState::Service
  attr_reader :object, :pass

  def initialize(object, pass)
    @object = object
    @pass = pass
  end

  def call
    success_response or failure_response
  end

  private

  def success_response
    return unless pass
    send_state :success, 'Yay! It works.', object
  end

  def failure_response
    send_state :failure, 'Boo! It failed.'
  end
end

describe 'Using the service' do
  let(:object) { Object.new }
  let(:yielded) { OpenStruct.new(message: nil, context: nil) }
  before do
    MyService.(object, pass) do |response|
      response.success { yielded.message = response.message; yielded.context = response.context }
      response.failure { yielded.message = response.message; yielded.context = response.context }
    end
  end

  context 'when pass is true' do
    let(:pass) { true }

    it 'has a happy message' do
      expect(yielded.message).to eq 'Yay! It works.'
    end

    it 'has a valid context' do
      expect(yielded.context).to eq object
    end
  end

  context 'when pass is false' do
    let(:pass) { false }

    it 'has a sad message' do
      expect(yielded.message).to eq 'Boo! It failed.'
    end

    it 'has a nil context' do
      expect(yielded.context).to eq nil
    end
  end
end
