(function() {
  App.chat = App.cable.subscriptions.create("AttendanceChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {alert("Student with ID" + data.student_id + "Marked"+ data.attendance);
    showUpdatedAttendance(data.student_id,data.course_id,data.attendance)
  }
  });

}).call(this);
