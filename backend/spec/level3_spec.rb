require 'json'
require File.dirname(__dir__) + '/level3/main'

RSpec.describe 'Level 3' do
  let(:output_file) { File.read(File.dirname(__FILE__) + '/../level3/data/expected_output.json')}

  subject { Level3::Main.new('level3').run }
  it 'outputs expected data' do
    expect(subject).to eq(JSON.parse(output_file).to_json)
  end
end
