class LiveController < WebsocketRails::BaseController
  def create
    byebug
    User.create! message
    send_message :create_success, user, namespace: :users
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