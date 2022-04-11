# frozen_string_literal: true

require 'spec_helper'
require 'cgi'
require 'uri'

RSpec.describe Sentry::Sanitize::Processor::CustomSanitizeData do
  let(:sanitize_fields) { ['password', '(?i-mx:.*auth-token$)'] }
  let(:processor) { described_class.new(sanitize_fields) }
  let(:filtered) { '********' }

  it 'filters auth-token from headers' do
    expect(processor.process({ 'headers' => { 'x-auth-token' => 'foobar' } }))
      .to                 eq({ 'headers' => { 'x-auth-token' => filtered } })
    expect(processor.process({ 'headers' => { 'X-AUTH-TOKEN' => 'foobar' } }))
      .to                 eq({ 'headers' => { 'X-AUTH-TOKEN' => filtered } })
  end

  it 'filters password from HTML form request body' do
    expect(processor.process({ 'data' => { 'password' => '123', 'account' => { 'password' => '123' } } }))
      .to                 eq({ 'data' => { 'password' => filtered, 'account' => { 'password' => filtered } } })
  end

  it 'filters password from JSON request body' do
    expect(processor.process({ 'data' => JSON.dump({ 'password' => '123', 'account' => { 'password' => '123' } }) }))
      .to                 eq({ 'data' => JSON.dump({ 'password' => filtered, 'account' => { 'password' => filtered } }) })
  end

  it 'filters password from query parameters' do
    expect(processor.process({ 'request' => { 'query_string' => 'foo=bar&password=test' } }))
      .to                 eq({ 'request' => { 'query_string' => 'foo=bar&password=********' } })
  end
end
