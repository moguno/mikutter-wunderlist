module Wunderlist
  class API
    def task_positions(list_name)
      list_id = get_list_ids([list_name]).first

      self.get("https://a.wunderlist.com/api/v1/task_positions", {"list_id" => list_id})
    end

    def set_task_positions(position_id, options)
      self.put("https://a.wunderlist.com/api/v1/task_positions/#{position_id}", options)
    end

    def user()
      self.get("https://a.wunderlist.com/api/v1/user")
    end
  end
end
