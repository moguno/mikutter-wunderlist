require_relative "monkey_patch.rb"
require_relative "spell"
require_relative "models"
require_relative "world"
require_relative "world_setting"
require_relative "datasource"
require_relative "dsl"

Plugin.create(:"mikutter-wunderlist") {
  timer(60) {
    Plugin.filtering(:worlds, []).first
                             .select { |_| _.is_a?(Plugin::Wunderlist::World) }
                             .each { |world|

      user = world.api.get("https://a.wunderlist.com/api/v1/user")["name"]

      user_model = WunderlistUser.new_ifnecessary(
        id: 99999,
        idname: user,
        name: user,
        uri: "wunderlistuser://99999",
        profile_image_url: "https://www.wunderlist.com/site/images/favicon.ico"
      )

      datasources = Plugin.filtering(:extract_datasources, {}).first

      datasources.keys.map { |slug|
        if slug.to_s =~ /^Wunderlist\/#{user}\/(.+)$/
          {:slug => slug, :list => $1}
        else
          nil
        end
      }.compact.each { |source|
        Thread.new {
          messages = world.api.tasks(source[:list]).map { |task|
            p task
            WunderlistTask.new_ifnecessary(
              id: task.id,
              uri: "https://www.wunderlist.com/#/tasks/#{task.id}/title/focus",
              created: Time.now,
              description: task.title,
              user: user_model
            )
          }

puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
puts messages.count
puts source[:slug]

          Plugin.call(:extract_receive_message, source[:slug], messages)
        }
      }
    }
  }
}
