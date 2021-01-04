# frozen_string_literal: true

require_relative '../../models/site'

describe Models::Site do
  subject(:model) { described_class.new('/about') }

  describe '.visit' do
    it 'increases overall visit_count' do
      model.visit('000.000.000.001')
      model.visit('000.000.000.002')
      model.visit('000.000.000.003')
      model.visit('000.000.000.002')

      expect(model.visit_count).to eq(4)
    end

    it 'increases  uniq_visit_count' do
      model.visit('000.000.000.001')
      model.visit('000.000.000.001')
      model.visit('000.000.000.002')
      model.visit('000.000.000.003')
      model.visit('000.000.000.002')
      model.visit('000.000.000.002')

      expect(model.uniq_visit_count).to eq(3)
    end
  end

  describe '.visit_print' do
    context 'when someone visited' do
      it 'returns string with informations' do
        model.visit('000.000.000.001')
        model.visit('000.000.000.002')

        expect(model.visit_print).to eq('/about 2 visits')
      end
    end
    # It is a case which will never happen in this project, but I wanted to test it
    context 'when noone visited' do
      it 'returns string with informations' do
        expect(model.visit_print).to eq('/about 0 visits')
      end
    end
  end

  describe '.uniq_visit_print' do
    context 'when someone visited' do
      it 'returns string with informations' do
        model.visit('000.000.000.001')
        model.visit('000.000.000.001')
        model.visit('000.000.000.002')

        expect(model.uniq_visit_print).to eq('/about 2 unique views')
      end
    end

    context 'when noone visited' do
      it 'returns string with informations' do
        expect(model.uniq_visit_print).to eq('/about 0 unique views')
      end
    end
  end
end
