class EventSerializer < ActiveModel::Serializer
  attributes :display_name, :date, :time, :uri
end
