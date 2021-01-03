# frozen_string_literal: true

require 'tempfile'
require_relative '../../services/site_log_parser'

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
      let(:lines) do
        [
          ['/page1', '000.000.000.001'],
          ['/page2', '000.000.000.001'],
          ['/page1', '000.000.000.002'],
          ['/page2', '000.000.000.002'],
          ['/page1', '000.000.000.003'],
          ['/page3', '000.000.000.003'],
          ['/page4', '000.000.000.004']
        ]
      end

      it 'returns array with site counts, sorted by visit count' do
        expect(service.call(test_log_file.path)).to eq(
          [
            '/page1 3',
            '/page2 2',
            '/page3 1',
            '/page4 1'
          ]
        )
      end
    end
  end
end
