# frozen_string_literal: true

require 'raven/processor'

module RavenProcessors
  # Builds fingerprint based on exception class & the line of exception
  class Fingerprint < Raven::Processor
    def process(data)
      fingerprint = data[:fingerprint] || data['fingerprint']
      exception = (data.dig('exception', 'values') || data.dig(:exception, :values))&.first

      return data if fingerprint || exception.nil? || exception.empty?

      data.merge(fingerprint: build_fingerprint(exception))
    end

    private

    def build_fingerprint(exception)
      [
        exception.fetch(:type),
        frame_to_line(exception[:stacktrace][:frames].last)
      ]
    end

    def frame_to_line(frame)
      return if frame.nil? || frame.empty?

      parts = [frame[:abs_path]]
      parts << ":#{frame[:lineno]}" unless frame[:lineno].nil? && frame[:lineno].empty?
      parts << ":in `#{frame[:function]}'" unless frame[:function].nil? && frame[:function].empty?
      parts.join
    end
  end
end
