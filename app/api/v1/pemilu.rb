module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :category do
      desc "Return list of category"
      get do
        results = HakPilih::CATEGORY
        {
          results: results
        }
      end
    end

    resource :hakpilih do
      desc "Return list data of users suffrage"
      get do
        results = HakPilih.apiall(params)
        {
          results: results
        }
      end
    end
  end
end