require "spec_helper"

##https://relishapp.com/rspec/rspec-expectations/v/3-6/docs/built-in-matchers/be-matchers
RSpec.describe RestclientCommunicator do
  it "has a version number" do
    expect(RestclientCommunicator::VERSION).not_to be nil
  end

  it "SEITE NICHT VORHANDEN" do 
    url = "https://www.google.de/hallo.html"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to eq("CE9904")
    expect(new_get.http_code).to eq(404)
  end

  it "TIMEOUT" do 
    new_get = RestclientCommunicator::Communication.new("https://www.google.de/hallo.html", {:open_timeout => 0, :read_timeout => 0})
    expect(new_get.errorcode).to eq("CE9905")
    expect(new_get.http_code).to be_nil
  end


end
