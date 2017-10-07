require "restclient_communicator/version"
require 'active_support'
require 'active_support/core_ext'
require 'addressable'
require 'rest_client'

module RestclientCommunicator
  # Your code goes here...
  class Communication

    attr_accessor :errorcode, :response, :http_code, :body, :options, :file

    VALID_SCHEMES = ["http","https"]

    def initialize(url, options={})
      return if url.blank?
      default_options = {
        :method => :get,
        :open_timeout => 5,
        :read_timeout => 5,
        :max_redirects => 1,
        :raw_response => false,
      }
      @options = options.reverse_merge(default_options)
      @errorcode, @response, @http_code, @body, @file = nil
      self.check_url(url)
    end

    def check_url(url)
      begin

        new_url = Addressable::URI.parse(url)
        #muss ich jetztz bereinigen, da dieser wert 1:1 an restclient geht
        if new_url

          if !VALID_SCHEMES.include? new_url.scheme
            @errorcode = "CE9991"
            return
          end

          options[:url] = new_url.normalize.to_str
          self.start 
        else
          @errorcode = "CE9993"
        end
      rescue Addressable::URI::TypeError, Addressable::URI::NoMethodError, Addressable::URI::InvalidURIError => e
        @errorcode = "CE9999"
      end
    end

    def start     
      begin
      


        #for result codes between 200 and 207, a RestClient::Response will be returned
        #for result codes 301, 302 or 307, the redirection will be followed if the request is a GET or a HEAD
        #for result code 303, the redirection will be followed and the request transformed into a GET
        #for other cases, a RestClient::ExceptionWithResponse holding the Response will be raised; a specific exception class will be thrown for known error codes
        #call .response on the exception to get the server's response       
        @response = RestClient::Request.execute(**@options)
        @http_code = @response.code
        case @http_code
        when 200,207
          
          #https://github.com/rest-client/rest-client/blob/master/lib/restclient/raw_response.rb
          #In addition, if you do not use the response as a string, you can access
          #a Tempfile object at res.file, which contains the path to the raw
          #downloaded request body.
          if @options[:raw_response]
            @file = @response.file
          else
            @body = @response.body
          end
        else
          case @options[:method]
          when :get, :head
            #bei get wird automatisch einem redirect gefolgt
            #For GET and HEAD requests, rest-client automatically follows redirection.
            case @http_code
            when 301,302,307
              @body = @response.body
            end
          when :post 
            case @http_code
            when 301, 302, 307
              @response.follow_redirection
            end
          end 
        end
      rescue RestClient::MovedPermanently, RestClient::Found, RestClient::TemporaryRedirect => e
        @response = e.response
        @http_code = @response.code
        @errorcode = "CE9920" if @options[:max_redirects] == 0
        #case @options[:method]
        #when :post
        #todo das ist nich nicht so oaky
        #e.response.follow_redirection
      rescue RestClient::Unauthorized => e
        @http_code = e.response.code
        @errorcode = "CE9901"
      rescue RestClient::Forbidden  => e
        @http_code = e.response.code
        @errorcode = "CE9902"
      rescue RestClient::ImATeapot => e
        @http_code = e.response.code
        @errorcode = "CE9903"
      rescue RestClient::NotFound => e
        @http_code = e.response.code
        @errorcode = "CE9904"
      rescue RestClient::Exceptions::Timeout => e
        #könnte man auch noch unterscheiden RestClient::Exceptions::Timeout::OpenTimeout, RestClient::Exceptions::Timeout::ReadTimeout
        #https://github.com/rest-client/rest-client/blob/master/lib/restclient/exceptions.rb
        @errorcode = "CE9905"
      rescue RestClient::ServerBrokeConnection  => e
        @errorcode = "CE9906"
      rescue RestClient::SSLCertificateNotVerified => e
        @errorcode = "CE9907"
      rescue RestClient::PayloadTooLarge => e
        @errorcode = "CE9908"
        @http_code = e.response.code
      rescue RestClient::RequestURITooLong => e
        @errorcode = "CE9909" 
      rescue RestClient::RequestedRangeNotSatisfiable => e
        @errorcode = "CE9910"      
      end
    end
  end
end
