require 'json'
require File.dirname(__dir__) + '/level4/main'

RSpec.describe 'Level 4' do
  let(:output_file) { File.read(File.dirname(__FILE__) + '/../level4/data/expected_output.json')}

  subject { Level4::Main.new('level4').run }
  it 'outputs expected data' do
    expect(subject).to eq(JSON.parse(output_file).to_json)
  end
end
