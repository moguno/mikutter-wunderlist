Plugin.create(:"mikutter-wunderlist") {
  # 投稿
  defspell(:compose, :wunderlist,
           condition: ->(wunderlist) {
             true
           }) { |wunderlist, body:|
    LIST = "inbox"

    Thread.new { 
      task = wunderlist.api.new_task(LIST, {
        :title => body,
        :completed => false
      })

      task.save

      position = wunderlist.api.task_positions(LIST).first

      request = {
        "values" => position["values"],
        "revision" => position["revision"],
      }

      request["values"].delete(task.id)
      request["values"].unshift(task.id)

      wunderlist.api.set_task_positions(position["id"], request)
    }
  }
}
