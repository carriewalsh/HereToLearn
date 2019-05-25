App.attendance = App.cable.subscriptions.create "AttendanceChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    alert("Student with ID" + data.student_id + "Marked"+ data.attendance)
