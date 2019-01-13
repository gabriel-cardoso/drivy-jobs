require 'json'
require File.dirname(__FILE__) + '/../level1/main'

RSpec.describe 'Level 1' do
  let(:output_file) { File.read(File.dirname(__FILE__) + '/../level1/data/expected_output.json')}

  subject { Level1::Main.run }
  it 'outputs expected data' do
    expect(subject).to eq(JSON.parse(output_file).to_json)
  end
end
