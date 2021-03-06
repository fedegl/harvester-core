module HarvesterCore
  class JsonResource < Resource
    
    def document
      @document ||= JSON.parse(fetch)
    end

    def strategy_value(options)
      options ||= {}
      path = options[:path]
      return nil unless path.present?

      if path.is_a?(Array)
        path.map {|p| document[p] }
      else
        document[path]
      end
    end
  end
end