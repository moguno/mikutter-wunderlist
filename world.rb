require "rubygems"
require "wunderlist"

module Plugin::Wunderlist
  class World < Diva::Model
    register(:wunderlist, name: "Wunderlist")

    field.string(:client_id, required: true)
    field.string(:access_token, required: true)

    field.has(:icon, Diva::Model, required: true)
    field.string(:slug, required: true)
    field.string(:title, required: true)

    def api()
      @api
    end

    def initialize(hash)
      client_id = hash[:client_id]
      access_token = hash[:access_token]

      @api ||= Wunderlist::API.new({
        :client_id => client_id,
        :access_token => access_token,
      })

      user = api.get("https://a.wunderlist.com/api/v1/user")

      super({
        :slug => user["id"],
        :title => user["name"],
      }.merge(hash))
    end
  end
end
