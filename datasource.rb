require "wunderlist"

Plugin.create(:"mikutter-wunderlist") {
  # データソース
  filter_extract_datasources { |datasources|
    worlds = Plugin.filtering(:worlds, []).last

    worlds.select { |_| _.is_a?(Plugin::Wunderlist::World) }.each { |world|
      user = world.api.get("https://a.wunderlist.com/api/v1/user")["name"]

      world.api.lists.each { |list|
        datasources[:"Wunderlist/#{user}/#{list.title}"] = _("Wunderlist/#{user}/#{list.title}")
      }
    }

    [datasources]
  }
}
