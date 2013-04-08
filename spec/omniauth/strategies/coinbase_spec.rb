require 'spec_helper'

describe OmniAuth::Strategies::Coinbase do
  subject do
    OmniAuth::Strategies::Coinbase.new({})
  end

  context 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('coinbase')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://coinbase.com')
    end
  end
end
