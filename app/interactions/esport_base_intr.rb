# frozen_string_literal: true

# Responsible for creating offers
class EsportBaseIntr < ApplicationInteraction
  require 'rest_client'
  string :url_type, presence: true
  hash :data_params, default: {}, strip: false
  BASE_URL = 'http://api.isportsapi.com/sport/basketball'

  def execute
    retrieve_results
  end

  def getData
    response = RestClient.get("#{BASE_URL}/#{url_type}", {params: data_params.merge({api_key: 'API-KEY'})})
    data = response.code == 200 ? response.body : response
    return data
  end

  def retrieve_results
    JSON.parse(getData)
  end
end