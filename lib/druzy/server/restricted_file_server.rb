require_relative 'one_instance_by_port'

require 'druzy/utils/net'
require 'i18n'
require 'socket'
require 'webrick'

I18n.enforce_available_locales = false

module Druzy
  module Server  
    class RestrictedFileServer < OneInstanceByPort
      
      def initialize(port)
        super(port)
        
        @files={}
        @id=0
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
          ip=Druzy::Utils.get_local_public_ipv4
          return "http://"+ip+":"+@server.config[:Port].to_s+"/"+@files[file].to_s+"/"+I18n.transliterate(File.basename(file))
        else
          return nil
        end
        
      end
      
    end
  
  end
end

if $0 == __FILE__
  server=Druzy::Server::RestrictedFileServer.instance(15433)
  server.add_file("/home/druzy/elliot.mp4")
  puts server.get_address("/home/druzy/elliot.mp4")
  sleep 30
end