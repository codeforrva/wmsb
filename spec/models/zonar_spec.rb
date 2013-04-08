require 'spec_helper'

describe Zonar do
  describe '.bus_location' do
    it 'parses xml response' do
      sample_bus_location = "<currentlocations>\n <asset tagid=\"\" fleet=\"B009\" id=\"192\" type=\"\">\n  <long>-71.136358</long>\n  <lat>42.2454529</lat>\n  <heading>171.60</heading>\n  <time>2013-04-05 16:16 EDT</time>\n  <speed unit=\"Mile/Hour\">4.2</speed>\n  <power>on</power>\n </asset>\n</currentlocations>"

      stub_zonar_api do |request|
        request.get('/interface.php') { [200, {}, sample_bus_location] }
      end

      Zonar.bus_location('BUSID').should eq Hash.from_xml(sample_bus_location)
    end

    it 'returns empty hash if failed' do
      stub_zonar_api do |request|
        request.get('/interface.php') { [400, {}, "{}"] }
      end

      Zonar.bus_location('BUSID').should eq Hash.new
    end
  end
end