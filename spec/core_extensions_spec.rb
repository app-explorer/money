require 'spec_helper'

RSpec.shared_examples_for "an object supporting to_money" do
  it "supports to_money" do
    expect(@value.to_money).to eq(@money)
    expect(@value.to_money('CAD').currency).to eq(Money::Currency.find!('CAD'))
  end
end

RSpec.describe Integer do
  before(:each) do
    @value = 1
    @money = Money.new("1.00")
  end

  it_should_behave_like "an object supporting to_money"

  it "parses 0 to Money.zero" do
    expect(0.to_money).to eq(Money.zero)
  end
end

RSpec.describe Float do
  before(:each) do
    @value = 1.23
    @money = Money.new("1.23")
  end

  it_should_behave_like "an object supporting to_money"

  it "parses 0.0 to Money.zero" do
    expect(0.0.to_money).to eq(Money.zero)
  end
end

RSpec.describe String do
  before(:each) do
    @value = "1.23"
    @money = Money.new(@value)
  end

  it_should_behave_like "an object supporting to_money"

  it "parses an empty string to Money.zero" do
    expect(''.to_money).to eq(Money.zero)
    expect(' '.to_money).to eq(Money.zero)
  end
end

RSpec.describe BigDecimal do
  before(:each) do
    @value = BigDecimal("1.23")
    @money = Money.new("1.23")
  end

  it_should_behave_like "an object supporting to_money"

  it "parses a zero BigDecimal to Money.zero" do
    expect(BigDecimal.new("-0.000").to_money).to eq(Money.zero)
  end
end
