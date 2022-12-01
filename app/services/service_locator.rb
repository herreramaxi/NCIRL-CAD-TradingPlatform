#https://gist.github.com/dajulia3/5479980

require 'singleton'

class ServiceLocator
    include Singleton
  
    def self.reset_instance
      self.instance_variable_set("@singleton__instance__", self.send(:new))
    end
  
    def initialize
      @services = {}
    end
  
    #Do this in your setup file
    def register(service_name, instance)
      @services[service_name] = instance
    end
  
    def get_service_instance(service_name)
      service_instance = @services[service_name]
      raise NoSuchServiceInstanceException if service_instance.nil?
  
      service_instance
    end
  
    class NoSuchServiceInstanceException < Exception; end
  end