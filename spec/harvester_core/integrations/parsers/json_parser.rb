class JsonParser < HarvesterCore::Json::Base
  
  base_url "http://api.europeana.eu/records.json"
  record_selector "$..items"

  attribute :collection,              default: "Europeana"

  attribute :identifier,              path: "guid"
  attribute :title,                   path: "title"
  attribute :description,             path: "description", truncate: 21
  attribute :landing_url,             path: "link" do
    get(:landing_url).mapping(/.*record\/(\w+)\/(\w+).*/ => 'http://www.europeana.eu/portal/record/\1/\2')
  end
  attribute :thumbnail_url,           path: "enclosure"
  attribute :creator,                 path: "creator"
  attribute :year,                    path: "year"
  attribute :language,                path: "language"
  attribute :dnz_type,                path: "type"
  attribute :contributing_partner,    path: "dataProvider"

end