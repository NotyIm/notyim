module Gaia
  class Client
    attr_reader :checkers

    def initialize
      @checkers = Hash.new
    end

    def add(ip: , region:)
      @checkers[ip] = region
    end
  end


  def self.configure
    @__client ||= Client.new
    yield @__client if block_given?

    @__client
  end

  def self.client
    @__client
  end
end
