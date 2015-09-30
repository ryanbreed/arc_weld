require 'csv'

module ArcWeld
  module Readers
    class Csv
      attr_accessor :file_path, :target_class
      attr_reader   :keys, :csv

      def initialize(file_path: nil, target_class: nil, options: {})
        @file_path, @target_class = file_path, target_class
        @csv = CSV.open(file_path, 'r', options)
        @keys = csv.readline.map { |k| k.to_sym }

      end

      def parse(array)
        target_class.new(Hash[keys.zip(array)])
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