require "spec_helper"

##https://relishapp.com/rspec/rspec-expectations/v/3-6/docs/built-in-matchers/be-matchers
RSpec.describe RestclientCommunicator do
  it "has a version number" do
    expect(RestclientCommunicator::VERSION).not_to be nil
  end


  it "URL FEHLER TYPE EROOR" do 
    new_get = RestclientCommunicator::Communication.new(1)
    expect(new_get.errorcode).to eq("CE9999")
    expect(new_get.http_code).to be_nil
    expect(new_get.response).to be_nil
    expect(new_get.body).to be_nil
  end


  it "URL FEHLER Schema" do 
    url = "httf://httpstat.uscas/200"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to eq("CE9991")
    expect(new_get.http_code).to be_nil
    expect(new_get.response).to be_nil
    expect(new_get.body).to be_nil
  end


  it "SEITE VORHANDEN 200" do 
    url = "http://httpstat.us/200"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to be_nil
    expect(new_get.http_code).to eq(200)
    expect(new_get.response).not_to be_nil
    expect(new_get.body).not_to be_nil
  end

   it "SEITE VORHANDEN 207" do 
    url = "http://httpstat.us/207"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to be_nil
    expect(new_get.http_code).to eq(207)
	expect(new_get.response).not_to be_nil
    expect(new_get.body).not_to be_nil
  end

 it "SEITE MOVED 301" do 
 	#er muss der seite autoamtsich folgen
    url = "http://httpstat.us/301, redirect folgen"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to be_nil
    expect(new_get.http_code).to eq(200)
    expect(new_get.response).not_to be_nil
    expect(new_get.body).not_to be_nil
  end


  it "SEITE MOVED 301, keinem redirect folgen" do 
 	#er muss der seite autoamtsich folgen
    url = "http://httpstat.us/301"
    new_get = RestclientCommunicator::Communication.new(url,{:max_redirects => 0})
    expect(new_get.errorcode).to eq("CE9920")
    expect(new_get.http_code).to eq(301)
    expect(new_get.body).to be_nil
    #es kommt der response <RestClient::Response 301 "301 Moved P..."
    expect(new_get.response).not_to be_nil
  end


 it "SEITE MOVED 302, redirect folgen" do 
 	#er muss der seite autoamtsich folgen
    url = "http://httpstat.us/302"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to be_nil
    expect(new_get.http_code).to eq(200)
    expect(new_get.response).not_to be_nil
    expect(new_get.body).not_to be_nil
  end

  it "SEITE MOVED 307, redirect folgen" do 
 	#er muss der seite autoamtsich folgen
    url = "http://httpstat.us/307"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to be_nil
    expect(new_get.http_code).to eq(200)
    expect(new_get.response).not_to be_nil
    expect(new_get.body).not_to be_nil
  end


  it "SEITE 401 Unauthorized" do 
 	#er muss der seite autoamtsich folgen
    url = "http://httpstat.us/401"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to eq("CE9901")
    expect(new_get.http_code).to eq(401)
    expect(new_get.response).to be_nil
    expect(new_get.body).to be_nil
  end


  it "SEITE 403 Forbidden" do 
 	#er muss der seite autoamtsich folgen
    url = "http://httpstat.us/403"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to eq("CE9902")
    expect(new_get.http_code).to eq(403)
    expect(new_get.response).to be_nil
    expect(new_get.body).to be_nil
  end

   it "SEITE 418 Teapot" do 
 	#er muss der seite autoamtsich folgen
    url = "http://httpstat.us/418"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to eq("CE9903")
    expect(new_get.http_code).to eq(418)
    expect(new_get.response).to be_nil
    expect(new_get.body).to be_nil
  end



  it "SEITE 413 RequestEntityTooLarge" do 
  #er muss der seite autoamtsich folgen
    url = "http://httpstat.us/413"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to eq("CE9908")
    expect(new_get.http_code).to eq(413)
    expect(new_get.response).to be_nil
    expect(new_get.body).to be_nil
  end


  it "SEITE 414 RequestURITooLong" do 
  #er muss der seite autoamtsich folgen
    url = "http://httpstat.us/414"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to eq("CE9909")
    expect(new_get.http_code).to be_nil
    expect(new_get.response).to be_nil
    expect(new_get.body).to be_nil
  end

  it "SEITE 416 RequestedRangeNotSatisfiable" do 
  #er muss der seite autoamtsich folgen
    url = "http://httpstat.us/416"
    new_get = RestclientCommunicator::Communication.new(url)
    expect(new_get.errorcode).to eq("CE9910")
    expect(new_get.http_code).to be_nil
    expect(new_get.response).to be_nil
    expect(new_get.body).to be_nil
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

  it "RAW RESPONSE TEST" do 
    new_get = RestclientCommunicator::Communication.new("https://github.com/fourcube/goiban-data-loader/raw/master/data/li.xlsx", {:raw_response => true, :open_timeout => 5, :read_timeout => 30})
    expect(new_get.errorcode).to be_nil
    expect(new_get.http_code).to eq(200)
    expect(new_get.file).not_to be_nil  
  end


end
