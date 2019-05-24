class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :course

  enum attendance: [:absent, :present, :tardy, :present_no_response, :absent_with_response]
end
