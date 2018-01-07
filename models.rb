
# ユーザーモデル
class WunderlistUser < Diva::Model
  include Diva::Model::UserMixin
  include Diva::Model::Identity

  register(:wunderlist_user, name: "Wunderlist")

  field.string(:idname, required: true)
  field.string(:name, required: true)
  field.string(:uri, required: true)
  field.string(:profile_image_url, required: true)
  field.int(:id, required: true)
end

# メッセージモデル
class WunderlistTask < Diva::Model
  include Diva::Model::MessageMixin
  include Diva::Model::Identity

  register(:wunderlist_task, name: "Wunderlist")

  field.string(:description, required: false)
  field.time(:created, required: false)
  field.string(:uri, required: true)
  field.has(:user, WunderlistUser, required: true)
  field.int(:id, required: true)
#  field.int(:favorite_count, required: true)
#  field.int(:retweet_count, required: true)

  entity_class(Diva::Entity::URLEntity)
end

