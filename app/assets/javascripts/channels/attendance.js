(function() {
  App.chat = App.cable.subscriptions.create("AttendanceChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      // debugger;
      // alert("Student with ID" + data.student_id + "Marked"+ data.attendance);
      if (data.student_id){
      showUpdatedAttendance(data.student_id, data.course_id, data.attendance)
    }else{
      addAttendance(data.student_id, data.student_name, data.course_id, data.attendance)
    }
  }
  });

}).call(this);
