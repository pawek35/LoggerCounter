# frozen_string_literal: true

require 'tempfile'
require_relative '../../services/site_log_parser'
require_relative '../../models/display_uniq_visits_strategy'

describe Services::SiteLogParser do
  subject(:service) { described_class.new }

  let(:test_log_file) do
    Tempfile.new('log').tap do |file|
      lines.each do |line|
        file << "#{line.join(' ')} \n"
      end
      file.close
    end
  end

  describe '.call' do
    context 'when log is not empty' do
      context 'when sorted by overall visit count' do
        let(:lines) do
          [
            ['/page4', '000.000.000.004'],
            ['/page2', '000.000.000.001'],
            ['/page1', '000.000.000.002'],
            ['/page2', '000.000.000.002'],
            ['/page1', '000.000.000.003'],
            ['/page3', '000.000.000.003'],
            ['/page1', '000.000.000.001'],
            ['/page5', '000.000.000.001']
          ]
        end

        it 'returns array with site counts' do
          expect(service.call(test_log_file.path)).to eq(
            [
              '/page1 3 visits',
              '/page2 2 visits',
              '/page4 1 visits',
              '/page3 1 visits',
              '/page5 1 visits'
            ]
          )
        end
      end

      context 'when sorted by uniq visit count' do
        subject(:service) { described_class.new(Models::DisplayUniqVisitsStrategy.new) }

        let(:lines) do
          [
            ['/page2', '000.000.000.001'],
            ['/page2', '000.000.000.009'],
            ['/page1', '000.000.000.001'],
            ['/page2', '000.000.000.002'],
            ['/page1', '000.000.000.001'],
            ['/page3', '000.000.000.003'],
            ['/page3', '000.000.000.003'],
            ['/page1', '000.000.000.001'],
            ['/page3', '000.000.000.004'],
            ['/page4', '000.000.000.001'],
            ['/page4', '000.000.000.001']
          ]
        end

        it 'returns array with site counts,' do
          expect(service.call(test_log_file.path)).to eq(
            [
              '/page2 3 unique views',
              '/page3 2 unique views',
              '/page1 1 unique views',
              '/page4 1 unique views'
            ]
          )
        end
      end
    end
  end
end
