require 'json'
require File.dirname(__dir__) + '/level5/main'

RSpec.describe 'Level 5' do
  let(:output_file) { File.read(File.dirname(__FILE__) + '/../level5/data/expected_output.json')}

  subject { Level5::Main.new('level5').run }
  it 'outputs expected data' do
    expect(subject).to eq(JSON.parse(output_file).to_json)
  end
end
