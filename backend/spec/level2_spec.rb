require 'json'
require File.dirname(__dir__) + '/level2/main'

RSpec.describe 'Level 2' do
  let(:output_file) { File.read(File.dirname(__FILE__) + '/../level2/data/expected_output.json')}

  subject { Level2::Main.new('level2').run }
  it 'outputs expected data' do
    expect(subject).to eq(JSON.parse(output_file).to_json)
  end
end
