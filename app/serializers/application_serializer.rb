class ApplicationSerializer < ActiveModel::Serializer
  delegate :url_helpers, to: 'Rails.application.routes'
end