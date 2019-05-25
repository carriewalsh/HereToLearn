class AttendanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "attendance_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
