require 'json/pure'
require 'strscan'

module PSON
  module Pure
    # This class implements the PSON parser that is used to parse a PSON string
    # into a Ruby data structure.
    class Parser < JSON::Pure::Parser
    end
  end
end
