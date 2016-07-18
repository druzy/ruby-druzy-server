require 'webrick'

module Druzy
  module Server  
    class OneInstanceByPort
      @@instances={}
      
      def initialize(port)
        @server=WEBrick::HTTPServer.new(:Port => port)
      end
      
      def self.instance(port)
        if !@@instances.has_key?(port)
          @@instances[port]=new(port)
        end
        @@instances[port]
      end
      
      def start_server
        Thread.new{@server.start()}
      end
      
      def stop_server
        @server.stop
      end
      
      private_class_method :new
      private :start_server, :stop_server
      
    end
  
  end
end