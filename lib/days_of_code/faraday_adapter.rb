module DaysOfCode
  class FaradayAdapter < Faraday::Adapter::NetHttp
    def net_http_connection(env)
      client = if proxy?
                Net::HTTP::Proxy(proxy_options[:server], proxy_options[:port])
              else
                Net::HTTP
              end
      client.new(env[:url].hostname, env[:url].port || (env[:url].scheme == 'https' ? 443 : 80))
    end

    private

    def proxy_options
      @proxy_options ||= { server: ENV['PROXY_SERVER'], port: ENV['PROXY_PORT'] }
    end

    def proxy?
      !ENV["PROXY_SERVER"].to_s.empty?
    end
  end
end
