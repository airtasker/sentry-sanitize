# frozen_string_literal: true

require 'sentry/sanitize/processor'
require 'sentry/sanitize/processor/sanitize_data'
require 'sentry/sanitize/processor/utf8conversion'

module Sentry
  class Processor::CustomSanitizeData < Processor::SanitizeData
    def initialize(sanitize_fields)
      self.sanitize_fields = sanitize_fields
      self.sanitize_credit_cards = true
      self.sanitize_fields_excluded = []
    end
  end
end
