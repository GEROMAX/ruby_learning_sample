require "rack"

puts Rack::Utils::HTTP_STATUS_CODES.map { |key, value| "#{key} = :#{value.downcase.gsub(' ', '_')}" }
