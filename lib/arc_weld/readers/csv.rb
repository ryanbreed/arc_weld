require 'csv'

module ArcWeld
  module Readers
    class Csv
      attr_accessor :path, :target_class, :key_proc
      attr_reader   :keys, :csv
      DEFAULT_OPTIONS = {skip_lines: %r{\A[#;]}}

      def initialize(path: nil, target_class: nil, options: DEFAULT_OPTIONS)
        @path, @target_class = path, target_class
        @csv = CSV.open(path, 'r', options)
        @key_proc ||= {}
        @keys = csv.readline.map { |k| k.to_sym }
      end

      def read_keys
        keys - processed_keys
      end

      def processed_keys
        key_proc.keys
      end

      def parse(array)
        row_hash = Hash[keys.zip(array)]
        instance_hash = row_hash.select {|k,v| read_keys.include?(k)}
        new_instance = target_class.new(instance_hash)

        if processed_keys.empty?
          new_instance
        else
          processed_hash = row_hash.select {|k,v| read_keys.include?(k)==false }
          processed_hash.each do |processed_key, processed_value|
            key_proc.fetch(processed_key).call(processed_key,processed_value,new_instance)
          end
          new_instance
        end
      end

      def not_at_start_record?
        (csv.lineno!=1)
      end

      def each(rewind: not_at_start_record?)
        reset_csv if rewind
        csv.each {|arr| yield parse(arr) }
      end

      def to_a(rewind: not_at_start_record?)
        reset_csv if rewind
        csv.readlines.map {|arr| parse(arr)}
      end

      def reset_csv
        csv.rewind
        *trash = csv.readline
        csv.lineno
      end
    end
  end
end
