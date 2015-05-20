class LiveController < WebsocketRails::BaseController
  def create
    user = User.create! message
    broadcast_message :create_success, user, namespace: :users
  end

  def update
    user = User.find(message["id"])
    user.update! message
    broadcast_message :update_success, user, namespace: :users
  end

  def delete
    user = User.find(message["id"])
    user.destroy!
    broadcast_message :delete_success, user, namespace: :users
  end
end





# class LiveController < WebsocketRails::BaseController
#   def create
#     # The `message` method contains the data received
#     user = User.new message
#     if user.save
#       send_message :create_success, user, :namespace => :users
#     else
#       send_message :create_fail, user, :namespace => :users
#     end
#   end
# end




# class LiveController < WebsocketRails::BaseController
#
#   def initialize_session
#     controller_store[:light] = LifxInterface.new
#   end
#
#   def create
#     controller_store[:light].turn_on
#   end
#
#   def destroy
#     controller_store[:light].turn_off
#   end
#
#   def change_color
#     red = message[:red]
#     green = message[:green]
#     blue = message[:blue]
#
#     controller_store[:light].set_rgb(red, green, blue)
#   end
#
#   def change_brightness
#     brightness = message[:brightness]
#     controller_store[:light].change_brightness(brightness)
#   end
#
# end