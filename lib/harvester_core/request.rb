require 'redis'

module HarvesterCore
  
  class Request

    class << self
      def get(url, options=[])
        self.new(url, options).get
      end
    end

    attr_accessor :url, :throttling_options

    def initialize(url, options=[])
      @url = url
      
      options ||= []
      @throttling_options = Hash[options.map {|option| [option[:host], option[:delay]] }]
    end

    def uri
      @uri ||= URI.parse(url)
    end

    def host
      @host ||= uri.host
    end

    def get
      if HarvesterCore.redis_available
        sleep(seconds_to_wait)
        self.last_request_at = Time.now
      end
      self.request_resource
    end

    def seconds_to_wait
      seconds = delay - (Time.now.to_f - last_request_at)
      seconds < 0 ? 0 : seconds
    end

    def last_request_at=(time)
      HarvesterCore.redis.set(host, time.to_f)
    end

    def last_request_at
      HarvesterCore.redis.get(host).to_f
    end

    def delay
      throttling_options[self.host].to_f
    end

    def request_resource
      response = nil

      measure = Benchmark.measure do
        if defined?(Rails) && ::HarvesterCore.caching_enabled
          response = Rails.cache.fetch(url, :expires_in => 10.minutes) { RestClient.get(url) }
        else
          response = RestClient.get(url)
        end
      end

      if defined?(Rails)
        real_time = measure.real.round(4)
        Rails.logger.info "\nGET (#{real_time}): #{url}\n"
        puts "GET (#{real_time}): #{url}"
      end

      response
    end
  end
end