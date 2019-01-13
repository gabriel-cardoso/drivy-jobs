require File.dirname(__FILE__) + '/../main'

RSpec.describe Main do
  let(:output_file) { File.read(File.dirname(__FILE__) + '/../data/expected_output.json')}
  subject { Main.run }
  it 'outputs expected data' do
    expect(subject).to eq(JSON.parse(output_file).to_json)
  end
end
