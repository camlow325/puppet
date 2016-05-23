require 'json'

module PSON

  module Pure
    module Generator
      # This class is used to create State instances, that are use to hold data
      # while generating a PSON text from a Ruby data structure.
      class State < JSON::Ext::Generator::State
      end

      module GeneratorMethods
        # Converts this object to a string (calling #to_s), converts
        # it to a PSON string, and returns the result. This is a fallback, if no
        # special method #to_pson was defined for some object.
        module Object
          def to_pson(*) to_json end
        end

        module Hash
          # Returns a PSON string containing a PSON object, that is unparsed from
          # this Hash instance.
          # _state_ is a PSON::State object, that can also be used to configure the
          # produced PSON string output further.
          # _depth_ is used to find out nesting depth, to indent accordingly.
          def to_pson(state = nil, depth = 0, *) to_json(state) end
        end

        module Array
          # Returns a PSON string containing a PSON array, that is unparsed from
          # this Array instance.
          # _state_ is a PSON::State object, that can also be used to configure the
          # produced PSON string output further.
          # _depth_ is used to find out nesting depth, to indent accordingly.
          def to_pson(state = nil, depth = 0, *)
            to_json(state)
          end
        end

        module Integer
          # Returns a PSON string representation for this Integer number.
          def to_pson(*) to_json end
        end

        module Float
          # Returns a PSON string representation for this Float number.
          def to_pson(state = nil, *)
            to_json
          end
        end

        module String
          # This string should be encoded with UTF-8 A call to this method
          # returns a PSON string encoded with UTF16 big endian characters as
          # \u????.
          def to_pson(*) to_json end

          # Module that holds the extinding methods if, the String module is
          # included.
          module Extend
            # Raw Strings are PSON Objects (the raw bytes are stored in an array for the
            # key "raw"). The Ruby String can be created by this module method.
            def pson_create(o)
              json_create(o)
            end
          end

          # Extends _modul_ with the String::Extend module.
          def self.included(modul)
            modul.extend JSON::Ext::Generator::GeneratorMethods::String::Extend
            modul.extend Extend
          end
        end

        module TrueClass
          # Returns a PSON string for true: 'true'.
          def to_pson(*) to_json end
        end

        module FalseClass
          # Returns a PSON string for false: 'false'.
          def to_pson(*) to_json end
        end

        module NilClass
          # Returns a PSON string for nil: 'null'.
          def to_pson(*) to_json end
        end
      end
    end
  end
end
