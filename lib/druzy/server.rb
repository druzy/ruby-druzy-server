require 'druzy/server/version'

require 'i18n'
require 'socket'
require 'webrick'

I18n.enforce_available_locales = false

module Druzy
  module Server  
    class RestrictedFileServer
      @@instances={}
      
      def initialize(port)
        @server=WEBrick::HTTPServer.new(:Port => port)
        @files={}
        @id=0
      end
      
      def self.instance(port)
        if !@@instances.has_key?(port)
          @@instances[port]=new(port)
        end
        @@instances[port]
      end
      
      def add_file(file)
        @files[file]=@id
        @server.mount("/"+@id.to_s+"/"+I18n.transliterate(File.basename(file)),WEBrick::HTTPServlet::FileHandler,file)
        @id+=1
        
        if @files.size == 1 
          start_server
        end
      end
      
      def remove_file(file)
        @files.delete(file)
        if @files.size == 0
          stop_server
        end
      end
      
      def get_address(file)
        if @files.include?(file)
          ip=Socket.ip_address_list.detect{|intf| intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast?}
          return "http://"+ip.ip_address+":"+@server.config[:Port].to_s+"/"+@files[file].to_s+"/"+I18n.transliterate(File.basename(file))
        else
          return nil
        end
        
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