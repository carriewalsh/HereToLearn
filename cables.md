# Action Cable Highlights

- Coffee script is javascript without parentheses and curly braces  

`rails g channel <channel name>`
Creates 3 files:
- `app/channels/<channel_name>_channel.rb`
- `app/assets/javascript/cable.js`
- `app/assets/javascript/channels/<channel_name>.coffee`

Let's call the `<channel_name>` "room" (As it is in (this tutorial)[https://www.learnenough.com/action-cable-tutorial])

```
#app/channels/room_channel.rb
# Be sure to restart your server when you modify this file.
# Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
```

Action Cable "subscribes" and "unsubscribes" users browsers via `WebSocket`.

Hence, the above methods are `callbacks` that define actions when either even takes place.

Note the `stream_from` method with the room name as a string in `subscribe`

Broadcasting is accomplished in controller via:
```
ActionCable.server.broadcast 'room_channel', <data hash>
```  

e.g.

```
ActionCable.server.broadcast 'room_channel',
                             {content:  message.content,
                             username: message.user.username}
```


In `room.coffee`, three methods; `connected`, `disconnected`, `received`.

`received` is what is important for us. It starts defaulted with a `data` parameter.

```
App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
  ```

**Thus we will need to define methods in the `received` method**

  Finally, must `mount` the cable in the `routes.rb` with the line:
  ```
  mount ActionCable.server, at: '/cable'
```

The `'/cable'` is a default.


## Our Implementation

Currently, a student submitting a survey hits `student/resonse_controller.rb#create` I believe this is appropriate.

Within that action I see adding an `ActionCable.server.broadcast`, which sends a hash of: `{student_id: <id>, attendance: 'present'}`

In turn, that will activate the code block in `received:` found in `room.coffee`. (Have we figured out how to change this to a `js` script?)  

Within that `recieved:` block there should be a call to a `jquery` function that changes the image associated with the relevant `student_id`  


Then there should be listeners on the attendance-toggles on the attendance pages. I imagine there must be a special java-scripty / jquery-y way of doing that.

Maybe something the along the lines of `$(.attendance_button).on('click', (e) => update_attendance(e))`

**Extant question** - Maybe Carrie and Josh discussed this earlier?

By what path then should the `update_attendance(e)` hit a rails controller -- Should it hit an API endpoint as was done with the `TutorialSequencer` in `Brownfield`?

Whatever happens it should also trigger another `broadcast`. of `{student_id:<id>, attendance: 'tardy'}`, e.g.  
