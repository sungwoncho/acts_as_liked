RSpec::Matchers.define :have_many do |expected|
  match do |actual|
    association = actual.reflect_on_association(expected)
    expect(association.macro).to eq :has_many
  end

  failure_message do |actual|
    "expected #{actual} to have many #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected #{actual} not to have many #{expected}"
  end

  description do
    "expect to have many #{expected}"
  end
end