Plugin.create(:"mikutter-wunderlist") {
  world_setting(:wunderlist, _("Wunderlist")) {
    label(_("Webページにアクセスして新しいアプリを登録して下さい。"))
    label(_("そして得られた、CLIENT IDとACCESS TOKENを入力して下さい。"))

    link("https://developer.wunderlist.com/apps")

    input(_("CLIENT ID"), :client_id)
    input(_("ACCESS TOKEN"), :access_token)

    result = await_input

    world = Plugin::Wunderlist::World.new({
      :icon => Plugin.filtering(:photo_filter, "https://www.wunderlist.com/site/images/favicon.ico", []).last.first,
    }.merge(result.to_h))

    world
  }
}
