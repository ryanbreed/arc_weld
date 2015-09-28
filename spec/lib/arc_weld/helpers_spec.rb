require 'spec_helper'
include ArcWeld::Helpers
describe ArcWeld::Helpers do
  describe '#constantize' do
    it 'constantizes snake_cased_literals' do
      expect(constantize('snake_cased_literal')).to eq('SnakeCasedLiteral')
    end
    it 'capitalizes string literals' do
      expect(constantize('literal')).to eq('Literal')
    end
    it 'constantizes space separated literals' do
      expect(constantize('some other literal')).to eq('SomeOtherLiteral')
    end
  end
end