# frozen_string_literal: true

require_relative '../../services/site_log_comparator'

describe Services::SiteLogComparator do
  subject(:service) { described_class.new }

  it '1 is equal 1' do
    expect(service.call(1)).to eq(true)
  end
end
